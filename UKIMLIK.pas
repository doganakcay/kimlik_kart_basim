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
    SHowmessage('Hata Oluþtu lütfen verilerinizi kontrol ediniz');
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

    //boyutlandýrma
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
    dbImage1.Picture.Bitmap := img1;  //boyutlandýrýlmýþ hali

     jpeg := TJPEGImage.Create;
     jpeg.Assign( dbImage1.Picture.Bitmap );
     jpeg.SaveToFile( ExtractFilePath(Application.ExeName)+
      '\'+OraQuery1.FieldByName('TCKIMLIK_NO').AsString+'.jpg' );



    Bitmap.Free;
    img1.Free;
    jpeg.free;
    }
  except
    Application.MessageBox('Hata oluþtu','Hata',MB_OK+MB_ICONERROR);
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
cxsetResourceString(@cxSDatePopupToday,'Bugün');
cxSetResourceString(@cxSDatePopupClear,'Temizle');
cxSetResourceString(@cxSDatePopupNow ,'Þimdi');
cxSetResourceString(@ cxSDatePopupOK ,'Tamam');
cxSetResourceString(@cxSMenuItemCaptionCut,'Kes');
  cxSetResourceString(@cxSMenuItemCaptionCopy , '&Kopyala') ;
  cxSetResourceString(@cxSMenuItemCaptionPaste  ,'&Yapýþtýr') ;
  cxSetResourceString(@cxSMenuItemCaptionDelete  , '&Sil') ;
  cxSetResourceString(@cxSMenuItemCaptionLoad  , '&Yükle...') ;
  cxSetResourceString(@cxSMenuItemCaptionSave  ,'Kaydet') ;




 // uses cxGridInplaceEditForm
//cxSetResourceString(@scxGridInplaceEditFormButtonUpdate,'Kaydet');
//cxSetResourceString(@scxGridInplaceEditFormButtonCancel , 'Vazgeç');
//scxGridInplaceEditFormButtonUpdate = 'Update';

 cxSetResourceString(@scxGridFilterRowInfoText, 'Filtre oluþturmak için buraya týklayýn.');

// uses cxGridStrs,cxFilterConsts,cxFilterControlStrs ,cxGridPopupMenuConsts

//  scxGridRecursiveLevels = 'You cannot create recursive levels';
  cxSetResourceString(@scxGridRecursiveLevels, 'Yinelemeli seviyeler oluþturamazsýnýz');
//  scxGridDeletingConfirmationCaption = 'Confirm';
//  cxSetResourceString(@scxGridDeletingConfirmationCaption, 'Onayla');
//  scxGridDeletingFocusedConfirmationText = 'Delete record?';
  cxSetResourceString(@scxGridDeletingFocusedConfirmationText, 'Kayýt silinsin mi ?');
//  scxGridDeletingSelectedConfirmationText = 'Delete all selected records?';
  cxSetResourceString(@scxGridDeletingSelectedConfirmationText, 'Seçili tüm kayýtlar silinsin mi ?');
//  scxGridNoDataInfoText = '<No data to display>';
  cxSetResourceString(@scxGridNoDataInfoText, '<Gösterilecek kayýt yok>');
//  scxGridNewItemRowInfoText = 'Click here to add a new row';
  cxSetResourceString(@scxGridNewItemRowInfoText, 'Yeni satýr eklemek için buraya týklayýn');
//  scxGridFilterIsEmpty = '<Filter is Empty>';
  cxSetResourceString(@scxGridFilterIsEmpty, '<Filtre boþ>');
//  scxGridCustomizationFormCaption = 'Customization';
  cxSetResourceString(@scxGridCustomizationFormCaption, 'Özelleþtirme');
//  scxGridCustomizationFormColumnsPageCaption = 'Columns';
  cxSetResourceString(@scxGridCustomizationFormColumnsPageCaption, 'Sütunlar');
//  scxGridGroupByBoxCaption = 'Drag a column header here to group by that column';
  cxSetResourceString(@scxGridGroupByBoxCaption, 'Gruplamak istediðiniz kolonu buraya sürükleyin');
//  scxGridFilterCustomizeButtonCaption = 'Customize...';
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption, 'Özelleþtir');
//  scxGridColumnsQuickCustomizationHint = 'Click here to select visible columns';
  cxSetResourceString(@scxGridColumnsQuickCustomizationHint, 'Görünür sütunlarý seçmek için týklayýn');
//  scxGridCustomizationFormBandsPageCaption = 'Bands';
  cxSetResourceString(@scxGridCustomizationFormBandsPageCaption, 'Bantlar');
//  scxGridBandsQuickCustomizationHint = 'Click here to select visible bands';
  cxSetResourceString(@scxGridBandsQuickCustomizationHint, 'Görünür bantlarý seçmek için týklayýn');
//  scxGridCustomizationFormRowsPageCaption = 'Rows';
  cxSetResourceString(@scxGridCustomizationFormRowsPageCaption, 'Satýrlar');
//  scxGridConverterIntermediaryMissing = 'Missing an intermediary component!'#13#10'Please add a %s component to the form.';
  cxSetResourceString(@scxGridConverterIntermediaryMissing, 'Bulunamayan aracý bileþen!'#13#10'Lütfen bir %s bileþeni forma ekleyin.');
//  scxGridConverterNotExistGrid = 'cxGrid does not exist';
  cxSetResourceString(@scxGridConverterNotExistGrid, 'cxGrid yok');
//  scxGridConverterNotExistComponent = 'Component does not exist';
  cxSetResourceString(@scxGridConverterNotExistComponent, 'Bileþen yok');
//  scxImportErrorCaption = 'Import error';
  cxSetResourceString(@scxImportErrorCaption, 'Ýçe aktarým hatasý');
//  scxNotExistGridView = 'Grid view does not exist';
  cxSetResourceString(@scxNotExistGridView, 'Grid görünümü yok');
//  scxNotExistGridLevel = 'Active grid level does not exist';
  cxSetResourceString(@scxNotExistGridLevel, 'Geçerli grid seviyesi yok');
//  scxCantCreateExportOutputFile = 'Can''t create the export output file';
  cxSetResourceString(@scxCantCreateExportOutputFile, 'Dýþa aktarýlacak dosya oluþturulamýyor');
//  cxSEditRepositoryExtLookupComboBoxItem = 'ExtLookupComboBox|Represents an ultra-advanced lookup using the QuantumGrid as its drop down control';
//  scxGridChartValueHintFormat = '%s for %s is %s'; // series display text, category, value

{********************************************************************}
{cxFilterConsts                                                      }
{********************************************************************}

//  // base operators
//  cxSFilterOperatorEqual = 'equals';
  cxSetResourceString(@cxSFilterOperatorEqual, 'eþit');
//  cxSFilterOperatorNotEqual = 'does not equal';
  cxSetResourceString(@cxSFilterOperatorNotEqual, 'eþit deðil');
//  cxSFilterOperatorLess = 'is less than';
  cxSetResourceString(@cxSFilterOperatorLess, 'küçük');
//  cxSFilterOperatorLessEqual = 'is less than or equal to';
  cxSetResourceString(@cxSFilterOperatorLessEqual, 'küçük veya eþit');
//  cxSFilterOperatorGreater = 'is greater than';
  cxSetResourceString(@cxSFilterOperatorGreater, 'büyük');
//  cxSFilterOperatorGreaterEqual = 'is greater than or equal to';
  cxSetResourceString(@cxSFilterOperatorGreaterEqual, 'büyük veya eþit');
//  cxSFilterOperatorLike = 'like';
  cxSetResourceString(@cxSFilterOperatorLike, 'içerir');
//  cxSFilterOperatorNotLike = 'not like';
  cxSetResourceString(@cxSFilterOperatorNotLike, 'içermez');
//  cxSFilterOperatorBetween = 'between';
  cxSetResourceString(@cxSFilterOperatorBetween, 'arasýnda');
//  cxSFilterOperatorNotBetween = 'not between';
  cxSetResourceString(@cxSFilterOperatorNotBetween, 'arasýnda deðil');
//  cxSFilterOperatorInList = 'in';
  cxSetResourceString(@cxSFilterOperatorInList, 'içinde olan');
//  cxSFilterOperatorNotInList = 'not in';
  cxSetResourceString(@cxSFilterOperatorNotInList, 'içinde olmayan');
//  cxSFilterOperatorYesterday = 'is yesterday';
  cxSetResourceString(@cxSFilterOperatorYesterday, 'dün');
//  cxSFilterOperatorToday = 'is today';
  cxSetResourceString(@cxSFilterOperatorToday, 'bugün');
//  cxSFilterOperatorTomorrow = 'is tomorrow';
  cxSetResourceString(@cxSFilterOperatorTomorrow , 'yarýn');
//  cxSFilterOperatorLastWeek = 'is last week';
  cxSetResourceString(@cxSFilterOperatorLastWeek, 'geçen hafta');
//  cxSFilterOperatorLastMonth = 'is last month';
  cxSetResourceString(@cxSFilterOperatorLastMonth, 'geçen ay');
//  cxSFilterOperatorLastYear = 'is last year';
  cxSetResourceString(@cxSFilterOperatorLastYear, 'geçen sene');
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
  cxSetResourceString(@cxSFilterNotCaption, 'deðil');
//  cxSFilterBlankCaption = 'blank';
  cxSetResourceString(@cxSFilterBlankCaption, 'boþ');
//  // derived
//  cxSFilterOperatorIsNull = 'is blank';
  cxSetResourceString(@cxSFilterOperatorIsNull, 'boþluk');
//  cxSFilterOperatorIsNotNull = 'is not blank';
  cxSetResourceString(@cxSFilterOperatorIsNotNull, 'boþluk deðil');
//  cxSFilterOperatorBeginsWith = 'begins with';
  cxSetResourceString(@cxSFilterOperatorBeginsWith , 'ile baþlayan');
//  cxSFilterOperatorDoesNotBeginWith = 'does not begin with';
  cxSetResourceString(@cxSFilterOperatorDoesNotBeginWith, 'ile baþlamayan');
//  cxSFilterOperatorEndsWith = 'ends with';
  cxSetResourceString(@cxSFilterOperatorEndsWith, 'ile biten');
//  cxSFilterOperatorDoesNotEndWith = 'does not end with';
  cxSetResourceString(@cxSFilterOperatorDoesNotEndWith, 'ile bitmeyen');
//  cxSFilterOperatorContains = 'contains';
  cxSetResourceString(@cxSFilterOperatorContains, 'içeren');
//  cxSFilterOperatorDoesNotContain = 'does not contain';
  cxSetResourceString(@cxSFilterOperatorDoesNotContain, 'içermeyen');
//  // filter listbox's values
//  cxSFilterBoxAllCaption = '(All)';
  cxSetResourceString(@cxSFilterBoxAllCaption, 'Hepsi');
//  cxSFilterBoxCustomCaption = '(Custom...)';
  cxSetResourceString(@cxSFilterBoxCustomCaption, 'Özel...');
//  cxSFilterBoxBlanksCaption = '(Blanks)';
  cxSetResourceString(@cxSFilterBoxBlanksCaption, '(Boþ olanlar)');
//  cxSFilterBoxNonBlanksCaption = '(NonBlanks)';
  cxSetResourceString(@cxSFilterBoxNonBlanksCaption, '(Boþ olmayanlar)');

{********************************************************************}
{cxFilterControlStrs                                                 }
{********************************************************************}

//  // cxFilterBoolOperator
//  cxSFilterBoolOperatorAnd = 'AND';        // all
  cxSetResourceString(@cxSFilterBoolOperatorAnd, 'VE');
//  cxSFilterBoolOperatorOr = 'OR';          // any
  cxSetResourceString(@cxSFilterBoolOperatorOr, 'VEYA');
//  cxSFilterBoolOperatorNotAnd = 'NOT AND'; // not all
  cxSetResourceString(@cxSFilterBoolOperatorNotAnd, 'VE DEÐÝL');
//  cxSFilterBoolOperatorNotOr = 'NOT OR';   // not any
  cxSetResourceString(@cxSFilterBoolOperatorNotOr, 'VEYA DEÐÝL');
//  //
//  cxSFilterRootButtonCaption = 'Filter';
  cxSetResourceString(@cxSFilterRootButtonCaption, 'Filtre');
//  cxSFilterAddCondition = 'Add &Condition';
  cxSetResourceString(@cxSFilterAddCondition, '&Koþul ekle');
//  cxSFilterAddGroup = 'Add &Group';
  cxSetResourceString(@cxSFilterAddGroup, '&Grup ekle');
//  cxSFilterRemoveRow = '&Remove Row';
  cxSetResourceString(@cxSFilterRemoveRow, '&Satýr kaldýr');
//  cxSFilterClearAll = 'Clear &All';
  cxSetResourceString(@cxSFilterClearAll, 'Hepsini &temizle');
//  cxSFilterFooterAddCondition = 'press the button to add a new condition';
  cxSetResourceString(@cxSFilterFooterAddCondition, 'yeni koþul eklemek için tuþa basýn');
//  cxSFilterGroupCaption = 'applies to the following conditions';
  cxSetResourceString(@cxSFilterGroupCaption, 'aþaðýdaki koþullarý uygulayýn');
//  cxSFilterRootGroupCaption = '<root>';
  cxSetResourceString(@cxSFilterRootGroupCaption, '<kök>');
//  cxSFilterControlNullString = '<empty>';
  cxSetResourceString(@cxSFilterControlNullString, '<boþ>');
//  cxSFilterErrorBuilding = 'Can''t build filter from source';
  cxSetResourceString(@cxSFilterErrorBuilding, 'Kaynaktan filtrelenemiyor');
//  //FilterDialog
//  cxSFilterDialogCaption = 'Custom Filter';
  cxSetResourceString(@cxSFilterDialogCaption, 'Özel filtre');
//  cxSFilterDialogInvalidValue = 'Invalid value';
  cxSetResourceString(@cxSFilterDialogInvalidValue, 'Geçersiz deðer');
//  cxSFilterDialogUse = 'Use';
  cxSetResourceString(@cxSFilterDialogUse, 'Kullan');
//  cxSFilterDialogSingleCharacter = 'to represent any single character';
  cxSetResourceString(@cxSFilterDialogSingleCharacter, 'tek karakteri temsil etmek için');
//  cxSFilterDialogCharactersSeries = 'to represent any series of characters';
  cxSetResourceString(@cxSFilterDialogCharactersSeries, 'peþ peþe karakterleri temsil etmek için');
//  cxSFilterDialogOperationAnd = 'AND';
  cxSetResourceString(@cxSFilterDialogOperationAnd, 'VE');
//  cxSFilterDialogOperationOr = 'OR';
  cxSetResourceString(@cxSFilterDialogOperationOr, 'VEYA');
//  cxSFilterDialogRows = 'Show rows where:';
  cxSetResourceString(@cxSFilterDialogRows, 'Satýrlarý goster');
//
//  // FilterControlDialog
//  cxSFilterControlDialogCaption = 'Filter builder';
  cxSetResourceString(@cxSFilterControlDialogCaption, 'Filtre hazýrlayýcý');
//  cxSFilterControlDialogNewFile = 'untitled.flt';
  cxSetResourceString(@cxSFilterControlDialogNewFile, 'isimsiz.flt');
//  cxSFilterControlDialogOpenDialogCaption = 'Open an existing filter';
  cxSetResourceString(@cxSFilterControlDialogOpenDialogCaption, 'Filtre aç');
//  cxSFilterControlDialogSaveDialogCaption = 'Save the active filter to file';
  cxSetResourceString(@cxSFilterControlDialogSaveDialogCaption, 'Geçerli filtreyi kaydet');
//  cxSFilterControlDialogActionSaveCaption = '&Save As...';
  cxSetResourceString(@cxSFilterControlDialogActionSaveCaption, '&Farklý kaydet');
//  cxSFilterControlDialogActionOpenCaption = '&Open...';
  cxSetResourceString(@cxSFilterControlDialogActionOpenCaption, '&Aç...');
//  cxSFilterControlDialogActionApplyCaption = '&Apply';
  cxSetResourceString(@cxSFilterControlDialogActionApplyCaption, '&Uygula');
//  cxSFilterControlDialogActionOkCaption = 'OK';
  cxSetResourceString(@cxSFilterControlDialogActionOkCaption, 'Tamam');
//  cxSFilterControlDialogActionCancelCaption = 'Cancel';
  cxSetResourceString(@cxSFilterControlDialogActionCancelCaption, 'Ýptal');
//  cxSFilterControlDialogFileExt = 'flt';
//  cxSFilterControlDialogFileFilter = 'Filters (*.flt)|*.flt';
  cxSetResourceString(@cxSFilterControlDialogFileFilter, 'Filtreler (*.flt)|*.flt');


    // uses cxGridPopupMenuConsts
  cxSetResourceString(@cxSGridNone ,'Yok'); //'None';
  cxSetResourceString(@cxSGridSortColumnAsc ,'Artan Sýralama'); //'Sort Ascending';
  cxSetResourceString(@cxSGridSortColumnDesc ,'Azalan Sýralama'); //'Sort Descending';
  cxSetResourceString(@cxSGridClearSorting ,'Sýralamayý Sil'); //'Clear Sorting';
  cxSetResourceString(@cxSGridGroupByThisField ,'Bu Alana Göre Grupla'); //'Group By This Field';
  cxSetResourceString(@cxSGridRemoveThisGroupItem ,'Gruplamayý Sil'); //'Remove from grouping';
  cxSetResourceString(@cxSGridGroupByBox ,'Gruplama Kutusu'); //'Group By Box';
  cxSetResourceString(@cxSGridAlignmentSubMenu ,'Hizalama'); //'Alignment';
  cxSetResourceString(@cxSGridAlignLeft ,'Sola Hizala'); //'Align Left';
  cxSetResourceString(@cxSGridAlignRight ,'Saða Hizala'); //'Align Right';
  cxSetResourceString(@cxSGridAlignCenter ,'Ortalý Hizala'); //'Align Center';
  cxSetResourceString(@cxSGridRemoveColumn ,'Sutunu Sil'); //'Remove This Column';
  cxSetResourceString(@cxSGridFieldChooser ,'Alan Seçiçi'); //'Field Chooser';
  cxSetResourceString(@cxSGridBestFit , 'En Uygun Büyüklük'); //'Best Fit';
  cxSetResourceString(@cxSGridBestFitAllColumns , 'En Uygun Büyüklük(Bütün Sutunlar)'); //'Best Fit (all columns)';
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
