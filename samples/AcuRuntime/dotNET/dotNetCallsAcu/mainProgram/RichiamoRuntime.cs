using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace RichiamoRuntime
{
    public partial class RichiamoRuntime : Form
    {
        public RichiamoRuntime()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            // name of the acu program to call
            object ProgramName = "CalledByRuntime";

		    //linkage elements, max 14
            object arg1 = "From .Net to COBOL";
		    object arg2 = 1;
            object arg3 = "my structure";
            //runtime command-line parameters
            object acuparameters = "-d -c C:\\AcuSamples\\dotNetCallsAcu\\acu-section\\cblconfi -le c:\\tmp\\runtimeerrors.log";
	   
            //creating the instance of runtime
            AcuGTObjects.AcuGTClass AcugtInterface = new AcuGTObjects.AcuGTClass();

            //setting execution parameters

            AcugtInterface.Initialize(ref acuparameters);
        
            
            //calling acu runtime
		    AcugtInterface.Call(ref ProgramName,  ref arg1,	 ref arg2, ref arg3);//,	 ref arg3,  ref arg4,
		                   	 //ref arg5,  ref arg6,  ref arg7,	 ref arg8,	 ref arg9,
		                   		//ref arg10,	ref arg11,	ref arg12,	ref arg13,	ref arg14);

            //closing acu runtime
    	    AcugtInterface.Shutdown();





        }
    }
}
