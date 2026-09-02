using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using acucobol;

namespace wrunnetutil
{/// <summary>
 /// Summary description for Form1.
 /// </summary>
 public class Form1 : System.Windows.Forms.Form
 {public bool needShutDown;
  public CVM  acuCobol;

  private MainMenu mainMenu1;
  private MenuItem menuItem1;
  private MenuItem menuItem2;
  private MenuItem menuItem3;
  private MenuItem menuItem4;
  private MenuItem menuItem5;
  private MenuItem menuItem6;
  private MenuItem menuItem7;
  private MenuItem menuItem8;

  /// <summary>
  /// Required designer variable.
  /// </summary>
  private System.ComponentModel.Container components = null;

  public Form1()
  {InitializeComponent();
   
   needShutDown = false;
   
   childTemplate newMDIChild = new childTemplate();
   
   // Set the Parent Form of the Child window.
   newMDIChild.MdiParent = this;

   newMDIChild.Show();}

  /// <summary>
  /// Clean up any resources being used.
  /// </summary>
  protected override void Dispose( bool disposing )
  {if (disposing)
      {if (components != null) 
          {components.Dispose();}}
   
   base.Dispose( disposing );}

  #region Windows Form Designer generated code
  /// <summary>
  /// Required method for Designer support - do not modify
  /// the contents of this method with the code editor.
  /// </summary>
  private void InitializeComponent()
  {
      this.mainMenu1 = new System.Windows.Forms.MainMenu();
      this.menuItem1 = new System.Windows.Forms.MenuItem();
      this.menuItem5 = new System.Windows.Forms.MenuItem();
      this.menuItem6 = new System.Windows.Forms.MenuItem();
      this.menuItem7 = new System.Windows.Forms.MenuItem();
      this.menuItem2 = new System.Windows.Forms.MenuItem();
      this.menuItem3 = new System.Windows.Forms.MenuItem();
      this.menuItem4 = new System.Windows.Forms.MenuItem();
      this.menuItem8 = new System.Windows.Forms.MenuItem();
      // 
      // mainMenu1
      // 
      this.mainMenu1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                 this.menuItem1,
                 this.menuItem3});
      // 
      // menuItem1
      // 
      this.menuItem1.Index = 0;
      this.menuItem1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                 this.menuItem5,
                 this.menuItem6,
                 this.menuItem7,
                 this.menuItem2});
      this.menuItem1.Text = "&File";
      // 
      // menuItem5
      // 
      this.menuItem5.Index = 0;
      this.menuItem5.Text = "&New";
      this.menuItem5.Click += new System.EventHandler(this.menuItem5_Click);
      // 
      // menuItem6
      // 
      this.menuItem6.Index = 1;
      this.menuItem6.Text = "&Close";
      this.menuItem6.Click += new System.EventHandler(this.menuItem6_Click);
      // 
      // menuItem7
      // 
      this.menuItem7.Index = 2;
      this.menuItem7.Text = "-";
      // 
      // menuItem2
      // 
      this.menuItem2.Index = 3;
      this.menuItem2.Text = "&Exit";
      this.menuItem2.Click += new System.EventHandler(this.menuItem2_Click_1);
      // 
      // menuItem3
      // 
      this.menuItem3.Index = 1;
      this.menuItem3.MdiList = true;
      this.menuItem3.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
                 this.menuItem4,
                 this.menuItem8});
      this.menuItem3.Text = "&Window";
      // 
      // menuItem4
      // 
      this.menuItem4.Index = 0;
      this.menuItem4.Text = "C&ascade";
      this.menuItem4.Click += new System.EventHandler(this.menuItem4_Click);
      // 
      // menuItem8
      // 
      this.menuItem8.Index = 1;
      this.menuItem8.Text = "Tile Horizontal";
      this.menuItem8.Click += new System.EventHandler(this.menuItem8_Click);
      // 
      // Form1
      // 
      this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
      this.ClientSize = new System.Drawing.Size(592, 401);
      this.IsMdiContainer = true;
      this.Menu = this.mainMenu1;
      this.Name = "Form1";
      this.Text = "Acucobol .NET Utility";
      this.Closing += new System.ComponentModel.CancelEventHandler(this.Form1_Closing);

  }
  #endregion

  /// <summary>
  /// The main entry point for the application.
  /// </summary>
  [STAThread]
  static void Main() 
  {Application.Run(new Form1());}

  private void menuItem5_Click(object sender, System.EventArgs e)
  {childTemplate newMDIChild = new childTemplate();
  
   // Set the Parent Form of the Child window.
   newMDIChild.MdiParent = this;
  
   newMDIChild.Show();}

  private void menuItem2_Click_1(object sender, System.EventArgs e)
  {if (needShutDown)
      {int imsg = 0;
      
       acuCobol.ShutDown(imsg);
       needShutDown = false;}
  
   Close();}

  private void menuItem6_Click(object sender, System.EventArgs e)
  {Form activeChild = this.ActiveMdiChild;
  
   activeChild.Close();}

  private void menuItem8_Click(object sender, System.EventArgs e)
  {LayoutMdi(MdiLayout.TileHorizontal);}

  private void menuItem4_Click(object sender, System.EventArgs e)
  {LayoutMdi(MdiLayout.Cascade);}

  private void Form1_Closing(object sender, System.ComponentModel.CancelEventArgs e)
  {if (needShutDown)
      {int imsg = 0;
      
       acuCobol.ShutDown(imsg);
       needShutDown = false;}}

  
 }
}
