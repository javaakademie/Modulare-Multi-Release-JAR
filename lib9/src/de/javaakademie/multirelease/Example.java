package de.javaakademie.multirelease;

import java.lang.ModuleLayer;

public class Example {
    public void showVersion() {

        System.out.println("Version: Java 9");

        ModuleLayer ml = Example.class.getModule().getLayer();
        if( ml != null ) {
            System.out.println( "Layer.Modules:       " + ml.modules() );
        } else {
            System.out.println( "ModuleLayer ist null" );
        }
    }
}