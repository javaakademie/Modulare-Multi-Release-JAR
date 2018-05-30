javac --release 8 -d lib8/classes lib8/src/de/javaakademie/multirelease/*.java

javac --release 9 -d lib9/classes lib9/src/module-info.java lib9/src/de/javaakademie/multirelease/Example.java

javac --release 10 -d lib10/classes lib10/src/module-info.java lib10/src/de/javaakademie/multirelease/Example.java

jar --create --file multi-release-jar-example.jar --main-class=de.javaakademie.multirelease.Main -C lib8/classes . --release 9 -C lib9/classes .  --release 10 -C lib10/classes .