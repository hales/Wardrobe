# Wardrobe — setup

Three stages, about twenty minutes. Two of them are just clicking through signup forms.

You need: a Supabase account (free), a Netlify account (free). Both accept a Google login, so no new passwords.

---

## 1. The database — about 8 minutes

**Create the project**

1. Go to supabase.com and sign up.
2. Click **New project**. Name it anything. Pick the region closest to you — Europe if you're mostly there.
3. It asks for a database password. Generate one and save it in your password manager. You won't need it day to day.
4. Wait a minute or two while it builds.

**Create the tables**

5. In the left sidebar, click **SQL Editor**, then **New query**.
6. Open `schema.sql` from this folder, copy everything in it, paste it in, and click **Run**.
7. You should see "Success. No rows returned." That's correct — it built empty tables.

**Lock the door**

This is the step that keeps strangers out, so don't skip it.

8. In the sidebar go to **Authentication → Sign In / Providers** (some versions call it Providers).
9. Find **Allow new users to sign up** and turn it **off**.

   Now nobody can create an account, which means nobody can see your data — including anyone who stumbles onto the URL.

10. Go to **Authentication → Users** and click **Add user → Create new user**. Add your email address. Repeat for your husband's.

    Tick "Auto Confirm User" if it offers, so no confirmation email is needed.

**Copy your two keys**

11. Go to **Project Settings → API**.
12. Copy the **Project URL**. It looks like `https://abcdefgh.supabase.co`.
13. Copy the **anon public** key. It's a long string starting with `eyJ`. This one is safe to put in a web page — it's designed for that, and the rules you set in step 7 mean it can't read anything without a signed-in account.

---

## 2. The app file — 1 minute

14. Open `index.html` in any plain text editor. TextEdit works; on a Mac use Format → Make Plain Text first.
15. Near the top you'll see a block that says PASTE YOUR TWO SUPABASE KEYS HERE.
16. Replace `PASTE_PROJECT_URL_HERE` with your Project URL and `PASTE_ANON_KEY_HERE` with your anon key, keeping the quote marks around each.
17. Save.

---

## 3. Putting it on the web — 5 minutes

18. Go to app.netlify.com/drop.
19. Drag the whole `rail-selfhosted` folder onto the page. It contains `index.html`, and that is the only file that needs to be there.
20. It gives you a live URL immediately, something like `blue-marmot-4f2a91.netlify.app`.
21. Click **Site configuration → Change site name** to make it something you'll remember — `our-wardrobe`, say.

**Tell Supabase about the URL**

22. Back in Supabase, go to **Authentication → URL Configuration**.
23. Set **Site URL** to your Netlify address, including the `https://`.
24. Add the same address under **Redirect URLs**.

    Without this, the sign-in email will send you to the wrong place.

25. Open your site. Enter your email. Click the link it sends you. You're in.

Send your husband the URL. He signs in with his own email and sees the same closet.

---

## Adding it to your phone's home screen

On iPhone: open the site in Safari, tap Share, then **Add to Home Screen**. It gets an icon and opens without browser chrome, so it behaves like an app.

---

## Changing anything later

Edit `index.html`, then drag the folder onto Netlify again. It replaces the old version. Your data lives in Supabase and isn't touched.

---

## Worth knowing

**Cost.** Both free tiers are far more than this needs. Supabase pauses a project after a week with no activity — opening the site wakes it, which takes a few seconds. Using it every few weeks keeps it awake.

**Backups.** Supabase's free tier doesn't keep automatic backups. If the closet ever represents real work, go to Table Editor, pick a table, and use Export to CSV every so often.

**Photos.** On upload, each photo has its background stripped, is cropped tight to the garment, and is stored in the database as text. That keeps setup to a single file. A few hundred pieces is comfortable; well past that, the right move is Supabase Storage — ask me and I'll convert it.

**Where the two of you can collide.** Edits sync within a few seconds. If you both edit the *same day of the same trip* in the same moment, the later save wins. Different days, different trips, or different closets are all safe.

**The site is public, the data is not.** Anyone with the URL sees a sign-in screen and nothing else. The page carries a no-index tag so search engines skip it.
