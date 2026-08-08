-- Wardrobe — database setup
-- Paste this whole file into Supabase → SQL Editor → New query → Run.
-- Safe to run more than once.

-- ---------------------------------------------------------------- tables

create table if not exists items (
  id          text primary key,
  owner       text not null check (owner in ('her', 'his')),
  cat         text not null default 'Other',
  name        text not null default '',
  img         text not null default '',
  created_at  timestamptz not null default now()
);

create table if not exists closet_settings (
  owner  text primary key check (owner in ('her', 'his')),
  cats   jsonb not null default '[]'::jsonb
);

create table if not exists trips (
  id          text primary key,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

create table if not exists outfits (
  id    text primary key,
  data  jsonb not null
);

create index if not exists items_owner_idx on items (owner);

-- ------------------------------------------------------------------ locks
-- Row level security is ON, and only signed-in accounts can read or write.
-- Anyone who finds the site without an account sees nothing at all.

alter table items           enable row level security;
alter table closet_settings enable row level security;
alter table trips           enable row level security;
alter table outfits         enable row level security;

drop policy if exists "signed in" on items;
drop policy if exists "signed in" on closet_settings;
drop policy if exists "signed in" on trips;
drop policy if exists "signed in" on outfits;

create policy "signed in" on items
  for all to authenticated using (true) with check (true);
create policy "signed in" on closet_settings
  for all to authenticated using (true) with check (true);
create policy "signed in" on trips
  for all to authenticated using (true) with check (true);
create policy "signed in" on outfits
  for all to authenticated using (true) with check (true);

-- --------------------------------------------------------------- live sync
-- Lets one person's change appear on the other person's screen.

do $$
begin
  begin execute 'alter publication supabase_realtime add table items';           exception when others then null; end;
  begin execute 'alter publication supabase_realtime add table closet_settings'; exception when others then null; end;
  begin execute 'alter publication supabase_realtime add table trips';           exception when others then null; end;
  begin execute 'alter publication supabase_realtime add table outfits';         exception when others then null; end;
end $$;
