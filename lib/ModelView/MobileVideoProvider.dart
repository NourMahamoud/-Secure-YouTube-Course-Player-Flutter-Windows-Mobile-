// import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/src/iframe_api/src/functions/video_information.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// class VideoProvider extends ChangeNotifier {
//   YoutubePlayerController? _controller;
//   bool _isPlaying = true;
//   double _volume = 100;
//   double _playbackRate = 1.0;
//   String? _videoId;
//   bool _isLoading = true;
//   String? _error;
//
//   // Getters
//   YoutubePlayerController? get controller => _controller;
//   bool get isPlaying => _isPlaying;
//   double get volume => _volume;
//   double get playbackRate => _playbackRate;
//   String? get videoId => _videoId;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//
//   Future<void> init(String videoId) async {
//     try {
//       _isLoading = true;
//       _error = null;
//       _videoId = videoId;
//       notifyListeners();
//
//       // Close existing controller if any
//       await _controller?.close();
//
//       _controller = YoutubePlayerController.fromVideoId(
//         videoId: videoId,
//         autoPlay: true,
//         params: const YoutubePlayerParams(
//           showControls: false,
//           showFullscreenButton: false,
//           enableCaption: false,
//           showVideoAnnotations: true,
//           strictRelatedVideos: false,
//           enableJavaScript: true,
//         ),
//       );
//
//       // Wait for controller to be ready
//       await _controller?.loadVideoById(videoId: videoId);
//
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _error = 'Failed to initialize video: $e';
//       notifyListeners();
//     }
//   }
//
//   Future<void> togglePlayPause() async {
//     if (_controller == null) return;
//
//     try {
//       _isPlaying = !_isPlaying;
//       if (_isPlaying) {
//         await _controller!.playVideo();
//       } else {
//         await _controller!.pauseVideo();
//       }
//       notifyListeners();
//     } catch (e) {
//       _error = 'Playback error: $e';
//       notifyListeners();
//     }
//   }
//
//   Future<void> play() async {
//     if (_controller == null) return;
//
//     try {
//       await _controller!.playVideo();
//       _isPlaying = true;
//       notifyListeners();
//     } catch (e) {
//       _error = 'Play error: $e';
//       notifyListeners();
//     }
//   }
//
//   Future<void> pause() async {
//     if (_controller == null) return;
//
//     try {
//       await _controller!.pauseVideo();
//       _isPlaying = false;
//       notifyListeners();
//     } catch (e) {
//       _error = 'Pause error: $e';
//       notifyListeners();
//     }
//   }
//
//   Future<void> setVolume(double value) async {
//     if (_controller == null) return;
//
//     try {
//       _volume = value.clamp(0, 100);
//       await _controller!.setVolume(_volume.round());
//       notifyListeners();
//     } catch (e) {
//       _error = 'Volume error: $e';
//       notifyListeners();
//     }
//   }
//
//   Future<void> seekTo(double seconds) async {
//     if (_controller == null) return;
//
//     try {
//       await _controller!.seekTo(seconds: seconds);
//       notifyListeners();
//     } catch (e) {
//       _error = 'Seek error: $e';
//       notifyListeners();
//     }
//   }
//
//
//   Future<Future<VideoData>?> getVideoData() async {
//     return _controller?.videoData;
//   }
//
//   void setPlaybackRate(double value) {
//     _playbackRate = value;
//
//     notifyListeners();
//   }
//
//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
//
//   @override
//   Future<void> dispose() async {
//     await _controller?.close();
//     super.dispose();
//   }
// }