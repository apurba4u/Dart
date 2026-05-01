# 🔧 UPDATE.md

## Remove Google Sign-In & Update Footer

---

## 🎯 Objective

* ❌ Remove Google Sign-In from Login & Registration pages
* ✅ Keep only Email/Password authentication
* 🏷️ Add footer text:
  **"Designed by Apurba Ovi (Ultimate Coder)"**

---

## ❌ Step 1: Remove Google Sign-In (UI + Logic)

### 🔹 Delete Google Button (from Login & Register pages)

Remove any button like:

```dart
ElevatedButton(
  onPressed: () async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
    );
  },
  child: Text("Sign in with Google"),
);
```

---

### 🔹 Remove Google Auth Function

Delete this code from your project:

```dart
await supabase.auth.signInWithOAuth(
  OAuthProvider.google,
);
```

---

### 🔹 Remove Google Imports (if any)

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
```

👉 Keep this import only if you are still using Supabase for email auth.

---

## ✅ Step 2: Keep Email/Password Authentication

### 🔐 Login

```dart
await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);
```

---

### 📝 Registration

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

## 🎨 Step 3: Update UI Text

### Login Page

* Title: Login
* Fields: Email, Password
* Button: Login
* Link: Don't have an account? Register

---

### Register Page

* Title: Register
* Fields: Name, Email, Photo URL, Password
* Button: Register
* Link: Already have an account? Login

---

## 🏷️ Step 4: Add Footer Text

Add this text at the bottom of every screen:

```text
Designed by Apurba Ovi (Ultimate Coder)
```

---

### 💡 Example Flutter Widget

```dart
Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      "Designed by Apurba Ovi (Ultimate Coder)",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    ),
  ),
);
```

---

## ⚠️ Notes

* Removing Google Sign-In simplifies your app
* Reduces configuration errors
* Makes assignment more stable

---

## 🎯 Final Result

* ✅ Login works (Email/Password)
* ✅ Register works
* ❌ No Google Sign-In
* 🏷️ Footer added

---

## 👨💻 Credits

Designed by Apurba Ovi (Ultimate Coder)
