# A social media app with Ruby on Rails

This is a desktop implementation of a twitter like website. The theme is to
connect with interests in personal computer technology. The features
implemented are 

- user registration
- followers
- posts
- likes

## Built With

- Ruby v2.6.1
- Ruby on Rails v5.2.4.1
- PostgreSQL >=9.5

## Live Demo

Live Version on Heroku: [Here](https://tranquil-oasis-42246.herokuapp.com/)
Video Presentation: [Here](https://www.youtube.com/watch?v=6QlTJBHYO0o)


## Getting Started

To get a local copy up and running follow these simple example steps.

### Setup

Install gems with:

```
bundle install
```

Setup database with:

```
rails db:create
rails db:migrate
```

Seed database with:
```
rails db:seed
```

## Usage

Start server with:

```
rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```
rpsec
```

## Authors

- Keshav Chakravarthy

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

I thank [Microverse](https://github.com/microverseinc) for providing feedback for this project. 

## 📝 License

The project is inspired by [Twitter - Redesign of UI](https://www.behance.net/gallery/14286087/Twitter-Redesign-of-UI-details) by [Gregoire Vella](https://www.behance.net/gregoirevella), Licensed under CC.

### Future Improvements

- To minimize SQL queries executed on the database to improve performance.
