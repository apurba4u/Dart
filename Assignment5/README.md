# 🚀 Flutter Authentication App (Supabase + Google OAuth)

A complete Flutter authentication system using Supabase with Email/Password and Google Sign-In.

---

## 🔐 Features

* ✅ User Registration (Name, Email, Photo, Password)
* ✅ Email & Password Login
* ✅ Google Sign-In (OAuth)
* ✅ Logout
* ✅ Error Handling
* ✅ Modern UI (Dark + Glass effect)

---

## 🔑 Supabase Config

* **Project URL:**
  https://dvlajexfsrinntourlvc.supabase.co

* **Anon API Key:**
  sb_publishable_3BBMssm3LbFi_XG1UzOfqg_2JwzDwHs

---

## ⚙️ Initialization (IMPORTANT)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dvlajexfsrinntourlvc.supabase.co',
    anonKey: 'sb_publishable_3BBMssm3LbFi_XG1UzOfqg_2JwzDwHs',
  );

  runApp(MyApp());
}
```

---

## 🔐 Authentication Code

### ✅ Register

```dart
await supabase.auth.signUp(
  email: email,
  password: password,
  data: {
    'name': name,
    'photo': photoUrl,
  },
);
```

---

### ✅ Login

```dart
await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);
```

---

### ✅ Google Login

```dart
await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
);
```

---

## 🌐 Google OAuth Setup

### 1. Google Cloud Console

* Create OAuth Client → **Web Application**

### 2. Redirect URI (MUST)

```text
https://dvlajexfsrinntourlvc.supabase.co/auth/v1/callback
```

### 3. Copy Credentials

* Client ID
* Client Secret

### 4. Supabase Setup

Authentication → Sign In / Providers → Google

* Enable Google
* Paste Client ID
* Paste Client Secret
* Save

---

## ⚠️ CRITICAL FIXES

### ❗ Login not working after register

👉 Fix:

* Confirm email → OFF
  (Authentication → User Signups)

---

### ❗ Google login না কাজ করলে

👉 Fix:

* Redirect URI must match EXACTLY

---

### ❗ Google button press করলে কিছু না হয়

👉 Fix:

* Google enabled?
* Client ID added?

---

### ❗ init() already called error

```text
Bad state: init() has already been called
```

👉 Cause:
Supabase initialized multiple times

👉 Fix:

✔️ Only in main.dart:

```dart
await Supabase.initialize(...);
```

❌ Do NOT use in:

* initState()
* other files
* FutureBuilder

✔️ Use everywhere:

```dart
final supabase = Supabase.instance.client;
```

---

### 🔄 Restart App

```bash
flutter clean
flutter pub get
flutter run
```

---

### ❗ Emulator issue

👉 Use real device

---

## 📱 App Flow

1. Login / Register
2. Email বা Google login
3. Home Page
4. Logout

---

## ✅ Final Checklist

* [ ] Supabase init only once
* [ ] Email enabled
* [ ] Confirm email OFF
* [ ] Google enabled
* [ ] Client ID সেট
* [ ] Client Secret সেট
* [ ] Redirect URI added
* [ ] Auth code correct

---

## 🚀 Run

```bash
flutter run
```

---

## 👨💻 Credits

Designed by Apurba Ovi (with the help of AI)
