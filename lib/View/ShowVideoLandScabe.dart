// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// class FullScreenVideoPage extends StatefulWidget {
//   final String  videoId;
//
//    FullScreenVideoPage({super.key, required this.videoId, });
//
//   @override
//   State<FullScreenVideoPage> createState() => _FullScreenVideoPageState();
// }
//
// class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//         initialVideoId: widget.videoId,
//
//         flags: YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//           loop: false,
//           isLive: false,
//           forceHD: false,
//           enableCaption: false,
//           showLiveFullscreenButton: false,
//           controlsVisibleAtStart: false,
//
//         ) ,);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }
//
//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//
//     ]);
//     _controller.dispose() ;
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: YoutubePlayer(controller: _controller,
//                 showVideoProgressIndicator: true,
//                 progressIndicatorColor: Colors.amber,
//                 progressColors: const ProgressBarColors(
//                   playedColor: Colors.amber,
//                   handleColor: Colors.amberAccent,
//                 ),
//
//
//                 onReady: () {
//                 },
//
//               ),
//             ),
//           ),
//
//           Positioned(
//             child: Container(
//
//             alignment: Alignment.centerRight,
//             color: Colors.black.withOpacity(0.001),
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.14,
//             child: IconButton(onPressed: (){
//               Navigator.of(context).pop();
//             }, icon: Icon(Icons.fullscreen_exit,color: Colors.white,size: 30,)),
//           ),
//             bottom: 0,
//             right: 10,
//
//           )
//         ],
//       ),
//     );
//   }
// }
