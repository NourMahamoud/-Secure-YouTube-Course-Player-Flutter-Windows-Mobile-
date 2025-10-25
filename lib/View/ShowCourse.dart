// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// import 'ShowVideoLandScabe.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key, required this.videoId});
//
//   final String videoId;
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.videoId,
//
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: false,
//         showLiveFullscreenButton: false,
//         controlsVisibleAtStart: false,
//
//       ) ,
//
//     );
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose() ;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: Text('watch_lecture'.tr())),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     width: width,
//                     child: AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: YoutubePlayer(controller: _controller,
//                         showVideoProgressIndicator: true,
//                         progressIndicatorColor: Colors.amber,
//                         progressColors: const ProgressBarColors(
//                           playedColor: Colors.amber,
//                           handleColor: Colors.amberAccent,
//                         ),
//
//
//                         onReady: () {
//                         },
//
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     top: 0,
//                     child: Container(
//                       color: Colors.black.withOpacity(0.001),
//                       width: 50,
//                     //  height: videoHeight * 0.11,
//                       alignment: Alignment.bottomRight,
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) => FullScreenVideoPage(
//                                 videoId: widget.videoId,
//                               ),
//                             ),
//                           );
//                         },
//                         icon: Icon(
//                           Icons.fullscreen,
//                           color: Colors.white,
//                           size: width * 0.07,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
