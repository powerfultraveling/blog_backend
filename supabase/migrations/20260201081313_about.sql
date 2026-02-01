
  create table "public"."about_categories" (
    "id" uuid not null default gen_random_uuid(),
    "slug" text not null,
    "name" text not null,
    "created_at" timestamp with time zone default now()
      );



  create table "public"."about_items" (
    "id" uuid not null default gen_random_uuid(),
    "about_category_id" uuid,
    "content" text not null,
    "sort_order" integer default 0,
    "created_at" timestamp with time zone default now()
      );


CREATE UNIQUE INDEX about_categories_pkey ON public.about_categories USING btree (id);

CREATE UNIQUE INDEX about_categories_slug_key ON public.about_categories USING btree (slug);

CREATE UNIQUE INDEX about_items_pkey ON public.about_items USING btree (id);

alter table "public"."about_categories" add constraint "about_categories_pkey" PRIMARY KEY using index "about_categories_pkey";

alter table "public"."about_items" add constraint "about_items_pkey" PRIMARY KEY using index "about_items_pkey";

alter table "public"."about_categories" add constraint "about_categories_slug_key" UNIQUE using index "about_categories_slug_key";

alter table "public"."about_items" add constraint "about_items_about_category_id_fkey" FOREIGN KEY (about_category_id) REFERENCES public.about_categories(id) ON DELETE CASCADE not valid;

alter table "public"."about_items" validate constraint "about_items_about_category_id_fkey";

grant delete on table "public"."about_categories" to "anon";

grant insert on table "public"."about_categories" to "anon";

grant references on table "public"."about_categories" to "anon";

grant select on table "public"."about_categories" to "anon";

grant trigger on table "public"."about_categories" to "anon";

grant truncate on table "public"."about_categories" to "anon";

grant update on table "public"."about_categories" to "anon";

grant delete on table "public"."about_categories" to "authenticated";

grant insert on table "public"."about_categories" to "authenticated";

grant references on table "public"."about_categories" to "authenticated";

grant select on table "public"."about_categories" to "authenticated";

grant trigger on table "public"."about_categories" to "authenticated";

grant truncate on table "public"."about_categories" to "authenticated";

grant update on table "public"."about_categories" to "authenticated";

grant delete on table "public"."about_categories" to "service_role";

grant insert on table "public"."about_categories" to "service_role";

grant references on table "public"."about_categories" to "service_role";

grant select on table "public"."about_categories" to "service_role";

grant trigger on table "public"."about_categories" to "service_role";

grant truncate on table "public"."about_categories" to "service_role";

grant update on table "public"."about_categories" to "service_role";

grant delete on table "public"."about_items" to "anon";

grant insert on table "public"."about_items" to "anon";

grant references on table "public"."about_items" to "anon";

grant select on table "public"."about_items" to "anon";

grant trigger on table "public"."about_items" to "anon";

grant truncate on table "public"."about_items" to "anon";

grant update on table "public"."about_items" to "anon";

grant delete on table "public"."about_items" to "authenticated";

grant insert on table "public"."about_items" to "authenticated";

grant references on table "public"."about_items" to "authenticated";

grant select on table "public"."about_items" to "authenticated";

grant trigger on table "public"."about_items" to "authenticated";

grant truncate on table "public"."about_items" to "authenticated";

grant update on table "public"."about_items" to "authenticated";

grant delete on table "public"."about_items" to "service_role";

grant insert on table "public"."about_items" to "service_role";

grant references on table "public"."about_items" to "service_role";

grant select on table "public"."about_items" to "service_role";

grant trigger on table "public"."about_items" to "service_role";

grant truncate on table "public"."about_items" to "service_role";

grant update on table "public"."about_items" to "service_role";


