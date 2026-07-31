Deploying `5-GREEN-CHAT` (Fly.io)

This guide shows a free-friendly option (Fly.io) that runs a container and can provide a persistent volume so you won't see Render's loading splash page.

Pre-reqs
- Fly CLI: https://fly.io/docs/hands-on/install-flyctl/
- Docker installed locally (only required to build image locally, Fly can also build remotely)
- A Fly account (free tier available)

Steps

1) Login to Fly

```bash
fly auth login
```

2) Create & launch your app (run inside the project folder)

```bash
# from project root
fly launch --name 5-green-chat --no-deploy
```

The `--no-deploy` flag prevents immediate deploy so you can create a persistent volume before the first deploy.

3) Create a persistent volume (10 GB example)

```bash
fly volumes create data-vol --region ord --size 10
```

Choose a `--region` nearest you (eg `iad`, `ord`, `mia`).

4) Edit `fly.toml` to mount the volume at `/app/data`

Add under the `[[mounts]]` section (or create it):

```toml
[[mounts]]
source = "data-vol"
destination = "/app/data"
```

5) Deploy to Fly

```bash
fly deploy
```

6) Set environment variables (API keys, email creds)

```bash
fly secrets set EMAIL_USER=you@example.com EMAIL_PASS=yourpass
```

7) Open the app

```bash
fly open
```

Notes
- Fly's free tier provides small resources; for light classroom use it's usually sufficient.
- Using a mounted volume for `/app/data` keeps `data/data.json` persistent across deploys.
- If you prefer no Docker at all and full-managed DB, use Render or Railway but ensure you store data in Postgres or S3.

If you want, I can also create a `fly.toml` for you (with a placeholder app name) and push these files to your GitHub repository. Let me know and I'll update your repo now.
