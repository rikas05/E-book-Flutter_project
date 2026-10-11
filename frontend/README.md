# Frontend - Flutter App for Ebook Library

A mobile application built with Flutter for browsing and managing digital ebooks.

## Setup

### Prerequisites

- Flutter 3.13+
- Dart 3.1+
- Android Studio or Xcode (for mobile development)

### Installation

```bash
flutter pub get
```

### Running the App

#### Android
```bash
flutter run -d android
```

#### iOS
```bash
flutter run -d ios
```

#### Web
```bash
flutter run -d web
```

#### All Devices
```bash
flutter run
```

## Project Structure

```
frontend/
├── lib/
│   ├── main.dart                    # App entry point with Provider setup
│   ├── models/
│   │   └── ebook.dart               # Ebook data model
│   ├── services/
│   │   └── ebook_api_service.dart   # API communication layer
│   ├── providers/
│   │   └── ebook_provider.dart      # State management with Provider
│   ├── screens/
│   │   ├── bookshelf_screen.dart    # Main library view with grid
│   │   ├── ebook_detail_screen.dart # Book details and actions
│   │   ├── ebook_reader_screen.dart # PDF viewer screen
│   │   └── upload_ebook_screen.dart # File upload screen
│   └── ...
├── test/
│   └── widget_test.dart             # Basic widget test
├── pubspec.yaml                     # Flutter dependencies
└── README.md                        # This file
```

## Features

### Screens

#### 1. Bookshelf Screen
- Grid display of all ebooks
- Search bar for filtering by title or author
- Real-time search results
- Tap to view book details
- Floating action button for upload
- Loading and error states
- Empty state message

#### 2. Detail Screen
- Full ebook information display
- Book cover placeholder
- Editable metadata (title, author, description)
- File information (path, size, upload date)
- Quick action buttons:
  - Download (future implementation)
  - Read (implemented with PDF viewer)
  - Delete with confirmation dialog

### State Management

#### EbookProvider
Manages all ebook-related state using Provider pattern:
- `ebooks` - List of all ebooks
- `isLoading` - Loading state for API calls
- `error` - Error messages for display
- `searchQuery` - Current search filter
- `filteredEbooks` - Search results

**Methods:**
- `fetchEbooks()` - Load all ebooks from API
- `fetchEbook(id)` - Load single ebook details
- `createEbook(ebook, filePath)` - Create new ebook with file
- `updateEbook(id, ebook)` - Update ebook
- `deleteEbook(id)` - Delete ebook
- `searchEbooks(query)` - Filter by search term
- `clearSearch()` - Reset search filter
- `clearError()` - Clear error message

### API Service

#### EbookApiService
Handles all HTTP communication with the Rails backend:
- Base URL: `http://localhost:3000`
- Timeout: 30 seconds for connect and receive
- Content-Type: application/json

**Key Methods:**
- `getEbooks({title, author})` - List all/filtered ebooks
- `getEbook(id)` - Get single ebook
- `createEbook(ebook, filePath)` - Create new ebook with file
- `updateEbook(id, ebook)` - Update ebook
- `deleteEbook(id)` - Delete ebook
- `searchEbooks({title, author})` - Search ebooks
- `downloadEbook(id, savePath)` - Download ebook file

### Data Model

#### Ebook Class
Represents an ebook with:
- `id` - Unique identifier (nullable for new ebooks)
- `title` - Book title (required)
- `author` - Book author (required)
- `description` - Book description (optional)
- `filePath` - Path to ebook file (required)
- `fileSize` - File size in bytes (required)
- `uploadedAt` - Upload timestamp (required)

**Methods:**
- `fromJson()` - Parse from API response
- `toJson()` - Convert to JSON for API requests
- `copyWith()` - Create modified copy of ebook

## Dependencies

### Key Packages

- **provider** ^6.0.0 - State management
- **dio** ^5.3.0 - HTTP client with better error handling
- **http** ^1.1.0 - Basic HTTP functionality
- **file_picker** ^5.4.0 - File selection for uploads
- **flutter_pdfview** ^1.3.2 - PDF viewing capability
- **path_provider** ^2.1.0 - File system access
- **cupertino_icons** ^1.0.8 - iOS-style icons
- **flutter_lints** ^6.0.0 - Code quality
- **flutter_test** - Widget testing

## Configuration

### Backend URL

To change the backend API URL, edit `EbookApiService` in `lib/services/ebook_api_service.dart`:

```dart
static const String baseUrl = 'http://localhost:3000';
```

For production, consider:
- Using environment variables
- Adding a configuration file
- Implementing build flavors

## Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/widget_test.dart
```

### Widget Testing
```bash
flutter test test/widget_test.dart
```

### Generate Coverage Report
```bash
flutter test --coverage
```

## UI/UX Details

### Color Scheme
- Primary: Blue (Colors.blue)
- Primary Dark: Dark Blue (Colors.blue.shade700)
- Background: White
- Accent: Green for download, Red for delete
- Error: Red with error icon

### Layout
- **Bookshelf**: 2-column grid with card-based design
- **Search Bar**: Full-width with clear button
- **Detail Screen**: Single-column scrollable layout
- **Cards**: Rounded corners, elevation for depth
- **Icons**: Material Icons (primary) and Cupertino Icons

### Responsive Design
- Auto-adjusts for different screen sizes
- GridView adjusts columns based on space
- Text wrapping and truncation to prevent overflow

## Error Handling

### User-Facing Errors
- Error state with icon and message
- Retry button in error state
- SnackBar messages for quick actions
- Validation errors in text fields

### Network Errors
- Timeouts: 30 seconds per request
- Connection errors: Displayed in UI
- Parsing errors: Generic error message
- API errors: Specific error details

## Performance Considerations

- Lazy loading of ebooks
- Filtered list updated on-the-fly
- Debounced search (can be added)
- Image caching (for future cover images)
- Minimal rebuilds with Provider

## Troubleshooting

### App Won't Connect to Backend
1. Verify backend is running: `rails s -p 3000`
2. Check API URL in `EbookApiService`
3. Test with curl: `curl http://localhost:3000/ebooks`
4. Check CORS settings in Rails

### Dependencies Won't Install
```bash
flutter pub cache clean
flutter pub get
```

### Hot Reload Not Working
```bash
flutter clean
flutter pub get
flutter run
```

### Build Fails
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

## Development Workflow

### Hot Reload
- Make changes and press 'r' in terminal
- Faster than full rebuild
- Preserves app state

### Hot Restart
- Press 'R' in terminal
- Restarts app, resets state
- Slower than hot reload

### Full Rebuild
```bash
flutter clean
flutter run
```

## Future Enhancements

- [x] Implement file upload functionality
- [x] Add PDF reader integration
- [ ] Implement user authentication
- [ ] Add bookmarks and notes feature
- [ ] Enhance bookshelf UI with themes
- [ ] Add offline reading capability
- [ ] Implement favorites/bookmarks
- [ ] Add reading progress tracking

## Related Documentation

- [Main Project README](../README.md)
- [Implementation Plan](../docs/implementation-plan.md)
- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package Docs](https://pub.dev/packages/provider)

