# 🛠️ INSTRUCTION.md

## Fix: Google Sign-In Not Working (Supabase + Flutter)

---

## 🚨 Problem

```
Google Sign-In failed: Bad state: init() has already been called
```

---

## 🎯 Root Cause

This error occurs when:

👉 `Supabase.initialize()` is called more than once in the project.

❗ Supabase MUST be initialized only once.

---

## ✅ STEP-BY-STEP FIX

---

### 🔹 STEP 1: Search for duplicate initialization

Search your project:

```bash
Supabase.initialize
```

---

### 🔹 STEP 2: Keep ONLY one initialization

✔️ Only in `main.dart`:

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

Delete `Supabase.initialize()` from:

* auth_service.dart
* login_page.dart
* register_page.dart
* initState()
* FutureBuilder

---

### 🔹 STEP 4: Use Supabase client correctly

Instead of initializing again, use:

```dart
final supabase = Supabase.instance.client;
```

---

### 🔹 STEP 5: Clean Restart (IMPORTANT)

Do NOT use hot reload.

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🔐 Google Login Code

Use this in your button:

```dart
await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
);
```

---

## ⚙️ Required Config Checklist

Make sure all are correct:

### Supabase:

* [ ] Google Provider Enabled
* [ ] Client ID added
* [ ] Client Secret added

---

### Google Console:

* [ ] Application Type → Web
* [ ] Redirect URI added:

```
https://dvlajexfsrinntourlvc.supabase.co/auth/v1/callback
```

---

### Supabase Auth:

* [ ] Email Provider Enabled
* [ ] Confirm Email OFF

---

## 🧪 Expected Result

After fix:

1. Click Google Sign-In
2. Browser opens
3. Select Google account
4. Login successful
5. Redirect back to app

---

## ❗ Common Mistakes

* Initializing Supabase multiple times ❌
* Using init inside widgets ❌
* Forgetting clean restart ❌
* Missing redirect URI ❌

---

## 🎯 Conclusion

👉 Your issue is NOT:

* API key ❌
* Supabase config ❌

👉 Your issue IS:

* Multiple initialization ❌

Fixing that will solve Google login completely.

---

## 👨💻 Credits

Designed by Apurba Ovi (Ultimate Coder)
