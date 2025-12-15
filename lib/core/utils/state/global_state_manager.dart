import 'dart:async';

/// A global state manager to prevent duplicate API requests and cache responses
class GlobalStateManager {
  static final GlobalStateManager _instance = GlobalStateManager._internal();
  factory GlobalStateManager() => _instance;
  GlobalStateManager._internal();

  final Map<String, dynamic> _cache = {};
  final Map<String, Completer<dynamic>> _pendingRequests = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  
  /// Cache duration in minutes
  static const int cacheDurationMinutes = 5;

  /// Execute a request with caching and deduplication
  Future<T> executeRequest<T>(
    String key,
    Future<T> Function() request, {
    Duration? cacheDuration,
  }) async {
    final duration = cacheDuration ?? const Duration(minutes: cacheDurationMinutes);
    
    // Check if we have a valid cached result
    if (_cache.containsKey(key) && _cacheTimestamps.containsKey(key)) {
      final cacheTime = _cacheTimestamps[key]!;
      if (DateTime.now().difference(cacheTime) < duration) {
        return _cache[key] as T;
      }
    }

    // Check if there's already a pending request for this key
    if (_pendingRequests.containsKey(key)) {
      return await _pendingRequests[key]!.future as T;
    }

    // Create a new request
    final completer = Completer<T>();
    _pendingRequests[key] = completer;

    try {
      final result = await request();
      
      // Cache the result
      _cache[key] = result;
      _cacheTimestamps[key] = DateTime.now();
      
      completer.complete(result);
      return result;
    } catch (error) {
      completer.completeError(error);
      rethrow;
    } finally {
      _pendingRequests.remove(key);
    }
  }

  /// Clear cache for a specific key
  void clearCache(String key) {
    _cache.remove(key);
    _cacheTimestamps.remove(key);
  }

  /// Clear all cache
  void clearAllCache() {
    _cache.clear();
    _cacheTimestamps.clear();
  }

  /// Check if a key is cached and valid
  bool isCached(String key, {Duration? cacheDuration}) {
    final duration = cacheDuration ?? const Duration(minutes: cacheDurationMinutes);
    
    if (!_cache.containsKey(key) || !_cacheTimestamps.containsKey(key)) {
      return false;
    }
    
    final cacheTime = _cacheTimestamps[key]!;
    return DateTime.now().difference(cacheTime) < duration;
  }

  /// Get cached value without making a request
  T? getCached<T>(String key) {
    return _cache[key] as T?;
  }
}