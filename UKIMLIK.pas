unit UKIMLIK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxExportXLS, frxExportPDF, frxExportImage, frxClass, frxDBSet, DB,
  DBAccess, Ora, MemDS, StdCtrls, ExtCtrls, Grids, DBGrids, cxGraphics,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ValEdit, Buttons, DBCtrls,jpeg,ShellAPI,WinSock,cxgridexportlink,
  dxSkinscxPCPainter, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxImage, cxDBEdit
  ,cxGridStrs,cxFilterConsts,cxFilterControlStrs ,cxEditConsts,
  cxGridPopupMenuConsts;

type
  TForm1 = class(TForm)
    OraQuery1: TOraQuery;
    AKGUN: TOraSession;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxTIFFExport1: TfrxTIFFExport;
    frxBMPExport1: TfrxBMPExport;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
    OraDataSource1: TOraDataSource;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    OraQuery2: TOraQuery;
    OraDataSource2: TOraDataSource;
    cxLookupComboBox1: TcxLookupComboBox;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1SNO: TcxGridDBColumn;
    cxGrid1DBTableView1TC: TcxGridDBColumn;
    cxGrid1DBTableView1ADISOYADI: TcxGridDBColumn;
    cxGrid1DBTableView1TCJPG: TcxGridDBColumn;
    cxGrid1DBTableView1KUR_SIC_NO: TcxGridDBColumn;
    cxGrid1DBTableView1GOREVUNVANI: TcxGridDBColumn;
    cxGrid1DBTableView1NUFUSAKAYITLIOLDUUIL: TcxGridDBColumn;
    cxGrid1DBTableView1NUFUSAKAYITLIOLDUUILE: TcxGridDBColumn;
    cxGrid1DBTableView1CILT: TcxGridDBColumn;
    cxGrid1DBTableView1AILE_SIRA: TcxGridDBColumn;
    cxGrid1DBTableView1SIRA_NO: TcxGridDBColumn;
    cxGrid1DBTableView1BABAADI: TcxGridDBColumn;
    cxGrid1DBTableView1ANNEADI: TcxGridDBColumn;
    cxGrid1DBTableView1DOGUMYERI: TcxGridDBColumn;
    cxGrid1DBTableView1DOG_TAR: TcxGridDBColumn;
    cxGrid1DBTableView1NUSUF_CUZ_SERI_NO: TcxGridDBColumn;
    cxGrid1DBTableView1KAN_GRB: TcxGridDBColumn;
    SaveDialog1: TSaveDialog;
    DBImage1: TcxDBImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cxLookupComboBox1PropertiesEditValueChanged(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function GetIPAddress: String;
    procedure Button4Click(Sender: TObject);
    procedure cxGrid1DBTableView1SNOGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);

  private
    { Private declarations }
    sql:string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.Button1Click(Sender: TObject);
var
I:INTEGER;
kisiler:string;
begin
 kisiler:='';
if RadioGroup1.ItemIndex=0 then
begin
 OraQuery1.Close;
 OraQuery1.SQL.Clear;
 OraQuery1.SQL.Add(SQL);
 OraQuery1.SQL.Add(' ORDER BY G.SIRA_NO') ;
 OraQuery1.Open;

end
else
begin

if Memo1.Lines.count<1 then  exit;

   try
 OraQuery1.Close;
 OraQuery1.SQL.Clear;
 OraQuery1.SQL.Add(SQL);
 OraQuery1.SQL.Add('AND SYSTEM.buyukharfcevir( P.PERSONEL_ADI||'+QuotedStr(' ')+'||P.SOYADI) IN (');
 for I := 0 to Memo1.Lines.Count - 1 do
 begin
 KISILER:=KISILER+'SYSTEM.buyukharfcevir('+QuotedStr(Memo1.Lines[I])+'),';
 end;
  KISILER:=COPY(KISILER,1,LENGTH(KISILER)-1);
  OraQuery1.SQL.Add(KISILER+')') ;
 OraQuery1.SQL.Add(' ORDER BY G.SIRA_NO') ;

 OraQuery1.Open;
   except
    SHowmessage('Hata Olu�tu l�tfen verilerinizi kontrol ediniz');
   end;


end;
 //Memo1.Lines.Text:=OraQuery1.SQL.Text;

end;



procedure TForm1.Button2Click(Sender: TObject);
begin
if SaveDialog1.Execute then
begin
//'xlsx'
ExportGridToExcel(SaveDialog1.FileName ,cxGrid1,true,true,true);
end;

//frxReport1.ShowReport(TRUE);
end;

procedure TForm1.Button3Click(Sender: TObject);
  var
  Bitmap: TBitmap;
  img1  : TBitmap;
  XRect : TRect;
  jpeg: TJPEGImage;
BEGIN
try



OraQuery1.First;
while NOT OraQuery1.Eof do
BEGIN
{DBImage1.Picture.SaveToFile(ExtractFilePath(Application.ExeName)+
        '\'+OraQuery1.FieldByName('TCKIMLIK_NO').AsString+'.jpg');  }
     jpeg := TJPEGImage.Create;
     jpeg.Assign( dbImage1.Picture.Graphic );
     jpeg.SaveToFile( ExtractFilePath(Application.ExeName)+
      '\'+OraQuery1.FieldByName('TC').AsString+'.jpg' );


 OraQuery1.Next;
 END;

    //boyutland�rma
{
    Bitmap := TBitmap.Create;
    Bitmap.Width  := dbImage1.Picture.Width;
    Bitmap.Height := dbImage1.Picture.Height;

    Bitmap.Canvas.Draw(0, 0, dbImage1.Picture.Graphic);

    img1 := TBitmap.Create();
    img1.Height := 200;
    img1.Width := 300;
    XRect := Rect(0, 0, 300, 200);

    img1.Canvas.StretchDraw(XRect,bitmap);

    dbImage1.Picture.Graphic := bitmap; //orijinal resim
    dbImage1.Picture.Bitmap := img1;  //boyutland�r�lm�� hali

     jpeg := TJPEGImage.Create;
     jpeg.Assign( dbImage1.Picture.Bitmap );
     jpeg.SaveToFile( ExtractFilePath(Application.ExeName)+
      '\'+OraQuery1.FieldByName('TCKIMLIK_NO').AsString+'.jpg' );



    Bitmap.Free;
    img1.Free;
    jpeg.free;
    }
  except
    Application.MessageBox('Hata olu�tu','Hata',MB_OK+MB_ICONERROR);
  end;

 end;




procedure TForm1.Button4Click(Sender: TObject);
begin;
end;

procedure TForm1.cxGrid1DBTableView1SNOGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
var
 AFocusedRecordIndex, ARecno: Integer;
begin
  ARecno := TcxGridDBTableView(Sender.GridView).DataController.DataSource.DataSet.RecNo;
  AFocusedRecordIndex :=  TcxGridDBTableView(Sender.GridView).Controller.FocusedRecordIndex;
  AText :=IntToStr(ARecno - AFocusedRecordIndex + ARecordIndex);
end;

procedure TForm1.cxLookupComboBox1PropertiesEditValueChanged(Sender: TObject);
begin
if cxLookupComboBox1.Text='' then exit;

Memo1.Lines.Add(cxLookupComboBox1.EditText)

end;

procedure TForm1.FormCreate(Sender: TObject);
var
u: array[0..127] of Char;
c: array[0..127] of Char;

s: dword;
i:integer;
ip,xip:string;
begin
Left:=0;
Top:=0;
Width:=Screen.Width;
Height:=Screen.Height;
ip:=GetIPAddress;


 if ip='0' then    Application.Terminate;

 xip:='';
 for I := 1 to Length(ip) do
   begin
     xip:=ip[i]+xip;
   end;

   xip:=trim(xip);
  xip:=copy(xip,pos('.',xip),length(xip)-pos('.',xip)+1);
   ip:='';
   for I := 1 to Length(xip) do
   begin
   ip:=xip[i]+ip;
   end;




AKGUN.Close;
AKGUN.Options.Direct:=TRUE;
AKGUN.Server:='10.42.112.3:1521:ORCL';

AKGUN.Username:='HBYS';
AKGUN.Password:='nzz8637cPF00';
AKGUN.Open;

OraQuery2.Open;
sql:=OraQuery1.SQL.Text;


//uses cxEditConsts
cxsetResourceString(@cxSDatePopupToday,'Bug�n');
cxSetResourceString(@cxSDatePopupClear,'Temizle');
cxSetResourceString(@cxSDatePopupNow ,'�imdi');
cxSetResourceString(@ cxSDatePopupOK ,'Tamam');
cxSetResourceString(@cxSMenuItemCaptionCut,'Kes');
  cxSetResourceString(@cxSMenuItemCaptionCopy , '&Kopyala') ;
  cxSetResourceString(@cxSMenuItemCaptionPaste  ,'&Yap��t�r') ;
  cxSetResourceString(@cxSMenuItemCaptionDelete  , '&Sil') ;
  cxSetResourceString(@cxSMenuItemCaptionLoad  , '&Y�kle...') ;
  cxSetResourceString(@cxSMenuItemCaptionSave  ,'Kaydet') ;




 // uses cxGridInplaceEditForm
//cxSetResourceString(@scxGridInplaceEditFormButtonUpdate,'Kaydet');
//cxSetResourceString(@scxGridInplaceEditFormButtonCancel , 'Vazge�');
//scxGridInplaceEditFormButtonUpdate = 'Update';

 cxSetResourceString(@scxGridFilterRowInfoText, 'Filtre olu�turmak i�in buraya t�klay�n.');

// uses cxGridStrs,cxFilterConsts,cxFilterControlStrs ,cxGridPopupMenuConsts

//  scxGridRecursiveLevels = 'You cannot create recursive levels';
  cxSetResourceString(@scxGridRecursiveLevels, 'Yinelemeli seviyeler olu�turamazs�n�z');
//  scxGridDeletingConfirmationCaption = 'Confirm';
//  cxSetResourceString(@scxGridDeletingConfirmationCaption, 'Onayla');
//  scxGridDeletingFocusedConfirmationText = 'Delete record?';
  cxSetResourceString(@scxGridDeletingFocusedConfirmationText, 'Kay�t silinsin mi ?');
//  scxGridDeletingSelectedConfirmationText = 'Delete all selected records?';
  cxSetResourceString(@scxGridDeletingSelectedConfirmationText, 'Se�ili t�m kay�tlar silinsin mi ?');
//  scxGridNoDataInfoText = '<No data to display>';
  cxSetResourceString(@scxGridNoDataInfoText, '<G�sterilecek kay�t yok>');
//  scxGridNewItemRowInfoText = 'Click here to add a new row';
  cxSetResourceString(@scxGridNewItemRowInfoText, 'Yeni sat�r eklemek i�in buraya t�klay�n');
//  scxGridFilterIsEmpty = '<Filter is Empty>';
  cxSetResourceString(@scxGridFilterIsEmpty, '<Filtre bo�>');
//  scxGridCustomizationFormCaption = 'Customization';
  cxSetResourceString(@scxGridCustomizationFormCaption, '�zelle�tirme');
//  scxGridCustomizationFormColumnsPageCaption = 'Columns';
  cxSetResourceString(@scxGridCustomizationFormColumnsPageCaption, 'S�tunlar');
//  scxGridGroupByBoxCaption = 'Drag a column header here to group by that column';
  cxSetResourceString(@scxGridGroupByBoxCaption, 'Gruplamak istedi�iniz kolonu buraya s�r�kleyin');
//  scxGridFilterCustomizeButtonCaption = 'Customize...';
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption, '�zelle�tir');
//  scxGridColumnsQuickCustomizationHint = 'Click here to select visible columns';
  cxSetResourceString(@scxGridColumnsQuickCustomizationHint, 'G�r�n�r s�tunlar� se�mek i�in t�klay�n');
//  scxGridCustomizationFormBandsPageCaption = 'Bands';
  cxSetResourceString(@scxGridCustomizationFormBandsPageCaption, 'Bantlar');
//  scxGridBandsQuickCustomizationHint = 'Click here to select visible bands';
  cxSetResourceString(@scxGridBandsQuickCustomizationHint, 'G�r�n�r bantlar� se�mek i�in t�klay�n');
//  scxGridCustomizationFormRowsPageCaption = 'Rows';
  cxSetResourceString(@scxGridCustomizationFormRowsPageCaption, 'Sat�rlar');
//  scxGridConverterIntermediaryMissing = 'Missing an intermediary component!'#13#10'Please add a %s component to the form.';
  cxSetResourceString(@scxGridConverterIntermediaryMissing, 'Bulunamayan arac� bile�en!'#13#10'L�tfen bir %s bile�eni forma ekleyin.');
//  scxGridConverterNotExistGrid = 'cxGrid does not exist';
  cxSetResourceString(@scxGridConverterNotExistGrid, 'cxGrid yok');
//  scxGridConverterNotExistComponent = 'Component does not exist';
  cxSetResourceString(@scxGridConverterNotExistComponent, 'Bile�en yok');
//  scxImportErrorCaption = 'Import error';
  cxSetResourceString(@scxImportErrorCaption, '��e aktar�m hatas�');
//  scxNotExistGridView = 'Grid view does not exist';
  cxSetResourceString(@scxNotExistGridView, 'Grid g�r�n�m� yok');
//  scxNotExistGridLevel = 'Active grid level does not exist';
  cxSetResourceString(@scxNotExistGridLevel, 'Ge�erli grid seviyesi yok');
//  scxCantCreateExportOutputFile = 'Can''t create the export output file';
  cxSetResourceString(@scxCantCreateExportOutputFile, 'D��a aktar�lacak dosya olu�turulam�yor');
//  cxSEditRepositoryExtLookupComboBoxItem = 'ExtLookupComboBox|Represents an ultra-advanced lookup using the QuantumGrid as its drop down control';
//  scxGridChartValueHintFormat = '%s for %s is %s'; // series display text, category, value

{********************************************************************}
{cxFilterConsts                                                      }
{********************************************************************}

//  // base operators
//  cxSFilterOperatorEqual = 'equals';
  cxSetResourceString(@cxSFilterOperatorEqual, 'e�it');
//  cxSFilterOperatorNotEqual = 'does not equal';
  cxSetResourceString(@cxSFilterOperatorNotEqual, 'e�it de�il');
//  cxSFilterOperatorLess = 'is less than';
  cxSetResourceString(@cxSFilterOperatorLess, 'k���k');
//  cxSFilterOperatorLessEqual = 'is less than or equal to';
  cxSetResourceString(@cxSFilterOperatorLessEqual, 'k���k veya e�it');
//  cxSFilterOperatorGreater = 'is greater than';
  cxSetResourceString(@cxSFilterOperatorGreater, 'b�y�k');
//  cxSFilterOperatorGreaterEqual = 'is greater than or equal to';
  cxSetResourceString(@cxSFilterOperatorGreaterEqual, 'b�y�k veya e�it');
//  cxSFilterOperatorLike = 'like';
  cxSetResourceString(@cxSFilterOperatorLike, 'i�erir');
//  cxSFilterOperatorNotLike = 'not like';
  cxSetResourceString(@cxSFilterOperatorNotLike, 'i�ermez');
//  cxSFilterOperatorBetween = 'between';
  cxSetResourceString(@cxSFilterOperatorBetween, 'aras�nda');
//  cxSFilterOperatorNotBetween = 'not between';
  cxSetResourceString(@cxSFilterOperatorNotBetween, 'aras�nda de�il');
//  cxSFilterOperatorInList = 'in';
  cxSetResourceString(@cxSFilterOperatorInList, 'i�inde olan');
//  cxSFilterOperatorNotInList = 'not in';
  cxSetResourceString(@cxSFilterOperatorNotInList, 'i�inde olmayan');
//  cxSFilterOperatorYesterday = 'is yesterday';
  cxSetResourceString(@cxSFilterOperatorYesterday, 'd�n');
//  cxSFilterOperatorToday = 'is today';
  cxSetResourceString(@cxSFilterOperatorToday, 'bug�n');
//  cxSFilterOperatorTomorrow = 'is tomorrow';
  cxSetResourceString(@cxSFilterOperatorTomorrow , 'yar�n');
//  cxSFilterOperatorLastWeek = 'is last week';
  cxSetResourceString(@cxSFilterOperatorLastWeek, 'ge�en hafta');
//  cxSFilterOperatorLastMonth = 'is last month';
  cxSetResourceString(@cxSFilterOperatorLastMonth, 'ge�en ay');
//  cxSFilterOperatorLastYear = 'is last year';
  cxSetResourceString(@cxSFilterOperatorLastYear, 'ge�en sene');
//  cxSFilterOperatorThisWeek = 'is this week';
  cxSetResourceString(@cxSFilterOperatorThisWeek, 'bu hafta');
//  cxSFilterOperatorThisMonth = 'is this month';
  cxSetResourceString(@cxSFilterOperatorThisMonth, 'bu ay');
//  cxSFilterOperatorThisYear = 'is this year';
  cxSetResourceString(@cxSFilterOperatorThisYear, 'bu sene');
//  cxSFilterOperatorNextWeek = 'is next week';
  cxSetResourceString(@cxSFilterOperatorNextWeek, 'gelecek hafta');
//  cxSFilterOperatorNextMonth = 'is next month';
  cxSetResourceString(@cxSFilterOperatorNextMonth, 'gelecek ay');
//  cxSFilterOperatorNextYear = 'is next year';
  cxSetResourceString(@cxSFilterOperatorNextYear, 'gelecek sene');
//  cxSFilterAndCaption = 'and';
  cxSetResourceString(@cxSFilterAndCaption, 've');
//  cxSFilterOrCaption = 'or';
  cxSetResourceString(@cxSFilterOrCaption, 'veya');
//  cxSFilterNotCaption = 'not';
  cxSetResourceString(@cxSFilterNotCaption, 'de�il');
//  cxSFilterBlankCaption = 'blank';
  cxSetResourceString(@cxSFilterBlankCaption, 'bo�');
//  // derived
//  cxSFilterOperatorIsNull = 'is blank';
  cxSetResourceString(@cxSFilterOperatorIsNull, 'bo�luk');
//  cxSFilterOperatorIsNotNull = 'is not blank';
  cxSetResourceString(@cxSFilterOperatorIsNotNull, 'bo�luk de�il');
//  cxSFilterOperatorBeginsWith = 'begins with';
  cxSetResourceString(@cxSFilterOperatorBeginsWith , 'ile ba�layan');
//  cxSFilterOperatorDoesNotBeginWith = 'does not begin with';
  cxSetResourceString(@cxSFilterOperatorDoesNotBeginWith, 'ile ba�lamayan');
//  cxSFilterOperatorEndsWith = 'ends with';
  cxSetResourceString(@cxSFilterOperatorEndsWith, 'ile biten');
//  cxSFilterOperatorDoesNotEndWith = 'does not end with';
  cxSetResourceString(@cxSFilterOperatorDoesNotEndWith, 'ile bitmeyen');
//  cxSFilterOperatorContains = 'contains';
  cxSetResourceString(@cxSFilterOperatorContains, 'i�eren');
//  cxSFilterOperatorDoesNotContain = 'does not contain';
  cxSetResourceString(@cxSFilterOperatorDoesNotContain, 'i�ermeyen');
//  // filter listbox's values
//  cxSFilterBoxAllCaption = '(All)';
  cxSetResourceString(@cxSFilterBoxAllCaption, 'Hepsi');
//  cxSFilterBoxCustomCaption = '(Custom...)';
  cxSetResourceString(@cxSFilterBoxCustomCaption, '�zel...');
//  cxSFilterBoxBlanksCaption = '(Blanks)';
  cxSetResourceString(@cxSFilterBoxBlanksCaption, '(Bo� olanlar)');
//  cxSFilterBoxNonBlanksCaption = '(NonBlanks)';
  cxSetResourceString(@cxSFilterBoxNonBlanksCaption, '(Bo� olmayanlar)');

{********************************************************************}
{cxFilterControlStrs                                                 }
{********************************************************************}

//  // cxFilterBoolOperator
//  cxSFilterBoolOperatorAnd = 'AND';        // all
  cxSetResourceString(@cxSFilterBoolOperatorAnd, 'VE');
//  cxSFilterBoolOperatorOr = 'OR';          // any
  cxSetResourceString(@cxSFilterBoolOperatorOr, 'VEYA');
//  cxSFilterBoolOperatorNotAnd = 'NOT AND'; // not all
  cxSetResourceString(@cxSFilterBoolOperatorNotAnd, 'VE DE��L');
//  cxSFilterBoolOperatorNotOr = 'NOT OR';   // not any
  cxSetResourceString(@cxSFilterBoolOperatorNotOr, 'VEYA DE��L');
//  //
//  cxSFilterRootButtonCaption = 'Filter';
  cxSetResourceString(@cxSFilterRootButtonCaption, 'Filtre');
//  cxSFilterAddCondition = 'Add &Condition';
  cxSetResourceString(@cxSFilterAddCondition, '&Ko�ul ekle');
//  cxSFilterAddGroup = 'Add &Group';
  cxSetResourceString(@cxSFilterAddGroup, '&Grup ekle');
//  cxSFilterRemoveRow = '&Remove Row';
  cxSetResourceString(@cxSFilterRemoveRow, '&Sat�r kald�r');
//  cxSFilterClearAll = 'Clear &All';
  cxSetResourceString(@cxSFilterClearAll, 'Hepsini &temizle');
//  cxSFilterFooterAddCondition = 'press the button to add a new condition';
  cxSetResourceString(@cxSFilterFooterAddCondition, 'yeni ko�ul eklemek i�in tu�a bas�n');
//  cxSFilterGroupCaption = 'applies to the following conditions';
  cxSetResourceString(@cxSFilterGroupCaption, 'a�a��daki ko�ullar� uygulay�n');
//  cxSFilterRootGroupCaption = '<root>';
  cxSetResourceString(@cxSFilterRootGroupCaption, '<k�k>');
//  cxSFilterControlNullString = '<empty>';
  cxSetResourceString(@cxSFilterControlNullString, '<bo�>');
//  cxSFilterErrorBuilding = 'Can''t build filter from source';
  cxSetResourceString(@cxSFilterErrorBuilding, 'Kaynaktan filtrelenemiyor');
//  //FilterDialog
//  cxSFilterDialogCaption = 'Custom Filter';
  cxSetResourceString(@cxSFilterDialogCaption, '�zel filtre');
//  cxSFilterDialogInvalidValue = 'Invalid value';
  cxSetResourceString(@cxSFilterDialogInvalidValue, 'Ge�ersiz de�er');
//  cxSFilterDialogUse = 'Use';
  cxSetResourceString(@cxSFilterDialogUse, 'Kullan');
//  cxSFilterDialogSingleCharacter = 'to represent any single character';
  cxSetResourceString(@cxSFilterDialogSingleCharacter, 'tek karakteri temsil etmek i�in');
//  cxSFilterDialogCharactersSeries = 'to represent any series of characters';
  cxSetResourceString(@cxSFilterDialogCharactersSeries, 'pe� pe�e karakterleri temsil etmek i�in');
//  cxSFilterDialogOperationAnd = 'AND';
  cxSetResourceString(@cxSFilterDialogOperationAnd, 'VE');
//  cxSFilterDialogOperationOr = 'OR';
  cxSetResourceString(@cxSFilterDialogOperationOr, 'VEYA');
//  cxSFilterDialogRows = 'Show rows where:';
  cxSetResourceString(@cxSFilterDialogRows, 'Sat�rlar� goster');
//
//  // FilterControlDialog
//  cxSFilterControlDialogCaption = 'Filter builder';
  cxSetResourceString(@cxSFilterControlDialogCaption, 'Filtre haz�rlay�c�');
//  cxSFilterControlDialogNewFile = 'untitled.flt';
  cxSetResourceString(@cxSFilterControlDialogNewFile, 'isimsiz.flt');
//  cxSFilterControlDialogOpenDialogCaption = 'Open an existing filter';
  cxSetResourceString(@cxSFilterControlDialogOpenDialogCaption, 'Filtre a�');
//  cxSFilterControlDialogSaveDialogCaption = 'Save the active filter to file';
  cxSetResourceString(@cxSFilterControlDialogSaveDialogCaption, 'Ge�erli filtreyi kaydet');
//  cxSFilterControlDialogActionSaveCaption = '&Save As...';
  cxSetResourceString(@cxSFilterControlDialogActionSaveCaption, '&Farkl� kaydet');
//  cxSFilterControlDialogActionOpenCaption = '&Open...';
  cxSetResourceString(@cxSFilterControlDialogActionOpenCaption, '&A�...');
//  cxSFilterControlDialogActionApplyCaption = '&Apply';
  cxSetResourceString(@cxSFilterControlDialogActionApplyCaption, '&Uygula');
//  cxSFilterControlDialogActionOkCaption = 'OK';
  cxSetResourceString(@cxSFilterControlDialogActionOkCaption, 'Tamam');
//  cxSFilterControlDialogActionCancelCaption = 'Cancel';
  cxSetResourceString(@cxSFilterControlDialogActionCancelCaption, '�ptal');
//  cxSFilterControlDialogFileExt = 'flt';
//  cxSFilterControlDialogFileFilter = 'Filters (*.flt)|*.flt';
  cxSetResourceString(@cxSFilterControlDialogFileFilter, 'Filtreler (*.flt)|*.flt');


    // uses cxGridPopupMenuConsts
  cxSetResourceString(@cxSGridNone ,'Yok'); //'None';
  cxSetResourceString(@cxSGridSortColumnAsc ,'Artan S�ralama'); //'Sort Ascending';
  cxSetResourceString(@cxSGridSortColumnDesc ,'Azalan S�ralama'); //'Sort Descending';
  cxSetResourceString(@cxSGridClearSorting ,'S�ralamay� Sil'); //'Clear Sorting';
  cxSetResourceString(@cxSGridGroupByThisField ,'Bu Alana G�re Grupla'); //'Group By This Field';
  cxSetResourceString(@cxSGridRemoveThisGroupItem ,'Gruplamay� Sil'); //'Remove from grouping';
  cxSetResourceString(@cxSGridGroupByBox ,'Gruplama Kutusu'); //'Group By Box';
  cxSetResourceString(@cxSGridAlignmentSubMenu ,'Hizalama'); //'Alignment';
  cxSetResourceString(@cxSGridAlignLeft ,'Sola Hizala'); //'Align Left';
  cxSetResourceString(@cxSGridAlignRight ,'Sa�a Hizala'); //'Align Right';
  cxSetResourceString(@cxSGridAlignCenter ,'Ortal� Hizala'); //'Align Center';
  cxSetResourceString(@cxSGridRemoveColumn ,'Sutunu Sil'); //'Remove This Column';
  cxSetResourceString(@cxSGridFieldChooser ,'Alan Se�i�i'); //'Field Chooser';
  cxSetResourceString(@cxSGridBestFit , 'En Uygun B�y�kl�k'); //'Best Fit';
  cxSetResourceString(@cxSGridBestFitAllColumns , 'En Uygun B�y�kl�k(B�t�n Sutunlar)'); //'Best Fit (all columns)';
  cxSetResourceString(@cxSGridShowFooter , 'Alt'); //'Footer';
  cxSetResourceString(@cxSGridShowGroupFooter ,'Grup Alt'); //'Group Footers';
  cxSetResourceString(@cxSGridSumMenuItem ,'Toplam'); //'Sum';
  cxSetResourceString(@cxSGridMinMenuItem ,'Minimum'); //'Min';
  cxSetResourceString(@cxSGridMaxMenuItem ,'Maximum'); //'Max';
  cxSetResourceString(@cxSGridCountMenuItem ,'Adet'); //'Count';
  cxSetResourceString(@cxSGridAvgMenuItem ,'Avaraj'); //'Average';
  cxSetResourceString(@cxSGridNoneMenuItem ,'Yok'); //'None';



end;

function TForm1.GetIPAddress: String;
type
  pu_long = ^u_long;
var
  varTWSAData : TWSAData;
  varPHostEnt : PHostEnt;
  varTInAddr : TInAddr;
  namebuf : Array[0..255] of char;

begin
  If WSAStartup($101,varTWSAData) <> 0 Then
  Result := '0'
  Else Begin
    gethostname(namebuf,sizeof(namebuf));
    varPHostEnt := gethostbyname(namebuf);
    varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
    Result := inet_ntoa(varTInAddr);
  End;
  WSACleanup;

end;

end.
