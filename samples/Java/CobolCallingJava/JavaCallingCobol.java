/*
 * Copyright (C) 2005-2006,2008 Micro Focus. All rights reserved.
 *
 * This sample code is supplied for demonstration purposes only
 * on an "as is" basis and is for use at your own risk.
 */

import java.io.*;
import java.util.*;
import com.acucorp.acucobolgt.*;

/**
 * JavaCallingCobol sample Java program
 *
 */
public class JavaCallingCobol {
	//private static Logger _log;

/////////////////////////////////////////////////////////////////////////////
//main
/////////////////////////////////////////////////////////////////////////////
	public static void main(String[] args)  throws IOException {
	    try {
			String tmp = new String();
			//System.setProperty( "java.util.logging.config.file", "logging.properties" );
			//_log = Logger.getLogger("com.acucorp.acucobolgt.CVM");
			if( args.length == 0 ) {
			    System.err.println("no argument specified");
			    System.err.println("end");
			    return;
			}
			for( int idx = 0; idx < args.length; idx++ )	{
			    tmp += args[idx] + " ";
			}
			System.setProperty( "line.separator", "\r\n" );

/////////////////////////////////////////////////////////////////////////////
// cvm
/////////////////////////////////////////////////////////////////////////////
			if( args[0].equals("cvm") ) {
			    CVM cvm;
			    cvm = CVM.GET_INSTANCE();
			    String prop;
			    Properties props = System.getProperties();
	
			    String stringInOut = new String("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			    String stringTwo = new String("//////////////////////////////////");
			    int intInOut = 10;
			    double doubleInOut = 9.87654;
			    long longType2 = 999999999;
			    long longType3 = 888888888;
	
			    int intArr[] = new int[3];
			    intArr[0] = 10;
			    intArr[1] = 9;
			    intArr[2] = 8;
	
			    double doubleArr[] = new double[3];
			    doubleArr[0] = 111.111;
			    doubleArr[1] = 99.99;
			    doubleArr[2] = 88.88;
	
			    Integer intObj = new Integer(intInOut);
			    Double doubleObj = new Double(doubleInOut);
			    Long longT2Obj = new Long(longType2);
			    Long longT3Obj = new Long(longType3);
	
			    Object params[] = { stringInOut, intObj,
						doubleObj, longT2Obj, longT3Obj,
						intArr, doubleArr, stringTwo };
	
			    Object emptyParams[] = {};
	
			    System.err.println("******************************************");
			    System.err.println("**Calling JavaCallingCobol **************");
			    System.err.println("******************************************");
	
			    System.err.println("String: " + stringInOut);
			    System.err.println("Int: " + intInOut);
			    System.err.println("Double: " + doubleInOut);
			    System.err.println("LongT2: " + longType2);
			    System.err.println("LongT3: " + longType3);
			    System.err.println("String: " + stringTwo);
			    System.err.println("IntArray: " + intArr[0]);
			    System.err.println("IntArray: " + intArr[1]);
			    System.err.println("IntArray: " + intArr[2]);
			    System.err.println("Double Array: " + doubleArr[0]);
			    System.err.println("Double Array: " + doubleArr[1]);
			    System.err.println("Double Array: " + doubleArr[2]);
	
			    cvm.setErrorsOut( "localErrFile" );
	     	    cvm.setListConfig(true);
	            cvm.setConfigFile("config");
			    CALL_OPTIONS callOpts = new CALL_OPTIONS();
			    cvm.initialize();
			    cvm.callProgram( "JavaCallingCobol", params, callOpts );
			    Class cls, cls1;
			    String name;
			    Object obj;
	
			    System.err.println("******************************************");
			    System.err.println("** Java to Cobol Output ******************");
			    System.err.println("******************************************");
	
			    for( int idx = 0; idx < params.length; idx++  ) {
			        cls = params[idx].getClass();
			        name = cls.getName();
	
					if( name.charAt(0) != '[' ) {
					    System.err.println("param class name: " + name);
					    System.err.println("param value: " + params[idx].toString());
					    continue;
					} else {
					    for( int idx1 = 0; idx1 < java.lang.reflect.Array.getLength( params[idx] ); idx1++ ) {
							obj = java.lang.reflect.Array.get( params[idx], idx1 );
							cls1 = obj.getClass();
							name = cls1.getName();
							System.err.println("param class name: " + name);
							System.err.println("param value: " + obj.toString());
					    }
					}
		
			    }
			    cvm.shutdown();
			    System.err.println("shutdown complete");
			}
/////////////////////////////////////////////////////////////////////////////
// properties
/////////////////////////////////////////////////////////////////////////////
			else if( args[0].equals("props") ) {
			    System.err.println("properties start");
	
			    String prop;
			    Properties props = System.getProperties();
	
			    System.err.println("******************** System Properties ********************");
			    for (Enumeration e = props.propertyNames() ; e.hasMoreElements() ;) {
					prop = e.nextElement().toString();
					System.err.println("PROPERTY: [" + prop + "] VALUE: [" + props.getProperty(prop) + "]");
			    }
			    System.err.println("properties end");
			}
/////////////////////////////////////////////////////////////////////////////
//directions
/////////////////////////////////////////////////////////////////////////////
			else {
			    System.err.println("******************************************");
			    System.err.println("** Sample Options ************************");
			    System.err.println("******************************************");
			    System.err.println("props, cvm");
			}
	    } catch ( Exception e ) {
			System.err.println("exception caught");
			System.err.println( e.getMessage() );
			System.err.println("end");
	    }
	}

}
