using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using TestNetToCobol;
//using testnettocobol_CVM; 

namespace TestDll
{
    /// <summary> 
    /// Summary description for Form1. 
    /// </summary> 
    public class Form1 : System.Windows.Forms.Form
    {
        TestNetToCobol.TestNetToCobol cblObj;
        private System.Windows.Forms.Button button1;
        /// <summary> 
        /// Required designer variable. 
        /// </summary> 
        private System.ComponentModel.Container components = null;

        public Form1()
        {
            // 
            // Required for Windows Form Designer support 
            // 
            InitializeComponent();

            // 
            // TODO: Add any constructor code after InitializeComponent call 
            // 
        }

        /// <summary> 
        /// Clean up any resources being used. 
        /// </summary> 
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (components != null)
                {
                    components.Dispose();
                }
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code 
        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor. 
        /// </summary> 
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            //  
            // button1 
            //  
            this.button1.Location = new System.Drawing.Point(104, 24);
            this.button1.Name = "button1";
            this.button1.TabIndex = 0;
            this.button1.Text = "Test";
            this.button1.Click += new System.EventHandler(this.button1_Click);
            //  
            // Form1 
            //  
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.ClientSize = new System.Drawing.Size(292, 101);
            this.Controls.Add(this.button1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }
        #endregion

        /// <summary> 
        /// The main entry point for the application. 
        /// </summary> 
        [STAThread]
        static void Main()
        {
            Application.Run(new Form1());
        }

        private void button1_Click(object sender, System.EventArgs e)
        {
            TestNetToCobol_CVM.errorTypes err = TestNetToCobol_CVM.errorTypes.CS_OK;
            IntPtr pInfo = IntPtr.Zero;
            int cblReturn = 0;
            string err_msg;
            int some_int = 777;
            string some_string;

            // Instantiate COBOL object and CVM, COBOL VIRTUAL MACHINE 
            cblObj = new TestNetToCobol.TestNetToCobol();
            // Set ACUCOBOL-GT runtime options (properties) 
            cblObj.RunPath = "C:\\Program Files (x86)\\Micro Focus\\extend 10.4.0\\AcuGT\\bin";
            cblObj.Debug = true;
            cblObj.LinkageLength = true;
            //cblObj.Cache = true; 
            // Initialize the ACUCOBOL-GT runtime 
            cblObj.Initialize();

            try
            {

                //  The second to last parameter is for options specific 
                //  to a method call.  They may also be set via properties 
                //  before the method call is executed. 
                //  The last parameter is the return code from the COBOL program. 

                // call an ENTRY in the ACUCOBOL-GT program 
                some_int = 1111;
                cblReturn = 0;

                err = cblObj.int_only(ref some_int, null, ref cblReturn);

                // call the main ENTRY, 1st COBOL line in PROCEDURE DIVISION 
                some_int = 1422;
                some_string = "The hills are Alive             ";

                err = cblObj.TestNetToCobol_CVM_main(ref some_string,
                                         ref some_int,
                                         null,
                                         ref cblReturn);
            }
            catch (System.Exception e2)
            {
                Exception innerE = e2.InnerException;
                if ((innerE != null) && (innerE.Message.Length > 0))
                    err_msg = innerE.Message;
                else
                {
                    if (e2.Message.Length > 0)
                        err_msg = e2.Message;
                    else
                        err_msg = "AcuNet Temp Object Create Error";
                }
                MessageBox.Show(err_msg);
                return;
            }
            // test runtime return code 
            if (err != TestNetToCobol_CVM.errorTypes.CS_OK)
            {
                // get error text property  
                MessageBox.Show(cblObj.LastErrorMsg);
            }
            cblObj.ShutDown(0);
        }
    }
}