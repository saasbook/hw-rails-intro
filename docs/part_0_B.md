
## Part 0 (B): Preparation: deploy to Heroku

If this is your first time deploying to Heroku, you will need to do two things. First, sign up for a free [Heroku account](http://heroku.com). Then set up `ssh` keys to securely communicate with Heroku for app deployments. The three basic commands you need are the following, but see the [Heroku page](https://devcenter.heroku.com/articles/heroku-cli) for more details.

```sh
ssh-keygen -t rsa
heroku login --interactive
heroku keys:add
```

Now (or if you have deployed to Heroku before) you can create a new app container
with `heroku apps:create`.  
Heroku will assign your app a whimsical name such as `luminous-coconut-237`; once your app is deployed, you would access it at `http://luminous-coconut-237.herokuapp.com`.  You can login to the Heroku website if you want to change the name of your app.

Finally,  deploy to Heroku:

```sh
git push heroku master
```

(You may see the following warning the first time - it's fine. Answer
"yes", and in the future you shouldn't see it anymore:)

    The authenticity of host 'heroku.com (50.19.85.132)' can't be established.
    RSA key fingerprint is 8b:48:5e:67:0e:c9:16:47:32:f2:87:0c:1f:c8:60:ad.
    Are you sure you want to continue connecting (yes/no)?
    Please type 'yes' or 'no':

Is the app running on Heroku? If you navigate to the heroku URL that is printed at the end of the results from `git push heroku master` you'll get a "We're sorry, but something went wrong." error in the browser.

As with the previous assignment "Hello Rails",  `heroku logs` tell us
that the `movies` table doesn't exist.  So, as before, run the initial
migration and import the seed data:

```sh
$ heroku run rake db:migrate
$ heroku run rake db:seed
```

Now you should be able to navigate to your app's URL. 

**Note:** don't proceed past this point until you are able to complete the above successfully, or you won't be able to receive a grade for this assignment!

Next: [Part 1: Sort the list of movies](part_1.md)
