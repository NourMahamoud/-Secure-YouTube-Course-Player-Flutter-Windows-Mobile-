// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// class YoutubeVideoWidget extends StatelessWidget {
//   final String videoId;
//   final double aspectRatio;
//
//   const YoutubeVideoWidget({
//     Key? key,
//     required this.videoId,
//     this.aspectRatio = 16 / 9,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => YoutubeVideoProvider()..init(videoId),
//       child: Consumer<YoutubeVideoProvider>(
//         builder: (context, provider, child) {
//           if (provider.errorMessage != null) {
//             return _buildErrorWidget(provider.errorMessage!);
//           }
//
//           if (!provider.isInitialized) {
//             return _buildLoadingWidget();
//           }
//
//           return Column(
//             children: [
//               _buildVideoPlayer(provider),
//               _buildCustomControls(provider),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildVideoPlayer(YoutubeVideoProvider provider) {
//     return AspectRatio(
//       aspectRatio: aspectRatio,
//       child: YoutubePlayerScaffold(
//         controller: provider.controller,
//         builder: (context, player) {
//           return player;
//         },
//       ),
//     );
//   }
//
//   Widget _buildCustomControls(YoutubeVideoProvider provider) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       color: Colors.grey[100],
//       child: Column(
//         children: [
//           // Playback controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.replay_10),
//                 onPressed: provider.seekBackward,
//                 tooltip: 'Rewind 10 seconds',
//               ),
//               IconButton(
//                 icon: Icon(
//                   provider.isPlaying ? Icons.pause : Icons.play_arrow,
//                   size: 32,
//                 ),
//                 onPressed: provider.togglePlayPause,
//                 tooltip: provider.isPlaying ? 'Pause' : 'Play',
//               ),
//               IconButton(
//                 icon: const Icon(Icons.forward_10),
//                 onPressed: provider.seekForward,
//                 tooltip: 'Forward 10 seconds',
//               ),
//               IconButton(
//                 icon: const Icon(Icons.replay),
//                 onPressed: provider.restart,
//                 tooltip: 'Restart video',
//               ),
//               IconButton(
//                 icon: Icon(provider.isMuted ? Icons.volume_off : Icons.volume_up),
//                 onPressed: provider.toggleMute,
//                 tooltip: provider.isMuted ? 'Unmute' : 'Mute',
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 8),
//
//           // Speed and fullscreen controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Playback speed
//               Row(
//                 children: [
//                   const Text('Speed: ', style: TextStyle(fontWeight: FontWeight.bold)),
//                   PopupMenuButton<double>(
//                     onSelected: provider.setSpeed,
//                     itemBuilder: (context) => [
//                       _buildSpeedMenuItem(0.25, '0.25x'),
//                       _buildSpeedMenuItem(0.5, '0.5x'),
//                       _buildSpeedMenuItem(0.75, '0.75x'),
//                       _buildSpeedMenuItem(1.0, 'Normal'),
//                       _buildSpeedMenuItem(1.25, '1.25x'),
//                       _buildSpeedMenuItem(1.5, '1.5x'),
//                       _buildSpeedMenuItem(2.0, '2.0x'),
//                     ],
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         '${provider.playbackSpeed}x',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               // Volume slider
//               SizedBox(
//                 width: 150,
//                 child: Row(
//                   children: [
//                     const Icon(Icons.volume_up, size: 20),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Slider(
//                         value: provider.volume,
//                         min: 0,
//                         max: 100,
//                         divisions: 10,
//                         onChanged: provider.setVolume,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Fullscreen button
//               IconButton(
//                 icon: const Icon(Icons.fullscreen),
//                 onPressed: provider.toggleFullscreen,
//                 tooltip: 'Toggle fullscreen',
//               ),
//             ],
//           ),
//
//           // Progress information
//           const SizedBox(height: 8),
//           _buildProgressInfo(provider),
//         ],
//       ),
//     );
//   }
//
//   PopupMenuItem<double> _buildSpeedMenuItem(double speed, String label) {
//     return PopupMenuItem<double>(
//       value: speed,
//       child: Text(label),
//     );
//   }
//
//   Widget _buildProgressInfo(YoutubeVideoProvider provider) {
//     final position = provider.currentPosition;
//     final duration = provider.totalDuration;
//
//     String formatDuration(Duration d) {
//       final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
//       final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
//       return '$minutes:$seconds';
//     }
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           formatDuration(position),
//           style: const TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//         Text(
//           '${(position.inSeconds / duration.inSeconds * 100).toStringAsFixed(1)}%',
//           style: const TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//         Text(
//           formatDuration(duration),
//           style: const TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return AspectRatio(
//       aspectRatio: aspectRatio,
//       child: Container(
//         color: Colors.black,
//         child: const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red)),
//               SizedBox(height: 16),
//               Text(
//                 'Loading YouTube Player...',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget(String error) {
//     return AspectRatio(
//       aspectRatio: aspectRatio,
//       child: Container(
//         color: Colors.black,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error_outline, color: Colors.white, size: 64),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Failed to load video',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   error,
//                   style: const TextStyle(color: Colors.white70),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     // You can add retry logic here
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }