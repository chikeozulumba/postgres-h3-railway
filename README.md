# PostGIS with H3 Extension Railway Template

This template provides a PostgreSQL database with PostGIS and Uber's H3 extension pre-installed, ready to deploy on Railway.

## Features

- PostgreSQL 16
- PostGIS 3.4
- Uber's H3 extension for hexagonal hierarchical geospatial indexing
- Pre-configured extensions and dependencies

## Prerequisites

- A Railway account
- Railway CLI (optional, for local development)

## Environment Variables

These are the required Postgres variables which can be modified before deployment, they contain the default values.

```env
POSTGRES_DB=postgres-h3-db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

## Local Development

Clone this repository:

```bash
git clone <your-repo-url>
cd postgres-h3
```

## Running using docker

Start the database using Docker Compose:

```bash
docker-compose up -d
```

Connect to the database:

```bash
psql -h localhost -p 54040 -U postgres -d postgres-h3-db
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

Developed and maintained by [Chike Ozulumba](https://chikeozulumba.com). For issues or suggestions, please open an issue on the [GitHub repository](https://github.com/MykalMachon/grafana-stack-railway).
