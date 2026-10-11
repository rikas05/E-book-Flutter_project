# Digital Ebook Library

A full-stack ebook library application with Rails API backend and Flutter mobile frontend.

## Current Status

✅ **Environment Setup Complete**
- Ruby 4.0.6 and Rails 8.1.3.1 installed
- Flutter SDK installed
- Both backend and frontend scaffolding generated

✅ **Backend (Rails API) - COMPLETED**
- Rails API app initialized
- Ebook model with validations created
- Database migrations configured
- RESTful API endpoints implemented (CRUD operations)
- CORS support enabled
- Search and filter functionality built-in
- Database created and migrations run

✅ **Frontend (Flutter) - COMPLETED**
- Flutter app scaffolded with Material Design
- EbookProvider state management with Provider package
- Bookshelf screen with grid-based ebook display
- Search and filter UI
- Detail screen for viewing ebook information
- API service layer for backend communication
- Dio HTTP client integration

## Project Structure

```
flutter_project/
├── backend/                 # Rails API
│   ├── app/
│   │   ├── controllers/     # EbooksController with CRUD logic
│   │   ├── models/          # Ebook model with validations
│   │   └── ...
│   ├── config/
│   │   ├── routes.rb        # API routes
│   │   └── initializers/cors.rb  # CORS configuration
│   ├── db/
│   │   └── migrate/         # Database migrations
│   └── Gemfile              # Ruby dependencies
│
├── frontend/                # Flutter app
│   ├── lib/
│   │   ├── main.dart        # App entry point with Provider setup
│   │   ├── models/          # Ebook data model
│   │   ├── services/        # EbookApiService for HTTP calls
│   │   ├── providers/       # EbookProvider for state management
│   │   └── screens/         # UI screens
│   │       ├── bookshelf_screen.dart   # Main library view
│   │       └── ebook_detail_screen.dart # Book details
│   └── pubspec.yaml         # Flutter dependencies
│
└── docs/                    # Documentation

```

## Features

### Backend API Endpoints

- **GET /ebooks** - List all ebooks (with title/author filters)
- **POST /ebooks** - Create new ebook
- **GET /ebooks/:id** - Get ebook details
- **PATCH /ebooks/:id** - Update ebook
- **DELETE /ebooks/:id** - Delete ebook
- **GET /ebooks/:id/download** - Download ebook file
- **GET /ebooks/search** - Search ebooks by title or author

### Frontend Features

- **Bookshelf View** - Grid display of ebook library
- **Search & Filter** - Real-time search by title or author
- **Detail View** - Full ebook information display
- **File Information** - View file size and upload date
- **Quick Actions** - Delete, download, and read options (expandable)
- **Loading States** - Progress indicators during data fetching
- **Error Handling** - User-friendly error messages and recovery options

## Setup Instructions

### Prerequisites

- Ruby 4.0+
- Rails 8.1+
- Flutter 3.13+
- Git

### Backend Setup

```bash
cd backend
bundle install
rails db:create
rails db:migrate
rails s -p 3000
```

The API will be available at `http://localhost:3000`

### Frontend Setup

```bash
cd frontend
flutter pub get
flutter run
```

For Android: `flutter run -d android`
For iOS: `flutter run -d ios`
For Web: `flutter run -d web`

## Environment Variables

### Backend

Create `.env` file in `backend/` (optional):

```
FRONTEND_URL=localhost:3000
RAILS_ENV=development
```

## Technologies Used

### Backend
- **Rails 8.1.3.1** - Web framework
- **SQLite3** - Database (development)
- **Bundler** - Dependency management
- **Rack::Cors** - CORS middleware

### Frontend
- **Flutter** - Mobile framework
- **Provider** - State management
- **Dio** - HTTP client
- **file_picker** - File selection
- **Material Design 3** - UI framework

## Next Steps (Phase 4 & 5)

1. Implement file upload functionality
2. Add PDF reading capability
3. Enhance bookshelf UI with themes
4. Add user authentication
5. Create comprehensive test suite
6. Deploy to production

## API Usage Examples

### Get All Ebooks
```bash
curl http://localhost:3000/ebooks
```

### Search Ebooks
```bash
curl "http://localhost:3000/ebooks?title=Flutter&author=Google"
```

### Create Ebook
```bash
curl -X POST http://localhost:3000/ebooks \
  -H "Content-Type: application/json" \
  -d '{
    "ebook": {
      "title": "My Book",
      "author": "Author Name",
      "file_path": "/path/to/file.pdf",
      "file_size": 1024000
    }
  }'
```

## Troubleshooting

### Rails Server Won't Start
- Ensure SQLite3 is installed: `gem install sqlite3`
- Check Ruby version: `ruby --version` (should be 4.0+)
- Clear database: `rails db:drop db:create db:migrate`

### Flutter App Won't Connect to Backend
- Verify Rails server is running on port 3000
- Check CORS configuration in `backend/config/initializers/cors.rb`
- Ensure API_URL in Flutter points to correct backend address
- Test with curl: `curl http://localhost:3000/ebooks`

## Documentation

See [implementation-plan.md](./docs/implementation-plan.md) for detailed implementation notes.

## License

MIT License - See LICENSE file for details.

## Authors

- Backend: Rails API development
- Frontend: Flutter mobile app development

