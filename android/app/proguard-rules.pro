# --------------------------------------------------
# Razorpay SDK ke liye keep rules
# --------------------------------------------------

# Razorpay ke classes ko minify ya remove mat karo
-keep class com.razorpay.** { *; }

# Missing annotation classes fix ke liye
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# AnalyticsEvent aur dusre internal classes
-keep class com.razorpay.AnalyticsEvent { *; }

# Optional: agar future me R8 crash ho
-dontwarn com.razorpay.**
-dontwarn proguard.annotation.**
