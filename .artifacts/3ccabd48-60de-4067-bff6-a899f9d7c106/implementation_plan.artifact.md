# Implementation Plan - Fix Missing System Notifications

The system notification is not appearing because the app lacks the necessary Android 13+ permissions and manifest declarations.

## Proposed Changes

### [Component] Android Manifest

#### [MODIFY] [AndroidManifest.xml](file:///C:/Users/ghosh/Documents/club_project/android/app/src/main/AndroidManifest.xml)
- Add `<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>` to allow the app to show notifications on Android 13 (API 33) and above.

### [Component] Notification Service

#### [MODIFY] [notification_service.dart](file:///C:/Users/ghosh/Documents/club_project/lib/widgets/notification_service.dart)
- Update `init()` to request notification permissions at runtime. This will trigger the system dialog asking the user to "Allow" notifications when the app first starts.

## Verification Plan

### Manual Verification
- Rebuild the APK and install it.
- Open the app. A system dialog should appear asking for notification permissions. Tap **Allow**.
- Go to the Signup screen and create a new account.
- After the "Account Created" dialog appears, check the system notification tray.
- Verify the "Welcome to Statixa!" notification is present.
