## Part 0 (A): Preparation: get RottenPotatoes running locally


 The actual RottenPotatoes starter app you will use is in another
 public repo:
 [saasbook/rottenpotatoes-rails-intro](https://github.com/saasbook/rottenpotatoes-rails-intro).
 On that repo's GitHub page, click "Use This Template", which will
 create a new copy of the repo in your GitHub account.  **Do not fork
 the repo** since we don't intend to accept pull requests from student assignments!

Once you have a copy of the repo in your own GitHub account, clone it
into your development environment:

 ```sh
 $ git clone git@github.com:[your_github_username]/rottenpotatoes-rails-intro.git
 ```

(Note: this assumes you have connected your GitHub account to your
development environment.  Here is  [how to do it for
Codio](https://docs.codio.com/dashboard/account/#adding-your-public-key-to-github-or-bitbucket) 
and [how to do it for generic Mac/Windows/Un*x environments](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).)

Whenever you start working on a Rails project, the first thing you should do is to run Bundler, to make sure all the app's gems are installed.  Switch to the app's root directory (presumably `rottenpotatoes-rails-intro`) and run `bundle install --without production` (you only need to specify `--without production` the first time, as this setting will be remembered on future runs of Bundler for this project).

Finally, run the initial migration, which (since it's the very first
migration) will also create the database itself:

```sh
$ bin/rake db:migrate
```

**NOTE:** `bin/rake` and `bin/rails`, or just `rake` and `rails`?
If you're using one of the recommended development setups (either
using Codio, or managing your own development environment with `rvm`),
then the execution path (`$PATH` in Un*x parlance) should be correctly
set so that the correct version of `rake` or `rails` appears earliest
in the path.  If you're using a nonstandard development environment,
or if these commands behave weirdly, saying `bin/rake` or `bin/rails`
will force using the version in your Rails app's `bin/` directory.
Whenever these instructions say to run `rake` or `rails`, it is always
safe to substitute `bin/rake` or `bin/rails`, especially if the
commands aren't behaving the way we say they should.


<details>
  <summary><strong>Self Check Question:</strong> How does Rails decide where and how to create the development database? (Hint: check the <code>db</code> and <code>config</code> subdirectories)</summary>
  <p><blockquote>The <code>rake db:migrate</code> command creates a local development database (following the specifications in <code>config/database.yml</code>) and runs the migrations in <code>db/migrate</code> to create the app's schema.  It also creates/updates the file <code>db/schema.rb</code> to reflect the latest database schema.  <strong>Note: it's important to keep this file under version control.</strong> </blockquote></p>
</details>
<br />

<details>
  <summary><strong>Self Check Question:</strong> What tables got created by the migrations?</summary>
  <p><blockquote>The <code>movies</code> table itself and the rails-internal <code>schema_migrations</code> table that records which migrations have been run.</blockquote></p>
</details>
<br />

Now insert "seed data" into the database. (_Seeds_ are initial data items that the app needs to run):

```sh
$ bin/rake db:seed
```

<details>
  <summary><strong>Self Check Question:</strong> What seed data was inserted and where was it specified? (Hint: <code>rake -T db:seed</code> explains the seed task; <code>rake -T</code> explains other available Rake tasks)</summary>
  <p><blockquote>A set of movie data which is specified in <code>db/seeds.rb</code></blockquote></p>
</details>
<br />

At this point you should be able to [run the app locally](https://github.com/saasbook/hw-hello-rails/blob/master/Codio.md) and visit
it from a browser to make sure it's working before you go on.


Next: [Part 0 (B): Preparation: deploy to Heroku](part_0_B.md)
