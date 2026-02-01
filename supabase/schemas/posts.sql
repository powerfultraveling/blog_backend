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
  status varchar DEFAULT 'draft', -- draft, published, deleted
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
