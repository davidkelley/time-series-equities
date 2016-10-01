# Time Series Equities

This small demo service returns time-series pricing information for equities. Time series data can be requested using a `?ticker=`, `?after=` and an optional `?before=` timestamp.

## Getting Started

This project uses Docker Compose to help speed up getting started developing with this project. You can use the following commands to build, test and start the service:

* `docker-compose build` - Build the Docker container
* `docker-compose run api bundle exec dotenv rspec` - Run the RSpec tests for the project.
* `docker-compose up` - Start the service.

## API

This API responds to a `GET:/` for retrieving equity information.

### `GET:/`

| Parameter | Required? | Type          | Description                                          | Default                   |
|:----------|:----------|:--------------|:-----------------------------------------------------|:--------------------------|
| `ticker`  | yes       | String        | The ticker for the equity |                          |                           |
| `after`   | yes       | Integer       | Return data after this specific epoch timestamp      |                           |
| `before`  | no        | Integer       | Return data before this specific epoch timestamp     | Now @ UTC                 |

Below is an example response:

```
[
  ...,
  {
    "ticker": "aapl",
    "updated_at": 1475319374.8242612,
    "high": 6.9335772265472375,
    "low": 5.059099217338988,
    "last": 3.088687691361896,
    "volume": 33455.0,
    "change": 2.9035945911976127,
    "bid": 5.084776383420558,
    "ask": 9.084227834320469
  }
  ...
]
```

### `POST:/`                          
| Parameter              | Required?  | Type    | Description                        | Default               |
|:-----------------------|:-----------|:--------|:-----------------------------------|:----------------------|
| `ticker`               | yes        | String  | The ticker for the equity          |                       |
| `updated_at`           | no         | Float   | The updated price timestamp        | Now @ UTC             |
| `high`                 | yes        | Float   | Highest price of the day           |                       |
| `low`                  | yes        | Float   | Lowest price of the day            |                       |
| `last`                 | yes        | Float   | Last executed trade price          |                       |
| `volume`               | yes        | Integer | Executed trading volume            |                       |
| `change`               | yes        | Float   | Price Change                       |                       |
| `bid`                  | yes        | Float   | Current Bid Price                  |                       |
| `ask`                  | yes        | Float   | Current Ask Price                  |                        |
