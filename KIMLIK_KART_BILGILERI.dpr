program KIMLIK_KART_BILGILERI;

uses
  Forms,
  UKIMLIK in 'UKIMLIK.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Yeni Kimlik kartlarý';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
