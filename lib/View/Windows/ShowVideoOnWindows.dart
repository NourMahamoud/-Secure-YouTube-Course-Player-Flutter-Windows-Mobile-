import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

import '../../ModelView/VideoProvider.dart';
import '../../utlis/ScreenSize.dart';

class YoutubePlayerWindows extends StatefulWidget {
  final String videoId;
  final bool autoPlay;

  const YoutubePlayerWindows({
    Key? key,
    required this.videoId,
    this.autoPlay = true,
  }) : super(key: key);

  @override
  State<YoutubePlayerWindows> createState() => _YoutubePlayerWindowsState();
}

class _YoutubePlayerWindowsState extends State<YoutubePlayerWindows> {
  bool _showControls = true;
  late VideoProvider _videoProvider;
  Timer? _controlsTimer;

  @override
  void initState() {
    super.initState();
    _videoProvider = VideoProvider();
    _videoProvider.init(widget.videoId);
    _startControlsTimer();
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(Duration(seconds: 3), () {
      if (mounted && _showControls) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _handleUserInteraction() {
    setState(() {
      _showControls = true;
    });
    _startControlsTimer();
  }

  @override
  void dispose() {
    _controlsTimer?.cancel();
    _videoProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _videoProvider,
      child: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          // Handle errors
          if (videoProvider.errorMessage != null) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      videoProvider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => videoProvider.init(widget.videoId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Show loading indicator while initializing
          if (!videoProvider.isInitialized) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Initializing YouTube Player...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: _handleUserInteraction,
            onPanDown: (_) => _handleUserInteraction(),
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  // WebView
                  Positioned.fill(
                    child: Webview(
                      videoProvider.controller,
                      permissionRequested: (url, kind, isUserInitiated) async {
                        return WebviewPermissionDecision.allow;
                      },
                    ),
                  ),

                  // Loading indicator when player is not ready
                  if (!videoProvider.isPlayerReady)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.red),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Loading YouTube Player...',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => videoProvider.init(widget.videoId),
                                child: const Text('Retry Initialization'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Controls overlay
                  AnimatedOpacity(
                    opacity: _showControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: ScreenSize.width(context),
                      height: ScreenSize.height(context),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          // Top controls
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            leading: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                videoProvider.controller.dispose();
                                Navigator.of(context).pop();
                              },
                            ),
                            title: Text(
                              'watch_lecture'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              // Mute/Unmute button
                              IconButton(
                                icon: Icon(
                                  videoProvider.isMuted
                                      ? Icons.volume_off
                                      : Icons.volume_up,
                                  color: Colors.white,
                                ),
                                onPressed: videoProvider.toggleMute,
                              ),
                              // Fullscreen button
                              IconButton(
                                icon: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                ),
                                onPressed: videoProvider.toggleFullscreen,
                              ),
                            ],
                          ),

                          // Center play/pause button
                          Expanded(
                            child: Center(
                              child: AnimatedOpacity(
                                opacity: _showControls ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: IconButton(
                                  icon: Icon(
                                    videoProvider.isPlaying
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_filled,
                                    color: Colors.white.withOpacity(0.9),
                                    size: 72,
                                  ),
                                  onPressed: videoProvider.togglePlayPause,
                                ),
                              ),
                            ),
                          ),

                          // Bottom controls
                          Container(
                            color: Colors.black.withOpacity(0.6),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                // Playback speed indicator
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Speed: ${videoProvider.playbackSpeed}x',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Row 1: Play controls
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _ControlButton(
                                      icon: Icons.replay_10,
                                      onPressed: videoProvider.rewind10,
                                      tooltip: 'Rewind 10s',
                                    ),
                                    _ControlButton(
                                      icon: Icons.fast_rewind,
                                      onPressed: videoProvider.restart,
                                      tooltip: 'Restart',
                                    ),
                                    _PlayPauseButton(
                                      isPlaying: videoProvider.isPlaying,
                                      onPressed: videoProvider.togglePlayPause,
                                    ),
                                    _ControlButton(
                                      icon: Icons.stop,
                                      onPressed: videoProvider.stop,
                                      tooltip: 'Stop',
                                    ),
                                    _ControlButton(
                                      icon: Icons.forward_10,
                                      onPressed: videoProvider.forward10,
                                      tooltip: 'Forward 10s',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Row 2: Speed controls
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _SpeedButton(
                                        speed: 0.25,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 0.25,
                                      ),
                                      _SpeedButton(
                                        speed: 0.5,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 0.5,
                                      ),
                                      _SpeedButton(
                                        speed: 0.75,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 0.75,
                                      ),
                                      _SpeedButton(
                                        speed: 1.0,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 1.0,
                                      ),
                                      _SpeedButton(
                                        speed: 1.25,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 1.25,
                                      ),
                                      _SpeedButton(
                                        speed: 1.5,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 1.5,
                                      ),
                                      _SpeedButton(
                                        speed: 1.75,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 1.75,
                                      ),
                                      _SpeedButton(
                                        speed: 2.0,
                                        provider: videoProvider,
                                        isSelected: videoProvider.playbackSpeed == 2.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Control button widget
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _ControlButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 28),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}

// Play/Pause button widget
class _PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPressed;

  const _PlayPauseButton({
    Key? key,
    required this.isPlaying,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isPlaying ? 'Pause' : 'Play',
      child: IconButton(
        icon: Icon(
          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
          color: Colors.white,
          size: 40,
        ),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.red.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

// Speed button widget
class _SpeedButton extends StatelessWidget {
  final double speed;
  final VideoProvider provider;
  final bool isSelected;

  const _SpeedButton({
    Key? key,
    required this.speed,
    required this.provider,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Tooltip(
        message: '${speed}x speed',
        child: ElevatedButton(
          onPressed: () => provider.setSpeed(speed),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.red : Colors.black.withOpacity(0.5),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Colors.white.withOpacity(isSelected ? 0.8 : 0.3),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            "${speed}x",
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}