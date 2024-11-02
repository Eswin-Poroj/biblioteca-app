# Mantener las anotaciones de Google y javax
-keep class com.google.errorprone.annotations.* { *; }
-keep class javax.annotation.* { *; }
-keep class com.google.crypto.tink.* { *; }

# Mantener clases necesarias de Tink (si es necesario, depende del uso)
-keepattributes *Annotation*

# Asegúrate de que R8 mantenga todo en com.google.crypto.tink y javax.annotation
-dontwarn javax.annotation.**
-dontwarn com.google.errorprone.annotations.**
-dontwarn com.google.crypto.tink.**