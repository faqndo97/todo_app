[![CI](https://github.com/faqndo97/todo_app/actions/workflows/ci.yml/badge.svg)](https://github.com/faqndo97/todo_app/actions/workflows/ci.yml)

# [TODO App](https://todoapp-hotwire-572de9890c06.herokuapp.com/)

## Initial Setup

Requirements:

* Docker latest version (Docker is used to run Postgres locally, if you prefer not to use Docker, you can use any other Postgres installation)
* Pnpm latest version
* Ruby 3.3.5

Run the following command after the three requirements are met:

```bash
bin/setup
```

This script will install ruby and javascript dependencies, create a new database.yml (which you need to configure based on your installation) and run the setup commands for the project. The script will also install overcommit hooks automatically in order to ensure a solid code style.

## Run the server

In order to run the server for this application we need multiple processes running, for Rails Application and for TailwindCSS. To do this we're using [Foreman](https://github.com/ddollar/foreman) to run the processes but also [Overmind](https://github.com/DarthSim/overmind) is configure if you prefer to use it. To start the server just run:

```bash
bin/dev
```

This will start the Rails server and the TailwindCSS server.


