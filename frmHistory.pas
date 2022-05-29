unit frmHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus;

type
  THistory = class(TForm)
    lvHistory: TListView;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Clear1: TMenuItem;
    Update1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Update1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshList();
  end;

var
  History: THistory;

implementation

uses
  uHistoryManager, uTypes;

{$R *.dfm}

procedure FillHistoryList(lvHistory: TListView; HistoryData: TAHistory);
var
  HistoryItem: TActionHistory;
  lvItem: TListItem;
begin
  lvHistory.Clear;
  HistoryItem := HistoryData.First;

  while (HistoryItem <> nil) do
  begin
    lvItem := lvHistory.Items.Add;
    lvItem.Caption := HistoryItem.Data.Target;
    lvItem.SubItems.Add(HistoryItem.Data.Action);
    lvItem.SubItems.Add(HistoryItem.Data.TargetType);
    lvItem.SubItems.Add(HistoryItem.Data.Path);
    lvItem.SubItems.Add(HistoryItem.Data.Date);
    HistoryItem := HistoryItem.Next;
  end;

end;

procedure THistory.RefreshList();
var
  HistoryData: TAHistory;
begin
  HistoryData := GetHistoryActions();
  FillHistoryList(lvHistory, HistoryData);
end;

procedure THistory.Update1Click(Sender: TObject);
var
  Action: TActionItem;
begin
  RefreshList();
end;

procedure THistory.Clear1Click(Sender: TObject);
var
  dlgAnswer: Integer;
begin
  dlgAnswer := MessageDlg(
      'Are you sure you want to delete history?' + #13#10 +
      'The data will not remain in the basket!',
      mtWarning,
      [mbYes, mbNo],
      0
    );

  if (dlgAnswer = mrYes) then
  begin
    ClearFile();
    RefreshList();
  end;

end;

procedure THistory.FormCreate(Sender: TObject);
begin
  RefreshList();
end;

end.
