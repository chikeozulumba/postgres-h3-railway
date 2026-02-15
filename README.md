# PostGIS with H3 Extension Railway Template

This template provides a PostgreSQL database with PostGIS and Uber's H3 extension pre-installed, ready to deploy on Railway.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/0c4k7A?referralCode=8bSENY)

## Features

- PostgreSQL 17
- PostGIS 3.4
- Uber's H3 postgres extension bindings for hexagonal hierarchical geospatial indexing [https://github.com/postgis/h3-pg](https://github.com/postgis/h3-pg)
- Pre-configured extensions and dependencies

## Prerequisites

- A Railway account
- Railway CLI (optional, for local development)

## Environment Variables

Docker Compose reads `POSTGRES_PORT`, `POSTGRES_DB`, `POSTGRES_USER`, and `POSTGRES_PASSWORD` from a `.env` file. These are the same variables used for deployment; you can change the values in `.env` before first run.

## Local Development

Clone this repository:

```bash
git clone <your-repo-url>
cd postgres-h3
```

## Running using docker

Create a `.env` file so Docker Compose and the database init scripts have valid values (without it, variables are empty and initialization will fail):

```bash
cp .env.example .env
```

Edit `.env` if you want different database name, user, or password. Then start the database:

```bash
docker-compose up -d
```

Connect to the database (use the same `POSTGRES_DB` and `POSTGRES_PASSWORD` as in your `.env`):

```bash
psql -h localhost -p 54040 -U postgres -d postgresh3db -W

```

Enter the password when prompted (e.g. `postgres` if that’s your `POSTGRES_PASSWORD`).

### "password authentication failed for user postgres"

- **Use the right port and password:** With docker-compose the app is on port **54040** (mapped from 5432). Connect with the same password as in `.env` (`POSTGRES_PASSWORD`).
- **Stale volume:** The password is set only when the data directory is first created. If you previously ran the container without `POSTGRES_PASSWORD` or with a different one, the existing volume still has the old password. Reset and re-init:

  ```bash
  docker-compose down -v
  docker-compose up -d
  ```

  (`-v` removes the `postgres_data` volume so the next startup re-initializes with your current `.env`.)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

Developed and maintained by [Chike Ozulumba](https://chikeozulumba.com). For issues or suggestions, please open an issue on the [GitHub repository](https://github.com/chikeozulumba/postgres-h3-railway).
