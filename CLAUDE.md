# ManageMyLupus - AI Knowledge Base

> This file helps AI assistants quickly understand the project without reading all files.
> Last updated: 2026-06-17

## Project Overview

**ManageMyLupus** is a medical education app for lupus patients. It's a cross-platform app using:
- **Single Rails codebase** that serves web, iOS, and Android
- **Turbo Native** for native mobile wrappers
- **Offline caching** via Service Workers

```
┌─────────────────────────────────────────┐
│     Rails App (render.com)              │
│     Edit once → updates all platforms   │
└─────────────────────────────────────────┘
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
    Browser    iOS App     Android App
               (App Store) (Play Store)
```

## Tech Stack

| Layer | Technology |
|-------|------------|
| Backend | Rails 8.0.2, Ruby 3.3.4 |
| Database | SQLite3 |
| Frontend | Hotwire (Turbo + Stimulus), Bootstrap 5, Tailwind |
| iOS | Swift + turbo-ios |
| Android | Kotlin + turbo-android |
| AI | OpenAI API (embeddings for card ranking) |
| Hosting | Render.com |

## Directory Structure

```
ManagemyLupus_ROR/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb    # Includes TurboNativeNavigation
│   │   ├── home_controller.rb           # Landing page
│   │   ├── survey_controller.rb         # Main survey logic (save, next)
│   │   ├── cards_controller.rb          # Individual card details (for native modals)
│   │   ├── pwa_controller.rb            # Offline fallback page
│   │   └── turbo/
│   │       └── native_controller.rb     # Path configuration for native apps
│   │
│   ├── controllers/concerns/
│   │   └── turbo_native_navigation.rb   # Detection helpers (turbo_native_app?, etc.)
│   │
│   ├── models/
│   │   └── survey_card.rb               # PORO with all card data (not ActiveRecord!)
│   │
│   ├── views/
│   │   ├── layouts/
│   │   │   ├── application.html.erb     # Main web layout
│   │   │   └── turbo_native.html.erb    # Native-specific layout (hides footer, safe areas)
│   │   ├── home/index.html.erb          # Landing page
│   │   ├── survey/next.html.erb         # Main survey card display
│   │   ├── cards/show.html.erb          # Individual card detail (for deep links)
│   │   ├── pwa/
│   │   │   ├── manifest.json.erb        # PWA manifest
│   │   │   ├── service-worker.js        # Offline caching logic
│   │   │   └── offline.html.erb         # Offline fallback page
│   │   └── shared/_modal.html.erb       # Reusable modal component
│   │
│   └── helpers/
│       └── survey_helper.rb             # OpenAI embedding helper (get_embedding)
│
├── config/
│   ├── routes.rb                        # All routes defined here
│   └── initializers/
│       └── openai.rb                    # OpenAI client setup (requires OPENAI_API_KEY)
│
├── ManageMyLupus-iOS/                   # iOS native shell
│   └── ManageMyLupus/
│       ├── App/
│       │   ├── AppDelegate.swift
│       │   └── SceneDelegate.swift      # App entry, deep link handling
│       ├── Navigation/
│       │   └── TurboNavigator.swift     # Navigation logic, offline handling
│       ├── Controllers/
│       │   └── VisitableViewController.swift
│       └── Resources/
│           └── path-configuration.json  # Navigation rules
│
├── ManageMyLupus-Android/               # Android native shell
│   └── app/src/main/
│       ├── java/com/managemylupus/app/
│       │   ├── TurboApplication.kt      # App setup, base URL config
│       │   ├── MainActivity.kt          # Main activity, deep links
│       │   ├── MainSessionNavHostFragment.kt  # Turbo session, offline handling
│       │   ├── WebFragment.kt           # Default web fragment
│       │   └── WebBottomSheetDialogFragment.kt  # Modal fragment
│       └── res/
│           ├── raw/path_configuration.json
│           ├── layout/*.xml
│           └── navigation/nav_graph.xml
│
└── CLAUDE.md                            # This file
```

## Key Routes

```ruby
GET  /                           # Home page
POST /survey/save                # Save survey answers to session
GET  /survey/next?category=X     # Show cards (basic|treatment|steroids|biologic|sexspissues|foryou)
GET  /cards/:id                  # Individual card detail
GET  /turbo/native/configuration # Path config JSON for native apps
GET  /offline                    # Offline fallback page
GET  /manifest.json              # PWA manifest
GET  /service-worker.js          # Service worker
```

## Data Model

**SurveyCard** (PORO in `app/models/survey_card.rb`):
- NOT a database model - all cards are hardcoded
- Card categories: `intro`, `treatment`, `steroids`, `biologic`, `sexspissues`, `learn_cards`
- Each card has: id, title, image_url, description (array), categories, learn_more, learn_more_id, hidden

**Session Storage**:
```ruby
session[:survey] = {
  gender: "female",           # female, male
  status: "active_kidneys",   # quiet, active_no_kidneys, active_kidneys
  kidney_treatment: "a",      # a, b, c, d
  notes: "user notes..."      # Free text for AI ranking
}
```

## Turbo Native Detection

```ruby
# In controllers/views:
turbo_native_app?      # true if request from iOS or Android app
turbo_native_ios?      # true if iOS
turbo_native_android?  # true if Android

# Native apps send User-Agent containing "Turbo Native"
```

## Path Configuration (Navigation Rules)

```json
{
  "rules": [
    { "patterns": ["^/$"], "properties": { "presentation": "replace" } },
    { "patterns": ["^/survey/next"], "properties": { "presentation": "push" } },
    { "patterns": ["^/cards/\\d+$"], "properties": { "presentation": "modal" } }
  ]
}
```

- `replace` - Replace current screen
- `push` - Push onto navigation stack
- `modal` - Present as modal/bottom sheet
- `none` - No navigation (form submissions)

## Offline Support

1. **Service Worker** caches pages on visit
2. **Offline page** shown for uncached routes
3. **Auto-reload** when back online (iOS/Android)

Cached automatically:
- Home page, all survey categories
- Any page visited while online
- CSS, JS, images

## Environment Variables

```bash
OPENAI_API_KEY=sk-...  # Required for "For You" card ranking
```

## Admin Panel

**URL:** `/admin/cards`
**Login:** admin / lupus2024 (hardcoded in `admin/cards_controller.rb`)

### How It Works
```
Doctor edits card in admin
        ↓
New YAML version created: config/cards/versions/treatment_20260617_143022.yml
        ↓
App reads latest YAML (falls back to hardcoded if no YAML)
        ↓
All versions traceable in History tab
```

### Key Files
- `app/controllers/admin/cards_controller.rb` - Admin controller
- `app/services/card_version_service.rb` - YAML versioning logic
- `app/models/concerns/yaml_loadable.rb` - Loads YAML or falls back to hardcoded
- `config/cards/versions/` - All YAML versions stored here

### Card Loading Priority
1. Check for YAML in `config/cards/versions/{category}_*.yml`
2. If found, use latest YAML file
3. If not, use hardcoded data in `survey_card.rb`

## Common Tasks

### Add a new card (via Admin)
1. Go to `/admin/cards`
2. Click card to edit
3. Save changes
4. New YAML version created automatically

### Add a new card (via Code)
Edit `app/models/survey_card.rb`, add to the appropriate `*_hardcoded` method

### Change UI/styling
Edit the ERB views in `app/views/` - changes deploy instantly

### Update iOS/Android base URL
- iOS: `ManageMyLupus-iOS/.../TurboNavigator.swift` → `TurboConfig.baseURL`
- Android: `ManageMyLupus-Android/.../TurboApplication.kt` → `BASE_URL`

### Add a new route/page
1. Add route in `config/routes.rb`
2. Create controller action
3. Create view
4. Update path-configuration.json if needed for native navigation

### Test locally
```bash
# Get local IP
ipconfig getifaddr en0

# Start server (accessible from mobile devices)
OPENAI_API_KEY=xxx bin/rails server -b 0.0.0.0 -p 3000

# Test Turbo Native endpoint
curl -H "User-Agent: Turbo Native iOS" http://localhost:3000/turbo/native/configuration
```

## Deployment

| Platform | Location | Deploy Command |
|----------|----------|----------------|
| Web | Render.com | Auto-deploys on git push |
| iOS | App Store | Archive in Xcode → App Store Connect |
| Android | Play Store | Generate signed AAB → Play Console |

## What Updates Instantly vs Requires App Store

**Instant (edit Rails):**
- All content, cards, text
- UI, colors, styling
- New pages/features
- Bug fixes

**Requires App Store Update:**
- App icon, app name
- Native features (camera, push notifications)
- Navigation structure changes

## Existing Native Apps (separate from this)

The footer links to existing native apps (separate codebases):
- Android: `uab.lupasdecisionaid2` on Play Store
- iOS: `managemylupus` (ID: 1550959573) on App Store

The Turbo Native apps created here are NEW apps that wrap this Rails app.

## Questions to Ask User

When working on this project, clarify:
1. Are we editing the Rails app or native shells?
2. Does this change require app store update?
3. What's the target: web only, native only, or all platforms?
