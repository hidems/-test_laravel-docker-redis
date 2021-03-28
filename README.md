# Overview
Simple Laravel environment by Docker and Docker-compose.

# How to start
## Create db folder
```
mkdir db
```

## Change DB name
If you want to change DB name, you need to change change 'docker-compose.yml'. 
```
environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: lara_db # Here!!
```

## Start Dcoker
```
docker-compose up -d
```
**It must be executed at first.**
**You need to exchange /src, if you want to use own code.**

## Install laravel by composer (Ver 6.* if you want latest ver, remove "6.*")
```
docker-compose exec php composer create-project --prefer-dist laravel/laravel . "6.*"
```
~~docker run --rm -v {Current Directly}/src:/app composer create-project --prefer-dist laravel/laravel . "6.*"~~

## composer update (If already installed)
```
docker-compose exec php composer update (or install)
```
~~docker run --rm -v {Current Directly}/src:/app composer update ( or install)~~


## Edit `src/.env` file
```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel # Set DB name
DB_USERNAME=root
DB_PASSWORD=password
```

Need to change files's authority in case of WSL2
```
sudo chown {user_name}:{user_name} /src -R
```

Confirm DB work correctly
```
docker-compose exec php php artisan migrate
```

## Access
Top page: http://127.0.0.1:8080/
phpmyadmin: http://127.0.0.1:8888/

Need to change files's authority in docker container, in case of WSL2
```
docker-compose exec php chown www-data:www-data storage -R
docker-compose exec php chown www-data:www-data bootstrap/cache -R
```

# Plugin for Laravel
## laravel/ui package
```
docker-compose exec php composer require laravel/ui
* For Laravel 6
docker-compose exec php composer require laravel/ui:^1.0 --dev

docker-compose exec php php artisan ui vue --auth

docker run --rm -v {Current Directly}/src:/usr/src/app -w /usr/src/app node npm install
docker run --rm -v {Current Directly}/src:/usr/src/app -w /usr/src/app node npm run dev
or
docker-compose exec php npm install
docker-compose exec php npm run dev
* For Laravel 8 
docker-compose exec php npm install vue-loader@^15.9.5 --save-dev --legacy-peer-deps

docker-compose exec php php artisan migrate
```
~~docker run --rm -v {Current Directly}/src:/app composer require laravel/ui~~

~~docker exec -it php php artisan ui vue --auth~~

## Vue Router
```
npm install --save vue-router
```


# Troubleshooting
## Create encryption key
```
docker-compose exec php php artisan key:generate
```
-> Write down automatically `APP_KEY` in `.env`

## Fail to download files in db
Add this code under mysql in `docker-compose.yml`.
```
depends_on:
      -  php
      -  mysql
user: "1000:50" # Here!!
```

## Too slow and ideas of sollution
It is because of WSL2. Not to use WSL2, then it was improved.
https://stackoverflow.com/questions/63036490/docker-is-extremely-slow-when-running-laravel-on-nginx-container-wsl2

-> Project moves to out of windows mount directly(/mnt).

### Other ideas to improve.
Use "redis" for cash and session.

Reduce mount files.
https://qiita.com/ProjectEuropa/items/c094cfb4aac2968a9901

Use docker-sync.
https://qiita.com/reflet/items/ee15bf6b1b90a3a90905

https://qiita.com/miyawa-tarou/items/7ffdd8af86c57ca80ed1
