using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace wrunnetutil
{/// <summary>
 /// Summary description for AddParams.
 /// </summary>
	public class AddParams : Form
	{private int ParmNo;

	 public int Parameter
  {get {return (int)ParmNo;}
		 set {ParmNo = (int)value;
		      ParamNumber.Text = ParmNo.ToString();}}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private Button AddParam;
  private Button OK;
  private Label  label1;
  private Label  label2;
  private Label  label3;
  
  public ComboBox ParamType;
  public TextBox  ParamNumber;
  public TextBox  paramVal;

		/// <summary>
		/// Required designer variable.
		/// </summary>
  private System.ComponentModel.Container components = null;

  //*****************************************************************************
  // 
  //*****************************************************************************
  public delegate void ParamAdded(AddParams Param);
  public event ParamAdded addedParam;

  public AddParams()
  {InitializeComponent();
		 ParmNo = 1;}

  //*****************************************************************************
  // 
  //*****************************************************************************
  protected override void Dispose( bool disposing )
  {if (disposing)
		    {if (components != null)
		        {components.Dispose();}}
		
		 base.Dispose(disposing);}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		    this.label1 = new Label();
		    this.ParamNumber = new TextBox();
		    this.ParamType = new ComboBox();
		    this.label2 = new Label();
		    this.label3 = new Label();
		    this.paramVal = new TextBox();
		    this.OK = new Button();
		    this.AddParam = new Button();
		    this.SuspendLayout();
		    // 
		    // label1
		    // 
		    this.label1.Location = new System.Drawing.Point(8, 16);
		    this.label1.Name = "label1";
		    this.label1.Size = new System.Drawing.Size(104, 16);
		    this.label1.TabIndex = 0;
		    this.label1.Text = "Number";
		    // 
		    // ParamNumber
		    // 
		    this.ParamNumber.Location = new System.Drawing.Point(64, 8);
		    this.ParamNumber.Name = "ParamNumber";
		    this.ParamNumber.Size = new System.Drawing.Size(32, 20);
		    this.ParamNumber.TabIndex = 1;
		    this.ParamNumber.Text = "";
		    // 
		    // ParamType
		    // 
		    this.ParamType.Items.AddRange(new object[] {
								   "short int",
								   "int",
								   "long",
								   "unsigned short",
								   "unsigned int",
								   "unsigned long",
								   "Byte",
								   "String",
								   "float",
								   "double"});
		    this.ParamType.Location = new System.Drawing.Point(64, 40);
		    this.ParamType.MaxDropDownItems = 10;
		    this.ParamType.MaxLength = 150;
		    this.ParamType.Name = "ParamType";
		    this.ParamType.Size = new System.Drawing.Size(168, 21);
		    this.ParamType.TabIndex = 2;
		    // 
		    // label2
		    // 
		    this.label2.Location = new System.Drawing.Point(8, 40);
		    this.label2.Name = "label2";
		    this.label2.Size = new System.Drawing.Size(56, 23);
		    this.label2.TabIndex = 3;
		    this.label2.Text = "Type";
		    // 
		    // label3
		    // 
		    this.label3.Location = new System.Drawing.Point(8, 72);
		    this.label3.Name = "label3";
		    this.label3.Size = new System.Drawing.Size(48, 16);
		    this.label3.TabIndex = 4;
		    this.label3.Text = "Value";
		    // 
		    // paramVal
		    // 
		    this.paramVal.Location = new System.Drawing.Point(64, 72);
		    this.paramVal.Name = "paramVal";
		    this.paramVal.Size = new System.Drawing.Size(168, 20);
		    this.paramVal.TabIndex = 5;
		    this.paramVal.Text = "";
		    // 
		    // OK
		    // 
		    this.OK.Location = new System.Drawing.Point(24, 112);
		    this.OK.Name = "OK";
		    this.OK.TabIndex = 6;
		    this.OK.Text = "DONE";
		    this.OK.Click += new System.EventHandler(this.OK_Click);
		    // 
		    // AddParam
		    // 
		    this.AddParam.Location = new System.Drawing.Point(152, 112);
		    this.AddParam.Name = "AddParam";
		    this.AddParam.TabIndex = 7;
		    this.AddParam.Text = "Add";
		    this.AddParam.Click += new System.EventHandler(this.AddParam_Click);
		    // 
		    // AddParams
		    // 
		    this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
		    this.ClientSize = new System.Drawing.Size(250, 142);
		    this.Controls.Add(this.AddParam);
		    this.Controls.Add(this.OK);
		    this.Controls.Add(this.paramVal);
		    this.Controls.Add(this.ParamNumber);
		    this.Controls.Add(this.label3);
		    this.Controls.Add(this.label2);
		    this.Controls.Add(this.ParamType);
		    this.Controls.Add(this.label1);
		    this.FormBorderStyle = FormBorderStyle.FixedDialog;
		    this.Name = "AddParams";
		    this.Text = "Add Parameter Data";
		    this.ResumeLayout(false);

		}
		#endregion

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void OK_Click(object sender, System.EventArgs e)
  {DialogResult = DialogResult.OK;}
	    
  //*****************************************************************************
  // 
  //*****************************************************************************
  private void AddParam_Click(object sender, System.EventArgs e)
  {ParmNo++;
		 addedParam(this);
		 ParamNumber.Text = ParmNo.ToString();}  
		 
		 
	}
}
