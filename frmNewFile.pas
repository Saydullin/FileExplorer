unit frmNewFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormNewFile = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditPath: TEdit;
    EditFileName: TEdit;
    Button1: TButton;
    cbHidden: TCheckBox;
    cbSystem: TCheckBox;
    cbTemp: TCheckBox;
    cbReadOnly: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNewFile: TFormNewFile;

implementation

{$R *.dfm}

uses
  System.IOUtils, uHistoryManager, uTypes, DateUtils;

type
  TException = record
    Code: Integer;
    Desc: String;
  end;

function CreateFile(Path: String; FileName: String): TException; stdcall; external 'IOUtilsManager.dll';

procedure SetFileAttributes(Path: String; cbHidden, cbSystem, cbTemp, cbReadOnly: TCheckBox);
var
  FileAttributes: TFileAttributes;
begin
  try
    if cbReadOnly.Checked then
      Include(FileAttributes, TFileAttribute.faReadOnly);

    if cbHidden.Checked then
      Include(FileAttributes, TFileAttribute.faHidden);

    if cbSystem.Checked then
      Include(FileAttributes, TFileAttribute.faSystem);

    if cbTemp.Checked then
      Include(FileAttributes, TFileAttribute.faTemporary);

    TFile.SetAttributes(Path, FileAttributes);
  except
  end;
end;

procedure TFormNewFile.Button1Click(Sender: TObject);
var
  ECreateFolder: TException;
  Action: TActionItem;
begin
  ECreateFolder := CreateFile(EditPath.Text, EditFileName.Text);
  SetFileAttributes(
    EditPath.Text + EditFileName.Text,
    cbHidden,
    cbSystem,
    cbTemp,
    cbReadOnly
  );

  if (ECreateFolder.Code = 0) then
  begin
    MessageDlg('File created successfully', mtInformation, mbOKCancel, 0);
    Action.Target := EditFileName.Text;
    Action.Action := 'Created';
    Action.TargetType := 'File';
    Action.Path := TPath.Combine(EditPath.Text, EditFileName.Text);
    Action.Date := DateToStr(Now) + ' ' + TimeToStr(Now);
    AddAction(Action);
    FormNewFile.Close;
  end
  else
    MessageDlg(ECreateFolder.Desc, mtError, mbOKCancel, 0);
end;

end.
