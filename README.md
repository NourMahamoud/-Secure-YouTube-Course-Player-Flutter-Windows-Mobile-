Secure YouTube Course Player (Flutter – Windows & Mobile)
📌 Overview

This project provides a secure playback layer for YouTube-hosted educational videos.

Instead of exposing YouTube links directly, this application:

Embeds videos inside a controlled environment

Prevents direct link copying

Disables native YouTube controls

Minimizes screen recording risks

Provides platform-specific secure handling

🏗 Architecture
🖥 Windows Implementation

Windows does not natively support secure embedded YouTube playback.

Solution implemented:

Custom webview_windows controller

Local HTTP server inside Flutter app

Injected YouTube IFrame API

Custom origin handling to avoid Error 150/153

JavaScript ↔ Dart communication bridge

Disabled popup policy

Custom playback control functions

Windows Flow

Initialize WebView

Start local HTTP server

Serve secure HTML player

Inject YouTube IFrame API

Control playback via JS bridge

📱 Mobile Implementation

Using youtube_player_flutter with:

Hidden thumbnail

Controlled UI

Immersive fullscreen mode

Locked landscape orientation

Custom playback actions

No redirect to YouTube app

🔒 Security Features

No visible direct video URL

No copyable YouTube link

No native share button

Controlled playback only via app

Popup window denied

JS API locked to defined origin

⚙ Technologies Used

Flutter

webview_windows

youtube_player_flutter

Dart HTTP Server

YouTube IFrame API

JavaScript Bridge Communication

🚀 Use Case

Designed for:

Paid course platforms

Educational institutions

Private training systems

Premium digital content protection

⚠ Disclaimer

This project does not bypass YouTube policies.
It provides a controlled playback layer to reduce content misuse.
