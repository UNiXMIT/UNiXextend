using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using acucobol;

namespace wrunnetutil
{public enum defines : int
 {// the max number of COBOL pgms that can be executed
  // in one instantiation of this class
  MAX_STRING_LENGTH = 512}

 /// <summary>
 /// Summary description for childTemplate.
 /// </summary>
 public class childTemplate : Form
 {private Button       AcuInit;
  private Button       AddParam;
  private Button       button1;
  private Button       DeleteParam;
  private Button       Execute;
  private Button       ProgramSearch;
  private Button       RuntimeSearch;
  private CheckBox     Cache;
  private CheckBox     Debug;
  private CheckBox     NoStop;
  private ColumnHeader columnHeader1;
  private ColumnHeader columnHeader2;
  private ColumnHeader columnHeader3;
  private ColumnHeader columnHeader4;
  private Label        label1;
  private Label        label2;
  private Label        label3;
  private Label        label4;
  private Label        label5;
  private ListView     ParamsView;
  private TextBox      EntryName;
  private TextBox      ProgramPath;
  private TextBox      ReturnCode;
  private TextBox      RuntimeOptions;
  private TextBox      RuntimePath;

  /// <summary>
  /// Required designer variable.
  /// </summary>
  private System.ComponentModel.Container components = null;

  private int NextParamNo;

  public bool Initialized;


  public childTemplate()
  {InitializeComponent();
  
   NextParamNo     = 1;
   Initialized     = false;
   NoStop.Enabled  = true;}

  /// <summary>
  /// Clean up any resources being used.
  /// </summary>
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
      this.ProgramPath = new TextBox();
      this.label1 = new Label();
      this.ProgramSearch = new Button();
      this.RuntimeSearch = new Button();
      this.label2 = new Label();
      this.RuntimePath = new TextBox();
      this.ParamsView = new ListView();
      this.columnHeader1 = new ColumnHeader();
      this.columnHeader2 = new ColumnHeader();
      this.columnHeader3 = new ColumnHeader();
      this.columnHeader4 = new ColumnHeader();
      this.AddParam = new Button();
      this.DeleteParam = new Button();
      this.Debug = new CheckBox();
      this.Cache = new CheckBox();
      this.NoStop = new CheckBox();
      this.ReturnCode = new TextBox();
      this.label3 = new Label();
      this.Execute = new Button();
      this.label4 = new Label();
      this.EntryName = new TextBox();
      this.RuntimeOptions = new TextBox();
      this.label5 = new Label();
      this.AcuInit = new Button();
      this.button1 = new Button();
      this.SuspendLayout();
      // 
      // ProgramPath
      // 
      this.ProgramPath.Location = new System.Drawing.Point(8, 40);
      this.ProgramPath.Name = "ProgramPath";
      this.ProgramPath.Size = new System.Drawing.Size(200, 20);
      this.ProgramPath.TabIndex = 1;
      this.ProgramPath.Text = "";
      // 
      // label1
      // 
      this.label1.Location = new System.Drawing.Point(8, 24);
      this.label1.Name = "label1";
      this.label1.Size = new System.Drawing.Size(128, 16);
      this.label1.TabIndex = 1;
      this.label1.Text = "Acucobol Program Path";
      // 
      // ProgramSearch
      // 
      this.ProgramSearch.Location = new System.Drawing.Point(152, 16);
      this.ProgramSearch.Name = "ProgramSearch";
      this.ProgramSearch.Size = new System.Drawing.Size(56, 23);
      this.ProgramSearch.TabIndex = 0;
      this.ProgramSearch.Text = "Search";
      this.ProgramSearch.Click += new System.EventHandler(this.ProgramSearch_Click);
      // 
      // RuntimeSearch
      // 
      this.RuntimeSearch.Location = new System.Drawing.Point(488, 16);
      this.RuntimeSearch.Name = "RuntimeSearch";
      this.RuntimeSearch.Size = new System.Drawing.Size(56, 23);
      this.RuntimeSearch.TabIndex = 3;
      this.RuntimeSearch.Text = "Search";
      this.RuntimeSearch.Click += new System.EventHandler(this.RuntimeSearch_Click);
      // 
      // label2
      // 
      this.label2.Location = new System.Drawing.Point(352, 24);
      this.label2.Name = "label2";
      this.label2.Size = new System.Drawing.Size(96, 16);
      this.label2.TabIndex = 4;
      this.label2.Text = "Runtime Path";
      // 
      // RuntimePath
      // 
      this.RuntimePath.Location = new System.Drawing.Point(352, 40);
      this.RuntimePath.Name = "RuntimePath";
      this.RuntimePath.Size = new System.Drawing.Size(192, 20);
      this.RuntimePath.TabIndex = 4;
      this.RuntimePath.Text = "";
      // 
      // ParamsView
      // 
      this.ParamsView.BackColor = System.Drawing.SystemColors.Info;
      this.ParamsView.Columns.AddRange(new ColumnHeader[] {
             this.columnHeader1,
             this.columnHeader2,
             this.columnHeader3,
             this.columnHeader4});
      this.ParamsView.FullRowSelect = true;
      this.ParamsView.GridLines = true;
      this.ParamsView.Location = new System.Drawing.Point(8, 72);
      this.ParamsView.Name = "ParamsView";
      this.ParamsView.Size = new System.Drawing.Size(536, 136);
      this.ParamsView.Sorting = SortOrder.Ascending;
      this.ParamsView.TabIndex = 5;
      this.ParamsView.View = View.Details;
      // 
      // columnHeader1
      // 
      this.columnHeader1.Text = "#";
      this.columnHeader1.Width = 30;
      // 
      // columnHeader2
      // 
      this.columnHeader2.Text = "type";
      this.columnHeader2.Width = 76;
      // 
      // columnHeader3
      // 
      this.columnHeader3.Text = "In-Value";
      this.columnHeader3.Width = 185;
      // 
      // columnHeader4
      // 
      this.columnHeader4.Text = "Return-Value";
      this.columnHeader4.Width = 241;
      // 
      // AddParam
      // 
      this.AddParam.Location = new System.Drawing.Point(104, 216);
      this.AddParam.Name = "AddParam";
      this.AddParam.Size = new System.Drawing.Size(88, 23);
      this.AddParam.TabIndex = 6;
      this.AddParam.Text = "Add Param";
      this.AddParam.Click += new System.EventHandler(this.AddParam_Click);
      // 
      // DeleteParam
      // 
      this.DeleteParam.Location = new System.Drawing.Point(336, 216);
      this.DeleteParam.Name = "DeleteParam";
      this.DeleteParam.Size = new System.Drawing.Size(88, 23);
      this.DeleteParam.TabIndex = 7;
      this.DeleteParam.Text = "Delete Param";
      this.DeleteParam.Click += new System.EventHandler(this.DeleteParam_Click);
      // 
      // Debug
      // 
      this.Debug.Location = new System.Drawing.Point(112, 288);
      this.Debug.Name = "Debug";
      this.Debug.Size = new System.Drawing.Size(64, 24);
      this.Debug.TabIndex = 10;
      this.Debug.Text = "Debug";
      // 
      // Cache
      // 
      this.Cache.Location = new System.Drawing.Point(376, 288);
      this.Cache.Name = "Cache";
      this.Cache.Size = new System.Drawing.Size(64, 24);
      this.Cache.TabIndex = 14;
      this.Cache.Text = "Cache";
      // 
      // NoStop
      // 
      this.NoStop.Location = new System.Drawing.Point(240, 288);
      this.NoStop.Name = "NoStop";
      this.NoStop.Size = new System.Drawing.Size(72, 24);
      this.NoStop.TabIndex = 13;
      this.NoStop.Text = "No Stop";
      // 
      // ReturnCode
      // 
      this.ReturnCode.Location = new System.Drawing.Point(408, 320);
      this.ReturnCode.Name = "ReturnCode";
      this.ReturnCode.Size = new System.Drawing.Size(64, 20);
      this.ReturnCode.TabIndex = 15;
      this.ReturnCode.Text = "";
      // 
      // label3
      // 
      this.label3.Location = new System.Drawing.Point(336, 328);
      this.label3.Name = "label3";
      this.label3.Size = new System.Drawing.Size(72, 16);
      this.label3.TabIndex = 16;
      this.label3.Text = "Return Code";
      // 
      // Execute
      // 
      this.Execute.Location = new System.Drawing.Point(216, 320);
      this.Execute.Name = "Execute";
      this.Execute.TabIndex = 16;
      this.Execute.Text = "Execute";
      this.Execute.Click += new System.EventHandler(this.Execute_Click);
      // 
      // label4
      // 
      this.label4.Location = new System.Drawing.Point(240, 24);
      this.label4.Name = "label4";
      this.label4.Size = new System.Drawing.Size(72, 16);
      this.label4.TabIndex = 18;
      this.label4.Text = "Entry Name";
      // 
      // EntryName
      // 
      this.EntryName.Location = new System.Drawing.Point(224, 40);
      this.EntryName.Name = "EntryName";
      this.EntryName.Size = new System.Drawing.Size(112, 20);
      this.EntryName.TabIndex = 2;
      this.EntryName.Text = "";
      // 
      // RuntimeOptions
      // 
      this.RuntimeOptions.Location = new System.Drawing.Point(112, 256);
      this.RuntimeOptions.Name = "RuntimeOptions";
      this.RuntimeOptions.Size = new System.Drawing.Size(328, 20);
      this.RuntimeOptions.TabIndex = 8;
      this.RuntimeOptions.Text = "";
      // 
      // label5
      // 
      this.label5.Location = new System.Drawing.Point(8, 256);
      this.label5.Name = "label5";
      this.label5.Size = new System.Drawing.Size(96, 23);
      this.label5.TabIndex = 21;
      this.label5.Text = "Runtime Options";
      // 
      // AcuInit
      // 
      this.AcuInit.Location = new System.Drawing.Point(456, 256);
      this.AcuInit.Name = "AcuInit";
      this.AcuInit.Size = new System.Drawing.Size(88, 23);
      this.AcuInit.TabIndex = 9;
      this.AcuInit.Text = "AcuInitialize";
      this.AcuInit.Click += new System.EventHandler(this.AcuInit_Click);
      // 
      // button1
      // 
      this.button1.Location = new System.Drawing.Point(16, 320);
      this.button1.Name = "button1";
      this.button1.TabIndex = 22;
      this.button1.Text = "Help";
      this.button1.Click += new System.EventHandler(this.button1_Click);
      // 
      // childTemplate
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(552, 348);
      this.Controls.Add(this.button1);
      this.Controls.Add(this.RuntimeOptions);
      this.Controls.Add(this.EntryName);
      this.Controls.Add(this.ReturnCode);
      this.Controls.Add(this.RuntimePath);
      this.Controls.Add(this.ProgramPath);
      this.Controls.Add(this.AcuInit);
      this.Controls.Add(this.label5);
      this.Controls.Add(this.label4);
      this.Controls.Add(this.Execute);
      this.Controls.Add(this.label3);
      this.Controls.Add(this.NoStop);
      this.Controls.Add(this.Cache);
      this.Controls.Add(this.Debug);
      this.Controls.Add(this.DeleteParam);
      this.Controls.Add(this.AddParam);
      this.Controls.Add(this.ParamsView);
      this.Controls.Add(this.RuntimeSearch);
      this.Controls.Add(this.label2);
      this.Controls.Add(this.ProgramSearch);
      this.Controls.Add(this.label1);
      this.Name = "childTemplate";
      this.Opacity = 0;
      this.Text = "COBOL Progran Information";
      this.ResumeLayout(false);

  }
  #endregion

  //*****************************************************************************
  // instantiates the Params Dialog to add parameters
  //*****************************************************************************
  private void AddParam_Click(object sender, System.EventArgs e)
  {AddParams Param = new AddParams();
  
   Param.addedParam += new AddParams.ParamAdded(NotifyParamChange);

   Param.Parameter = NextParamNo++;
  
   if (Param.ShowDialog(this) == DialogResult.OK)
       if (NextParamNo == Param.Parameter) NextParamNo--; 
  
   Param.Dispose();}

  //*****************************************************************************
  // Event Callback from AddParams .. adds to listview a parameter line
  //*****************************************************************************
  public void NotifyParamChange(AddParams Param)
  {ListViewItem itm;
   
   int i = 0;
   
   itm = this.ParamsView.Items.Add(Param.ParamNumber.Text);
  
   i = itm.Index;
  
   this.ParamsView.Items[i].SubItems.Add(Param.ParamType.Text);
   this.ParamsView.Items[i].SubItems.Add(Param.paramVal.Text);
   this.ParamsView.Items[i].SubItems.Add("");

   NextParamNo = Param.Parameter;

   Param.ParamType.Text = "";
   Param.paramVal.Text  = "";}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void Execute_Click(object sender, System.EventArgs e)
  {errorTypes rtn;
   
   int      CobolReturnCode = 0;
   object[] paramObjects    = null;
   byte[]   cblTypes        = null;

   Form1 parentForm = (Form1)MdiParent;
  
   if (ParamsView.Items.Count > 0) paramObjects = ConvertToNetTypes();

   if (parentForm.acuCobol == null) parentForm.acuCobol = new CVM();
  
   parentForm.acuCobol.Debug = Debug.Checked;
   parentForm.acuCobol.Cache = Cache.Checked;
   parentForm.acuCobol.NoStop = NoStop.Checked;

   parentForm.acuCobol.LinkageLength = true;

   parentForm.acuCobol.RunPath = RuntimePath.Text;
  
   if ((EntryName.Text != null) && (EntryName.Text.Length > 0))
       rtn = parentForm.acuCobol.Call(EntryName.Text, ref paramObjects, ref cblTypes, null, ref CobolReturnCode);
   else
       rtn = parentForm.acuCobol.Call(ProgramPath.Text, ref paramObjects, ref cblTypes, null, ref CobolReturnCode);
  
   if (rtn == errorTypes.CS_OK)
      {if ((paramObjects != null) && (paramObjects.Length > 0)) ConvertToViewStrings(ref paramObjects);}
  
   ReturnCode.Text = ((int)rtn).ToString();
 
   if (rtn != errorTypes.CS_OK) MessageBox.Show(parentForm.acuCobol.LastErrorMsg, "WRUNNETUTIL", MessageBoxButtons.OK, MessageBoxIcon.Stop);

   if (rtn != errorTypes.CS_OK)
      {MessageBox.Show("Free Info Failed", "WRUNNETUTIL", MessageBoxButtons.OK, MessageBoxIcon.Stop);
       ReturnCode.Text = ((int)rtn).ToString();}
  
   Initialized = true;
   parentForm.needShutDown = true;}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void ConvertToViewStrings(ref object[] paramObjects)
  {int i = 0;
  
   foreach (object obj in paramObjects)
           {ParamsView.Items[i].SubItems[3].Text = obj.ToString();
            i++;}}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private object[] ConvertToNetTypes()
  {int      i = 0;
   
   object[] paramObjects = new object[ParamsView.Items.Count];

   foreach (ListViewItem itm in ParamsView.Items)
           {if (itm.SubItems[1].Text == "Byte")           paramObjects[i] = Convert.ToByte(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "short int")      paramObjects[i] = Convert.ToInt16(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "int")            paramObjects[i] = Convert.ToInt32(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "long")           paramObjects[i] = Convert.ToInt64(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "unsigned short") paramObjects[i] = Convert.ToUInt16(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "unsigned int")   paramObjects[i] = Convert.ToUInt32(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "unsigned long")  paramObjects[i] = Convert.ToUInt64(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "float")          paramObjects[i] = Convert.ToSingle(itm.SubItems[2].Text);
            if (itm.SubItems[1].Text == "double")         paramObjects[i] = Convert.ToDouble(itm.SubItems[2].Text);

            if (itm.SubItems[1].Text == "String")
               {paramObjects[i] = itm.SubItems[2].Text;
                
                int    lngth  = ((string)paramObjects[i]).Length;
                string append = new String(' ', (int)defines.MAX_STRING_LENGTH - lngth);
                
                paramObjects[i] += append;}

            i++;}

   return paramObjects;}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void DeleteParam_Click(object sender, System.EventArgs e)
  {ListView.SelectedListViewItemCollection slcted = this.ParamsView.SelectedItems;

   foreach (ListViewItem item in slcted) item.Remove();}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void ProgramSearch_Click(object sender, System.EventArgs e)
  {OpenFileDialog opn = new OpenFileDialog();
   
   if ((opn.ShowDialog()) == DialogResult.OK) ProgramPath.Text = opn.FileName;}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void RuntimeSearch_Click(object sender, System.EventArgs e)
  {FolderBrowserDialog folderDlg = new FolderBrowserDialog();
  
   if ((folderDlg.ShowDialog()) == DialogResult.OK) RuntimePath.Text = folderDlg.SelectedPath;}
     
  //*****************************************************************************
  // 
  //*****************************************************************************
  private void AcuInit_Click(object sender, System.EventArgs e)
  {bool rtn;
   Form1 parentForm = (Form1)MdiParent;
   
   if (parentForm.acuCobol == null) parentForm.acuCobol = new CVM();

   parentForm.acuCobol.RunPath = RuntimePath.Text;

   rtn = parentForm.acuCobol.Initialize(RuntimeOptions.Text);

   if (! rtn)
       MessageBox.Show("Failed to Initialized", "WRUNNETUTIL", MessageBoxButtons.OK, MessageBoxIcon.Stop);
   else   
      {MessageBox.Show("Initialization Complete", "WRUNNETUTIL", MessageBoxButtons.OK, MessageBoxIcon.Information);
   
       Initialized             = true;
       parentForm.needShutDown = true;}}

  //*****************************************************************************
  // 
  //*****************************************************************************
  private void button1_Click(object sender, System.EventArgs e)
  {try
    {Help.ShowHelp(this, "wrunnetutil.htm");}
   catch (System.Exception e2)
    {MessageBox.Show("wrunnetutil.htm not found");}}


 }
}
