## Notes TODO List - Sample Rest API

#### ⭐ Star us on GitHub — it motivates a lot!

Basic app for notes / TODO list API to pratice TDD in RoR.

## Project Status

(This project is currently in development)

## Installation and Setup Instructions

### Requirements:  

Clone down this repository. You will need `ruby` 2.7.2 installed globally on your machine, and a `Postgres` database server.

🚀 Running:

    $ bin/bundle install
    $ bin/rails db:setup
    $ bin/rails s -p 3000

📚 Mock Data

    $ bin/rails db:generate_data_faker

🔍 Tests:

    $ bin/rspec
    $ bin/rspec <test_folder>