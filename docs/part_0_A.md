## Part 0 (A): Preparation: get RottenPotatoes running locally

The actual RottenPotatoes starter app you will use is in another public
repo: [saasbook/rottenpotatoes-rails-intro](https://github.com/saasbook/rottenpotatoes-rails-intro).  Clone that repo onto your development computer:

```sh
$ git clone git@github.com:saasbook/rottenpotatoes-rails-intro
```

Whenever you start working on a Rails project, the first thing you
should do is to run Bundler, to make sure all the app's gems are
installed.  Switch to the app's root directory (presumably
`rottenpotatoes-rails-intro`) and run `bundle install --without production` (you only
need to specify `--without production` the first time, as this setting
will be remembered on future runs of Bundler for this project).

Finally, get the local database created:

```sh
$ rake db:migrate
```

<details>
  <summary><strong>Self Check Question:</strong> How does Rails decide where and how to create the
development database?  (Hint: check the `db` subdirectory)</summary>
  <p><blockquote>This creates a local development database and
runs the migrations to create the app's schema.  It also creates the
file `db/schema.rb` to reflect the latest database schema.  **You should
place this file under version control.** </blockquote></p>
</details>

<details>
  <summary><strong>Self Check Question:</strong> What tables got created by the migrations?</summary>
  <p><blockquote>The Movies table</blockquote></p>
</details>

Now insert "seed data" into the database--initial data items that the
app needs to run:

```sh
$ rake db:seed
```

<details>
  <summary><strong>Self Check Question:</strong> What seed data was inserted and where was it specified?
(Hint: `rake -T db:seed` explains the seed task; `rake -T` explains
other available Rake tasks)</summary>
  <p><blockquote>A set of movie data which is specified in `db/seeds.rb`</blockquote></p>
</details>

At this point you should be able to run the app locally (`rails server`)
and navigating to `http://localhost:3000/movies` in your browser.  If you are using c9, use `rails s -p $PORT -b $IP` and navigate to the link generated within c9.

Next: [Part 0 (B): Preparation: deploy to Heroku](part_0_B.md)
