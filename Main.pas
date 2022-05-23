unit Main;

interface

uses
  StrUtils, System.IOUtils, ShellApi, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.ButtonGroup, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Buttons,
  Vcl.FileCtrl;

type
  TForm3 = class(TForm)
    LabelTitle: TLabel;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    lvFilesPrint: TListView;
    ButtonSearch: TButton;
    ImageList1: TImageList;
    ButtonRouterLeft: TSpeedButton;
    ButtonRouterRight: TSpeedButton;
    ButtonCreateFile: TSpeedButton;
    ButtonDelete: TSpeedButton;
    ButtonRefreshPage: TSpeedButton;
    ButtonCreateFolder: TSpeedButton;
    ComboBoxFilter: TComboBox;
    ComboBoxSearch: TComboBox;
    lvFileInfo: TListView;
    LabelFilesInfo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure ButtonRouterLeftClick(Sender: TObject);
    procedure lvFIlesPrintDblClick(Sender: TObject);
    procedure ComboBoxFilterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBoxSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonRouterRightClick(Sender: TObject);
    procedure lvFIlesPrintColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvFIlesPrintSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ButtonCreateFolderClick(Sender: TObject);
    procedure ButtonCreateFileClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonRefreshPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses
  frmNewDirectory, frmNewFile, uIOUtils, uTypes;

type
  TPRouterHistory = ^TRouterHistory;
  TRouterHistory = record
    Path: String;
    Next: TPRouterHistory;
    Prev: TPRouterHistory;
  end;
  TRouter = record
    First: TPRouterHistory;
    Current: TPRouterHistory;
  end;

var
  Router: TRouter;

const
  DEFAULT_PATH = 'C:\\';
  FILTER_FOLDERS_ONLY = 'folders only';
  FILTER_FILES_ONLY = 'files only';

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True;
   ListOfStrings.DelimitedText   := Str;
end;

function GetPrevStep(Path: String): String;
var
  StrArr: Array of String;
  OutPutList: TStringList;
  Index: Integer;
begin
  Index := Pos('\', Path);
  Result := 'C:\\Users\';
  if Index > 0 then
    Result := Copy(Path, 0, Index + 1);
end;

function getNormalizeSize(Bytes: UInt64): String;
begin
  if ((Bytes / 1000 / 1000) > 1000) then
    Result := Format('%.2f', [Bytes / 1000 / 1000 / 1000]) + ' GB'
  else if (Bytes / 1000 > 1000) then
    Result := Format('%.2f', [Bytes / 1000 / 1000]) + ' MB'
  else if (Bytes > 1000) then
    Result := Format('%.2f', [Bytes / 1000]) + ' KB'
  else
    Result := IntToStr(BYTES) + ' B';
end;

function IsInArray(Target: String; StrArray: Array of String): Boolean;
var
  IsExist: Boolean;
  I: Integer;
begin
  IsExist := False;
  for I := 0 to Length(StrArray) - 1 do
  begin
    if (StrArray[I] = Target) then
      IsExist := True;
    if (IsExist) then
      break;
  end;

  Result := IsExist;
end;

procedure SetComboboxValues(List: TStringList; ComboBox: TComboBox);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do
    ComboBox.Items.Add(List[I]);
end;

procedure ResetComboBox(ComboBox: TComboBox; DefItems: Array of String);
var
  I: Integer;
begin
  if (Length(DefItems) = 0) then Exit;

  for I := 0 to Length(DefItems) - 1 do
    ComboBox.Items.Add(DefItems[I]);
  ComboBox.Text := DefItems[0];
end;

procedure ShowCatalog(List: TListView; Path: String; cbFilter, cbSearch: TComboBox);
var
  Itm: TListItem;
  SR: TSearchRec;
  FindRes: Integer;
  MyDate: TDateTime;
  Extensions: TStringList;
  Folders: TStringList;
  SearchPath: String;
  IsFilesOnly: Boolean;
  IsFoldersOnly: Boolean;
  ImageIndex: Integer;
  Attrs: TFileAttributes;
begin
  List.Clear;
  Extensions := TStringList.Create;
  Extensions.Sorted := False;
  Extensions.Duplicates := dupIgnore;
  Folders := TStringList.Create;
  Folders.Sorted := False;
  Folders.Duplicates := dupIgnore;
  SearchPath := DEFAULT_PATH;
  IsFilesOnly := True;
  IsFoldersOnly := True;

  if (cbFilter.Text = FILTER_FOLDERS_ONLY) then
    IsFilesOnly := False
  else if (cbFilter.Text = FILTER_FILES_ONLY) then
    IsFoldersOnly := False;

  if (cbFilter.ItemIndex <= 0) or (cbFilter.Text = 'any')
  or Not (IsFilesOnly) or Not (IsFoldersOnly) then
    SearchPath := Path + '*.*'
  else
    SearchPath := Path + '*' + cbFilter.Text;

  FindRes := FindFirst(SearchPath, faAnyFile, SR);
  while FindRes = 0 do
  begin
    if ((SR.Attr and faDirectory) = faDirectory) and
    ((SR.Name = '.') or (SR.Name = '..')) then
    begin
      FindRes := FindNext(SR);
      Continue;
    end;

    if IsFilePath(Path + SR.Name) then
    begin // File
      if IsFilesOnly then
      begin
        Itm := List.Items.Add;
        Itm.Caption := SR.Name;
        Itm.ImageIndex := 2;
        Itm.SubItems.Add(getNormalizeSize(SR.Size));
        MyDate := FileDateToDateTime(SR.Time);
        Itm.SubItems.Add(DateTimeToStr(MyDate));
      end;
      try
        Extensions.Add(TPath.GetExtension(Path + SR.Name));
      except
      end;
    end
    else
    begin // Folder
      if IsFoldersOnly then
      begin
        Itm := List.Items.Add;
        Itm.Caption := SR.Name;
        Itm.ImageIndex := 0;
        Itm.SubItems.Add(getNormalizeSize(SR.Size));
        MyDate := FileDateToDateTime(SR.Time);
        Itm.SubItems.Add(DateTimeToStr(MyDate));
      end;

      try
        Folders.Add(Path + SR.Name);
      except
      end;
    end;
    try
      Attrs := TPath.GetAttributes(Path + SR.Name);
      if (TFileAttribute.faReadOnly in Attrs) then
        Itm.SubItems.Add('Read only')
      else if (TFileAttribute.faTemporary in Attrs) then
        Itm.SubItems.Add('Temp')
      else if (TFileAttribute.faSystem in Attrs) then
        Itm.SubItems.Add('System')
      else if (TFileAttribute.faHidden in Attrs) then
        Itm.SubItems.Add('Hidden')
      else if (TFileAttribute.faDirectory in Attrs) then
        Itm.SubItems.Add('Directory')
      else if (TFileAttribute.faArchive in Attrs) then
        Itm.SubItems.Add('Archive')
    except
    end;
    FindRes := FindNext(SR);
  end;

  SetComboboxValues(Folders, cbSearch); // For Search Edit
  SetComboboxValues(Extensions, cbFilter); // For Filter Edit
  Extensions.Free;
  Folders.Free;

  FindClose(SR);
end;

procedure RouterAdd(Path: String);
var
  RouterItem: TPRouterHistory;
begin
  New(RouterItem);
  RouterItem^.Path := Path;
  RouterItem^.Next := nil;
  RouterItem^.Prev := nil;

  if (Router.First = nil) then
    Router.First := RouterItem
  else
  begin
    Router.First.Prev := RouterItem;
    RouterItem.Next := Router.First;
    RouterItem.Prev := nil;
    Router.First := RouterItem;
  end;
  Router.Current := RouterItem;
end;

function RouterNext(): String;
begin
  if (Router.Current.Prev = nil) then
    Result := ''
  else
  begin
    Router.Current := Router.Current.Prev;
    Result := Router.Current.Path;
  end;
end;

function RouterPrev(): String;
begin
  if (Router.Current.Next = nil) then
    Result := ''
  else
  begin
    Router.Current := Router.Current.Next;
    Result := Router.Current.Path;
  end;
end;

procedure NextPage(ListView: TListView; NewPath: String; cbFilter, cbSearch: TComboBox);
begin
  if (cbFilter.Text = '') then
    cbFilter.Text := 'any';

  ShowCatalog(ListView, NewPath, cbFilter, cbSearch);
  RouterAdd(NewPath);
end;

procedure PrevPage(ListView: TListView; NewPath: String; cbFilter, cbSearch: TComboBox);
begin
  if (cbFilter.Text = '') then
    cbFilter.Text := 'any';

  ShowCatalog(ListView, NewPath, cbFilter, cbSearch);
end;

procedure CheckRouterArrows(RouterLeftButton: TSpeedButton; RouterRightButton: TSpeedButton);
begin
  RouterLeftButton.Enabled := Router.Current.Next <> nil;
  RouterRightButton.Enabled := Router.Current.Prev <> nil;
end;

procedure TForm3.ButtonSearchClick(Sender: TObject);
begin
  ComboBoxSearch.Text := IncludeTrailingBackslash(ComboBoxSearch.Text);
//  NextPage(lvFilesPrint, ComboBoxSearch.Text, ComboBoxFilter, ComboBoxSearch);
  Self.ButtonRefreshPageClick(Sender);
  CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
end;

function isAlphabetChars(Text: String): Boolean;
const
  ALPHABET_CHARS = ['a'..'z', 'A'..'Z'];
var
  I: Integer;
  IsOk: Boolean;
begin
  IsOk := True;
  for I := 1 to Length(Text) do
  begin
    IsOk := Text[I] in ALPHABET_CHARS;
    if Not isOk then
      break;
  end;

  Result := IsOk;
end;

procedure setFileInfo(FilePath: String; lvFilesInfo: TListView);
const
  Internals: Array of String = ['Hidden', 'System', 'Temp', 'Read only'];
  InternalsField: Array of TFileAttribute = [
    TFileAttribute.faHidden,
    TFileAttribute.faSystem,
    TFileAttribute.faTemporary,
    TFileAttribute.faReadOnly
  ];
var
  I: Integer;
  Item: TListItem;
  Attrs: TFileAttributes;
  TimeVar: TDateTime;
  FileAttributes: TFileAttributes;
begin
  lvFilesInfo.Clear;
  Item := lvFilesInfo.Items.Add;
  Item.Caption := 'Path';
  Item.SubItems.Add(FilePath);
  Item := lvFilesInfo.Items.Add;
  Item.Caption := 'Target';
  if (IsFilePath(FilePath)) then
    Item.Caption := 'File'
  else
    Item.Caption := 'Folder';
  Item.SubItems.Add(ExtractFileName(FilePath));

  Item := lvFilesInfo.Items.Add;
  Item := lvFilesInfo.Items.Add;
  Item.Caption := 'ATTRIBUTES';
  Item.Selected;
  try
    Attrs := TPath.GetAttributes(FilePath);
    for I := 0 to Length(Internals)-1 do
    begin
      Item := lvFilesInfo.Items.Add;
      Item.Caption := Internals[I];
      if (InternalsField[I] in Attrs) then
        Item.SubItems.Add('Yes')
      else
        Item.SubItems.Add('No');
    end;

    try
      TimeVar := TFile.GetCreationTime(FilePath);
      Item := lvFilesInfo.Items.Add;
      Item := lvFilesInfo.Items.Add;
      Item.Caption := 'DATES';
      Item := lvFilesInfo.Items.Add;
      Item.Caption := 'Made in';
      Item.SubItems.Add(DateTimeToStr(TimeVar));
      Item := lvFilesInfo.Items.Add;
      Item.Caption := 'Last Edit in';
      TimeVar := TFile.GetLastWriteTime(FilePath);
      Item.SubItems.Add(DateTimeToStr(TimeVar));
    except
    end;
  except
  end;

end;

procedure TForm3.ComboBoxFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if (ComboBoxFilter.Text = '') then
      ComboBoxFilter.Text := 'any';
    Self.ButtonRefreshPageClick(Sender);
  end;
end;

procedure TForm3.ComboBoxSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if (ComboBoxSearch.Text = '') then
      ComboBoxSearch.Text := DEFAULT_PATH;

    Self.ButtonSearchClick(Sender);
    ComboBoxSearch.SelStart := Length(ComboBoxSearch.Text);
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Router.First := nil;
  Router.Current := nil;
  RouterAdd(DEFAULT_PATH);
  ComboBoxSearch.Text := DEFAULT_PATH;
  ResetComboBox(ComboBoxFilter, ['any', FILTER_FOLDERS_ONLY, FILTER_FILES_ONLY]);
  NextPage(lvFilesPrint, DEFAULT_PATH, ComboBoxFilter, ComboBoxSearch);
  ButtonRouterLeft.Enabled := False;
  ButtonRouterRight.Enabled := False;
  SetFileInfo('C:\\', lvFileInfo);
end;

procedure TForm3.lvFIlesPrintColumnClick(Sender: TObject; Column: TListColumn);
begin
  lvFilesPrint.SortType := stData;
end;

procedure TForm3.lvFIlesPrintDblClick(Sender: TObject);
var
  Item: TListItem;
begin
  Item := lvFilesPrint.Selected;
  if (Item = nil) then Exit;

  if (Item.ImageIndex = 2) then
    ShellExecute(Handle, 'open', PChar(ComboBoxSearch.Text + Item.Caption), nil, nil, sw_ShowNormal)
  else
  begin
    ComboBoxSearch.Text := ComboBoxSearch.Text + Item.Caption + '\';
    NextPage(lvFilesPrint, ComboBoxSearch.Text, ComboBoxFilter, ComboBoxSearch);
    CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
  end;
end;

procedure TForm3.lvFIlesPrintSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  setFileInfo(ComboBoxSearch.Text + Item.Caption, lvFileInfo);
end;

procedure TForm3.ButtonCreateFileClick(Sender: TObject);
var
  ModalResult: Integer;
begin
  FormNewFile.EditPath.Text := ComboBoxSearch.Text;
  FormNewFile.EditFileName.Text := 'Untitled.txt';
  ModalResult := FormNewFile.ShowModal();
  if (ModalResult = mrCancel) then
    Self.ButtonRefreshPageClick(Sender);
end;

procedure TForm3.ButtonCreateFolderClick(Sender: TObject);
var
  ModalResult: Integer;
begin
  FormNewFolder.EditPath.Text := ComboBoxSearch.Text;
  FormNewFolder.EditFolderName.Text := 'Untitled';
  ModalResult := FormNewFolder.ShowModal();
  if (ModalResult = mrCancel) then
    Self.ButtonRefreshPageClick(Sender);
end;

procedure TForm3.ButtonRefreshPageClick(Sender: TObject);
begin
  ShowCatalog(lvFilesPrint, ComboBoxSearch.Text, ComboBoxFilter, ComboBoxSearch);
end;

procedure TForm3.ButtonDeleteClick(Sender: TObject);
var
  Item: TListItem;
  MsgAnswer: Integer;
  FileType: String;
  Exception: TException;
begin
  Item := lvFilesPrint.Selected;
  if (Item = nil) then
  begin
    MessageDlg(
        'Select row in File Explorer to delete something',
        mtError,
        mbOKCancel,
        0
      );
    Exit;
  end;

  FileType := 'folder';
  if (Item.ImageIndex = 2) then // File
    FileType := 'file';
  MsgAnswer := MessageDlg(
      'Are you sure you want to delete ' + FileType + ' "' + Item.Caption + '"?' + #13 + #10 +
      'The data will not remain in the basket!',
      mtWarning,
      [mbYes, mbNo],
      0
    );
  if (MsgAnswer = 6) then
  begin // Answer = 'Yes'
    if (FileType = 'folder') then
      Exception := DeleteFolder(ComboBoxSearch.Text + Item.Caption)
    else
      Exception := DeleteFile(ComboBoxSearch.Text + Item.Caption);
    if (Exception.Code = 0) then
    begin
      Self.ButtonRefreshPageClick(Sender);
      MessageDlg(Exception.Desc, mtInformation, mbOKCancel, 0);
    end
    else
      MessageDlg(Exception.Desc, mtError, mbOKCancel, 0);
  end;
end;

procedure TForm3.ButtonRouterLeftClick(Sender: TObject);
var
  PrevPath: String;
begin
  PrevPath := RouterPrev();
  ComboBoxSearch.Text := PrevPath;
  PrevPage(lvFilesPrint, PrevPath, ComboBoxFilter, ComboBoxSearch);
  CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
end;

procedure TForm3.ButtonRouterRightClick(Sender: TObject);
var
  NextPath: String;
begin
  NextPath := RouterNext();
  ComboBoxSearch.Text := NextPath;
  PrevPage(lvFilesPrint, NextPath, ComboBoxFilter, ComboBoxSearch);
  CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
end;

end.


