// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:Elmotakhasas/ModelView/MobileVideoProvider.dart';
// import 'package:provider/provider.dart';
//
// class CustomBottomSheetSetting extends StatelessWidget {
//   const CustomBottomSheetSetting({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(create: (_)=>VideoProvider(),
//       child: _CustomBottomSheetSetting(),
//     );
//   }
// }
// class _CustomBottomSheetSetting extends StatelessWidget {
//   const _CustomBottomSheetSetting({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<VideoProvider>(context, listen: false);
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Container(
//       color: Colors.black87,
//       child: Consumer<VideoProvider>(
//
//         builder: ( context,videoProvider,child) {
//           return Container(
//             height: height * 0.35,
//             padding: EdgeInsets.all(width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: width * 0.15,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[600],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: height * 0.02),
//                 Text('video_settings'.tr(),
//                     style: TextStyle(color: Colors.white, fontSize: width * 0.05, fontWeight: FontWeight.bold)),
//                 SizedBox(height: height * 0.03),
//
//                 // Play / Pause
//                 Row(
//                   children: [
//                     Icon(Icons.play_arrow, color: Colors.white, size: width * 0.06),
//                     SizedBox(width: width * 0.03),
//                     Text('playback'.tr(), style: TextStyle(color: Colors.white, fontSize: width * 0.04)),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: provider.togglePlayPause,
//                       icon: Icon(
//                         provider.isPlaying ? Icons.pause : Icons.play_arrow,
//                         color: Colors.white,
//                         size: width * 0.06,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 // Volume
//                 Row(
//                   children: [
//                     Icon(Icons.volume_up, color: Colors.white, size: width * 0.06),
//                     SizedBox(width: width * 0.03),
//                     Text('volume'.tr(), style: TextStyle(color: Colors.white, fontSize: width * 0.04)),
//                     Expanded(
//                       child: Slider(
//                         value: provider.volume,
//                         min: 0,
//                         max: 100,
//                         divisions: 10,
//                         activeColor: Colors.red,
//                         inactiveColor: Colors.grey,
//                         onChanged: provider.setVolume,
//                       ),
//                     ),
//                     Text('${provider.volume.round()}%', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//
//                 // Playback speed
//                 Row(
//                   children: [
//                     Icon(Icons.speed, color: Colors.white, size: width * 0.06),
//                     SizedBox(width: width * 0.03),
//                     Text('playback_speed'.tr(), style: TextStyle(color: Colors.white, fontSize: width * 0.04)),
//                     const Spacer(),
//                     DropdownButton<double>(
//                       value: provider.playbackRate,
//                       dropdownColor: Colors.grey[900],
//                       style: TextStyle(color: Colors.white, fontSize: width * 0.04),
//                       items: [0.5, 1.0, 1.5, 2.0]
//                           .map((rate) => DropdownMenuItem(value: rate, child: Text('${rate}x')))
//                           .toList(),
//                       onChanged: (value) {
//                         if (value != null) provider.setPlaybackRate(value);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
