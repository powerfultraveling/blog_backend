alter table "public"."post_assets" enable row level security;

alter table "public"."post_categories" enable row level security;

alter table "public"."post_comments" enable row level security;

alter table "public"."post_tag_item" enable row level security;

alter table "public"."post_tags" enable row level security;

alter table "public"."posts" enable row level security;


  create policy "post_assets_delete"
  on "public"."post_assets"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "post_assets_insert"
  on "public"."post_assets"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "post_assets_select"
  on "public"."post_assets"
  as permissive
  for select
  to public
using (true);



  create policy "post_assets_update"
  on "public"."post_assets"
  as permissive
  for update
  to authenticated
using (true)
with check (true);



  create policy "post_categories_delete"
  on "public"."post_categories"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "post_categories_insert"
  on "public"."post_categories"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "post_categories_select"
  on "public"."post_categories"
  as permissive
  for select
  to public
using (true);



  create policy "post_categories_update"
  on "public"."post_categories"
  as permissive
  for update
  to authenticated
using (true)
with check (true);



  create policy "post_comments_delete"
  on "public"."post_comments"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "post_comments_insert"
  on "public"."post_comments"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "post_comments_select"
  on "public"."post_comments"
  as permissive
  for select
  to public
using (true);



  create policy "post_comments_update"
  on "public"."post_comments"
  as permissive
  for update
  to authenticated
using (true)
with check (true);



  create policy "post_tag_item_delete"
  on "public"."post_tag_item"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "post_tag_item_insert"
  on "public"."post_tag_item"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "post_tag_item_select"
  on "public"."post_tag_item"
  as permissive
  for select
  to public
using (true);



  create policy "post_tag_item_update"
  on "public"."post_tag_item"
  as permissive
  for update
  to authenticated
using (true)
with check (true);



  create policy "post_tags_delete"
  on "public"."post_tags"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "post_tags_insert"
  on "public"."post_tags"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "post_tags_select"
  on "public"."post_tags"
  as permissive
  for select
  to public
using (true);



  create policy "post_tags_update"
  on "public"."post_tags"
  as permissive
  for update
  to authenticated
using (true)
with check (true);



  create policy "posts_delete"
  on "public"."posts"
  as permissive
  for delete
  to authenticated
using (true);



  create policy "posts_insert"
  on "public"."posts"
  as permissive
  for insert
  to authenticated
with check (true);



  create policy "posts_select"
  on "public"."posts"
  as permissive
  for select
  to public
using (true);



  create policy "posts_update"
  on "public"."posts"
  as permissive
  for update
  to authenticated
using (true)
with check (true);



