
  create policy "Allow authenticated uploads to images"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check ((bucket_id = 'images'::text));



