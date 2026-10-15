# Part 0 (A): Preparation: get RottenPotatoes running locally

## GitHub setup

You instructors will have told you whether you should be using a personal GitHub repository for this assignment, or whether you should be using a local git repository only.

### Personal GitHub Repository

As in previous CHIPS, you will need to authenticate `git` with GitHub to clone the repository for this assignment. The clone URL below will require that you use [public key authentication](https://docs.codio.com/common/settings/github.html).

If you course staff has provided you with a GitHub repository for this assignment, you should clone that repository using the organuzation name and repository name provided to you.

```sh
git clone git@github.com:cs169/fa23-YOUR_GITHUB_USERNAME-chips-5.3.git rottenpotatoes-rails-intro
cd rottenpotatoes-rails-intro
```

### Template Repository (local git only)

If you are not using a personal repository, you can clone the template repository directly. This will create a local git repository on your machine, but it will not be connected to any remote repository on GitHub. You **should** still use git locally to manage your changes, but you won't be able to push your changes to GitHub.

```sh
git clone git@github.com:saasbook/hw-rails-intro.git rottenpotatoes-rails-intro
cd rottenpotatoes-rails-intro
```

Since this repository isn't shared with your team, you *can* push directly to the `main` branch. Still, it's a good habit to get into the practice of making a branch for changes you want to make, so you can later create a pull request before merging into `main` (which gives you the power to document your sets of commits thoroughly).

A good name for this branch would be something like `add-filtering`, which is descriptive of the feature you'll be adding in the next part of this assignment. You're also welcome to continue to choose a pair programming partner in your team for this CHIPS, in which case you should pick a repository to use between the two of you and add the other member as a collaborator to the repository. If you work in a pair, you should add both team members' GitHub usernames to the branch name so we can more easily see who worked with whom.

```
git checkout -b <BRANCH_NAME>
git push -u origin <BRANCH_NAME>
```

You will now have a local branch to make edits that is connected to an identically named remote branch on the GitHub repo to which you should push frequently using the following commands:

```sh
git status # review your changes
git add [...] # you will need to include your own files!
git commit -m "your message here"
git push origin
```

---

Whenever you start working on a Rails project, the first thing you should do is to run Bundler, to make sure all the app's gems are installed.  Switch to the app's root directory (presumably `rottenpotatoes-rails-intro`) and run `bundle config set without 'production'` (you only need to specify `without 'production'` the first time, as this setting will be remembered on future runs of Bundler for this project).

Finally, run the initial migration, which (since it's the very first migration) will also create the database itself:

```sh
bundle exec rails db:migrate
```

You can probably get away with just running `rails db:migrate` directly, but starting with your commands with `bundle exec` asks bundler to run the command in the context of the dependencies specified in the current app's Gemfile (rather than potentially pulling in a version of `rails` installed globally on the server you're using, which can cause dependency headaches down the line). It's a good havit to get into.

<details>
  <summary><strong>Self Check Question:</strong> How does Rails decide where and how to create the development database? (Hint: check the <code>db</code> and <code>config</code> subdirectories)</summary>
  <p><blockquote>The <code>rails db:migrate</code> command creates a local development database (following the specifications in <code>config/database.yml</code>) and runs the migrations in <code>db/migrate</code> to create the app's schema.  It also creates/updates the file <code>db/schema.rb</code> to reflect the latest database schema.  <strong>Note: it's important to keep this file under version control.</strong> </blockquote></p>
</details>
<br />

<details>
  <summary><strong>Self Check Question:</strong> What tables got created by the migrations?</summary>
  <p><blockquote>The <code>movies</code> table itself and the rails-internal <code>schema_migrations</code> table that records which migrations have been run. You can run <code>sqlite3 storage/development.sqlite3</code> and then <code>.tables</code> to check all the tables in the database. (Press <code>Ctrl+D</code> to exit.)</blockquote></p>
</details>
<br />

Now insert "seed data" into the database. (_Seeds_ are initial data items that the app needs to run):

```sh
bundle exec rails db:seed
```

<details>
  <summary><strong>Self Check Question:</strong> What seed data was inserted and where was it specified? (Hint: <code>rake -T db:seed</code> explains the seed task; <code>rake -T</code> explains other available Rake tasks)</summary>
  <p><blockquote>A set of movie data which is specified in <code>db/seeds.rb</code></blockquote></p>
</details>
<br />

At this point you should be able to run the app locally and visit it from a browser to make sure it's working before you go on.

Follow the instructions below to run and preview a Rails app locally -- the steps are a bit different depending on whether you're using Codio.

## If developing in Codio

You can click the `Box URL` button like in previous CHIPS. If you want to do it manually, you can obtain your Codio subdomain name by going into any Codio terminal window and saying `hostname`.  Your subdomain will be a pair of random words--in this example we'll pretend it's `luminous-coconut`.

1. Start the app in a terminal:  `bundle exec rails server -b 0.0.0.0` (again, `bundle exec` probably isn't necessary, but it's good to use it anyway!)
2. Open a regular browser window to  `luminous-coconut-3000.codio.io` to visit the app's home page

## If developing Locally

If you're developing locally, the steps would instead be these:

1. Start the app in a terminal: `bundle exec rails server`  (omit `-b 0.0.0.0`)
2. Open a regular browser window to `localhost:3000/` to visit the app's home page (note the `:3000` rather than `-3000`)

---

[← Modifying RottenPotatoes](01-Modifying-RottenPotatoes.md) | [Contents](README.md) | [Part 0 (B): Preparation: deploy to the cloud →](03-Part-0--B---Preparation--deploy-to-Heroku.md)
