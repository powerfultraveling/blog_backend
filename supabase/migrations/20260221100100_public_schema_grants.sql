-- authenticated 沒有 public schema 的 USAGE 會出現 42501 permission denied
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
