import 'package:flutter/material.dart';
import '../models/emoji_category.dart';
import '../services/search_service.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchService _searchService = SearchService();
  List<String> _searchResults = [];
  bool _isSearching = false;
  List<EmojiCategory> _categories = [];

  SearchViewModel(this._categories);

  List<String> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  void searchEmojis(String query) {
    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
    } else {
      _searchResults = _searchService.searchEmojis(query, _categories);
      _isSearching = true;
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }
}
