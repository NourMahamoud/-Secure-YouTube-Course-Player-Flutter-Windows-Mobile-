import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class VideoProvider extends ChangeNotifier {
  final WebviewController controller = WebviewController();
  bool isInitialized = false;
  bool isPlayerReady = false;
  bool isPlaying = false;
  bool isFullscreen = false;
  bool isMuted = false; // Added mute state
  double playbackSpeed = 1.0;
  String? errorMessage;

  Future<void> init(String videoId) async {
    try {
      await controller.initialize();
      await controller.setBackgroundColor(Colors.black);
      await controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);

      final html = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            margin: 0;
            padding: 0;
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
          }
          #player {
            width: 100%;
            height: 100%;
          }
          .status {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-family: Arial;
            font-size: 12px;
            z-index: 1000;
          }
        </style>
      </head>
      <body>
        <div class="status">Loading YouTube Player...</div>
        <div id="player"></div>
        <script>
          // function to send messages to flutter
          function sendMessage(type, data) {
            console.log("Sending message:", type, data);
            try {
              if (window.chrome && window.chrome.webview) {
                window.chrome.webview.postMessage(JSON.stringify({ 
                  type: type, 
                  data: data 
                }));
              }
            } catch(e) {
              console.error("Failed to send message:", e);
            }
          }

          var tag = document.createElement('script');
          tag.src = "https://www.youtube.com/iframe_api";
          var firstScriptTag = document.getElementsByTagName('script')[0];
          firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

          var player;
          var isPlayerCreated = false;
          
          function updateStatus(message) {
            var statusEl = document.querySelector('.status');
            if (statusEl) {
              statusEl.textContent = message;
            }
          }

          function onYouTubeIframeAPIReady() {
            updateStatus("Creating YouTube Player...");
            player = new YT.Player('player', {
              height: '100%',
              width: '100%',
              videoId: '$videoId',
              playerVars: {
                'autoplay': 1,
                'controls': 0,
                'modestbranding': 1,
                'rel': 0,
                'playsinline': 1,
                'enablejsapi': 1
              },
              events: {
                'onReady': function(event) {
                  updateStatus("Player Ready - Starting Video");
                  isPlayerCreated = true;
                  sendMessage("ready");
                  // Don't mute by default - let user control
                  player.playVideo();
                },
                'onStateChange': function(event) {
                  console.log("Player state:", event.data);
                  if (event.data == YT.PlayerState.PLAYING) {
                    sendMessage("playing");
                  } else if (event.data == YT.PlayerState.PAUSED) {
                    sendMessage("paused");
                  } else if (event.data == YT.PlayerState.ENDED) {
                    sendMessage("ended");
                  } else if (event.data == YT.PlayerState.BUFFERING) {
                    sendMessage("buffering");
                  }
                },
                'onError': function(error) {
                  updateStatus("Player Error: " + error.data);
                  sendMessage("error", error.data);
                }
              }
            });
          }

          function playVideo() { 
            if (player && typeof player.playVideo === 'function') {
              player.playVideo(); 
            }
          }
          
          function pauseVideo() { 
            if (player && typeof player.pauseVideo === 'function') {
              player.pauseVideo(); 
            }
          }
          
          function stopVideo() { 
            if (player && typeof player.stopVideo === 'function') {
              player.stopVideo(); 
            }
          }
          
          function seekToStart() { 
            if (player && typeof player.seekTo === 'function') {
              player.seekTo(0, true); 
            }
          }
          
          function forward10() { 
            if (player && typeof player.getCurrentTime === 'function') {
              var t = player.getCurrentTime(); 
              player.seekTo(t + 10, true); 
            }
          }
          
          function rewind10() { 
            if (player && typeof player.getCurrentTime === 'function') {
              var t = player.getCurrentTime(); 
              player.seekTo(t - 10, true); 
            }
          }
          
          function setSpeed(speed) { 
            if (player && typeof player.setPlaybackRate === 'function') {
              player.setPlaybackRate(speed); 
              sendMessage("speed", speed);
            }
          }
          
          function toggleMute() {
            if (player && typeof player.isMuted === 'function') {
              if (player.isMuted()) {
                player.unMute();
                sendMessage("unmuted");
              } else {
                player.mute();
                sendMessage("muted");
              }
            }
          }
          
          function setMute(muted) {
            if (player) {
              if (muted) {
                player.mute();
                sendMessage("muted");
              } else {
                player.unMute();
                sendMessage("unmuted");
              }
            }
          }
          
          function toggleFullscreen() {
            var iframe = player.getIframe();
            if (iframe && iframe.requestFullscreen) {
              iframe.requestFullscreen();
            }
          }

          // Fallback: check if player is created after 5 seconds
          setTimeout(function() {
            if (!isPlayerCreated) {
              updateStatus("Player creation timeout - retrying...");
              sendMessage("error", "Player creation timeout");
            }
          }, 5000);
        </script>
      </body>
      </html>
      ''';

      await controller.loadStringContent(html);

      controller.webMessage.listen((event) {
        debugPrint("📩 Raw message received: ${event.runtimeType} - $event");
        _handleWebMessage(event);
      });

      isInitialized = true;
      notifyListeners();

      // Fallback: mark as ready after 3 seconds if no message received
      Future.delayed(Duration(seconds: 3), () {
        if (!isPlayerReady) {
          debugPrint("⚠️ Using fallback - marking player as ready");
          isPlayerReady = true;
          notifyListeners();
        }
      });

    } on PlatformException catch (e) {
      errorMessage = "Initialization error: ${e.message}";
      notifyListeners();
    }
  }

  void _handleWebMessage(dynamic event) {
    try {
      Map<String, dynamic> message = {};

      if (event is String) {
        try {
          message = jsonDecode(event) as Map<String, dynamic>;
        } catch (e) {
          // Handle simple string messages
          _handleSimpleMessage(event);
          return;
        }
      } else if (event is Map) {
        message = event.cast<String, dynamic>();
      }

      final String type = message['type']?.toString() ?? '';
      final dynamic data = message['data'];

      debugPrint("🎯 Processing message - Type: $type, Data: $data");

      switch (type) {
        case 'ready':
          isPlayerReady = true;
          isPlaying = true;
          break;
        case 'playing':
          isPlaying = true;
          break;
        case 'paused':
        case 'ended':
        case 'buffering':
          isPlaying = false;
          break;
        case 'error':
          errorMessage = "YouTube error: $data";
          break;
        case 'speed':
          if (data != null) {
            playbackSpeed = (data is num) ? data.toDouble() : double.tryParse(data.toString()) ?? 1.0;
            debugPrint("🎚️ Speed changed to: $playbackSpeed");
          }
          break;
        case 'muted':
          isMuted = true;
          break;
        case 'unmuted':
          isMuted = false;
          break;
      }

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error handling message: $e");
    }
  }

  void _handleSimpleMessage(String message) {
    debugPrint("📨 Simple message: $message");

    switch (message) {
      case 'ready':
        isPlayerReady = true;
        isPlaying = true;
        break;
      case 'playing':
        isPlaying = true;
        break;
      case 'paused':
      case 'ended':
        isPlaying = false;
        break;
    }
    notifyListeners();
  }

  void play() => _runJs("playVideo();");
  void pause() => _runJs("pauseVideo();");
  void stop() => _runJs("stopVideo();");
  void restart() => _runJs("seekToStart();");
  void forward10() => _runJs("forward10();");
  void rewind10() => _runJs("rewind10();");

  void setSpeed(double speed) {
    playbackSpeed = speed;
    _runJs("setSpeed($speed);");
    notifyListeners(); // Force UI update
  }

  void toggleMute() {
    isMuted = !isMuted;
    _runJs("setMute($isMuted);");
    notifyListeners();
  }

  void toggleFullscreen() => _runJs("toggleFullscreen();");
  void togglePlayPause() {
    if (isPlaying) {
      pause();
      isPlaying = false;
      notifyListeners();
    } else {
      play();
      isPlaying = true;
      notifyListeners();
    }
  }

  void _runJs(String jsCode) {
    if (isPlayerReady) {
      try {
        controller.executeScript(jsCode);
        debugPrint("✅ Executed JS: $jsCode");
      } catch (e) {
        debugPrint("❌ JS execution error: $e");
      }
    } else {
      debugPrint("⏳ Player not ready yet! Tried: $jsCode");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}