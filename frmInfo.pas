unit frmInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi;

type
  TFormInfo = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lkGithub: TLinkLabel;
    Label5: TLabel;
    LinkLabel2: TLinkLabel;
    procedure lkGithubClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInfo: TFormInfo;

implementation

{$R *.dfm}

procedure TFormInfo.lkGithubClick(Sender: TObject);
var
  GitHubLink: string;
begin
  GitHubLink := 'https://github.com/Saydullin/FileExplorer/';
  ShellExecute(Application.Handle, 'open', PChar(GitHubLink),
   nil, nil, SW_SHOW);
end;

end.
