# ─── Flutter ─────────────────────────────────────────────────
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }

# ─── Supabase / GoTrue / PostgREST ──────────────────────────
-keep class io.supabase.** { *; }
-dontwarn io.supabase.**

# ─── Keep model classes for JSON serialization ──────────────
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# ─── SQLite / Drift ─────────────────────────────────────────
-keep class org.sqlite.** { *; }
-dontwarn org.sqlite.**

# ─── General ────────────────────────────────────────────────
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-dontwarn javax.annotation.**

# ─── Google Play Core / Deferred Components ─────────────────
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
