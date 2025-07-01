# MCP Gateway (Docker Enhanced)

A containerized gateway server that bridges Model Context Protocol (MCP) STDIO servers to MCP HTTP+SSE and REST API, enabling multi-instance MCP servers to be exposed over HTTP with Docker support and environment variable management.

## Acknowledgments

This project is based on [acehoss/mcp-gateway](https://github.com/acehoss/mcp-gateway). Special thanks to the original author for creating the foundational MCP gateway architecture.

## Key Features

### Enhancements
- Full Docker and Docker Compose support
- Environment variable management for secure API key passing
- Python ecosystem support via UV tool integration
- Pre-built Docker image available on Docker Hub

### Core Features
- Run multiple instances of the same MCP server type
- Configure multiple different MCP server types
- Flexible network binding configuration
- Clean separation between server instances using session IDs
- Automatic cleanup of server resources on connection close
- YAML-based configuration
- Optional Basic and Bearer token authentication
- Configurable debug logging levels
- REST API Support with OpenAPI schema generation

## Quick Start with Docker

### Using Docker Compose

Create a `docker-compose.yml`:
```yaml
version: '3.8'

services:
  mcp-gateway:
    image: ihainan/mcp-gateway:latest
    ports:
      - "3000:3000"
    volumes:
      - ./config.yaml:/app/config.yaml
      - ./mcp-data:/app/mcp-data
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

Create a `config.yaml`:
```yaml
hostname: "0.0.0.0"
port: 3000

servers:
  # NPX-based server with API key
  tavily:
    command: npx
    args:
      - -y
      - "tavily-mcp@0.2.0"
    env:
      - TAVILY_API_KEY="your-actual-api-key-here"
      
  # Standard filesystem server
  filesystem:
    command: npx
    args:
      - -y
      - "@modelcontextprotocol/server-filesystem"
      - "/app/mcp-data"
      
  # Python server using UV
  mcp-server-arxiv:
    type: stdio
    command: uv
    args:
      - tool
      - run
      - arxiv-mcp-server
    env:
      - STORAGE_PATH="/app/mcp-data/mcp-server-arxiv"
```

Start the gateway:
```bash
docker-compose up -d
```

## License

MIT License

---

*Based on [acehoss/mcp-gateway](https://github.com/acehoss/mcp-gateway)*
