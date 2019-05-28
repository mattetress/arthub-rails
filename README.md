# ArtHub

ArtHub is a networking and event sharing platform for artists. Artists can sign up via email or Facebook OAuth. Artist profiles have portfolio functionality.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing

Fork and clone this repository.

Install gem dependencies

```
$ bundle install
```

Create database and run migrations

```
$ rake db:create && rake db:migrate
```

Create a .env file in the root directory for environment variables.

```
$ touch .env
```

Add Facebook key and secret to .env file.  Be sure to replace the X's with your own info.  Key and secret can be created at developers.facebook.com

```
FACEBOOK_KEY=XXXXXXXX
FACEBOOK_SECRET=XXXXXXXX
```

Start the server by running `rails s` in the terminal. The app should now be running at [localhost:3000](http://localhost:3000/)

## Built With

* [Rails](https://guides.rubyonrails.org/)
* [JavaScript](https://devdocs.io/javascript/)

## Contributing

Please read [CONTRIBUTING.md](https://github.com/mattetress/arthub-rails/blob/master/contributing.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Matt Etress** - *Initial work* - [mattetress](https://github.com/mattetress)

See also the list of [contributors](https://github.com/mattetress/arthub-rails/contributors) who participated in this project.
