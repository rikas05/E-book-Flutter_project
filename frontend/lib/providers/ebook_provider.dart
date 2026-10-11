import 'package:flutter/material.dart';
import '../models/ebook.dart';
import '../services/ebook_api_service.dart';

class EbookProvider extends ChangeNotifier {
  final EbookApiService _apiService = EbookApiService();

  List<Ebook> _ebooks = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // Getters
  List<Ebook> get ebooks => _ebooks;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  // Get filtered ebooks based on search
  List<Ebook> get filteredEbooks {
    if (_searchQuery.isEmpty) {
      return _ebooks;
    }
    return _ebooks.where((ebook) {
      return ebook.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ebook.author.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // Fetch all ebooks
  Future<void> fetchEbooks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _ebooks = await _apiService.getEbooks();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch ebook by id
  Future<Ebook?> fetchEbook(int id) async {
    try {
      return await _apiService.getEbook(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Create new ebook
  Future<bool> createEbook(Ebook ebook, String filePath) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newEbook = await _apiService.createEbook(ebook, filePath);
      _ebooks.insert(0, newEbook);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update ebook
  Future<bool> updateEbook(int id, Ebook ebook) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedEbook = await _apiService.updateEbook(id, ebook);
      final index = _ebooks.indexWhere((e) => e.id == id);
      if (index != -1) {
        _ebooks[index] = updatedEbook;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete ebook
  Future<bool> deleteEbook(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.deleteEbook(id);
      _ebooks.removeWhere((e) => e.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Search ebooks
  Future<void> searchEbooks(String query) async {
    _searchQuery = query;
    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
