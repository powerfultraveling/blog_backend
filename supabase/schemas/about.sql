-- 關於我模組
CREATE TABLE "about_categories" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "slug" text UNIQUE NOT NULL,
  "name" text NOT NULL,
  "created_at" timestamptz DEFAULT now()
);

CREATE TABLE "about_items" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "about_category_id" uuid REFERENCES "about_categories"("id") ON DELETE CASCADE,
  "content" text NOT NULL,
  "sort_order" integer DEFAULT 0, -- 增加排序功能，這對條列式介紹很重要
  "created_at" timestamptz DEFAULT now()
);