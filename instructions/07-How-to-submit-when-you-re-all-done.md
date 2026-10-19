# How to submit when you're all done

Deploying your finished app by the homework deadline is part of the grading process. Even if you have code checked in that works properly, you still need a working deploy to get full credit. Each team member, even if pair programming for this assignment, should complete a deploy and submit the link for their own personal app individually.

Once you're confident the functionality works correctly on your deployed app, submit its URI in `rottenpotatoes-url.txt`, the empty text file at the top level of your app (in Codio, it's in the file tree to the left), with no other contents. If you don't have that file, create it.

Submit the URL exactly as your browser shows it, e.g. `https://your-app.onrender.com` (on Heroku, `https://your-app.herokuapp.com`). Either `https://` or `http://` works; the autograder falls back to `http://` if it cannot connect over `https://`.

On Render, free services also sleep after 15 minutes of inactivity and take about a minute to wake up, so **open your app in a browser right before you submit** so that the live tests aren't waiting on a cold start.

On Gradescope, submit your whole app (a zip of your repo, or your GitHub repo) together with `rottenpotatoes-url.txt`. The autograder runs the same tests twice, worth 25 points each: once against your deployed app, and once against the code you submitted, which it sets up with `bin/rails db:prepare` and starts itself. A missing deployment, or a repo that will not start, therefore costs you only that half. Before you submit, check that a clean clone of your repo runs with `bin/rails db:prepare` followed by `bin/rails server`.

> **Submission (100 points)**
>
> You should now be ready to submit your assignment. Remember to run your test cases once more, then submit your files to Gradescope, Codio or whichever platform your course is using.

---

[← Part 3: Remember the sorting and filtering settings](06-Part-3--Remember-the-sorting-and-filtering-settings.md) | [Contents](README.md)
