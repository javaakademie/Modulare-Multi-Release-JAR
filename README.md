# Modulare Multi-Release-JAR-Dateien

Mit Java 9 wurde das Konzept der Multi-Release-JARs, auch bekannt als MRJARs,
eingeführt. Mit diesem Feature ist es möglich, mehrere Versionen gleicher Klassen
für unterschiedliche Java-Laufzeitumgebungen in ein einzelnes JAR zu verpacken.
Das Beispiel zeigt die Verwendung dieser Möglichkeit unter Berücksichtigung der Java-
Versionen 8, 9 und 10 und von Java-Modulen.

## Voraussetzung

Java >=10 Compiler

## Bauen der Anwendung

build-Script ausführen oder über die Kommandozeile wie folgt bauen:

```
javac --release 8 -d lib8/classes lib8/src/de/javaakademie/multirelease/*.java

javac --release 9 -d lib9/classes lib9/src/module-info.java lib9/src/de/javaakademie/multirelease/Example.java

javac --release 10 -d lib10/classes lib10/src/module-info.java lib10/src/de/javaakademie/multirelease/Example.java

jar --create --file multi-release-jar-example.jar --main-class=de.javaakademie.multirelease.Main -C lib8/classes . --release 9 -C lib9/classes .  --release 10 -C lib10/classes .
```

Zunächst wird für jede zu unterstützende Java-Version ein Release gebaut. Mittels dem seit Java 9 eingeführtem release-Tag wird der entsprechende Bytecode erzeugt.
Zuletzt werden alle Versionen in einem Multi-Release JAR verpackt.

Die sich ergebene Struktur des JARs sieht wie folgt aus:

```
multirelease.jar/
├── de/javaakademie/multirelease/
│                   ├── Main.java
|                   └── Example.java
└── META-INF/
    ├── versions
    |   ├── 9/
    |   |   ├ de/javaakademie/multirelease/
    |   |   |                 └── Example.java
    |   |   └── module-info.class
    |   └── 10/
    |   |   ├ de/javaakademie/multirelease/
    |   |   |                 └── Example.java
    |   |   └── module-info.class
    └── MANIFEST.MF
```

Ein Blick in die MANIFEST.MF zeigt:    

```
Manifest-Version: 1.0
Created-By: 10.0.1 (Oracle Corporation)
Main-Class: de.javaakademie.multirelease.Main
Multi-Release: true
```

Mittels des Eintrags ```Multi-Release: true``` weiß jede JVM ab Version 9,
dass es sich bei der JAR um eine Multi-Release-Datei handelt und sich im Ordner META-INF/versions weitere ByteCode-Versionen für verschiedene Java-Versionen befinden.  

## Ausführen der Anwendung im Klassenpfad

run-classpath-Script ausführen oder über die Kommandozeile wie folgt bauen:

```
java -jar multi-release-jar-example.jar
```

Hier wird die JAR also wie bekannt gestartet und die JVM weiß aufgrund des Eintrags ```Main-Class: de.javaakademie.multirelease.Main``` in der MANIFEST.MF, wo sich die Main-Klasse befindet. 

## Ausführen der Anwendung im Modulpfad

run-modulepath-Script ausführen oder über die Kommandozeile wie folgt bauen:

```
java -p . -m de.javaakademie.multirelease
```

Angegeben wird der Modulpfad mit ```-p .``` oder alternativ ```--module-path .``` und der Name des Root-Moduls mittels ```-m de.javaakademie.multirelease``` oder ```--module de.javaakademie.multirelease```.


