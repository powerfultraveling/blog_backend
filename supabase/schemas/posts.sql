CREATE TABLE post_categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE post_tags (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  post_category_id uuid NOT NULL REFERENCES post_categories(id),
  profile_id uuid REFERENCES profiles(id),
  title varchar NOT NULL,
  subtitle varchar,
  content text,
  cover_image_path text, -- 儲存 Supabase Storage 的路徑或 URL
  status varchar DEFAULT 'draft', -- draft, published, deleted
  likes_count integer DEFAULT 0,
  published_at timestamptz,
  created_at timestamptz DEFAULT now(),
  deleted_at timestamptz
);

-- 中間表：文章與標籤 (多對多)
CREATE TABLE post_tag_item (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id uuid NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  tag_id uuid NOT NULL REFERENCES post_tags(id) ON DELETE CASCADE,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE post_comments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id uuid NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  profile_id uuid REFERENCES profiles(id), -- 匿名留言則此欄位為 null
  nickname varchar, -- 供匿名用戶使用
  content text NOT NULL,
  status varchar DEFAULT 'approved',
  created_at timestamptz DEFAULT now(),
  deleted_at timestamptz
);

CREATE TABLE post_assets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id uuid NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  path text NOT NULL, -- 儲存 Supabase Storage 的路徑或 URL
  created_at timestamptz DEFAULT now()
);


-- 建立索引以提升查詢效能
CREATE INDEX idx_posts_status ON posts(status);
CREATE INDEX idx_posts_category ON posts(post_category_id);
CREATE INDEX idx_comments_post ON post_comments(post_id);

-- RLS：anon + authenticated 可 SELECT，僅 authenticated 可 INSERT/UPDATE/DELETE
ALTER TABLE post_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_tag_item ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_assets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "post_categories_select" ON post_categories FOR SELECT TO public USING (true);
CREATE POLICY "post_categories_insert" ON post_categories FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "post_categories_update" ON post_categories FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "post_categories_delete" ON post_categories FOR DELETE TO authenticated USING (true);

CREATE POLICY "post_tags_select" ON post_tags FOR SELECT TO public USING (true);
CREATE POLICY "post_tags_insert" ON post_tags FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "post_tags_update" ON post_tags FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "post_tags_delete" ON post_tags FOR DELETE TO authenticated USING (true);

CREATE POLICY "posts_select" ON posts FOR SELECT TO public USING (true);
CREATE POLICY "posts_insert" ON posts FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "posts_update" ON posts FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "posts_delete" ON posts FOR DELETE TO authenticated USING (true);

CREATE POLICY "post_tag_item_select" ON post_tag_item FOR SELECT TO public USING (true);
CREATE POLICY "post_tag_item_insert" ON post_tag_item FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "post_tag_item_update" ON post_tag_item FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "post_tag_item_delete" ON post_tag_item FOR DELETE TO authenticated USING (true);

CREATE POLICY "post_comments_select" ON post_comments FOR SELECT TO public USING (true);
CREATE POLICY "post_comments_insert" ON post_comments FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "post_comments_update" ON post_comments FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "post_comments_delete" ON post_comments FOR DELETE TO authenticated USING (true);

CREATE POLICY "post_assets_select" ON post_assets FOR SELECT TO public USING (true);
CREATE POLICY "post_assets_insert" ON post_assets FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "post_assets_update" ON post_assets FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "post_assets_delete" ON post_assets FOR DELETE TO authenticated USING (true);

-- Storage buckets（文章封面、文章內圖片），非登入者可讀
INSERT INTO storage.buckets (id, name, public)
VALUES
  ('cover_image', 'cover_image', true),
  ('images', 'images', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- RLS：允許所有人讀取 cover_image、images bucket 的物件
CREATE POLICY "Public read cover_image"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'cover_image');

CREATE POLICY "Public read images"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'images');

CREATE POLICY "Allow authenticated uploads to images"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'images');

GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;