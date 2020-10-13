## Part 2: Sort the list of movies (15 points)

On the list of all movies page, make the column headings for "Movie
Title" and "Release Date" into clickable links. Clicking one of them
should cause the list to be reloaded but sorted in ascending order on
that column. For example, clicking the "release date" column heading
should redisplay the list of movies with the earliest-released movies
first; clicking the "title" header should list the movies
alphabetically by title. (For movies whose names begin with
non-letters, the sort order should match the behavior of
`String#<=>`.) 

When the listing page is redisplayed with sorting-on-a-column enabled,
the column header that was selected for sorting should appear with a
yellow-orange background, as shown below. The selected column header
should also have 2 additional CSS classes added to it: 1) `hilite`,
and 2) a utility class from the [Bootstrap
Colors](https://getbootstrap.com/docs/4.5/utilities/colors/) set. You
should do this by setting controller variables that are used to
conditionally set the CSS class of the appropriate table heading to
these new classes. 

The result should look something like this:

![Screenshot showing the "Movie Title" column selected with a yellow background.](../table-header-screenshot.png)

**Note.** Initially, you will probably find that when you click on a
sort column, the app will "forget" which checkboxes have been
checked.   Similarly, when you sort on a column but then you change
which checkboxes are checked, the app will "forget" the desired sort
order.  We'll fix these cases next.

**IMPORTANT for grading purposes:**

The link (that is, the `<a>` tag) for sorting by "title" should have the HTML element id `title_header`, and the link for sorting by release date should have the HTML element id `release_date_header`.  The table containing the list of movies should have the HTML element id `movies` (this has already been set for you by the starter code).


### Hint: Adding parameters to existing RESTful routes


The current RottenPotatoes views use the Rails-provided
"resource-based routes" helper `movies_path` to generate the correct
URI for the movies index page. You may find it helpful to know that if
you pass this helper method a hash of additional parameters, those
parameters will be parsed by Rails and available in the `params[]`
hash.  To play around with this behavior, you can [test out routes in
the Rails
console](https://stackoverflow.com/questions/1397644/testing-routes-in-the-console).
(How did I find this secret information?  I Googled "test routes in
rails console".)

So, when you are converting those column headers into clickable
links (for which it's best to use the `link_to` helper) that point to
the RESTful route for fetching the movie list (best done using the
route helper `movies_path()`, think about
how you might modify the call that generates the route helper in order
to include information visible in `params` that would tell you which
column header was clicked.  **Hint:** Remember that every parameter in
a route has a key and a value, so any argument you pass to
`movies_path` would have to be a hash.

### Hint: displaying things in the right order

* Databases are pretty good at returning collections of rows in sorted order according to one or more attributes. Before you rush to sort the collection returned from the database, look at the [documentation](http://api.rubyonrails.org/v4.2.11/) for `ActiveRecord.order` and see if you can get the database to do the work for you.

Don't put code in your views! The view shouldn't have to sort the collection itself—its job is just to show stuff. The controller should spoon-feed the view exactly what is to be displayed.

## Remembering both the sort order and filtering order

At this point, you should have sort columns working, but you probably
noticed that sorting on a column "forgets" the values of which
checkboxes were checked.  Let's fix that.

The key to fixing it is to remember that when we constructed the form
for the checkboxes in part 1, the only thing that was needed to pass
the info to the controller about which checkboxes were checked.  For
example, if the boxes whose field names were `ratings_G` and
`ratings_PG` were checked, `params[:ratings]` would contain a hash 
`{'G': '1', 'PG': '1'}`.  (HTML allows a checked box to be given any
value, but we chose "1" which is conventional since the value is
usually irrelevant, since if the checkbox is not checked, it doesn't
appear in the submitted form values at all.)

So if we could _also_ include this info in the link when the user
clicks a column name, the info would be passed into the controller
action along with the column name itself!

Now, the view already knows that the value `@ratings_to_show` is
an array containing only the values for the
boxes that were checked--for example, something like `['G','R']`.  But
to make it look right for `params`, we need to pass `movies_path()`
something that looks more like `['G':'1', 'R':'1']` (or really, any
value other than `'1'` is fine, since it's just the presence of the
key that matters).

Judiciously using Google, find a concise way to derive a hash whose
keys are the values of an array, and whose value for all the keys is
some constant like `'1'`.
With that in hand,, modify the arguments to the `movies_path()` route
helper already used by your column headers to include that hash, such that the information
about which checkboxes were checked on the form appears as part of the
route.

At this point, you should be able to refresh the view by _either_
clicking on a column header _or_ clicking the Refresh button, and both
types of changes should be "remembered".

### Submission

You'll submit the code for this part after you deploy on Heroku and when you supply your Heroku deployment URL in part 3.

For now, commit all the changes you have made so far, and deploy them to check that they work on Heroku before moving on to the next section:

```sh
git commit -am "part 2 complete"
git push heroku master
```

Next: [Part 3: Remember the sorting and filtering settings](part_3.md)
