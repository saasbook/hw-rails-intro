# Part 0 (B): Preparation: deploy to the cloud

RottenPotatoes stores its movies in a database, so deploying it means running
your code on a cloud host *and* giving that host a production database. The
instructions below cover two platforms: **Render** first, then **Heroku** at
the bottom of this page. Follow the one you were told to deploy on.

For CHIPS 5.3, you will need to complete the deployment to **your own
individual app**, not your team app. Even if you are pair programming, you
should complete a deployment on your own.

## Render

Render deploys from GitHub: you connect your repo once, and every later push to
the branch you chose rebuilds and redeploys the app. If you don't have an
account yet, sign up at https://render.com with your GitHub account, which
connects your repos in the same step.

Render will deploy from `main`, which is also the branch Parts 1-3 merge your
work into, so the production configuration below belongs on `main` too. First
commit the work you already have on your branch (you probably have a change in
the `db` folder):

```sh
git status # make sure you're on your new branch
git add [..] # stage the updated files
git commit -m [..] # write a message
git push origin <YOUR_BRANCH>
```

Then switch to `main` to make the two edits that follow:

```sh
git checkout main
```

### Point the production database at PostgreSQL

As in "Hello Rails", production on Render means PostgreSQL rather than the
SQLite database you develop against. The `pg` gem is already in the
`:production` group of your `Gemfile`, but `config/database.yml` still points
production at a local SQLite file, which will fail on Render. Replace its
`production:` section at the bottom of the file with:

```yaml
production:
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  url: <%= ENV['DATABASE_URL'] %>
```

`DATABASE_URL` is the connection string Render hands your app; you'll set it in
the dashboard below.

### Add a build script

Render's free tier gives you no production terminal, so migrations and seed data
have to run during the **build phase**, which happens every time you push.
Create a file `bin/render-build.sh` containing:

```sh
#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

bundle exec rails db:migrate
# Seed only when the table is empty, so redeploys don't duplicate the movies
bundle exec rails runner 'Rails.application.load_seed if Movie.count.zero?'
```

Make the script executable:

```sh
chmod +x bin/render-build.sh
```

### Generate your app's credentials

Rails signs the session cookie that Part 3 relies on with a secret called
`secret_key_base`, and it refuses to boot in production without one. Your app
doesn't have one yet, so generate it now (substitute your preferred editor for
`nano`):

```sh
EDITOR=nano bundle exec rails credentials:edit
```

That creates two files and opens the new credentials in the editor. Save and
exit without changing anything (in `nano`: `Ctrl+O`, `Enter`, `Ctrl+X`); Rails
has already filled in a random `secret_key_base` for you.

* `config/credentials.yml.enc` holds your encrypted secrets, and your app can't boot in production without it, so **commit it**.
* `config/master.key` is the key that decrypts them. It is already listed in `.gitignore` and must **never** be committed. You will paste its contents into Render instead.

Now commit and push all three changes:

```sh
git add config/database.yml bin/render-build.sh config/credentials.yml.enc
git commit -m "Configure the production database, Render build, and credentials"
git push origin main
```

### Create the database and the web service

1. Log in to the [Render Dashboard](https://dashboard.render.com/), click **New +** at the top right, and select **Postgres**.
2. Give it a **Name** (e.g. `chip-5-3-YOUR_NAME`), choose the **Free** plan, and click **Create Database**.
3. Once its status is "Available", find the **Connections** section and copy the **internal** connection URL: the one whose label starts with "Internal" and whose value starts with `postgresql://`. Do not use the external one.
4. Back on the dashboard, click **New +**, select **Web Service**, and connect the GitHub repo for this assignment.
5. Fill out these settings:
   * **Name:** `chip-5-3-YOUR_NAME` (this becomes part of your public URL, `https://<name>.onrender.com`)
   * **Language:** `Ruby`
   * **Branch:** `main`
   * **Build Command:** `./bin/render-build.sh`
   * **Start Command:** `bundle exec rails server`
   * **Instance Type:** `Free`
6. Under **Environment Variables**, add these two:
   * `DATABASE_URL` = the internal connection URL you copied in step 3
   * `RAILS_MASTER_KEY` = the contents of your local `config/master.key`, which is the one line of text in that file. Unlike Heroku, Render won't supply a secret for you, and Rails won't boot in production without one.
7. Click **Deploy Web Service**.

Render now clones your repo, runs your build script (installing gems,
precompiling assets, migrating and seeding the database), and starts the app
with Puma. Follow along in the build logs; when the service goes **Live**, open
the `https://<name>.onrender.com` URL shown at the top of its page. If a build
fails because you forgot to push a file, push the fix, or use the **Manual
Deploy** drop-down and choose **Clear build cache & deploy**.

> **Note:** free Render services spin down after 15 minutes of inactivity, and
> the first request after that takes about a minute to answer. That is normal,
> not a broken deploy, but do warm your app up before a demo or a submission.

From here on there is no separate deploy command: pushing to `main` is the
deploy. Run `git checkout <YOUR_BRANCH>` to get back to your feature work.

**Note:** don't proceed past this point until you are able to complete the above successfully, or you won't be able to receive a grade for this assignment!

## Heroku

If you were told to deploy on Heroku rather than Render, follow this section
instead of the Render one above.

### Initial Heroku Deployment

Log in to your Heroku account by typing the command: `heroku login -i` in the terminal. Provide your berkeley.edu (or approved alternative) email but when it asks for a password, instead you must find your **API Key** from the bottom of the [Account Settings page on Heroku](https://dashboard.heroku.com/account). Copy and paste this value in for the password.

For CHIPS 5.3, you will need to complete the Heroku deployment to **your own individual Heroku app**, not your team app. Even if you are pair programming, you should complete a deployment on your own. We have created a Heroku app for you based on your email address, and it can be found by running the `heroku apps` command in your shell:

```sh
heroku apps -t esaas # "esaas" is the name of the Heroku team your app is in
```

Find the name of your personal app, then use it in the commands below. We'll add Heroku to your git repo as a remote named `heroku`, as we have done in the past, so you can deploy to the app.

```
heroku apps:favorites:add -a <HEROKU_APP_NAME>
heroku git:remote -a <HEROKU_APP_NAME>
```

A "stack" is a term that describes the operating system and default software that you application is running on. Heroku has a [large set of stacks](https://devcenter.heroku.com/articles/stack) you can select from. In this case, `heroku-24` includes the right versions of rails.

If you haven't yet made a commit to your new branch, do that now (you probably have a change in the `db` folder):

```sh
git status # make sure you're on your new branch
git add [..] # stage the updated files
git commit -m [..] # write a message
```

Now, push your current branch to the Heroku remote's `main` branch:

```sh
git push heroku <YOUR_BRANCH>:main
```

(You may see the following warning the first time - it's fine. Answer "yes", and in the future you shouldn't see it anymore:)

    The authenticity of host 'heroku.com (50.19.85.132)' can't be established.
    RSA key fingerprint is 8b:48:5e:67:0e:c9:16:47:32:f2:87:0c:1f:c8:60:ad.
    Are you sure you want to continue connecting (yes/no)?
    Please type 'yes' or 'no':

Is the app running on Heroku? If you navigate to the heroku URL that is printed above the blue text at the end of the results from `git push heroku master` you'll get a "We're sorry, but something went wrong." error in the browser.

As with the previous assignment "Hello Rails", `heroku logs` tell us that the `movies` table doesn't exist. So, as before, run the initial migration and import the seed data:

```sh
heroku run bundle exec rails db:setup
# or, if that doesn't work:
heroku run bundle exec rails db:migrate
heroku run bundle exec rails db:seed
```

Since you're starting from a fresh Heroku app, the deployment should have detected your Postgres dependency and added the Postgres addon for you. If not, though, you'll get an error from the rake commands, and you should attach the addon manually:

```sh
heroku addons -a <HEROKU_APP_NAME> # make sure the postgres addon doesn't already exist
heroku addons:create heroku-postgresql -a <HEROKU_APP_NAME> # if necessary
```


Now you should be able to navigate to your app's URL.

**Note:** don't proceed past this point until you are able to complete the above successfully, or you won't be able to receive a grade for this assignment!

---

[← Part 0 (A): Preparation: get RottenPotatoes running locally](02-Part-0--A---Preparation--get-RottenPotatoes-running-locally.md) | [Contents](README.md) | [Part 1: Filter the list of movies by rating →](04-Part-1--Filter-the-list-of-movies-by-rating.md)
