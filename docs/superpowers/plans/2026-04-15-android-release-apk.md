# Android Release APK Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Produce a signed release APK of VULGUS that Rob can sideload onto his own phone and share with friends via Drive/WhatsApp. The APK should carry a proper app name, a placeholder Bauhaus icon, the `POST_NOTIFICATIONS` permission (needed by the onboarding priming screen on Android 13+), and be signed with a reusable release keystore so future versions can update the same install.

**Architecture:** Flutter `build apk --release` output, signed via a Gradle `signingConfig` that reads an off-repo `android/key.properties` file. Icon assets generated from a single 1024×1024 `assets/icon/app_icon.png` via `flutter_launcher_icons`. Application identity migrated from `com.vulgus.vulgus` (scaffold default) to **`app.vulgus`** (reverse-DNS of the vulgus.app domain).

**Tech Stack:** Flutter 3.41.6, Android Gradle Plugin (AGP 8.x via Kotlin DSL), `flutter_launcher_icons`, Python 3 + Pillow for the placeholder icon.

**Out of scope (separate work):**
- Kat-designed final icon (swap the PNG later, re-run launcher icons)
- Android App Bundle (`.aab`) for Play Store
- Play Console setup
- CI release pipeline
- iOS release build
- Custom launch/splash screen beyond default
- ProGuard / R8 rule tuning

---

## File Changes

```
flutter_app/
├── android/
│   ├── app/
│   │   ├── build.gradle.kts                ← UPDATE: applicationId, namespace, signing config
│   │   └── src/main/
│   │       ├── AndroidManifest.xml         ← UPDATE: android:label, add POST_NOTIFICATIONS
│   │       └── kotlin/
│   │           ├── com/vulgus/vulgus/      ← DELETE (old package dir)
│   │           └── app/vulgus/
│   │               └── MainActivity.kt     ← MOVE here; update `package` stmt
│   ├── key.properties                      ← NEW (gitignored — never commit)
│   └── vulgus-release.keystore             ← NEW (gitignored — never commit, back up!)
├── assets/
│   └── icon/
│       ├── app_icon.png                    ← NEW 1024×1024 placeholder
│       └── generate_placeholder.py         ← NEW one-shot script (reproducible)
├── .gitignore                              ← UPDATE: key.properties + *.keystore
└── pubspec.yaml                            ← UPDATE: flutter_launcher_icons dep + config, assets
```

---

## Task Index

1. Migrate application ID to `app.vulgus` + app label "VULGUS"
2. Add `POST_NOTIFICATIONS` permission to manifest
3. Generate placeholder Bauhaus icon PNG (1024×1024, red bg + white V)
4. Configure `flutter_launcher_icons` and generate density variants
5. Generate release keystore + key.properties + update `.gitignore`
6. Wire Gradle signing config
7. Build + verify release APK

---

## Task 1: Application ID migration

**Why:** Default `com.vulgus.vulgus` is cosmetically bad and locks us to it forever once the app is on any store. Switch to `app.vulgus` now while no real installs exist.

**Files:**
- Modify: `android/app/build.gradle.kts`
- Modify: `android/app/src/main/AndroidManifest.xml`
- Move: `android/app/src/main/kotlin/com/vulgus/vulgus/MainActivity.kt` → `android/app/src/main/kotlin/app/vulgus/MainActivity.kt`

- [ ] **Step 1: Update `android/app/build.gradle.kts`**

Find these two lines:

```kotlin
namespace = "com.vulgus.vulgus"
```
```kotlin
applicationId = "com.vulgus.vulgus"
```

Change both to:

```kotlin
namespace = "app.vulgus"
```
```kotlin
applicationId = "app.vulgus"
```

- [ ] **Step 2: Update `android/app/src/main/AndroidManifest.xml`**

Change `android:label="vulgus"` to `android:label="VULGUS"`.

- [ ] **Step 3: Move MainActivity.kt**

```bash
cd flutter_app/android/app/src/main/kotlin
mkdir -p app/vulgus
git mv com/vulgus/vulgus/MainActivity.kt app/vulgus/MainActivity.kt
rm -r com
```

Edit `app/vulgus/MainActivity.kt` — change the `package` declaration on the first line:

```kotlin
package app.vulgus
```

(Everything else in the file is untouched.)

- [ ] **Step 4: Build gradle clean**

```bash
cd flutter_app
flutter clean
flutter pub get
```

- [ ] **Step 5: Smoke-test debug build compiles**

```bash
flutter build apk --debug
```

Expected: build succeeds. If Gradle errors about `MainActivity` not being found in the expected package, re-check the `package` line in MainActivity.kt matches the directory path.

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "feat(android): migrate applicationId to app.vulgus; label VULGUS"
```

---

## Task 2: POST_NOTIFICATIONS permission

**Why:** The onboarding `NotificationPrimingScreen` calls `Permission.notification.request()`. On Android 13+ this is a runtime permission (`POST_NOTIFICATIONS`) and requires a manifest declaration — without it, `permission_handler` silently returns denied.

**Files:**
- Modify: `android/app/src/main/AndroidManifest.xml`

- [ ] **Step 1: Add the permission**

Near the top of `AndroidManifest.xml`, inside the root `<manifest>` tag but outside `<application>`, add:

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

Typical placement is above the `<application>` tag.

- [ ] **Step 2: Verify**

```bash
flutter build apk --debug
```

Expected: success.

- [ ] **Step 3: Commit**

```bash
git add android/app/src/main/AndroidManifest.xml
git commit -m "feat(android): declare POST_NOTIFICATIONS permission"
```

---

## Task 3: Placeholder Bauhaus icon

**Why:** The scaffold ships the generic Flutter "F" icon. We need at least a brand-accurate placeholder before any friend installs it. Kat can replace the PNG later.

**Design:** 1024×1024 PNG. Red background (`#B7102A`). White bold "V" in the centre, Space-Grotesk-ish geometric style. No rounded corners (the launcher applies its own rounding/masking). This matches the Bauhaus aesthetic from `DESIGN.md`.

**Files:**
- Create: `assets/icon/generate_placeholder.py`
- Create: `assets/icon/app_icon.png` (generated output; **do commit** the PNG so the build doesn't depend on Python being present)

- [ ] **Step 1: Install Pillow globally** (per Rob's Python-env preference)

```bash
pip install --user Pillow
```

- [ ] **Step 2: Create `assets/icon/generate_placeholder.py`**

```python
"""Generate the VULGUS placeholder app icon.

Writes assets/icon/app_icon.png — 1024×1024 PNG.
Red Bauhaus background, off-white bold "V" centred, no rounding
(the Android launcher handles masking).

Re-run this script whenever you want to regenerate the placeholder.
Kat: replace app_icon.png with a proper design, then run
     `flutter pub run flutter_launcher_icons` to re-emit all densities.
"""
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

SIZE = 1024
BG = (0xB7, 0x10, 0x2A, 0xFF)   # primary red
FG = (0xF9, 0xF9, 0xF9, 0xFF)   # surface / off-white

out = Path(__file__).parent / "app_icon.png"

img = Image.new("RGBA", (SIZE, SIZE), BG)
draw = ImageDraw.Draw(img)

# Try to load a bold sans serif; fall back to PIL default if unavailable.
candidates = [
    r"C:\Windows\Fonts\arialbd.ttf",
    r"C:\Windows\Fonts\segoeuib.ttf",
    r"C:\Windows\Fonts\arial.ttf",
]
font = None
for path in candidates:
    try:
        font = ImageFont.truetype(path, size=780)
        break
    except OSError:
        continue
if font is None:
    font = ImageFont.load_default()

# Measure and centre the glyph.
text = "V"
bbox = draw.textbbox((0, 0), text, font=font)
tw = bbox[2] - bbox[0]
th = bbox[3] - bbox[1]
# textbbox returns the ink box offset; subtract offsets to get true centring.
x = (SIZE - tw) // 2 - bbox[0]
y = (SIZE - th) // 2 - bbox[1]
draw.text((x, y), text, font=font, fill=FG)

img.save(out, format="PNG", optimize=True)
print(f"Wrote {out} ({img.size[0]}x{img.size[1]})")
```

- [ ] **Step 3: Run it**

```bash
cd flutter_app
python assets/icon/generate_placeholder.py
```

Expected stdout: `Wrote .../assets/icon/app_icon.png (1024x1024)`. Open the file and eyeball it — red square, white V.

- [ ] **Step 4: Commit**

```bash
git add assets/icon/generate_placeholder.py assets/icon/app_icon.png
git commit -m "feat(android): placeholder Bauhaus app icon"
```

---

## Task 4: flutter_launcher_icons

**Why:** Android needs icons in 5 density buckets (mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi) plus an adaptive-icon foreground/background split for Android 8+. `flutter_launcher_icons` generates all of them from a single source PNG.

**Files:**
- Modify: `pubspec.yaml`
- Generated (by the tool): `android/app/src/main/res/mipmap-*/launcher_icon.png` + adaptive icon resources

- [ ] **Step 1: Add the dev dependency to `pubspec.yaml`**

Under `dev_dependencies:`, add:

```yaml
  flutter_launcher_icons: ^0.14.1
```

At the bottom of the file, add a top-level `flutter_launcher_icons:` config block:

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: false
  image_path: "assets/icon/app_icon.png"
  min_sdk_android: 21
  adaptive_icon_background: "#B7102A"
  adaptive_icon_foreground: "assets/icon/app_icon.png"
  remove_alpha_ios: false
```

Note: using the same PNG as both full icon and adaptive foreground is fine for a placeholder — the letter V stays centred in both framings.

- [ ] **Step 2: Install + run**

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

Expected: writes PNGs into `android/app/src/main/res/mipmap-*/launcher_icon.png` plus adaptive-icon XML + drawables. The scaffold's `ic_launcher.png` files still exist — that's fine, they're unused once the manifest references `@mipmap/launcher_icon` (next step).

- [ ] **Step 3: Update AndroidManifest.xml to use the new icon**

In `android/app/src/main/AndroidManifest.xml`, change:

```xml
android:icon="@mipmap/ic_launcher"
```

to:

```xml
android:icon="@mipmap/launcher_icon"
```

(Location: the `<application>` opening tag.)

- [ ] **Step 4: Verify**

```bash
flutter build apk --debug
```

Expected: success.

- [ ] **Step 5: Commit**

```bash
git add pubspec.yaml pubspec.lock android/app/src/main/AndroidManifest.xml android/app/src/main/res/
git commit -m "feat(android): generate launcher icons from Bauhaus placeholder"
```

---

## Task 5: Release keystore + key.properties + .gitignore

**Why:** A release APK must be signed. The signing key identifies future updates — **losing this keystore means you can never update this app on a user's device without forcing a reinstall.** Back it up somewhere durable (password manager, 1Password, encrypted USB).

**Files:**
- Create: `android/vulgus-release.keystore` (gitignored)
- Create: `android/key.properties` (gitignored)
- Modify: `flutter_app/.gitignore`

- [ ] **Step 1: Generate the keystore**

This step is **interactive** — `keytool` will prompt for passwords and a name/org. Run this yourself in your terminal (an agent can't answer the prompts):

```bash
cd flutter_app/android
keytool -genkey -v -keystore vulgus-release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 -alias vulgus
```

Answer the prompts:

| Prompt | Suggested answer |
|---|---|
| Keystore password | pick something strong; **save it in your password manager** |
| Re-enter password | same |
| First and last name | `Rob Chambers` (or whatever you use publicly) |
| Organizational unit | blank (press enter) |
| Organization | `VULGUS` |
| City/locality | your city |
| State/province | blank or your county |
| Two-letter country code | `GB` |
| Is all correct? | `yes` |
| Key password for `<vulgus>` | press enter to reuse the keystore password (simplest) |

Expected: creates `android/vulgus-release.keystore` (a few KB).

**IMPORTANT:** back this file up right now before you continue. Copy it to a password-manager attachment or an encrypted cloud folder. Lose it and you lose the ability to ever ship an update.

- [ ] **Step 2: Create `android/key.properties`**

Create `flutter_app/android/key.properties` with the actual passwords:

```properties
storePassword=<your keystore password>
keyPassword=<same, if you pressed enter in Step 1>
keyAlias=vulgus
storeFile=vulgus-release.keystore
```

- [ ] **Step 3: Add to `.gitignore`**

Append to `flutter_app/.gitignore` (create section at the bottom):

```
# Android signing — NEVER commit these
android/key.properties
android/*.keystore
android/*.jks
```

- [ ] **Step 4: Verify they're ignored**

```bash
cd flutter_app
git status
```

`key.properties` and `vulgus-release.keystore` must NOT appear in the status output (tracked or untracked). If they do, the `.gitignore` rule didn't match — fix before continuing.

- [ ] **Step 5: Commit the .gitignore change only**

```bash
git add .gitignore
git commit -m "chore(android): gitignore release keystore and key.properties"
```

**Do not** `git add` the keystore or key.properties — verify the commit diff is only the `.gitignore` update.

---

## Task 6: Gradle signing config

**Why:** Tell Gradle to load `key.properties` and apply it to the `release` build type.

**Files:**
- Modify: `android/app/build.gradle.kts`

- [ ] **Step 1: Read the current file**

Note the top of the existing `android { ... }` block and where `buildTypes` lives. The file uses Kotlin DSL (`.kts`).

- [ ] **Step 2: Add key.properties loading**

At the **very top** of `android/app/build.gradle.kts` (above the `plugins { ... }` block or right after it), add:

```kotlin
import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
```

- [ ] **Step 3: Add a signing config inside `android { ... }`**

Inside the `android { ... }` block (above `buildTypes { ... }`), add:

```kotlin
    signingConfigs {
        create("release") {
            val propsFile = rootProject.file("key.properties")
            if (propsFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = rootProject.file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }
```

- [ ] **Step 4: Wire the release build type to use it**

Inside `buildTypes { ... }`, find the `release { ... }` block. It currently probably looks like:

```kotlin
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
```

Change the `signingConfig` line to:

```kotlin
            signingConfig = signingConfigs.getByName("release")
```

- [ ] **Step 5: Smoke-test the Gradle config parses**

```bash
cd flutter_app
flutter build apk --debug
```

Expected: debug build still succeeds. (Release build tested in Task 7.)

- [ ] **Step 6: Commit**

```bash
git add android/app/build.gradle.kts
git commit -m "feat(android): release signing config driven by key.properties"
```

---

## Task 7: Build + verify release APK

**Files:** none modified — this is pure build + inspection.

- [ ] **Step 1: Build**

```bash
cd flutter_app
flutter build apk --release
```

Expected output includes something like:

```
✓ Built build/app/outputs/flutter-apk/app-release.apk (~25-40 MB).
```

If you see `Execution failed ... keystore was tampered with, or password was incorrect` — the `key.properties` file has the wrong password. Fix it, re-run.

If you see `SigningConfig "release" is missing required property "storeFile"` — `key.properties` wasn't loaded (path wrong, or file doesn't exist in `flutter_app/android/`). Double-check Task 5.

- [ ] **Step 2: Verify the APK is signed with your release key**

```bash
cd flutter_app
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
```

Expected: prints a certificate owned by `CN=Rob Chambers, O=VULGUS, C=GB` (or whatever you entered in Task 5). If it prints `CN=Android Debug`, the signing config didn't apply — re-check Task 6.

- [ ] **Step 3: Verify applicationId**

```bash
cd flutter_app
"%ANDROID_HOME%/build-tools/"$(ls "$ANDROID_HOME/build-tools" | tail -1)"/aapt" dump badging build/app/outputs/flutter-apk/app-release.apk | grep -E "package|application-label"
```

(If the `aapt` path resolution doesn't work in Git Bash on Windows, just open the APK with 7-zip and peek at `AndroidManifest.xml` via `manifest-tool` or skip this step — the `keytool` check in Step 2 is the critical one.)

Expected: `package: name='app.vulgus'`, `application-label:'VULGUS'`.

- [ ] **Step 4: Install on your phone**

Connect your Android device via USB (with USB debugging enabled), then:

```bash
cd flutter_app
flutter install --release
```

Or manually:

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

Expected: installs; icon on launcher shows the red Bauhaus V; opens into VULGUS onboarding.

- [ ] **Step 5: Smoke-test on device**

Walk the full onboarding flow, solve one game, share from the end modal. Verify:
- Notification priming screen actually shows the system permission dialog (Android 13+)
- Icon is the red V, not the default Flutter F
- App name in recents/multitasker reads "VULGUS"
- No "app not signed" or Play Protect warnings (other than the one-time sideload warning)

- [ ] **Step 6: Sharing**

The signed APK at `build/app/outputs/flutter-apk/app-release.apk` is what you send to friends via Drive/WhatsApp/email. They'll still see the "install unknown apps" prompt the first time but no Play Protect scary-red warning.

- [ ] **Step 7: Push the plan's commits**

```bash
git push origin main
```

(Nothing from Task 5-7 was a content commit except the `.gitignore` and gradle config; the APK itself is not committed.)

---

## Self-Review

**Spec coverage:**
- ✅ applicationId migrated from `com.vulgus.vulgus` → `app.vulgus` — Task 1
- ✅ App label `VULGUS` — Task 1
- ✅ `POST_NOTIFICATIONS` permission — Task 2
- ✅ Placeholder Bauhaus icon (red V) — Tasks 3, 4
- ✅ Reusable release keystore — Task 5
- ✅ Gradle signing config — Task 6
- ✅ Release APK builds and signs — Task 7
- ✅ Keystore + passwords never committed — Task 5 (.gitignore)

**Security checklist:**
- `key.properties` gitignored
- `*.keystore` gitignored
- Keystore backed up out of the repo before Task 7 runs

**Out of scope (follow-up plans):**
- Android App Bundle (`.aab`) — add when going to Play Console
- Play Store listing (screenshots, description, content rating, privacy policy)
- Real Kat-designed icon (just swap `assets/icon/app_icon.png` and re-run `flutter pub run flutter_launcher_icons`)
- iOS release build (needs Apple Developer account + Mac)
- CI release pipeline
- ProGuard / R8 rule tuning
- Launch screen / splash customisation
