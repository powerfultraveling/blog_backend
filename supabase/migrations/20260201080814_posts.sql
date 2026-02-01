
  create table "public"."post_assets" (
    "id" uuid not null default gen_random_uuid(),
    "post_id" uuid not null,
    "path" text not null,
    "created_at" timestamp with time zone default now()
      );



  create table "public"."post_categories" (
    "id" uuid not null default gen_random_uuid(),
    "slug" text not null,
    "name" text not null,
    "created_at" timestamp with time zone default now()
      );



  create table "public"."post_comments" (
    "id" uuid not null default gen_random_uuid(),
    "post_id" uuid not null,
    "profile_id" uuid,
    "nickname" character varying,
    "content" text not null,
    "status" character varying default 'approved'::character varying,
    "created_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );



  create table "public"."post_tag_item" (
    "id" uuid not null default gen_random_uuid(),
    "post_id" uuid not null,
    "tag_id" uuid not null,
    "created_at" timestamp with time zone default now()
      );



  create table "public"."post_tags" (
    "id" uuid not null default gen_random_uuid(),
    "slug" text not null,
    "name" text not null,
    "created_at" timestamp with time zone default now()
      );



  create table "public"."posts" (
    "id" uuid not null default gen_random_uuid(),
    "post_category_id" uuid not null,
    "profile_id" uuid,
    "title" character varying not null,
    "subtitle" character varying,
    "content" text,
    "status" character varying default 'draft'::character varying,
    "published_at" timestamp with time zone,
    "created_at" timestamp with time zone default now(),
    "deleted_at" timestamp with time zone
      );


CREATE INDEX idx_comments_post ON public.post_comments USING btree (post_id);

CREATE INDEX idx_posts_category ON public.posts USING btree (post_category_id);

CREATE INDEX idx_posts_status ON public.posts USING btree (status);

CREATE UNIQUE INDEX post_assets_pkey ON public.post_assets USING btree (id);

CREATE UNIQUE INDEX post_categories_pkey ON public.post_categories USING btree (id);

CREATE UNIQUE INDEX post_categories_slug_key ON public.post_categories USING btree (slug);

CREATE UNIQUE INDEX post_comments_pkey ON public.post_comments USING btree (id);

CREATE UNIQUE INDEX post_tag_item_pkey ON public.post_tag_item USING btree (id);

CREATE UNIQUE INDEX post_tags_pkey ON public.post_tags USING btree (id);

CREATE UNIQUE INDEX post_tags_slug_key ON public.post_tags USING btree (slug);

CREATE UNIQUE INDEX posts_pkey ON public.posts USING btree (id);

alter table "public"."post_assets" add constraint "post_assets_pkey" PRIMARY KEY using index "post_assets_pkey";

alter table "public"."post_categories" add constraint "post_categories_pkey" PRIMARY KEY using index "post_categories_pkey";

alter table "public"."post_comments" add constraint "post_comments_pkey" PRIMARY KEY using index "post_comments_pkey";

alter table "public"."post_tag_item" add constraint "post_tag_item_pkey" PRIMARY KEY using index "post_tag_item_pkey";

alter table "public"."post_tags" add constraint "post_tags_pkey" PRIMARY KEY using index "post_tags_pkey";

alter table "public"."posts" add constraint "posts_pkey" PRIMARY KEY using index "posts_pkey";

alter table "public"."post_assets" add constraint "post_assets_post_id_fkey" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE not valid;

alter table "public"."post_assets" validate constraint "post_assets_post_id_fkey";

alter table "public"."post_categories" add constraint "post_categories_slug_key" UNIQUE using index "post_categories_slug_key";

alter table "public"."post_comments" add constraint "post_comments_post_id_fkey" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE not valid;

alter table "public"."post_comments" validate constraint "post_comments_post_id_fkey";

alter table "public"."post_comments" add constraint "post_comments_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES public.profiles(id) not valid;

alter table "public"."post_comments" validate constraint "post_comments_profile_id_fkey";

alter table "public"."post_tag_item" add constraint "post_tag_item_post_id_fkey" FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE not valid;

alter table "public"."post_tag_item" validate constraint "post_tag_item_post_id_fkey";

alter table "public"."post_tag_item" add constraint "post_tag_item_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES public.post_tags(id) ON DELETE CASCADE not valid;

alter table "public"."post_tag_item" validate constraint "post_tag_item_tag_id_fkey";

alter table "public"."post_tags" add constraint "post_tags_slug_key" UNIQUE using index "post_tags_slug_key";

alter table "public"."posts" add constraint "posts_post_category_id_fkey" FOREIGN KEY (post_category_id) REFERENCES public.post_categories(id) not valid;

alter table "public"."posts" validate constraint "posts_post_category_id_fkey";

alter table "public"."posts" add constraint "posts_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES public.profiles(id) not valid;

alter table "public"."posts" validate constraint "posts_profile_id_fkey";

grant delete on table "public"."post_assets" to "anon";

grant insert on table "public"."post_assets" to "anon";

grant references on table "public"."post_assets" to "anon";

grant select on table "public"."post_assets" to "anon";

grant trigger on table "public"."post_assets" to "anon";

grant truncate on table "public"."post_assets" to "anon";

grant update on table "public"."post_assets" to "anon";

grant delete on table "public"."post_assets" to "authenticated";

grant insert on table "public"."post_assets" to "authenticated";

grant references on table "public"."post_assets" to "authenticated";

grant select on table "public"."post_assets" to "authenticated";

grant trigger on table "public"."post_assets" to "authenticated";

grant truncate on table "public"."post_assets" to "authenticated";

grant update on table "public"."post_assets" to "authenticated";

grant delete on table "public"."post_assets" to "service_role";

grant insert on table "public"."post_assets" to "service_role";

grant references on table "public"."post_assets" to "service_role";

grant select on table "public"."post_assets" to "service_role";

grant trigger on table "public"."post_assets" to "service_role";

grant truncate on table "public"."post_assets" to "service_role";

grant update on table "public"."post_assets" to "service_role";

grant delete on table "public"."post_categories" to "anon";

grant insert on table "public"."post_categories" to "anon";

grant references on table "public"."post_categories" to "anon";

grant select on table "public"."post_categories" to "anon";

grant trigger on table "public"."post_categories" to "anon";

grant truncate on table "public"."post_categories" to "anon";

grant update on table "public"."post_categories" to "anon";

grant delete on table "public"."post_categories" to "authenticated";

grant insert on table "public"."post_categories" to "authenticated";

grant references on table "public"."post_categories" to "authenticated";

grant select on table "public"."post_categories" to "authenticated";

grant trigger on table "public"."post_categories" to "authenticated";

grant truncate on table "public"."post_categories" to "authenticated";

grant update on table "public"."post_categories" to "authenticated";

grant delete on table "public"."post_categories" to "service_role";

grant insert on table "public"."post_categories" to "service_role";

grant references on table "public"."post_categories" to "service_role";

grant select on table "public"."post_categories" to "service_role";

grant trigger on table "public"."post_categories" to "service_role";

grant truncate on table "public"."post_categories" to "service_role";

grant update on table "public"."post_categories" to "service_role";

grant delete on table "public"."post_comments" to "anon";

grant insert on table "public"."post_comments" to "anon";

grant references on table "public"."post_comments" to "anon";

grant select on table "public"."post_comments" to "anon";

grant trigger on table "public"."post_comments" to "anon";

grant truncate on table "public"."post_comments" to "anon";

grant update on table "public"."post_comments" to "anon";

grant delete on table "public"."post_comments" to "authenticated";

grant insert on table "public"."post_comments" to "authenticated";

grant references on table "public"."post_comments" to "authenticated";

grant select on table "public"."post_comments" to "authenticated";

grant trigger on table "public"."post_comments" to "authenticated";

grant truncate on table "public"."post_comments" to "authenticated";

grant update on table "public"."post_comments" to "authenticated";

grant delete on table "public"."post_comments" to "service_role";

grant insert on table "public"."post_comments" to "service_role";

grant references on table "public"."post_comments" to "service_role";

grant select on table "public"."post_comments" to "service_role";

grant trigger on table "public"."post_comments" to "service_role";

grant truncate on table "public"."post_comments" to "service_role";

grant update on table "public"."post_comments" to "service_role";

grant delete on table "public"."post_tag_item" to "anon";

grant insert on table "public"."post_tag_item" to "anon";

grant references on table "public"."post_tag_item" to "anon";

grant select on table "public"."post_tag_item" to "anon";

grant trigger on table "public"."post_tag_item" to "anon";

grant truncate on table "public"."post_tag_item" to "anon";

grant update on table "public"."post_tag_item" to "anon";

grant delete on table "public"."post_tag_item" to "authenticated";

grant insert on table "public"."post_tag_item" to "authenticated";

grant references on table "public"."post_tag_item" to "authenticated";

grant select on table "public"."post_tag_item" to "authenticated";

grant trigger on table "public"."post_tag_item" to "authenticated";

grant truncate on table "public"."post_tag_item" to "authenticated";

grant update on table "public"."post_tag_item" to "authenticated";

grant delete on table "public"."post_tag_item" to "service_role";

grant insert on table "public"."post_tag_item" to "service_role";

grant references on table "public"."post_tag_item" to "service_role";

grant select on table "public"."post_tag_item" to "service_role";

grant trigger on table "public"."post_tag_item" to "service_role";

grant truncate on table "public"."post_tag_item" to "service_role";

grant update on table "public"."post_tag_item" to "service_role";

grant delete on table "public"."post_tags" to "anon";

grant insert on table "public"."post_tags" to "anon";

grant references on table "public"."post_tags" to "anon";

grant select on table "public"."post_tags" to "anon";

grant trigger on table "public"."post_tags" to "anon";

grant truncate on table "public"."post_tags" to "anon";

grant update on table "public"."post_tags" to "anon";

grant delete on table "public"."post_tags" to "authenticated";

grant insert on table "public"."post_tags" to "authenticated";

grant references on table "public"."post_tags" to "authenticated";

grant select on table "public"."post_tags" to "authenticated";

grant trigger on table "public"."post_tags" to "authenticated";

grant truncate on table "public"."post_tags" to "authenticated";

grant update on table "public"."post_tags" to "authenticated";

grant delete on table "public"."post_tags" to "service_role";

grant insert on table "public"."post_tags" to "service_role";

grant references on table "public"."post_tags" to "service_role";

grant select on table "public"."post_tags" to "service_role";

grant trigger on table "public"."post_tags" to "service_role";

grant truncate on table "public"."post_tags" to "service_role";

grant update on table "public"."post_tags" to "service_role";

grant delete on table "public"."posts" to "anon";

grant insert on table "public"."posts" to "anon";

grant references on table "public"."posts" to "anon";

grant select on table "public"."posts" to "anon";

grant trigger on table "public"."posts" to "anon";

grant truncate on table "public"."posts" to "anon";

grant update on table "public"."posts" to "anon";

grant delete on table "public"."posts" to "authenticated";

grant insert on table "public"."posts" to "authenticated";

grant references on table "public"."posts" to "authenticated";

grant select on table "public"."posts" to "authenticated";

grant trigger on table "public"."posts" to "authenticated";

grant truncate on table "public"."posts" to "authenticated";

grant update on table "public"."posts" to "authenticated";

grant delete on table "public"."posts" to "service_role";

grant insert on table "public"."posts" to "service_role";

grant references on table "public"."posts" to "service_role";

grant select on table "public"."posts" to "service_role";

grant trigger on table "public"."posts" to "service_role";

grant truncate on table "public"."posts" to "service_role";

grant update on table "public"."posts" to "service_role";


