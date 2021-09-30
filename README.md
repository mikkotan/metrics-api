# Metrics API
## Run via Docker
### Pre-requisites
- Docker
- Docker-compose

### Get Started
1. Clone the project
```
$ git clone git@gitlab.com:michael.tan/metrics-api.git
```
2. Change directory
```
$ cd metrics-api
```
3. Build with docker
```
$ docker-compose build
```
4. Create database
```
$ docker-compose run --rm web rails db:create
```
5. Run migration files
```
$ docker-compose run --rm web rails db:migrate
```
6. Run db seed
```
$ docker-compose run --rm web rails db:seed
```
7. Run containers
```
$ docker-compose up -d
```
8. Run tests
```
$ docker-compose run --rm web rspec
```

## Run without Docker
### Pre-requisites
- ruby-3.0.2
- Rails 6.1.4
- PostgreSQL (latest)

### Get Started
1. Follow steps 1 and 2 above
2. Install dependencies
```
$ bundle install
```
3. Update database.yml
```
default: &default
  adapter: postgresql
  encoding: unicode
  host: localhost
  port: 5432
  username: your_username
  password: your_password
  pool: 5

development:
  <<: *default
  database: metrics_development

test:
  <<: *default
  database: metrics_test
```
4. Create database
```
$ rails db:create
```
5. Run migration files
```
$ rails db:migrate
```
6. Run db seed
```
$ rails db:seed
```
7. Run rails server
```
$ rails s
```
8. If you wish to run specs
```
$ rspec
```

### API Endpoints
**Metrics API**
```
POST /api/v1/metrics
GET /api/v1/metrics
GET /api/v1/metrics/:id
PUT /api/v1/metrics/:id
DELETE /api/v1/metrics/:id
```

Metric Params:
```
{
  name: 'Player Retention Rate'
}
```

**Metric Values API**
```
GET /api/v1/:metric_id/values?query[from]=""&query[to]=""
POST /api/v1/:metric_id/values
DELETE /api/v1/:metric_id/values/:id
```

MetricValue params:
```
{
  value: 10,
  timestamp: Time.now
}
```
