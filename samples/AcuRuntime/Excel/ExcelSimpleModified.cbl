       IDENTIFICATION               DIVISION.
       PROGRAM-ID.                  ExcelSimpleModified.
       AUTHOR.  claudio.contardi@microfocus.com.
      *====================
      *
      * Copyright (c) 1996-2006 by Acucorp, Inc.  Users of ACUCOBOL
      * may freely modify and redistribute this program.
      *
      * The purpose of this application is to show the absolute minimum
      * required to access a cell in a Microsoft Excel spreadsheet.
      *
      ************************************************************************************
      ************************************************************************************
      *
      *  !  !  !  !  !  W  A  R  N  I  N  G   !  !  !  !  !
      *
      * Compile with one of the following commandlines,
      * accordingly with your Office version
      *
WARNIN* ccbl32 -ga -si 2000 ExcelSimpleModified.cbl
WARNIN* ccbl32 -ga -si 2003 ExcelSimpleModified.cbl
WARNIN* ccbl32 -ga -si 2010 ExcelSimpleModified.cbl
WARNIN* ccbl32 -ga -si 2016 ExcelSimpleModified.cbl
      *
      ************************************************************************************
      ************************************************************************************
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION                SECTION.
       SPECIAL-NAMES.
WARNIN*    COPY    "excel-2000.def".                                       | 2000
WARNIN*    COPY    "excel-2003.def".                                       | 2003
WARNIN*    COPY    "excel-2010.def".                                       | 2010
WARNIN*    COPY    "excel-2013-x64.def".                                   | 2013x64
WARNIN*    COPY    "excel-2016-x86.def".                                   | 2016
           decimal-point is comma.
       DATA        DIVISION.
       WORKING-STORAGE              SECTION.
      *
           COPY    "activex.def".
           COPY    "acucobol.def".
      *
       01 EXCEL-HANDLES.
         05  olExcel                HANDLE OF APPLICATION.
         05  olWrkBk                HANDLE OF WORKBOOK.
         05  olWrkSh                HANDLE OF WORKSHEET.
         05  olWrkShNEW             HANDLE OF WORKSHEET.
         05  olWrkShPVT             HANDLE OF WORKSHEET.
         05  olRange1               HANDLE OF RANGE.
         05  olRange2               HANDLE OF RANGE.
         05  olRange3               HANDLE OF RANGE.
         05  olRangeArea            HANDLE OF RANGE.
         05  olRangeKey1            HANDLE OF RANGE.
         05  olRangeKey2            HANDLE OF RANGE.
      *  05  olSortFields1          HANDLE OF @SortFields.                 | 2010 2016
      *  05  olSortFields2          HANDLE OF @SortFields.                 | 2010 2016
         05  olFont                 HANDLE OF @Font.
         05  olInterior             HANDLE OF Interior.
         05  olBorders              HANDLE OF XlBordersIndex.
         05  olBorder               HANDLE OF Borders.
         05  olPivotCaches          HANDLE OF PivotCaches.

ed0315 01  WS-MY-STRING             PIC X(80).

ed0315*01  WS-MY-NUM REDEFINES WS-MY-STRING PIC 9(10).
ed0315 01  WS-MY-NUM                PIC 9(10).

cccccc 01  WS-MY-FORMAT             PIC X(15).

cccccc 01  WS-IS-NUMBER             PIC 9.

       77 ws-computer-name          pic x(128) value spaces.
       77 ws-local-server-name      pic x(134) value spaces.        

       77  WS-COUNT                 PIC 9(5).
       77  WS-NAME                  PIC X(80) VALUE SPACES.
       77  WS-SEPARATOR             PIC X.

       01  WS-DATE-FROM-COBOL.
         05  WS-YYYY                PIC X(4).
         05  WS-MM                  PIC X(2).
         05  WS-DD                  PIC X(2).
       01  WS-DATE-EXCEL.
         05  WS-DD-EXCEL            PIC X(2).
         05  FILLER                 PIC X VALUE "/".
         05  WS-MM-EXCEL            PIC X(2).
         05  FILLER                 PIC X VALUE "/".
         05  WS-YYYY-EXCEL          PIC X(4).

       01  WS-RANGE.
           02 FILLER                PIC X VALUE x"22".
           02 WS-RANGE-1            PIC X(4).
           02 FILLER                PIC X VALUE ":".
           02 WS-RANGE-2            PIC X(4).
           02 FILLER                PIC X VALUE x"22".


       PROCEDURE DIVISION.
       Main.
           PERFORM OPEN-EXCEL
           PERFORM OPEN-CREATE-WORKBOOK

           PERFORM WORK-WITH-CELL-VALUES

           PERFORM SORT-CELL-VALUES

           PERFORM FORMAT-CELLS

           PERFORM PAGE-SETUP

           PERFORM WORK-WITH-WORKSHEET

      *     PERFORM new-impl.

**TODO*****    PERFORM PIVOT

**TODO*****    PERFORM GROUP-ROWS

           .
       Closing.
           PERFORM SAVE-WORKBOOK
           PERFORM CLOSE-WORKBOOK
           PERFORM CLOSE-EXCEL
           PERFORM CHECK-TASK-MANAGER

           STOP RUN.
           .

*************************************************************************
       OPEN-EXCEL.
           INITIALIZE EXCEL-HANDLES.
           ACCEPT TERMINAL-ABILITIES FROM TERMINAL-INFO
           
           IF IS-REMOTE
              ACCEPT ws-computer-name from ENVIRONMENT "COMPUTERNAME"
              INSPECT ws-computer-name REPLACING TRAILING SPACES 
                                       BY low-values
 
              STRING "Local:"
                     ws-computer-name DELIMITED BY low-values
                     INTO ws-local-server-name
              INSPECT ws-local-server-name REPLACING TRAILING SPACES 
                                           BY low-values
              CREATE  Application      OF Excel
                      SERVER-NAME IS ws-local-server-name
                      HANDLE           IN olExcel
              MODIFY  olExcel          @Visible = 0
           ELSE
              CREATE  Application      OF Excel
                      HANDLE           IN olExcel
              MODIFY  olExcel          @Visible = 1
           END-IF
           .

*************************************************************************
       CLOSE-EXCEL.
           IF olRange1 NOT = 0
              DESTROY olRange1
           END-IF
           IF olRange2 NOT = 0
              DESTROY olRange2
           END-IF
           IF olRange3 NOT = 0
              DESTROY olRange3
           END-IF
           IF olRangeArea NOT = 0
              DESTROY olRangeArea
           END-IF
           IF olRangeKey1 NOT = 0
              DESTROY olRangeKey1
           END-IF
           IF olRangeKey2 NOT = 0
              DESTROY olRangeKey2
           END-IF
      *     IF olSortFields1 NOT = 0                                       | 2010 2016
      *        DESTROY olSortFields1                                       | 2010 2016
      *     END-IF                                                         | 2010 2016
      *     IF olSortFields2 NOT = 0                                       | 2010 2016
      *        DESTROY olSortFields2                                       | 2010 2016
      *     END-IF                                                         | 2010 2016
           IF olPivotCaches NOT = 0
              DESTROY olPivotCaches
           END-IF
           IF olBorder NOT = 0
              DESTROY olBorder
           END-IF
           IF olBorders NOT = 0
              DESTROY olBorders
           END-IF
           IF olInterior NOT = 0
              DESTROY olInterior
           END-IF
           IF olFont NOT = 0
              DESTROY olFont
           END-IF
           IF olWrkSh NOT = 0
              DESTROY olWrkSh
           END-IF
           IF olWrkShNEW NOT = 0
              DESTROY olWrkShNEW
           END-IF
           IF olWrkShPVT NOT = 0
              DESTROY olWrkShPVT
           END-IF
           IF olWrkBk NOT = 0
              DESTROY olWrkBk
           END-IF
           MODIFY  olExcel          Quit().
      *This next line is very important, otherwise Excel will stick in
      *memory.
           DESTROY olExcel.  
*************************************************************************
       CHECK-TASK-MANAGER.
           display message box "Check you Task Manager. No EXCEL.EXE pro
      -                        "cess should remain active!"
           .
*************************************************************************
       OPEN-CREATE-WORKBOOK.
           IF ws-name = SPACES
              MODIFY  olExcel          Workbooks::Add()
                      GIVING           olWrkBk
           ELSE
              MODIFY  olExcel          Workbooks::Open(ws-name)
                      GIVING           olWrkBk
           END-IF.
           INQUIRE olWrkBk          Worksheets::Item(1) IN
                   olWrkSh.
*************************************************************************
       CLOSE-WORKBOOK.
      *Enforce a close without save, or Excel will prompt you.
            MODIFY  olWrkBk      @Close(BY NAME SaveChanges 0)
            .
*************************************************************************
       SAVE-WORKBOOK.
            IF ws-name = SPACES
ed0315*         MOVE "C:\temp\FULLtest.xlsx"  TO ws-name                    | 2010 2013x64 2016
ed0315*         MOVE "C:\temp\FULLtest.xls"   TO ws-name                    | 2000 2003
            END-IF

CCCCCC     MODIFY olExcel @DisplayAlerts("FALSE")

            MODIFY olWrkBk       @SaveAs(BY NAME @Filename = ws-name)
                                  GIVING WS-MY-STRING

CCCCCC     MODIFY olExcel @DisplayAlerts("TRUE")
            .
*************************************************************************
       WORK-WITH-CELL-VALUES.
      *Set the value of a cell.
            MODIFY  olWrkSh      Range("C5")::Value = "Dev Sys".
            MODIFY  olWrkSh      Range("C6")::Value = "Acuconnect Thin C
      -     "lient".
            MODIFY  olWrkSh      Range("D5")::Value = 123456789,00.
ed0315*     MODIFY  olWrkSh      Range("D6")::Value = 123456789,99.
ed0315      MODIFY  olWrkSh      Range("D6")::Value = "12:34:34".
            MODIFY  olWrkSh      Range("C8")::Value = "Total".

TODO  *    *     MODIFY  olWrkSh      Range("D8")::FormulaR1C1::SUM("D5:D6").

            MODIFY  olWrkSh      Range("C:D")::EntireColumn()::AutoFit().
      *     MODIFY  olWrkSh      Range("D6")::NumberFormat = "0".
ed0315*     INQUIRE olWrkSh      Range("D6")::Value IN WS-MY-NUM.
ed0315*     DISPLAY MESSAGE BOX "WS-MY-NUM = " WS-MY-NUM.
ed0315*     INQUIRE olWrkSh      Range("D6")::Value IN WS-MY-STRING.
ed0315*     DISPLAY MESSAGE BOX "WS-MY-STRING = " WS-MY-STRING.

cccccc* https://msdn.microsoft.com/en-us/library/office/ff196401.aspx
cccccc
cccccc      INQUIRE olWrkSh      Range("D6")::NumberFormat
cccccc                           IN WS-MY-FORMAT.
cccccc
cccccc      INQUIRE olWrkSh       @Range( 
cccccc                            BY NAME Cell1 = "D6" 
cccccc                            BY NAME Cell2 = "D6" 
cccccc                            ) IN olRange1 
cccccc
cccccc      MODIFY olExcel        @WorksheetFunction::IsNumber(olRange1)
cccccc                            GIVING WS-IS-NUMBER.                          | boolean 
cccccc
cccccc      EVALUATE TRUE
cccccc       WHEN WS-MY-FORMAT = "Standard" OR "General"
cccccc         IF WS-IS-NUMBER = 0
cccccc           INQUIRE olWrkSh      Range("D6")::Value IN WS-MY-STRING
cccccc           DISPLAY MESSAGE BOX "Valore cella = " WS-MY-STRING
cccccc         ELSE
cccccc           INQUIRE olWrkSh      Range("D6")::Value IN WS-MY-NUM
cccccc           DISPLAY MESSAGE BOX "Valore cella = " WS-MY-NUM
cccccc         END-IF
cccccc       WHEN WS-MY-FORMAT = "0" OR "0,0" OR "0,00"  
cccccc         INQUIRE olWrkSh      Range("D6")::Value IN WS-MY-NUM
cccccc         DISPLAY MESSAGE BOX "Valore cella = " WS-MY-NUM
cccccc      END-EVALUATE
cccccc      .

*************************************************************************
       FORMAT-CELLS.
      *Columns("C:D").Select
      *      MODIFY  olWrkSh      Range("C:D")::Columns()::Select().

      *Columns("C:D").EntireColumn.AutoFit
            MODIFY  olWrkSh      Range("C:D")::EntireColumn()::AutoFit().

            MODIFY  olWrkSh      Range("D5:D6")::NumberFormat = "0,00".

      * INQUIRE DEL SEGNO DI SEPARAZIONE DECIMALE
      *
WARNIN*     INQUIRE olWrkBk @Application::DecimalSeparator                    | 2003 2010 2016
WARNIN*                      IN WS-SEPARATOR                                  | 2003 2010 2016

            MOVE "20090721"      TO WS-DATE-FROM-COBOL.
            MOVE WS-YYYY         TO WS-YYYY-EXCEL
            MOVE WS-MM           TO WS-MM-EXCEL
            MOVE WS-DD           TO WS-DD-EXCEL
            MODIFY olWrkSh Range("B2")::NumberFormat = "gg/MM/aaaa".
            MODIFY olWrkSh Range("B2")::Value = WS-DATE-EXCEL.

      * http://msdn.microsoft.com/en-us/library/aa214203(office.11).aspx
            MODIFY olWrkSh        Range("B2")::ColumnWidth = 30
            MODIFY olWrkSh        Range("B2")::RowHeight = 30

      *Columns("C:D").Select
      *With Selection
      *        .HorizontalAlignment = xlCenter
      *        .VerticalAlignment = xlCenter
      *        .WrapText = False
      *        .Orientation = 0
      *        .AddIndent = False
      *        .IndentLevel = 0
      *        .ShrinkToFit = False
      *        .ReadingOrder = xlContext
      *        .MergeCells = False
      *End With
            MODIFY olWrkSh
                        Range("B2")::HorizontalAlignment = xlCenter
            MODIFY olWrkSh
                        Range("B2")::VerticalAlignment = xlCenter.

      *Range("C5").Select
      *Selection.Font.Bold = True
            INQUIRE olWrkSh      Range("C5")::Font
                    IN olFont.
            MODIFY  olFont       Bold = 1.
            DESTROY olFont

      *alternative method for Bold
            MODIFY  olWrkSh     Range("D5:D6")::Font()::Bold(1)

      *Range("D5").Select
      *Selection.Font.Italic = True
            INQUIRE olWrkSh      Range("C6")::Font
                    IN olFont.
            MODIFY  olFont       Italic = 1.
            DESTROY olFont

      *Range("D6").Select
      *With Selection.Font
      *        .Color = -16776961
      *        .TintAndShade = 0
      *End With
            INQUIRE olWrkSh      Range("C8")::Font
                    IN olFont.
            MODIFY  olFont       Color = -16776961.
            DESTROY olFont

      *Range("C6").Select
      *With Selection.Interior
      *        .Pattern = xlSolid
      *        .PatternColorIndex = xlAutomatic
      *        .Color = 65535
      *        .TintAndShade = 0
      *        .PatternTintAndShade = 0
      *End With
            INQUIRE olWrkSh      Range("D8")::Interior
                    IN           olInterior.
            MODIFY  olInterior   Pattern = xlSolid
                                 PatternColorIndex = xlAutomatic
                                 Color = 65535.

      *With Selection.Borders(xlEdgeBottom)
      *        .LineStyle = xlContinuous
      *        .Weight = xlThin
      *        .ColorIndex = xlAutomatic
      *End With
            MODIFY  olWrkSh      Range("C8:D8")::BorderAround(
                                   BY NAME LineStyle = xlContinuous
                                   BY NAME Weight = xlThin
                                   BY NAME ColorIndex = xlAutomatic
                                   )

TODO  *      *Selection.Borders(xlDiagonalDown).LineStyle = xlNone
      *Selection.Borders(xlDiagonalUp).LineStyle = xlNone
      *Selection.Borders(xlEdgeLeft).LineStyle = xlNone
      *With Selection.Borders(xlEdgeTop)
      *         .LineStyle = xlContinuous
      *         .ColorIndex = 0
      *         .TintAndShade = 0
      *         .Weight = xlThin
      *End With
      *Selection.Borders(xlEdgeBottom).LineStyle = xlNone
      *Selection.Borders(xlEdgeRight).LineStyle = xlNone
      *Selection.Borders(xlInsideVertical).LineStyle = xlNone
      *Selection.Borders(xlInsideHorizontal).LineStyle = xlNone
            INQUIRE olWrkSh Range("C6:D6")::Borders IN olBorder.
            MODIFY  olBorder(xlDiagonalDown)   LineStyle = xlNone.
            MODIFY  olBorder(xlDiagonalUp)     LineStyle = xlNone.
            MODIFY  olBorder(xlEdgeLeft)       LineStyle = xlNone.
            MODIFY  olBorder(xlEdgeBottom)     LineStyle = xlContinuous
                                               Weight = xlThin
                                               ColorIndex = xlAutomatic.
            MODIFY  olBorder(xlEdgeRight)      LineStyle = xlNone.
            MODIFY  olBorder(xlInsideVertical) LineStyle = xlNone.
            MODIFY  olBorder(xlInsideHorizontal) LineStyle = xlNone.
            .
*************************************************************************
       PAGE-SETUP.
            MODIFY  olExcel     @ActiveWindow::Zoom = 90

            MODIFY  olWrkSh     @PageSetup::HeaderMargin = 19.
            MODIFY  olWrkSh     @PageSetup::FooterMargin = 19.

*******      MODIFY  olWrkSh     @PageSetup::PrintArea = " ".

*******      MODIFY  olWrkSh     @PageSetup::Zoom = 90
            MODIFY  olWrkSh     @PageSetup::Zoom = 0 as VT-BOOL
            MODIFY  olWrkSh     @PageSetup::FitToPagesWide = 1
            MODIFY  olWrkSh     @PageSetup::FitToPagesTall = 1

*******      MODIFY  olExcel     @ActiveWindow::SelectedSheets::PrintOut(
*******                                     BY NAME Copies = 1
*******                                     BY NAME Preview = 0).

            .
*************************************************************************
       WORK-WITH-WORKSHEET.
*******Add a new worksheet on the right
            MODIFY  olWrkBk          Worksheets::Add()
                    GIVING olWrkShNEW.

            INQUIRE olWrkBk          Worksheets::Count IN ws-count

            IF olWrkSh NOT = 0
               DESTROY olWrkSh
            END-IF

            INQUIRE olWrkBk          Worksheets::Item(ws-count)
                    IN olWrkSh.

            MODIFY  olWrkShNEW       @Move(BY NAME After olWrkSh)

*******Copy Sheet1, put it on the right and return to Sheet1
      *Sheets("Sheet1").Select
      *Sheets("Sheet1").Copy After:=Sheets(4)
            IF olWrkSh NOT = 0
               DESTROY olWrkSh
            END-IF

            INQUIRE olWrkBk          Worksheets::Item(1) IN
                    olWrkSh.

            MODIFY  olWrkSh         @Copy(BY NAME After olWrkShNEW)


      *Select the first worksheet and put it on foreground
            IF olWrkSh NOT = 0
               DESTROY olWrkSh
            END-IF

            INQUIRE olWrkBk          Worksheets::Item(1) IN
                    olWrkSh.

            MODIFY  olWrkBk          Worksheets::Select()
            .
*************************************************************************
*******PIVOT.
*******     MODIFY  olWrkBk          Worksheets::Add()
*******             GIVING olWrkShPVT.
*******
*******     MODIFY  olExcel          PivotCaches::Create()
*******             GIVING olPivotCaches.
*******     .
*************************************************************************
       GROUP-ROWS.
*******Rows("7:12").Select
*******Selection.Rows.Group

              MOVE "A5" TO WS-RANGE-1
              MOVE "A8" TO WS-RANGE-2

              MODIFY olWrkSh
              Range(WS-RANGE)::Rows()::Select()
              MODIFY olWrkSh
              Range(WS-RANGE)::Rows()::Group()

            .
*************************************************************************
       SORT-CELL-VALUES.

            MODIFY  olWrkSh      Range("B10")::Value = "BBB".
            MODIFY  olWrkSh      Range("B11")::Value = "AAA".
            MODIFY  olWrkSh      Range("B12")::Value = "BBB".
            MODIFY  olWrkSh      Range("B13")::Value = "CCC".
            MODIFY  olWrkSh      Range("C10")::Value = "333".
            MODIFY  olWrkSh      Range("C11")::Value = "444".
            MODIFY  olWrkSh      Range("C12")::Value = "222".
            MODIFY  olWrkSh      Range("C13")::Value = "111".

******* from MS Excel 2003 - BEGIN **************************************************
*******
******* Range("B10:C13").Select
******* Selection.Sort Key1:=Range("B10"), Order1:=xlAscending, Key2:=Range("C10" _
*******     ), Order2:=xlAscending, Header:=xlGuess, OrderCustom:=1, MatchCase:= _
*******     False, Orientation:=xlTopToBottom, DataOption1:=xlSortNormal, DataOption2 _
*******     :=xlSortNormal
      *                                                                        | 2003
      *    INQUIRE  olWrkSh     @Range(                                        | 2003
      *                         BY NAME Cell1 = "B10"                          | 2003
      *                         BY NAME Cell2 = "C13"                          | 2003
      *                         ) IN olRange1                                  | 2003
      *    INQUIRE  olWrkSh     @Range(                                        | 2003
      *                         BY NAME Cell1 = "B10"                          | 2003
      *                         ) IN olRange2                                  | 2003
      *    INQUIRE  olWrkSh     @Range(                                        | 2003
      *                         BY NAME Cell1 = "C10"                          | 2003
      *                         ) IN olRange3                                  | 2003
      *                                                                        | 2003
      *    MODIFY  olRange1     @Sort(                                         | 2003
      *                           BY NAME Key1 = olRange2                      | 2003
      *                           BY NAME Order1 = xlAscending                 | 2003
      *                           BY NAME Key2 = olRange3                      | 2003
      *                           BY NAME Type = xlSortValues                  | 2003
      *                           BY NAME Order2 = xlDescending                | 2003
      *                           BY NAME Key3 = null                          | 2003
      *                           BY NAME Order3 = null                        | 2003
      *                           BY NAME Header = xlNo                        | 2003
      *                           BY NAME OrderCustom = 1                      | 2003
      *                           BY NAME MatchCase = "False"                  | 2003
      *                           BY NAME Orientation = xlTopToBottom          | 2003
      *                           BY NAME SortMethod = xlPinYin                | 2003
      *                           BY NAME DataOption1 = xlSortNormal           | 2003
      *                           BY NAME DataOption2 = xlSortNormal           | 2003
      *                           BY NAME DataOption3 = null                   | 2003
      *                           )                                            | 2003
      *                                                                        | 2003
      *    DESTROY olRange1 olRange2 olRange3                                  | 2003
      *                                                                        | 2003
******* from MS Excel 2003 - END ****************************************************

******* from MS Excel 2010 - BEGIN **************************************************
*******
******* SELECT 2 COLUMNS, SORT ON 1 COLUMN
*******
******* Range("B10:B13").Select
******* ActiveWorkbook.Worksheets("Sheet1").Sort.SortFields.Clear
******* ActiveWorkbook.Worksheets("Sheet1").Sort.SortFields.Add Key:=Range("B10"), _
*******   SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:= _
*******   xlSortTextAsNumbers
******* With ActiveWorkbook.Worksheets("Sheet1").Sort
*******   .SetRange Range("B10:B13")
*******   .Header = xlNo
*******   .MatchCase = False
*******   .Orientation = xlTopToBottom
*******   .SortMethod = xlPinYin
*******   .Apply
******* End With
      *                                                                        | 2010 2016
      *    MOVE "B10"           TO WS-RANGE-1                                  | 2010 2016
      *    MOVE "C13"           TO WS-RANGE-2                                  | 2010 2016
      *    INQUIRE  olWrkSh     @Range(                                        | 2010 2016
      *                         BY NAME Cell1 = WS-RANGE-1                     | 2010 2016
      *                         ) IN olRangeKey1                               | 2010 2016
      *    INQUIRE  olWrkSh     @Range(                                        | 2010 2016
      *                         BY NAME Cell1 = WS-RANGE-1                     | 2010 2016
      *                         BY NAME Cell2 = WS-RANGE-2                     | 2010 2016
      *                         ) IN olRangeArea                               | 2010 2016
      *                                                                        | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortFields::Clear()                     | 2010 2016
      *                                                                        | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortFields::Add(                        | 2010 2016
      *                         BY NAME Key = olRangeKey1                      | 2010 2016
      *                         BY NAME SortOn = xlSortOnValues                | 2010 2016
      *                         BY NAME Order = xlDescending                   | 2010 2016
      *                         BY NAME DataOption = xlSortNormal              | 2010 2016
      *                         ) GIVING olSortFields1                         | 2010 2016
      *                                                                        | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SetRange(olRangeArea)                   | 2010 2016
      *    MODIFY  olWrkSh      @Sort::Header(xlNo)                            | 2010 2016
      *    MODIFY  olWrkSh      @Sort::MatchCase("False")                      | 2010 2016
      *    MODIFY  olWrkSh      @Sort::Orientation(xlTopToBottom)              | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortMethod(xlPinYin)                    | 2010 2016
      *    MODIFY  olWrkSh      @Sort::Apply()                                 | 2010 2016
      *                                                                        | 2010 2016
      *    DESTROY olRangeKey1 olRangeArea olSortFields1                       | 2010 2016
      *                                                                        | 2010 2016
*******
******* SELECT 2 COLUMNS, SORT ON 2 COLUMN
*******
******* Range("B10:C13").Select
      * ActiveWorkbook.Worksheets("Sheet1").Sort.SortFields.Clear
      * ActiveWorkbook.Worksheets("Sheet1").Sort.SortFields.Add Key:=Range("B10:B13") _
      *    , SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:=xlSortNormal
      * ActiveWorkbook.Worksheets("Sheet1").Sort.SortFields.Add Key:=Range("C10:C13") _
      *    , SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
      * With ActiveWorkbook.Worksheets("Sheet1").Sort
      *   .SetRange Range("B10:C13")
      *   .Header = xlGuess
      *   .MatchCase = False
      *   .Orientation = xlTopToBottom
      *   .SortMethod = xlPinYin
      *    .Apply
      * End With
      *                                                                        | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortFields::Clear()                     | 2010 2016
      *                                                                        | 2010 2016
      *    MOVE "B10"           TO WS-RANGE-1                                  | 2010 2016
      *    MOVE "B13"           TO WS-RANGE-2                                  | 2010 2016
      *    INQUIRE  olWrkSh     @Range(                                        | 2010 2016
      *                         BY NAME Cell1 = WS-RANGE-1                     | 2010 2016
      *                         BY NAME Cell2 = WS-RANGE-2                     | 2010 2016
      *                         ) IN olRangeKey1                               | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortFields::Add(                        | 2010 2016
      *                         BY NAME Key = olRangeKey1                      | 2010 2016
      *                         BY NAME SortOn = xlSortOnValues                | 2010 2016
      *                         BY NAME Order = xlAscending                    | 2010 2016
      *                         BY NAME DataOption = xlSortNormal              | 2010 2016
      *                         ) GIVING olSortFields1                         | 2010 2016
      *                                                                        | 2010 2016
      *    MOVE "C10"           TO WS-RANGE-1                                  | 2010 2016
      *    MOVE "C13"           TO WS-RANGE-2                                  | 2010 2016
      *    INQUIRE  olWrkSh     @Range(                                        | 2010 2016
      *                         BY NAME Cell1 = WS-RANGE-1                     | 2010 2016
      *                         BY NAME Cell2 = WS-RANGE-2                     | 2010 2016
      *                         ) IN olRangeKey2                               | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortFields::Add(                        | 2010 2016
      *                         BY NAME Key = olRangeKey2                      | 2010 2016
      *                         BY NAME SortOn = xlSortOnValues                | 2010 2016
      *                         BY NAME Order = xlDescending                   | 2010 2016
      *                         BY NAME DataOption = xlSortNormal              | 2010 2016
      *                         ) GIVING olSortFields2                         | 2010 2016
      *                                                                        | 2010 2016
      *    MOVE "B10"           TO WS-RANGE-1                                  | 2010 2016
      *    MOVE "C13"           TO WS-RANGE-2                                  | 2010 2016
      *    INQUIRE  olWrkSh     @Range(                                        | 2010 2016
      *                         BY NAME Cell1 = WS-RANGE-1                     | 2010 2016
      *                         BY NAME Cell2 = WS-RANGE-2                     | 2010 2016
      *                         ) IN olRangeArea                               | 2010 2016
      *                                                                        | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SetRange(olRangeArea)                   | 2010 2016
      *    MODIFY  olWrkSh      @Sort::Header(xlNo)                            | 2010 2016
      *    MODIFY  olWrkSh      @Sort::MatchCase("False")                      | 2010 2016
      *    MODIFY  olWrkSh      @Sort::Orientation(xlTopToBottom)              | 2010 2016
      *    MODIFY  olWrkSh      @Sort::SortMethod(xlPinYin)                    | 2010 2016
      *    MODIFY  olWrkSh      @Sort::Apply()                                 | 2010 2016
      *                                                                        | 2010 2016
      *    DESTROY olRangeKey1 olRangeKey2 olRangeArea                         | 2010 2016
      *    DESTROY olSortFields1 olSortFields2                                 | 2010 2016
      *                                                                        | 2010 2016
******* from MS Excel 2010 - END ****************************************************

            .
*************************************************************************

       new-impl.

******* ActiveSheet.Protect DrawingObjects:=True, Contents:=True, Scenarios:=True
           MODIFY olWrkSh     @Protect(
                               BY NAME Password = NULL
                               BY NAME DrawingObjects = "True"
                               BY NAME Contents = "True"
                               BY NAME Scenarios = "True"
                                       )
            .
*************************************************************************

