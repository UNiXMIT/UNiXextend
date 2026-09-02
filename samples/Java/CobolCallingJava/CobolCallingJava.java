/*
 * Copyright (C) 2005-2006,2008 Micro Focus. All rights reserved.
 *
 * This sample code is supplied for demonstration purposes only
 * on an "as is" basis and is for use at your own risk.
 */

import java.util.*;
import java.io.*;
import com.acucorp.acucobolgt.*;

/**
 * CobolCallingJava example Java program
 *
 */
public class CobolCallingJava {

	private Properties _runtimeProperties;
	//static private Logger 	   _log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
	//System.setProperty( "java.util.logging.config.file", "logging.properties" );
	
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Main
	public static void main( String[] args ) {
		System.err.println( "CobolCallingJava: main reached" );
		if( args.length == 0 )
			System.err.println( "CobolCallingJava: no parameters were passed into main" );
		for( int cnt = 0; cnt < args.length; ++cnt ) {
			System.err.println( "CobolCallingJava: main command line argument[" + (cnt) + "]: " + args[cnt] );
		}
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Constuctor
	public CobolCallingJava( boolean val ) {
		super();
		System.err.println( "CobolCallingJava: boolean CTOR reached: " + val );
	}

	public CobolCallingJava( char val ) {
		super();
		System.err.println( "CobolCallingJava: char CTOR reached: " + val );
	}

	public CobolCallingJava( byte val ) {
		super();
		System.err.println( "CobolCallingJava: byte CTOR reached: " + val );
	}

	public CobolCallingJava( short val ) {
		super();
		System.err.println( "CobolCallingJava: short CTOR reached: " + val );
	}

	public CobolCallingJava( long val ) {
		super();
		System.err.println( "CobolCallingJava: long CTOR reached: " + val );
	}

	public CobolCallingJava( float val ) {
		super();
		System.err.println( "CobolCallingJava: float CTOR reached: " + val );
	}

	public CobolCallingJava( double val ) {
		super();
		System.err.println( "CobolCallingJava: double CTOR reached: " + val );
	}

	public CobolCallingJava( int val ) {
		super();
		System.err.println( "CobolCallingJava: int CTOR reached: " + val );
	}

	public CobolCallingJava() {
		super();
		System.err.println("CobolCallingJava: void CTOR reached");
	}

	public CobolCallingJava( String programName ) {
		super();
		System.err.println("CobolCallingJava: string CTOR reached");
		System.err.println("CobolCallingJava:  begin load");

		_runtimeProperties = new Properties();
		System.loadLibrary("wrun32");

		String prop;
		Properties sysProps = System.getProperties();
		prop = sysProps.getProperty( "os.name" );

		setRuntimeProperty( "program.name", programName );
		setRuntimeProperty( "os.name", prop );

		setRuntimeProperty( "display", "-d" );
		setRuntimeProperty( "tty", "" );
		setRuntimeProperty( "debug", "0" );
		setRuntimeProperty( "cache", "0" );
		setRuntimeProperty( "num.params", "0" );
		setRuntimeProperty( "signal.number", "0" );
		setRuntimeProperty( "no.stop", "1" );

		System.err.println( "CobolCallingJava:  end load " );
	}

	public void setRuntimeProperty( String key, String value ) {
		this.getDefaultProperties().setProperty( key, value );
	}

	public Properties getDefaultProperties() {
		return _runtimeProperties;
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaNV

	public int CobolCallingJavaIntNV( int cmdCode ) {
	    System.err.println( "CobolCallingJavaIntNV input: " + cmdCode );
	    System.err.println( "return value: " + ( cmdCode+27 ) );
	    return cmdCode+27;
	}

	public double CobolCallingJavaDoubleNV( double cmdCode ) {
	    System.err.println( "CobolCallingJavaDoubleNV input: " + cmdCode );
	    System.err.println( "return value: " + 88.55 );
	    return (double)88.55;
	}

	public String CobolCallingJavaStringNV( String cmdCode ) {
	    System.err.println( "CobolCallingJavaStringNV input: " + cmdCode );
	    System.err.println( "return value: stringNV done" );
	    return (String)"stringNV done";
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaV

	public int CobolCallingJavaIntV( int cmdCode ) {
	    System.err.println( "CobolCallingJavaIntV input: " + cmdCode );
	    System.err.println( "return value: " + ( cmdCode+27 ) );
	    return cmdCode+27;
	}

	public double CobolCallingJavaDoubleV( double cmdCode ) {
	    System.err.println( "CobolCallingJavaDoubleV input: " + cmdCode );
	    System.err.println( "return value: " + 88.55 );
	    return (double)88.55;
	}

	public String CobolCallingJavaStringV( String cmdCode ) {
	    System.err.println( "CobolCallingJavaStringV input: " + cmdCode );
	    System.err.println( "return value: stringV done" );
	    return (String)"stringV done";
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// Static CobolCallingJava

	public static int CobolCallingJavaInt( int cmdCode ) {
	    System.err.println( "CobolCallingJavaInt input: " + cmdCode );
	    System.err.println( "return value: " + ( cmdCode+27 ) );
	    return cmdCode+27;
	}

	public static double CobolCallingJavaDouble( double cmdCode ) {
	    System.err.println( "CobolCallingJavaDouble input: " + cmdCode );
	    System.err.println( "return value: " + 88.55 );
	    return (double)88.55;
	}

	public static String CobolCallingJavaString( String cmdCode ) {
	    System.err.println( "CobolCallingJavaString input: " + cmdCode );
	    System.err.println( "return value: CobolCallingJavaString done" );
	    return (String)"CobolCallingJavaString done";
	}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
// CobolCallingJavaArray

	public int CobolCallingJavaIntArray( int cmdCode[] ) {
	    System.err.println( "Int Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
	    	System.err.println( "int value: " + cmdCode[idx] );
	    	cmdCode[idx]++;
	    }
	    return 1;
	}

	public double CobolCallingJavaDoubleArray( double cmdCode[] ) {
	    System.err.println( "Double Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
			System.err.println( "double value: " + cmdCode[idx] );
			cmdCode[idx] += 200.0;
	    }
	    return (double)88.55;
	}

	public String CobolCallingJavaStringArray( String cmdCode[] ) {
	    System.err.println( "String Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ )
	    	System.err.println( "String value: " + cmdCode[idx] );
	    return (String)"CobolCallingJavaStringArray done";
	}

	public String CobolCallingJavaStringArrayModify( String cmdCode[] ) {
	    System.err.println( "String Array size: " + cmdCode.length );
	    for( int idx = 0; idx < cmdCode.length; idx++ ) {
	    	System.err.println( "String value: " + cmdCode[idx] );
	    	cmdCode[idx] = "BBBBBBBBBBBBBBBBBBBB";
	    }
	    for( int idx = 0; idx < cmdCode.length; idx++ )
	    	System.err.println( "String value: " + cmdCode[idx] );
	    return (String)"CobolCallingJavaStringArray done";
	}
}



