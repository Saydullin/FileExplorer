unit frmSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSearch = class(TForm)
    LabelTitle: TLabel;
    EditSearchFile: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Search: TSearch;

implementation

uses
  uIOUtils;

{$R *.dfm}

procedure TSearch.Button1Click(Sender: TObject);
var
  ResSearch: TStringList;
begin
  ResSearch := SearchFile(EditSearchFile.Text, 'C:\\');
  LabelTitle.Caption := IntToStr(ResSearch.Count);
end;

end.
