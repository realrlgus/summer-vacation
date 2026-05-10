# Summer Vacation

Friends travel planning and voting website.

## Stack

- Vite
- React
- TypeScript
- Supabase
- GitHub Pages

## Local Setup

```bash
npm install
npm run dev
```

Create `.env.local` from `.env.example`:

```bash
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=your-publishable-key
```

## Supabase

The schema lives in `supabase/migrations`.

Apply it after logging in and linking the project:

```bash
supabase login --token <access-token>
supabase link --project-ref <project-ref>
supabase db push
```

If direct database access resolves to IPv6 only on the current network, use the
Supabase Dashboard `Connect` panel and copy the Session pooler connection string.
Then run:

```bash
supabase db push --db-url "<session-pooler-connection-string>"
```

Do not store database passwords, secret keys, or service role keys in frontend
environment files.

## GitHub Pages

The deploy workflow reads these repository variables:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_PUBLISHABLE_KEY`
