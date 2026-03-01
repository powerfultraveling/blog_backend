
  create policy "Public read cover_image"
  on "storage"."objects"
  as permissive
  for select
  to public
using ((bucket_id = 'cover_image'::text));



  create policy "Public read images"
  on "storage"."objects"
  as permissive
  for select
  to public
using ((bucket_id = 'images'::text));



