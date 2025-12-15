import 'package:flutter_bloc/flutter_bloc.dart';
import 'global_state_manager.dart';

/// Mixin to add API request caching and deduplication to Cubits
mixin ApiRequestMixin<State> on Cubit<State> {
  final GlobalStateManager _stateManager = GlobalStateManager();

  /// Execute an API request with caching and deduplication
  Future<T> executeApiRequest<T>(
    String key,
    Future<T> Function() request, {
    Duration? cacheDuration,
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      _stateManager.clearCache(key);
    }

    return await _stateManager.executeRequest<T>(
      key,
      request,
      cacheDuration: cacheDuration,
    );
  }

  /// Clear cache for a specific key
  void clearApiCache(String key) {
    _stateManager.clearCache(key);
  }

  /// Clear all API cache
  void clearAllApiCache() {
    _stateManager.clearAllCache();
  }

  /// Check if data is cached
  bool isApiCached(String key, {Duration? cacheDuration}) {
    return _stateManager.isCached(key, cacheDuration: cacheDuration);
  }

  /// Get cached data without making a request
  T? getCachedApiData<T>(String key) {
    return _stateManager.getCached<T>(key);
  }
}