# 🛠️ GOOGLE_AUTH_FIX.md

## Fix: Google Sign-In Not Working (Flutter + Supabase)

---

## 🚨 Problem

* Google Sign-In does NOT work on Login/Register pages ❌
* You may see this error:

```
Google Sign-In failed: Bad state: init() has already been called
```

---

## 🎯 Root Cause

👉 `Supabase.initialize()` is being called **more than once** in your project.

❗ Supabase must be initialized **ONLY ONCE**.

---

## 🔍 Why Google Login Fails

* Email login → simple API call (may still work)
* Google login → OAuth flow + redirect
* Multiple initialization → breaks OAuth → Google login fails ❌

---

## ✅ COMPLETE FIX (Step-by-Step)

---

### 🔹 STEP 1: Search for duplicate initialization

Search your entire project:

```bash
Supabase.initialize
```

---

### 🔹 STEP 2: Keep ONLY in `main.dart`

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

### 🔹 STEP 3: REMOVE from everywhere else ❌

Delete any `Supabase.initialize()` from:

* auth_service.dart
* login_page.dart
* register_page.dart
* initState()
* FutureBuilder

---

### 🔹 STEP 4: Use Supabase client correctly

```dart
final supabase = Supabase.instance.client;
```

👉 Do NOT initialize again.

---

### 🔹 STEP 5: Google Sign-In button code

```dart
await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
);
```

---

### 🔹 STEP 6: Clean restart (IMPORTANT)

```bash
flutter clean
flutter pub get
flutter run
```

❗ Do NOT use hot reload

---

## ⚙️ Required Configuration Checklist

---

### ✅ Supabase

* [ ] Google Provider Enabled
* [ ] Client ID added
* [ ] Client Secret added

---

### ✅ Google Cloud Console

* [ ] Application Type → Web
* [ ] Authorized Redirect URI:

```
https://dvlajexfsrinntourlvc.supabase.co/auth/v1/callback
```

---

### ✅ Supabase Auth Settings

* [ ] Email Provider Enabled
* [ ] Confirm Email → OFF

---

## 🧪 Expected Behavior

1. Click "Sign in with Google"
2. Browser opens
3. Select Google account
4. Login successful
5. Redirect back to app

---

## ❗ Common Mistakes

* Initializing Supabase multiple times ❌
* Using init inside widgets ❌
* Missing redirect URI ❌
* Not doing clean restart ❌

---

## 🎯 Final Conclusion

👉 The issue is NOT:

* API key ❌
* Supabase config ❌

👉 The issue IS:

* Multiple initialization ❌

---

## 👨💻 Credits

Designed by Apurba Ovi (Ultimate Coder)
