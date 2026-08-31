# Grandpa Academy Eggs

Pterodactyl / Pelican compatible eggs for self-hosted services.

## Eggs

### AI
| Egg | Docker Image | Description |
|-----|-------------|-------------|
| [Hermes Agent](ai/hermes-agent/) | `ghcr.io/grandpaacademy/yolks:hermes_agent` | Self-hosted AI agent with OpenAI-compatible API |

### Languages
| Egg | Docker Images | Description |
|-----|--------------|-------------|
| [Python](language/python/) | `python_3.14` - `python_3.10` | Generic Python app runner |
| [Node.js](language/nodejs/) | `nodejs_24` - `nodejs_20` | Generic Node.js/TypeScript runner |
| [Golang](language/golang/) | `golang_1.24` - `golang_1.22` | Go build & run |
| [Rust](language/rust/) | `rust_latest` | Cargo build & run |
| [Java](language/java/) | `java_24` - `java_17` | Maven/Gradle JAR runner |

### Software
| Egg | Docker Image | Description |
|-----|-------------|-------------|
| [Caddy](software/caddy/) | `caddy_latest` | Web server with automatic HTTPS |
| [PostgreSQL](software/postgres/) | `postgres_17` - `postgres_15` | Database server |
| [Redis](software/redis/) | `redis_latest` | In-memory data store |
| [Valkey](software/valkey/) | `valkey_latest` | Open source Redis fork |
| [Nginx](software/nginx/) | `nginx_latest` | Web server / reverse proxy |

## Usage

1. Download the `egg-*.json` file for the egg you want
2. In Pterodactyl Panel: **Admin** → **Nests** → **Create New Egg** → **Import Egg**
3. Upload the JSON file
4. Configure the egg variables as needed

## Docker Images

All images are hosted at `ghcr.io/grandpaacademy/yolks`. These are custom images built for Grandpa Academy's Pterodactyl deployment.

## Contributing

1. Create your egg in the appropriate category directory
2. Follow the naming convention: `egg-<name>.json`
3. Include `install.sh` and `startup.sh` if needed
4. Submit a PR

## License

MIT
