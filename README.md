Modifying RottenPotatoes
========================

# Rails Intro: add features to RottenPotatoes

In this homework you will add a feature to an existing simple Rails app
and deploy the result publicly on the Heroku cloud hosting service. We
will run live integration tests against your deployed version. 

General advice:  This homework involves modifying RottenPotatoes in
various ways. Git is your friend: commit frequently in case you
inadvertently break something that was working before! That way you can
always back up to an earlier revision, or just visually compare what
changed in each file since your last “good” commit. 

**Remember, commit early and often!**

## Preparation: get RottenPotatoes running locally

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

##### Self Check Questions (click triangle to check your answer)

<details>
  <summary>How does Rails decide where and how to create the
development database?  (Hint: check the `db` subdirectory)</summary>
  <p><blockquote>This creates a local development database and
runs the migrations to create the app's schema.  It also creates the
file `db/schema.rb` to reflect the latest database schema.  **You should
place this file under version control.** </blockquote></p>
</details>

<details>
  <summary>What tables got created by the migrations?</summary>
  <p><blockquote>The Movies table</blockquote></p>
</details>

------

Now insert "seed data" into the database--initial data items that the
app needs to run:

```sh
$ rake db:seed
```

##### Self Check Question

<details>
  <summary>What seed data was inserted and where was it specified?
(Hint: `rake -T db:seed` explains the seed task; `rake -T` explains
other available Rake tasks)</summary>
  <p><blockquote>A set of movie data which is specified in `db/seeds.rb`</blockquote></p>
</details>

------

At this point you should be able to run the app locally (`rails server`)
and navigating to `http://localhost:3000/movies` in your browser.  If you are using c9, use `rails s -p $PORT -b $IP` and navigate to the link generated within c9.

## Preparation: deploy to Heroku

If you have deployed to Heroku before, just create a new app container
with `heroku create`.  If this is your first time deploying to Heroku,
you will need to do two things.  First, sign up for a free [Heroku
account](http://heroku.com).  Then set up `ssh` keys to securely
communicate with Heroku for app deployments.  The three basic commands
you need are the following, but see the Heroku page for more details.

```sh
$ ssh-keygen -t rsa
$ heroku login
$ heroku keys:add
```

Once your keys are set up (a one-time process), you should be able to create an "app
container" on Heroku into which you'll deploy RottenPotatoes:

```sh
$ heroku create
```

Heroku will assign your app a whimsical name such as
`luminous-coconut-237`; once your app is deployed, you would access it
at `http://luminous-coconut-237.herokuapp.com`.  You can login to the
Heroku website if you want to change the name of your app.

Finally, we deploy our app to Heroku:

```sh
$ git push heroku master
```

(It is normal to see the following warning the first time---answer
"yes", and in the future you shouldn't see it anymore:)

    The authenticity of host 'heroku.com (50.19.85.132)' can't be established.
    RSA key fingerprint is 8b:48:5e:67:0e:c9:16:47:32:f2:87:0c:1f:c8:60:ad.
    Are you sure you want to continue connecting (yes/no)? 
    Please type 'yes' or 'no':

Is the app running on Heroku?  No, because just as we ran `rake
db:migrate` and `rake db:seed` to do first-time database creation locally, we must also cause
a database to be created on the Heroku side:

```sh
$ heroku run rake db:migrate
```

and

```sh
$ heroku run rake db:seed
```

Now you should be able to navigate to your app's URL.  `heroku open`
opens your browser to that URL in case you forgot it.

**Note:** don't proceed past this point until you are able to complete
the above successfully, or you won't be able to receive a grade for this
assignment!

# Part 1: Sort the list of movies (15 points)

On the list of all movies page, make the column headings for "Movie Title"
and "Release Date" into clickable links. Clicking one
of them should cause the list to be reloaded but sorted in ascending
order on that column. For example, clicking the "release date" column
heading should redisplay the list of movies with the earliest-released
movies first; clicking the "title" header should list the movies
alphabetically by title. (For movies whose names begin with non-letters,
the sort order should match the behavior of `String#<=>`.)

When the listing page is redisplayed with sorting-on-a-column enabled,
the column header that was selected for sorting should appear with a
yellow background, as shown below. You should do this by setting
controller variables that are used to conditionally set the CSS class of
the appropriate table heading to `hilite`, and pasting this simple CSS
into RottenPotatoes `app/assets/stylesheets/default.css` file:

```css
table#movies th.hilite {
  background-color: yellow;
}
```

The result should look something like this:

![](https://github.com/saasbook/hw-rails-intro/blob/master/table-header-screenshot.png)

**IMPORTANT for grading purposes:**

The link (that is, the `<a>` tag) for sorting by "title" should have the
HTML element id `title_header`, and the link for sorting by release date
should have the HTML element id `release_date_header`.  The table
containing the list of movies should have the HTML element id `movies`
(this has already been set for you by the starter code).

## Hints and caveats:

* The current RottenPotatoes views use the Rails-provided "resource-based
routes" helper `movies_path` to generate the correct URI for the movies
index page. You may find it helpful to know that if you pass this helper
method a hash of additional parameters, those parameters will be parsed
by Rails and available in the `params[]` hash.  

* Databases are pretty good
at returning collections of rows in sorted order according to one or
more attributes. Before you rush to sort the collection returned from
the database, look at the
[documentation](http://api.rubyonrails.org/v4.2.6/) for
`ActiveRecord.order` and see if you can get the database to do the work for you.

* Don't put code in your views! The view shouldn't have to sort the
collection itself--its job is just to show stuff. The controller should
spoon-feed the view exactly what is to be displayed.  

## Submission

You'll submit the code for this part after you deploy on Heroku and when
you supply your Heroku deployment URL in part 3.

For now, commit all the changes you have made so far,
and deploy them to check that they work on Heroku
before moving on to the next section:

```sh
$ git commit -a -m "part 1 complete"
$ git push heroku master
```

# Part 2: Filter the list of movies by rating (15 points)

Enhance RottenPotatoes as follows. At the top of the All Movies listing,
add some checkboxes that allow the user to filter the list to show only
movies with certain MPAA ratings: 

![](https://github.com/saasbook/hw-rails-intro/blob/master/filter-screenshot.png)

When the Refresh button is pressed, the list of movies is redisplayed
showing only those movies whose ratings were checked. 

This will require a couple of pieces of code. We have provided the code
that generates the checkboxes form, which you can include in the
index.html.haml template: 

```
= form_tag movies_path, :method => :get do
  Include:
  - @all_ratings.each do |rating|
    = rating
    = check_box_tag "ratings[#{rating}]"
  = submit_tag 'Refresh'
```

BUT, you have to do a bit of work to use the above code: as you can see,
it expects the variable `@all_ratings` to be an enumerable collection of
all possible values of a movie rating, such as
`['G','PG','PG-13','R']`. The controller method needs to set up this
variable. And since the possible values of movie ratings are really the
responsibility of the Movie model, it's best if the controller sets this
variable by consulting the Model. Hence, you should create a class
method of `Movie` that returns an appropriate value for this collection. 

You will also need code that figures out (i) how to figure out which
boxes the user checked and (ii) how to restrict the database query based
on that result.  

Regarding (i), try viewing the source of the movie listings with the
checkbox form, and you'll see that the checkboxes have field names like
`ratings[G]`, `ratings[PG]`, etc. This trick will cause Rails to aggregate
the values into a single hash called `ratings`, whose keys will be the
names of the checked boxes only, and whose values will be the value
attribute of the checkbox (which is "1" by default, since we didn't
specify another value when calling the `check_box_tag` helper). That is,
if the user checks the **G** and **R** boxes, `params` will include as one if
its values `:ratings=>{"G"=>"1", "R"=>"1"}`. Check out the `Hash`
documentation for an easy way to grab just the keys of a hash, since we
don't care about the values in this case (checkboxes that weren't
checked don't appear in the `params` hash at all).

Regarding (ii), you'll probably end up replacing `Movie.all` in the
controller method with `Movie.where`, which has various options to help you
restrict the database query. 

## IMPORTANT for grading purposes

* Your form tag should have the id `ratings_form`.
* The form submit button for filtering by ratings should have an HTML
element id of `ratings_submit` 
* Each checkbox should have an HTML element id of `ratings_#{rating}`,
where the interpolated rating should be the rating itself, such as
`ratings_PG-13`, `ratings_G`, and so on.

## Hints and caveats

Make sure that you don't break the sorted-column functionality you added
previously! That is, sorting by column headers should still work, and if
the user then clicks the "Movie Title" column header to sort by movie
title, the displayed results should both be sorted but do not need to be
limited by the checked ratings (we'll get to that in part 3). 

If the user checks (say) **G** and **PG** and then redisplays the list, the
checkboxes that were used to filter the output should appear checked
when the list is redisplayed. This will require you to modify the
checkbox form slightly from the version we provided above. 

The first time the user visits the page, all checkboxes should be
checked by default (so the user will see all movies). For now, ignore
the case when the user unchecks all checkboxes--you will get to this in
the next part. 

Reminder: Don't put code in your views! Set up an instance
variable in the controller that remembers which ratings were actually
used to do the filtering, and make that variable available to the view
so that the appropriate boxes can be pre-checked when the index view is
reloaded. 

You'll submit this part after you deploy on Heroku and when you supply
your Heroku deployment URL in part 3.  But you can commit all the
changes you have made so far to git, deploy them to Heroku and check
that they work on Heroku before moving on to the next section:

```sh
$ git commit -a -m "part 2 complete"
$ git push heroku master
```

# Part 3: Remember the sorting and filtering settings (70 points)

OK, so the user can now click on the "Movie Title" or "Release Date"
headings and see movies sorted by those columns, and can additionally
use the checkboxes to restrict the listing to movies with certain
ratings only. And we have preserved RESTfulness, because the URI itself
always contains the parameters that will control sorting and filtering. 

The last step is to remember these settings. That is, if the user has
selected any combination of column sorting and restrict-by-rating
constraints, and then the user clicks to see the details of one of the
movies (for example), when she clicks the Back to Movie List on the
detail page, the movie listing should "remember" her sorting and
filtering settings from before. 

(Clicking away from the list to see the details of a movie is only one
example; the settings should be remembered regardless what actions the
user takes, so that any time she visits the index page, the settings are
correctly reinstated.) 

The best way to do the "remembering" will be to use the `session[]`
hash. The session is like the `flash[]`, except that once you set
something in the `session[]` it is remembered "forever" until you nuke the
session with `session.clear` or selectively delete things from it with
`session.delete(:some_key)`. That way, in the `index` method, you can
selectively apply the settings from the `session[]` even if the incoming
URI doesn’t have the appropriate `params[]` set. 

## Hints and caveats

If the user explicitly includes new sorting/filtering settings in
`params[]`, the session should not override them. Instead, these new
settings should be remembered in the session.

If a user unchecks all checkboxes, use the settings stored in the
`session[]` hash, since it doesn't make sense for a user to uncheck all the
boxes. 

To be RESTful, we want to preserve the property that a URI that results
in a sorted/filtered view always contains the corresponding
sorting/filtering parameters. Therefore, if you find that the incoming
URI is lacking the right `params[]` and you're forced to fill them in from
the `session[]`, the RESTful thing to do is to `redirect_to` the new URI
containing the appropriate parameters. There is an important corner case
to keep in mind here, though: if the previous action had placed a
message in the `flash[]` to display after a redirect to the movies page,
your additional redirect will delete that message and it will never
appear, since the `flash[]` only survives across a single redirect. To fix
this, use `flash.keep` right before your additional redirect. 

## When you're done with this part

Deploy to Heroku by following the same process as before:

```sh
$ git commit -a -m "part 3 complete"
$ git push heroku master
```

# How to submit when you're all done

Deploying your finished app to Heroku by the homework deadline is part
of the grading process. Even if you have code checked in that works
properly, you still need to also deploy it to Heroku to get full
credit. 

Once you're confident the functionality works correctly on Heroku,
submit the 
URI of your deployed Heroku app in a text file with no other
contents. 

**Please be careful** to use **http** and not **https**, that is, 
submit `http://your-app.herokuapp.com` **and NOT**
`https://your-app.herokuapp.com`. 
