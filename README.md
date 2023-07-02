# Home Media Server

This is my automated home media server documentation.

# Overview

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


## Folder structure
There will be a folder for each docker container in `docker-compose.yml` so they can be blind mounted to. This is make backups and configurations easier to manage. 
```
home-media-server
├── docker-compose.yml
├── .env
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

# Resources
- https://academy.pointtosource.com/containers/all-in-one-media-server-docker
- https://wiki.servarr.com/
- https://trash-guides.info/
