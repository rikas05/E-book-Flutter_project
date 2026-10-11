# Backend - Rails API for Ebook Library

A RESTful API built with Rails 8.1 for managing a digital ebook library.

## Setup

### Prerequisites

- Ruby 4.0+
- Rails 8.1+
- Bundler 4.0+
- SQLite3

### Installation

```bash
bundle install
rails db:create
rails db:migrate
```

Rails credentials are encrypted in `config/credentials.yml.enc`. Keep the
matching `config/master.key` out of version control and provide it through the
`RAILS_MASTER_KEY` environment variable in deployed environments.

### Running the Server

```bash
rails server -p 3000
```

The API will be available at `http://localhost:3000`

## API Endpoints

### Ebooks Resource

#### List Ebooks
- **GET** `/ebooks` - Get all ebooks
- **Query Parameters:**
  - `title` - Filter by title (optional)
  - `author` - Filter by author (optional)

```bash
curl http://localhost:3000/ebooks
curl "http://localhost:3000/ebooks?title=Flutter"
```

#### Get Ebook Details
- **GET** `/ebooks/:id` - Get specific ebook

```bash
curl http://localhost:3000/ebooks/1
```

#### Create Ebook
- **POST** `/ebooks` - Create new ebook
- **Body:** JSON with ebook data

#### Update Ebook
- **PATCH** `/ebooks/:id` - Update ebook details

#### Delete Ebook
- **DELETE** `/ebooks/:id` - Remove ebook

#### Search Ebooks
- **GET** `/ebooks/search` - Search ebooks

#### Download Ebook
- **GET** `/ebooks/:id/download` - Download ebook file

## Database Schema

### ebooks Table

| Column | Type | Details |
|--------|------|---------|
| id | bigint | Primary Key |
| title | string | Required, Max 255 chars |
| author | string | Required, Max 255 chars |
| description | text | Optional |
| file_path | string | Required |
| file_size | bigint | Required, Positive integer |
| uploaded_at | datetime | Auto-set to current time |

**Indexes:**
- title (for search performance)
- author (for filtering)
- uploaded_at (for sorting by upload date)

## Model Validations

The Ebook model includes validations for:
- `title` - Must be present, length 1-255
- `author` - Must be present, length 1-255
- `file_path` - Must be present
- `file_size` - Must be present, positive integer

## CORS Configuration

CORS is enabled for development to allow requests from:
- `localhost`
- `127.0.0.1`
- Frontend URL (configurable via `FRONTEND_URL` env var)

See `config/initializers/cors.rb` for details.

## Key Files

- **app/models/ebook.rb** - Ebook model with scopes and validations
- **app/controllers/ebooks_controller.rb** - RESTful API controller
- **config/routes.rb** - API route definitions
- **db/migrate/20260829000001_create_ebooks.rb** - Database schema
- **config/initializers/cors.rb** - CORS configuration

## Related Documentation

- [Main Project README](../README.md)
- [Implementation Plan](../docs/implementation-plan.md)
