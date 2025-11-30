# Mafia Killer 🔫

**A full-featured Flutter application for hosting and playing the classic Mafia (Werewolf) social deduction party games.**

Built entirely with Flutter for cross-platform (Android & iOS) deployment, the app currently stands at version **1.1.2+5** and is fully functional as a professional game master/narrator tool with rich visuals, audio immersion, and polished Persian UI.

## ✨ Current Features (Implemented & Working)

- **Complete Persian UI & Localization**  
  Full RTL support with three custom Persian/Arabic fonts (Noto Sans Arabic, Negar, Digi Ghaf Bold) for perfect typography and authentic feel.

- **High-Quality Visual Assets**  
  100+ custom-designed images including:
  - Role cards (all standard + advanced Mafia roles)
  - Role character illustrations
  - Last move / will cards
  - Endgame victory/defeat screens
  - Custom dialog boxes
  - Multiple atmospheric backgrounds
  - Icon sets

- **Immersive Audio System** (just_audio)  
  Professional sound effects and background music for day/night phases, role actions, voting, elimination, and dramatic moments.

- **Smooth Animations & Feedback**  
  - Loading spinners (flutter_spinkit)
  - Beautiful animated snack bars for in-game messages and announcements
  - Fluid transitions and visual effects throughout the game flow

- **Responsive & Adaptive Text** (auto_size_text)  
  Text automatically scales to fit any screen size while maintaining readability.

- **Monetization Ready** (Tapsell Plus)  
  Integrated Iranian ad network for banner, interstitial, and rewarded ads.

- **Robust Technical Foundation**
  - JSON serialization (json_annotation + json_serializable)
  - Logging system (logger)
  - Local file system access (path_provider)
  - HTTP requests & HTML parsing when needed
  - App version & build info display (package_info_plus)
  - External link launching (url_launcher)
  - Font Awesome icons integrated

- **Game Flow & Mechanics Implemented**
  - Role assignment and display
  - Night phase with audio cues and role actions
  - Day phase discussion and voting system
  - Game master narration mode
  - Endgame handling with custom victory screens
  - All core Mafia roles supported with dedicated visuals and audio

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point & MaterialApp setup
├── screens/                     # All game screens (home, setup, game, night, day, result...)
├── widgets/                     # Reusable custom widgets
├── models/                      # Role, Player, GameState models (JSON serializable)
├── services/                    # AudioService, GameLogic, etc.
├── utils/                       # Helpers, constants, extensions
├── assets/                      # Local assets (moved to lib/ for organization)
└── images/                      # All role cards, characters, backgrounds, etc.

assets/audios/                   # Sound effects & background music
pubspec.yaml                     # All dependencies & asset declarations
```

The app is production-ready in terms of core gameplay, visuals, and audio experience. It has been built and tested multiple times (build number +5).
