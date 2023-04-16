# Movies DB Challenge
This is a pre-populated PostgreSQL DB project with movies and related information to practice SQL.

## ERD:
![movies_erd](https://user-images.githubusercontent.com/10534896/231462475-2fb95681-938f-4903-a221-8c7c92e21522.png)

## Getting Started
This exercise requires you to install docker on your machine. Docker allows us to run applications inside containers. [You can read more about containers here](https://www.docker.com/resources/what-container).

### Installing Docker

#### Ubuntu

Update your software database:
```
sudo apt update
```

Remove any old versions of docker that might be on your system:
```
sudo apt remove docker docker-engine docker.io
```

Install docker:
```
sudo apt install docker.io
```

Check docker version:
```
docker --version
```

#### Windows and Mac

Docker requires a Linux kernal in order to run. This can be emulated on Windos and Mac. The easiest way to do this is to install [Docker Desktop](https://docs.docker.com/get-docker/). You will need to have Docker Desktop running in order to use docker commands in your terminal.

### Install pgAdmin4

For this challenge we will be using pgAdmin4. 
Regardless of your operating system, you should be able to download the client from https://www.pgadmin.org/download/.

If you're a Linux user you may install the client by running the following commands from the [official guide](https://www.pgadmin.org/download/pgadmin-4-apt):
```
# Install the public key for the repository:
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#
# Install pgAdmin
#

# Install for both desktop and web modes:
sudo apt install pgadmin4
```

### Getting the Database Running
Start by pulling the image:
```
docker pull commandshifthq/movies-db-postgres
```

Run the container by typing this command:
```
docker run -d -p 5433:5432 --name movies_db -e POSTGRES_PASSWORD=password commandshifthq/movies-db-postgres
```

Let's look what that did:
1. It asked docker to run start a movies container in detached mode (`docker run -d ... commandshifthq/movies-db-postgres`)
2. Made it accessible on port 5433 (`-p 5433:5432`)
3. Named the docker container (`--name movies_db`)
4. Set an environment variable, which is the password for the default `postgres` user to `password` (`-e POSTGRES_PASSWORD=password`)

Let's confirm the container is built and running by opening a shell inside it. This uses the `exec` command:
```
docker exec -it movies_db bash
```

The `-it` option asks docker to open an interactive shell, and then we set the terminal prompt to `bash`.

We are now inside the terminal of the docker container - of the computer inside our computer.

From here we can open postgres command line and check the database has been created. 
On this image we already have a database called `movies` and the default user is postgres so let's connect to it:
```
psql -d movies -U postgres
```

This should connect automatically, but if you are prompted for the postgres user password, type in `password` and hit return. (characters you entered won't be shown on terminal, just type away and hit enter)

Let's see what databases are on this postgres instance:
```
SELECT datname from pg_database;
```

You should see the following:

```
movies=# SELECT datname from pg_database;
  datname
-----------
 movies
 template1
 template0
(3 rows)
```

That's everything we need to do inside the container. Type in `exit;` to close `psql` and then again (without the `;`) to exit the container. It will continue to run in the background.

Note that if you now try to run the `psql -d movies -U postgres` command again, it won't work. This is because you're running the command from your own terminal, and you don't have `psql` installed (unless you've installed it yourself outside of this class!). It's only installed in the Docker container.

## Working on the database

Open up pgAdmin and let's add this postgres server connection so we can work with it from a nicer interface.
⚠️ If this is the first time you started pgAdmin, you will be asked for a "master password". This ensures only you can connect to the connections set and encrypts the credentials locally, so please ensure you do this and remember the password for next time.

Then find the "Add new server" quick link on the dashboard or from the left hand side pane, right click on `Servers -> Register -> Server...`.

A pop-up window will appear, and we'll need to change thing in two tabs:
1. Under the `General` Tab:
	- Give your server a name, like `movies`
	- Leave everything as default
2. Under the `Connection` Tab:
	- Hostname: `localhost`
	- Port: change it to `5433` (note this is the port we've set when we started the docker container)
	- Maintenance database: `movies`
	- Username: `postgres`
	- Password: `password`

Click `Save`. PgAdmin should automatically connect to the new server and the interface should refresh.

In the left hand side of the screen, in the sidebar, you will see the `movies` server. Press the arrow to expand it and you will see there is a `movies` database present as well. This action will also expand with more information and options for the database, but do not worry - at this point we are only interested in the `public` schema (under Schemas).

Check that you are able to send queries to the database by right clicking on the `public` schema and selecting the `Query Tool`. Then in the newly opened pane, enter some thing like:

```
SELECT * FROM movies;
```

Click the play button and confirm that the query returns employee information.

Now on to the exercises!


## Table Explanations
The movie table contains information about each movie. There are text descriptions such as title and overview. Some fields are more obvious than others: revenue (the amount of money the movie made), budget (the amount spent on creating the movie). Other fields are calculated based on data used to create the data source: popularity, votes_avg, and votes_count. The status indicates if the movie is Released, Rumoured, or in Post-Production.

The country list contains a list of different countries, and the movie_country table contains a record of which countries a movie was filmed in (because some movies are filmed in multiple countries). This is a standard many-to-many table, and you’ll find these in a lot of databases.

The same concept applies to the production_company table. There is a list of production companies and a many-to-many relationship with movies which is captured in the movie_company table.

The languages table has a list of languages, and the movie_languages captures a list of languages in a movie. The difference with this structure is the addition of a language_role table. This language_role table contains two records: Original and Spoken. A movie can have an original language (e.g. English), but many Spoken languages. This is captured in the movie_languages table along with a role.

Genres define which category a movie fits into, such as Comedy or Horror. A movie can have multiple genres, which is why the movie_genres table exists.

The same concept applies to keywords, but there are a lot more keywords than genres. I’m not sure what qualifies as a keyword, but you can explore the data and take a look. Some examples as “paris”, “gunslinger”, or “saving the world”.

The cast and crew section of the database is a little more complicated. Actors, actresses, and crew members are all people, playing different roles in a movie. Rather than have separate lists of names for crew and cast, this database contains a table called person, which has each person’s name.

The movie_cast table contains records of each person in a movie as a cast member. It has their character name, along with the cast_order, which I believe indicates that lower numbers appear higher on the cast list.

The movie_cast table also links to the gender table, to indicate the gender of each character. The gender is linked to the movie_cast table rather than the person table to cater for characters which may be a different gender than the person, or characters of unknown gender. This means that there is no gender table linked to the person table, but that’s because of the sample data.

The movie_crew table follows a similar concept and stores all crew members for all movies. Each crew member has a job, which is part of a department (e.g. Camera).

