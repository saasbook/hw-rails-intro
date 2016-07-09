
## Part 0 (B): Preparation: deploy to Heroku

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

Now you should be able to navigate to your app's URL. `heroku domains`
will print the URI in the console in case you forgot it.

**Note:** don't proceed past this point until you are able to complete
the above successfully, or you won't be able to receive a grade for this
assignment!

Next: [Part 1: Sort the list of movies](part_1.md)
