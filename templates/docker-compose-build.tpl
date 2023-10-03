cat > /root/docker-compose.yml <<- "SCRIPT"

version: '3'
services:
  traefik:
    image: "traefik:v2.10"
    container_name: "traefik"
    command:
      - "--log.level=DEBUG"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.myresolver.acme.tlschallenge=true"
      - "--certificatesresolvers.myresolver.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"
      - "--certificatesresolvers.myresolver.acme.email=amitgadhia65@gmail.com"
      - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "443:443"
      - "8080:8080"
    volumes:
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
    networks:
      - dockernet
  api-gateway:
    image: nuvolar/api-gateway
    restart: always
    expose:
      - 8080
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.api-gateway.rule=Host(`test.amitgadhia.in`)"
      - "traefik.http.routers.api-gateway.entrypoints=websecure"
      - "traefik.http.routers.api-gateway.tls.certresolver=myresolver"
    environment:
      ORDER_SERVICE_URL: 'http://order-service:8080'
    networks:
      - dockernet
  order-service:
    image: nuvolar/order-service
    restart: always
    environment:
      CUSTOMER_SERVICE_URL: 'http://customer-service:8080'
    networks:
      - dockernet
  customer-service:
    image: nuvolar/customer-service
    restart: always
    networks:
      - dockernet

networks: #use same network across containers to simplify communication between containers
  dockernet:
    #driver: bridge
    external: # network created previously by 'docker network create dockernet' command
      name: dockernet

SCRIPT
