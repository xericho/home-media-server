# Home Media Server

This is my automated home media server documentation.

## Tech stack
### Usenet
- FrugalUsenet (provider)
- NZBFinder (indexer)
- NZBgeek (optional indexer)

### Docker containers
- NZBget (downloader)
- Overseerr (automated content requester, integrates with Sonarr, Radarr and Plex)
- Plex (media server and player)
- Prowlarr (index manager for the *arrs)
- Radarr (movie grabber)
- Sonarr (TV show grabber)
- Bazarr (subtitle grabber)
- Nginx Proxy Manager (reverse proxy for overseerr)
- Fail2ban (prevents brute force attacks)


## Folder structure
There will be a folder for each docker container in `docker-compose.yml` so they can be blind mounted to. This is make backups and configurations easier to manage. 
```
home-media-server
├── docker-compose.yml
├── docker-compose.npm.yml
├── .env
├── npm
├── fail2ban
├── nzbget
├── overseerr
├── plex
├── prowlarr
├── radarr
├── sonarr
└── bazarr
```

## Media folder structure 
This is your folder structure for all your media files. NZBGet will put all downloads in the `usenet` directory and the *arrs will move them in the corresponding folders in `libraries`. Plex will only be synced to the `libraries` directory.
```
media_files
├── usenet
├── torrents (optional)
└── libraries
	├── movies
	└── tv
```

## Remote Access 
### Plex
Configure this to remove the 1Mbps limit when watching media outside LAN.
1. Port forward 32400 to your media server in your router/modem (http://192.168.1.254/).
1. Check that it's open using https://www.yougetsignal.com/tools/open-ports/.
1. Open 32400 in your firewall settings:
    ```
    sudo ufw allow 32400
    ```
1. In Plex, go to Settings > Remote Access. Manually specify port 32400 and click Apply.

### Other containers
1. Create a Cloudflare account and add your domain name (https://developers.cloudflare.com/fundamentals/get-started/setup/add-site/)
1. Go to DNS and add an A record to point to your server's WAN (public) IP. 
1. Go to SSL/TLS and select Full (strict) as encryption mode. 
1. Go to SSL/TLS > Edge Certificates and enable:
    - Always Use HTTPS
    - Automatic HTTPS Rewrites
1. Go to your Cloudflare profile > API Tokens > Create Token. Select Edit zone DNS and include your zone. Create and note the API token.
1. Go to Nginx Proxy Manager (port 81) and add a proxy host:
    - Domian name: same one from the A recrod
    - Scheme: http 
    - Forward Hostname/IP: **use the docker container name, not LAN IP** (e.g. `overseerr`)
    - Forward port: the corresponding port (e.g. 5055)
    - Enable Cache Assets and Block Common Exploits
    - In SSL, request a new SSL certificate. Select Use a DNS Challenge, choose Cloudflare, and paste the API Token from earlier. Also enable Force SSL and HTTP/2 Support. 
1. Port forward 80 and 443 to your media server in your router/modem (http://192.168.1.254/).
1. Check that it's open using https://www.yougetsignal.com/tools/open-ports/.
1. Open 80 and 443 in your firewall settings:
    ```
    sudo ufw allow http
    sudo ufw allow https
    ```

## Fail2ban
We will use fail2ban as an extra security measure for brute force attacks. Follow this [guide](https://dbt3ch.com/books/fail2ban/page/how-to-install-and-configure-fail2ban-to-work-with-nginx-proxy-manager) to set it up. For simplicity, use the `npm/nginx.conf` file instead of editing `npm`'s container files. It will be blind mounted in `docker-compose.npm.yml`.

## Resources
- https://academy.pointtosource.com/containers/all-in-one-media-server-docker
- https://wiki.servarr.com/
- https://trash-guides.info/
- https://www.youtube.com/watch?v=GarMdDTAZJo
- https://dbt3ch.com/books/fail2ban/page/how-to-install-and-configure-fail2ban-to-work-with-nginx-proxy-manager
