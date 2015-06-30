HW2: RAILS INTRO - ADD FEATURES TO ROTTENPOTATOES
---------

In this homework you will add a feature to an existing simple Rails app and deploy the result publicly on the Heroku cloud hosting service. We will run live integration tests against your deployed version.

General advice:  This homework involves modifying RottenPotatoes in various ways. Git is your friend: commit frequently in case you inadvertently break something that was working before! That way you can always back up to an earlier revision, or just visually compare what changed in each file since your last “good” commit.

Remember, commit early and often!

Preparation: If you've never used Rails before please follow these screencasts to work through chapter 4 of the ESaaS textbook to create a rottenpotatoes rails app from scratch.  This assignment assumes that you have a working version of RottenPotatoes running locally and deployed on Heroku. Please follow these steps to make an initial deployment to Heroku:

Clone the assignment skeleton:

    git clone https://github.com/saasbook/rails-intro

Switch to the rails_intro directory

    cd rails-intro

Now you need to install various libraries with the bundle command

    bundle install --without production

Next you will need to run some commands to set up the database locally and add some data

    bundle exec rake db:migrate

    bundle exec rake db:seed

Now you can test the app locally by running the following and navigating to http://localhost:3000/movies in your browser

    rails s

In order to deploy to Heroku you will need to sign up for a free Heroku account at https://id.heroku.com/signup and follow the instructions to create your account. Assuming you have Heroku Toolbelt installed (it should be pre-installed on the VM) you now need to set up ssh keys to securely talk to Heroku.  The three basic commands you need are the following, but see the Heroku page for more details.

    ssh-keygen -t rsa

    heroku login

    heroku keys:add

Note that this is an area that a lot of people get seriously stuck, particularly if they have existing ssh keys.  If you are on a fresh VM you should be fine.  If you do get stuck here, please do ask in the forums.

Once you have your heroku keys set up correctly you can create a heroku instance from the rottenpotatoes directory

    heroku create

Now we can use git to deploy our code to the Heroku server in the cloud

    git push heroku master

Note, if you see a warning such as:

    The authenticity of host 'heroku.com (50.19.85.132)' can't be established.
    RSA key fingerprint is 8b:48:5e:67:0e:c9:16:47:32:f2:87:0c:1f:c8:60:ad.
    Are you sure you want to continue connecting (yes/no)? 
    Please type 'yes' or 'no':

This is normal - go ahead and type yes then hit 'ENTER to add heroku to the list of known remote computers.

Next we need to tell the cloud instance to prepare the database:

    heroku run rake db:migrate

We need to tell the cloud instance to add some data to the database:

    heroku run rake db:seed

Now you can navigate to the heroku url that heroku create printed to the console and see your app running in the cloud.

    heroku open

You can find more details on git and Heroku in the appendices of the ESaaS textbook.
