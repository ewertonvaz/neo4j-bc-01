## Container Docker
```bash
docker run \
    --name neo4j-local \
    --restart always \
    --publish=7474:7474 --publish=7687:7687 \
    --env NEO4J_AUTH=neo4j/secret2026 \
    --volume=./data:/data \
    neo4j:2026.01.4
```   
