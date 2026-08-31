# Grandpa Academy Eggs

Pterodactyl / Pelican compatible eggs with custom Docker images.

## Quick Start

### Import an Egg
1. Download the `egg-*.json` file from the category you need
2. In Pterodactyl: **Admin** → **Nests** → **Create New Egg** → **Import Egg**
3. Upload the JSON
4. Configure variables

### Docker Images

All images are at `ghcr.io/grandpaacademy/yolks_*` — built automatically via GitHub Actions.

| Category | Images |
|----------|--------|
| **AI** | `yolks_hermes_agent` |
| **Python** | `yolks_python_3.14`, `_3.13`, `_3.12`, `_3.11`, `_3.10` |
| **Node.js** | `yolks_nodejs_24`, `_22`, `_20` |
| **Golang** | `yolks_golang_1.24`, `_1.23`, `_1.22` |
| **Rust** | `yolks_rust_latest` |
| **Java** | `yolks_java_24`, `_21`, `_17` |
| **Software** | `yolks_caddy_latest`, `_postgres_17/16/15`, `_redis_latest`, `_valkey_latest`, `_nginx_latest` |

### Build Locally

```bash
# Build all images
./build.sh

# Build specific image
./build.sh python3.14
./build.sh nodejs22
./build.sh hermes
```

## Egg Categories

### AI
| Egg | Description |
|-----|-------------|
| [Hermes Agent](ai/hermes-agent/) | Self-hosted AI agent with OpenAI-compatible API |

### Languages
| Egg | Description |
|-----|-------------|
| [Python](language/python/) | Generic Python app runner |
| [Node.js](language/nodejs/) | Generic Node.js/TypeScript runner |
| [Golang](language/golang/) | Go build & run |
| [Rust](language/rust/) | Cargo build & run |
| [Java](language/java/) | Maven/Gradle JAR runner |

### Software
| Egg | Description |
|-----|-------------|
| [Caddy](software/caddy/) | Web server with automatic HTTPS |
| [PostgreSQL](software/postgres/) | Database server |
| [Redis](software/redis/) | In-memory data store |
| [Valkey](software/valkey/) | Open source Redis fork |
| [Nginx](software/nginx/) | Web server / reverse proxy |

## Structure

```
eggs/
├── ai/                    # AI agent eggs
├── language/              # Language runtime eggs
├── software/              # Software/service eggs
├── docker/                # Dockerfiles for all images
│   ├── python/
│   ├── nodejs/
│   ├── golang/
│   ├── rust/
│   ├── java/
│   ├── caddy/
│   ├── postgres/
│   ├── redis/
│   ├── valkey/
│   ├── nginx/
│   └── hermes-agent/
├── .github/workflows/     # CI/CD for Docker builds
├── build.sh               # Local build script
└── README.md
```

## CI/CD

Docker images are built automatically via GitHub Actions when `docker/**` files change on `main`.

To manually rebuild all images:
```bash
gh workflow run docker-publish.yml
```

## Contributing

1. Create egg in the appropriate category directory
2. Add Dockerfile in `docker/<name>/`
3. Follow naming: `egg-<name>.json`
4. Submit PR — CI will build and push images

## License

MIT
