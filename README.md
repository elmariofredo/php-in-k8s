# PHP in K8s

This is example PHP project based on [Nette](https://nette.org/) deployed to [Kubernetes](https://kubernetes.io/)

## Components

1. [PHP FPM](https://www.php.net/manual/en/install.fpm.php) for serving application using FastCGI Protocol.
2. [Composer](https://getcomposer.org/) for php packages.
3. [NodeJS](https://nodejs.org/en/) for frontend building.
4. [Adminer](https://www.adminer.org/) for database management.
5. [Minio](https://min.io/) for S3 compatible backend.
6. [Nextras Migrations](https://nextras.org/migrations/docs/master/) for automatic database management.


## Development

### Prerequisites

Docker on Linux or [Docker Desktop](https://docs.docker.com/desktop/) on Mac or Windows

### Run

```bash
docker compose up
```
