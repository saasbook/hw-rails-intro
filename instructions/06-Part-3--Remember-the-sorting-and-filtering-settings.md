# Part 3: Remember the sorting and filtering settings

Make another feature branch for this part.

<details>
<summary>
Why not just make every change in one big branch/PR? Why are we splitting them up into smaller feature branches?
</summary>
<blockquote>
Aside from getting some practice with Git, it's good to keep changesets small when you're working in teams. Especially when each pull request is being reviewed by a team member, you'll find that reviews come in much quicker if you make your pull requests digestible and focus them to just one change at a time! It takes a little extra time to set up each branch, but you'll get faster at it as you do it more. In addition, when code changes can be split into parts that don't depend on each other, splitting into multiple branches can help you context-switch and simplify the handling of merge conflicts.
</blockquote>
</details>
<br>

OK, so the user can now click on the "Movie Title" or "Release Date" column headers and see movies sorted by those columns, and can additionally use the checkboxes to restrict the listing to movies with certain ratings only. And we have preserved RESTfulness, because the URI itself always contains the parameters that will control sorting and filtering. And changing one setting doesn't forget the other settings. We did all this by carefully controlling which parameters get passed in the form submit button (which uses `GET`).

But there's one more problem. If you navigate away from the Index view (say, to view the details of a movie) and then click the Back to List button to go back to the Index view, it seems to forget the sorting and filtering settings as well. (Go ahead and verify this.)

<details>
<summary>
Why is the sorting/checkbox-filtering setting "forgotten" when you navigate to a Movie Details page and then click the Back to List button?
</summary>
<blockquote>
The Back to List button is just a link for the RESTful route <code>GET /movies</code>, but in parts 1 and 2, we have been adding extra parameters to the route (in both the form submission and the column header links) to encode those settings.
</blockquote>
</details>

So the last step is to remember these settings even if the user navigates away from and then back to the list of movies.

Fortunately, HTTP-based SaaS has a way to "remember" state across otherwise-stateless requests: cookies. In Rails, the `session[]` hash provides a nice abstraction for using cookies: anything you put in there will basically be preserved for as long as that user's browser continues to correctly maintain cookies for your app. In other words, comparing it to something you've seen before, the session is like the `flash[]`, except that once you set something in the `session[]` it is remembered "forever" until you reset the session with `session.clear` or selectively delete things from it with `session.delete(:some_key)`.

**A big caveat:** Since the default storage for the contents of `session` is a browser cookie, (a) users who reset or clear their cookies will also reset the session for RottenPotatoes (and many other sites), and (b) the contents of the `session`, once serialized, cannot exceed the size of an HTTP cookie (4 KiB).

### Hints and caveats

Once you have determined the correct sorting and filtering settings, before you render the view, use `session[]` to hold on to the those settings.

Now modify the `index` action to detect whether _no_ `params[]` were passed that indicate sorting or filtering: this would be one way to tell that the user is landing on the home page _not_ having followed one of the special links we made in parts 1 and 2.

<details>
<summary>
What might be some other ways to tell if this is the case?
</summary>
<blockquote>
One possibility is to look at the HTTP <code>Referer</code> [sic] header, which often tells what page the user just came from when following a link. (Exercise: check the Rails docs to learn how to get access to the headers.) However, to keep things at the same level of abstraction, it's more reliable to use <code>params</code>. We could, e.g., add a special value in <code>params</code> for the links served on the home page that explicitly marks the links as being on the home page, say <code>params[:home]=1</code>. Then the absence of <code>params[:home]</code> means the user got to the home page from someplace else.
</blockquote>
</details>

Be careful: If the user explicitly includes new sorting/filtering settings in `params[]`, the new values of those settings should then be saved.

As before, if a user unchecks all checkboxes, it means "display all ratings."

Now, deploy again. You should first commit your changes to the new feature branch, then choose whether to make a pull request and merge through GitHub (as in part 1) or merge locally (as in part 2). Either way, make sure your changes have made their way to the `main` branch, then deploy as before.

---

[← Part 2: Sort the list of movies](05-Part-2--Sort-the-list-of-movies.md) | [Contents](README.md) | [How to submit when you're all done →](07-How-to-submit-when-you-re-all-done.md)
