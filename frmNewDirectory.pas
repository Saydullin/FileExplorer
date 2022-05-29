unit frmNewDirectory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormNewFolder = class(TForm)
    Label1: TLabel;
    EditPath: TEdit;
    Label2: TLabel;
    EditFolderName: TEdit;
    Label3: TLabel;
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
  FormNewFolder: TFormNewFolder;

implementation

{$R *.dfm}

uses
  System.IOUtils, uHistoryManager, uTypes;

type
  TException = record
    Code: Integer;
    Desc: String;
  end;

function CreateFolder(Path: String; FolderName: String): TException; stdcall; external 'IOUtilsManager.dll';

procedure SetFolderAttributes(Path: String; cbHidden, cbSystem, cbTemp, cbReadOnly: TCheckBox);
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

    TDirectory.SetAttributes(Path, FileAttributes);
  except
  end;
end;

procedure TFormNewFolder.Button1Click(Sender: TObject);
var
  ECreateFolder: TException;
  Action: TActionItem;
begin
  ECreateFolder := CreateFolder(EditPath.Text, EditFolderName.Text);
  SetFolderAttributes(
    EditPath.Text + EditFolderName.Text,
    cbHidden,
    cbSystem,
    cbTemp,
    cbReadOnly
  );

  if (ECreateFolder.Code = 0) then
  begin
    MessageDlg('Folder created successfully', mtInformation, mbOKCancel, 0);
    Action.Target := EditFolderName.Text;
    Action.Action := 'Created';
    Action.TargetType := 'Directory';
    Action.Path := TPath.Combine(EditPath.Text, EditFolderName.Text);
    Action.Date := DateToStr(Now) + ' ' + TimeToStr(Now);
    AddAction(Action);
    FormNewFolder.Close;
  end
  else
    MessageDlg(ECreateFolder.Desc, mtError, mbOKCancel, 0)
end;

end.


