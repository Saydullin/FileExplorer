program Project15;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form3},
  uRouter in 'uRouter.pas',
  Info in 'Info.pas' {Form1},
  NewDirectory in 'NewDirectory.pas' {FormNewFolder},
  NewFile in 'NewFile.pas' {FormNewFile},
  uSort in 'uSort.pas',
  uIOUtils in 'uIOUtils.pas',
  uTypes in 'uTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormNewFolder, FormNewFolder);
  Application.CreateForm(TFormNewFile, FormNewFile);
  Application.Run;
end.
