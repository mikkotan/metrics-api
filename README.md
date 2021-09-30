# Metrics API
## Run this project on your local machine
### Pre-requisites
- Docker
- Docker-compose

### Get Started
Clone the project
```
$ git clone git@gitlab.com:michael.tan/metrics-api.git
```
Change directory
```
$ cd metrics-api
```
Build with docker
```
$ docker-compose build
```
Create database
```
$ docker-compose run --rm web rails db:create
```
Run migration files
```
$ docker-compose run --rm web rails db:migrate
```
Run containers
```
$ docker-compose up -d
```
Run tests
```
$ docker-compose run --rm web rspec
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
