program Project15;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Form3},
  uRouter in 'uRouter.pas',
  frmInfo in 'frmInfo.pas' {FormInfo},
  frmNewDirectory in 'frmNewDirectory.pas' {FormNewFolder},
  frmNewFile in 'frmNewFile.pas' {FormNewFile},
  uSort in 'uSort.pas',
  uIOUtils in 'uIOUtils.pas',
  uTypes in 'uTypes.pas',
  frmHistory in 'frmHistory.pas' {History},
  uHistoryManager in 'uHistoryManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TFormInfo, FormInfo);
  Application.CreateForm(TFormNewFolder, FormNewFolder);
  Application.CreateForm(TFormNewFile, FormNewFile);
  Application.CreateForm(THistory, History);
  Application.Run;
end.
