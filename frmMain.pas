unit frmMain;

interface

uses
  StrUtils, System.IOUtils, ShellApi, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.ButtonGroup, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Buttons,
  Vcl.FileCtrl, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TMainForm = class(TForm)
    LabelTitle: TLabel;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    lvFilesPrint: TListView;
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
    History1: TMenuItem;
    ButtonSearch: TSpeedButton;
    EditSearchFile: TEdit;
    LabelSearching: TLabel;
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
    procedure ButtonSearchFileClick(Sender: TObject);
    procedure ButtonCreateFolderClick(Sender: TObject);
    procedure ButtonCreateFileClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonRefreshPageClick(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure lvFIlesPrintEdited(Sender: TObject; Item: TListItem;
      var S: string);
    procedure History1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  frmNewDirectory, frmNewFile, frmSearch, frmHistory, frmInfo,
  uIOUtils, uTypes, uSort, uHistoryManager;

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
  TSearchThread = class(TThread)
  private
    Path: String;
    FileName: String;
    lvFilesPrint: TListView;
    cbSearch: TComboBox;
    cbFilter: TComboBox;
    lSearching: TLabel;
  protected
    procedure Execute; override;
  end;
  TSizeThread = class(TThread)
  private
    Path: String;
    lvFileInfo: TListView;
    lvFileIndex: Integer;
  protected
    procedure Execute; override;
  end;

var
  Router: TRouter;
  SortStates: TSortStates;
  SizeThread: TSizeThread;
  SearchThread: TSearchThread;

const
  DEFAULT_PATH = 'C:\\';
  FILTER_FOLDERS_ONLY = 'folders only';
  FILTER_FILES_ONLY = 'files only';

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
  if ((Bytes / 1024 / 1000) >= 1000) then
    Result := Format('%.2f', [Bytes / 1024 / 1000 / 1000]) + ' GB'
  else if (Bytes / 1024 >= 1000) then
    Result := Format('%.2f', [Bytes / 1024 / 1000]) + ' MB'
  else if (Bytes >= 1024) then
    Result := Format('%.2f', [Bytes / 1024]) + ' KB'
  else
    Result := IntToStr(BYTES) + ' B ';
end;

function getInitialSize(SizeStr: String): UInt64;
begin
  Result := Trunc(StrToFloat(Copy(SizeStr, 0, Length(SizeStr) - 3)));

  if SizeStr.Contains('GB') then
    Result := Trunc(StrToFloat(Copy(SizeStr, 0, Length(SizeStr) - 3)) * 1024 * 1000 * 1000);
  if SizeStr.Contains('MB') then
    Result := Trunc(StrToFloat(Copy(SizeStr, 0, Length(SizeStr) - 3)) * 1024 * 1000);
  if SizeStr.Contains('KB') then
    Result := Trunc(StrToFloat(Copy(SizeStr, 0, Length(SizeStr) - 3)) * 1024);
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
  Str: String;
begin
  Str := ComboBox.Text;
  ComboBox.Clear;
  ComboBox.Text := Str;
  if (Length(DefItems) = 0) then Exit;

  for I := 0 to Length(DefItems) - 1 do
    ComboBox.Items.Add(DefItems[I]);
  ComboBox.Text := DefItems[0];
end;

procedure SaveAction(Target: String; Action: String; Path: String);
var
  ActionHistory: TActionHistory;
begin

end;

function GetAttrsAbbr(Attrs: TFileAttributes): String;
begin
  Result := '-';
  if (TFileAttribute.faReadOnly in Attrs) then
    Result := Result + 'r-';
  if (TFileAttribute.faTemporary in Attrs) then
    Result := Result + 't-';
  if (TFileAttribute.faSystem in Attrs) then
    Result := Result + 's-';
  if (TFileAttribute.faHidden in Attrs) then
    Result := Result + 'h-';
  if (TFileAttribute.faDirectory in Attrs) then
    Result := Result + 'd-';
  if (TFileAttribute.faArchive in Attrs) then
    Result := Result + 'a-';
end;

procedure ShowSearchResult(List: TListView; Paths: TStringList; cbFilter, cbSearch: TComboBox);
var
  SR: TSearchRec;
  FindRes: Integer;
  Itm: TListItem;
  MyDate: TDateTime;
  Extensions: TStringList;
  Folders: TStringList;
  I: Integer;
  SearchPath: String;
  IsFilesOnly: Boolean;
  IsFoldersOnly: Boolean;
  Attrs: TFileAttributes;
begin
  IsFilesOnly := True;
  IsFoldersOnly := True;
  Extensions := TStringList.Create;
  Extensions.Duplicates := dupIgnore;
  Extensions.Sorted := True;
  Folders := TStringList.Create;
  Folders.Sorted := False;
  Folders.Duplicates := dupIgnore;

  if (cbFilter.Text = FILTER_FOLDERS_ONLY) then
    IsFilesOnly := False
  else if (cbFilter.Text = FILTER_FILES_ONLY) then
    IsFoldersOnly := False;

  for I := 0 to Paths.Count-1 do
  begin
    if (cbFilter.ItemIndex <= 0) or (cbFilter.Text = 'any')
    or Not (IsFilesOnly) or Not (IsFoldersOnly) then
      SearchPath := Paths[I] + '*.*'
    else
      SearchPath := Paths[I] + '*' + cbFilter.Text;
    FindRes := FindFirst(SearchPath, faAnyFile, SR);
    if (FindRes = 0) then
    begin
      if IsFilePath(Paths[I]) then
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
          Extensions.Add(TPath.GetExtension(Paths[I]));
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
          Folders.Add(Paths[I]);
        except
        end;
      end;
      try
        Attrs := TPath.GetAttributes(Paths[I]);
        Itm.SubItems.Add(GetAttrsAbbr(Attrs));
      except
        Itm.SubItems.Add('');
      end;
    end;

    FindClose(SR);
  end;
  ResetComboBox(cbFilter, ['any', FILTER_FOLDERS_ONLY, FILTER_FILES_ONLY]);
  ResetComboBox(cbSearch, []);
  SetComboboxValues(Folders, cbSearch); // For Search Edit
  SetComboboxValues(Extensions, cbFilter); // For Filter Edit
  Extensions.Free;
  Folders.Free;
end;

procedure TSearchThread.Execute;
var
  ResSearch: TStringList;
begin
  ResSearch := SearchFile(FileName, Path);
  ShowSearchResult(lvFilesPrint, ResSearch, cbFilter, cbSearch);
  lSearching.Visible := False;
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
  Extensions.Duplicates := dupIgnore;
  Extensions.Sorted := True;
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
      Itm.SubItems.Add(GetAttrsAbbr(Attrs));
    except
      Itm.SubItems.Add('');
    end;
    FindRes := FindNext(SR);
  end;
  ResetComboBox(cbFilter, ['any', FILTER_FOLDERS_ONLY, FILTER_FILES_ONLY]);
  ResetComboBox(cbSearch, []);
  SetComboboxValues(Folders, cbSearch); // For Search Edit
  SetComboboxValues(Extensions, cbFilter); // For Filter Edit
  Extensions.Free;
  Folders.Free;

  FindClose(SR);
end;

procedure RouterAdd(Path: String; ToSetCurrent: Boolean);
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
  if (ToSetCurrent) then
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
  RouterAdd(NewPath, True);
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

procedure TMainForm.ButtonSearchClick(Sender: TObject);
begin
  ComboBoxSearch.Text := IncludeTrailingBackslash(ComboBoxSearch.Text);
  RouterAdd(ComboBoxSearch.Text, True);
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

procedure TSizeThread.Execute;
var
  Size: UInt64;
begin
  Size := GetDirectorySize(Path);
  lvFileInfo.Items[lvFileIndex].SubItems[0] := GetNormalizeSize(Size);
end;

procedure setFileInfo(FilePath: String; lvFilesInfo: TListView);
const
  Internals: Array of String = ['Archive', 'Hidden', 'System', 'Temp', 'Read only'];
  InternalsField: Array of TFileAttribute = [
    TFileAttribute.faArchive,
    TFileAttribute.faHidden,
    TFileAttribute.faSystem,
    TFileAttribute.faTemporary,
    TFileAttribute.faReadOnly
  ];
var
  I: Integer;
  Index: Integer;
  Item: TListItem;
  Attrs: TFileAttributes;
  CreatedDate: TDateTime;
  LastAccessDate: TDateTime;
  LastChangeDate: TDateTime;
  FileAttributes: TFileAttributes;
  IsFile: Boolean;
begin
  lvFilesInfo.Clear;

  IsFile := IsFilePath(FilePath);

  Item := lvFilesInfo.Items.Add;
  try
    Item.Caption := 'Path';
    Item.SubItems.Add(FilePath);
  except
  end;

  try
    Item := lvFilesInfo.Items.Add;
    if (IsFile) then
      Item.Caption := 'File'
    else
      Item.Caption := 'Folder';
    Item.SubItems.Add(ExtractFileName(FilePath));
  except
  end;

  Item := lvFilesInfo.Items.Add;
  try
    Item.Caption := 'Size';
    Item.SubItems.Add('Loading...');
  except
  end;

  try
    lvFilesInfo.Items[Item.Index].SubItems[0] := 'Loading...';
    SizeThread := TSizeThread.Create(True);
    SizeThread.FreeOnTerminate := False;
    SizeThread.Priority := tpNormal;
    SizeThread.lvFileIndex := Item.Index;
    SizeThread.Path := FilePath;
    SizeThread.lvFileInfo := lvFilesInfo;
    SizeThread.Resume;
  except
    on E: Exception do
      lvFilesInfo.Items[Item.Index].SubItems[0] := E.Message;
  end;


  Item := lvFilesInfo.Items.Add;
  try
    if (IsFile) then
      Attrs := TFile.GetAttributes(FilePath)
    else
      Attrs := TDirectory.GetAttributes(FilePath);
    Item := lvFilesInfo.Items.Add;
    Item.Caption := 'ATTRIBUTES';
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
      Item := lvFilesInfo.Items.Add;
      Item := lvFilesInfo.Items.Add;
      if (IsFile) then
      begin
        if Not (TFile.Exists(FilePath)) then
          Exit;
        Item.Caption := 'DATES';
        Item := lvFilesInfo.Items.Add;
        Item.Caption := 'Made in';
        CreatedDate := TFile.GetCreationTime(FilePath);
        Item.SubItems.Add(DateTimeToStr(CreatedDate));
        Item := lvFilesInfo.Items.Add;
        Item.Caption := 'Last Edit in';
        LastChangeDate := TFile.GetLastWriteTime(FilePath);
        Item.SubItems.Add(DateTimeToStr(LastChangeDate));
        Item := lvFilesInfo.Items.Add;
        Item.Caption := 'Last Access in';
        LastAccessDate := TFile.GetLastAccessTime(FilePath);
        Item.SubItems.Add(DateTimeToStr(LastAccessDate));
      end
      else
      begin
        if Not (TDirectory.Exists(FilePath)) then
          Exit;
        Item.Caption := 'DATES';
        Item := lvFilesInfo.Items.Add;
        Item.Caption := 'Made in';
        CreatedDate := TDirectory.GetCreationTime(FilePath);
        Item.SubItems.Add(DateTimeToStr(CreatedDate));
        Item := lvFilesInfo.Items.Add;
        Item.Caption := 'Last Edit in';
        LastChangeDate := TDirectory.GetLastWriteTime(FilePath);
        Item.SubItems.Add(DateTimeToStr(LastChangeDate));
        Item := lvFilesInfo.Items.Add;
        Item.Caption := 'Last Access in';
        LastAccessDate := TDirectory.GetLastAccessTime(FilePath);
        Item.SubItems.Add(DateTimeToStr(LastAccessDate));
      end;
    except
    end;
  except
  end;

end;

procedure TMainForm.ComboBoxFilterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
  begin
    if (ComboBoxFilter.Text = '') then
      ComboBoxFilter.Text := 'any';
    Self.ButtonRefreshPageClick(Sender);
  end;
end;

procedure TMainForm.ComboBoxSearchKeyDown(Sender: TObject; var Key: Word;
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  LabelSearching.Visible := False;
  SortStates.IsName := False;
  SortStates.IsSize := False;
  SortStates.IsDate := False;
  SortStates.IsAttributes := False;
  Router.First := nil;
  Router.Current := nil;
  RouterAdd(DEFAULT_PATH, True);
  ComboBoxSearch.Text := DEFAULT_PATH;
  ResetComboBox(ComboBoxFilter, ['any', FILTER_FOLDERS_ONLY, FILTER_FILES_ONLY]);
  NextPage(lvFilesPrint, DEFAULT_PATH, ComboBoxFilter, ComboBoxSearch);
  ButtonRouterLeft.Enabled := False;
  ButtonRouterRight.Enabled := False;
  SetFileInfo(DEFAULT_PATH, lvFileInfo);
end;

procedure TMainForm.Help1Click(Sender: TObject);
begin
  FormInfo.ShowModal();
end;

procedure TMainForm.History1Click(Sender: TObject);
begin
  History.RefreshList();
  History.ShowModal();
end;

procedure TMainForm.lvFilesPrintColumnClick(Sender: TObject; Column: TListColumn);
var
  lvItem: TListItem;
  FilesList: TFilesList;
  FilesListItem: TFileItem;
  I: Integer;
begin
  SetLength(FilesList, lvFilesPrint.Items.Count);
  for I := 0 to lvFilesPrint.Items.Count - 1 do
  begin
    New(FilesListItem);
    lvItem := lvFilesPrint.Items[I];
    FilesListItem.Name := lvItem.Caption;
    FilesListItem.Size := GetInitialSize(lvItem.SubItems[0]);
    FilesListItem.Date := lvItem.SubItems[1];
    FilesListItem.Attributes := lvItem.SubItems[2];
    FilesList[I] := FilesListItem;
  end;

  Case Column.Index of
    0: begin
      SortStates.IsName := Not SortStates.IsName;
      SortListByName(FilesList, SortStates.IsName);
    end;
    1: begin
      SortStates.IsSize := Not SortStates.IsSize;
      SortListBySize(FilesList, SortStates.IsSize);
    end;
    2: begin
      SortStates.IsDate := Not SortStates.IsDate;
      SortListByDate(FilesList, SortStates.IsDate);
    end;
    3: begin
      SortStates.IsAttributes := Not SortStates.IsAttributes;
      SortListByAttr(FilesList, SortStates.IsAttributes);
    end;
  end;

  for I := 0 to lvFilesPrint.Items.Count - 1 do
  begin
    FilesListItem := FilesList[I];
    lvItem := lvFilesPrint.Items[I];
    lvItem.Caption := FilesListItem.Name;
    lvItem.SubItems[0] := GetNormalizeSize(FilesListItem.Size);
    lvItem.SubItems[1] := FilesListItem.Date;
    lvItem.SubItems[2] := FilesListItem.Attributes;
  end;
end;

procedure TMainForm.lvFIlesPrintDblClick(Sender: TObject);
var
  Item: TListItem;
begin
  Item := lvFilesPrint.Selected;
  if (Item = nil) then Exit;

  if (Item.ImageIndex = 2) then
    ShellExecute(Handle, 'open', PChar(ComboBoxSearch.Text + Item.Caption), nil, nil, sw_ShowNormal)
  else
  begin
    ComboBoxSearch.Text := TPath.Combine(ComboBoxSearch.Text, Item.Caption) + '\';
    NextPage(lvFilesPrint, ComboBoxSearch.Text, ComboBoxFilter, ComboBoxSearch);
    CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
  end;
end;

procedure TMainForm.lvFIlesPrintEdited(Sender: TObject; Item: TListItem;
  var S: string);
var
  Exception: TException;
  QAnswer: Integer;
  Action: TActionItem;
  DeleteFileName: String;
  DeletePath: String;
  FileType: String;
begin
  DeleteFileName := Item.Caption;
  DeletePath := ComboBoxSearch.Text + S;
  QAnswer := MessageDlg(
        'Are you sure rename "' + Item.Caption + '" to "' + S + '"?',
        mtConfirmation,
        [mbYes, mbNo],
        0
      );

  if (QAnswer <> mrYes) then
  begin
    S := Item.Caption;
    Exit;
  end;

  if (Item.ImageIndex = 2) then
  begin // File
    FileType := 'File';
    Exception := RenameFile(ComboBoxSearch.Text + Item.Caption, ComboBoxSearch.Text + S);
  end
  else
  begin
    FileType := 'Directory';
    Exception := RenameDirectory(ComboBoxSearch.Text + Item.Caption, ComboBoxSearch.Text + S);
  end;

  if (Exception.Code = 1) then
  begin
    MessageDlg(
        Exception.Desc,
        mtError,
        mbOKCancel,
        0
      );
    S := Item.Caption;
  end
  else
  begin
    MessageDlg(
        Exception.Desc,
        mtInformation,
        mbOKCancel,
        0
      );
    Action.Target := DeleteFileName;
    Action.Action := 'Renamed';
    Action.TargetType := FileType;
    Action.Path := DeletePath;
    Action.Date := DateToStr(Now) + ' ' + TimeToStr(Now);
    AddAction(Action);
    Self.ButtonRefreshPageClick(Sender);
  end;
end;

procedure TMainForm.lvFIlesPrintSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  setFileInfo(ComboBoxSearch.Text + Item.Caption, lvFileInfo);
end;

procedure TMainForm.ButtonCreateFileClick(Sender: TObject);
var
  ModalResult: Integer;
begin
  FormNewFile.EditPath.Text := ComboBoxSearch.Text;
  FormNewFile.EditFileName.Text := 'Untitled.txt';
  ModalResult := FormNewFile.ShowModal();
  if (ModalResult = mrCancel) then
    Self.ButtonRefreshPageClick(Sender);
end;

procedure TMainForm.ButtonCreateFolderClick(Sender: TObject);
var
  ModalResult: Integer;
begin
  FormNewFolder.EditPath.Text := ComboBoxSearch.Text;
  FormNewFolder.EditFolderName.Text := 'Untitled';
  ModalResult := FormNewFolder.ShowModal();
  if (ModalResult = mrCancel) then
    Self.ButtonRefreshPageClick(Sender);
end;

procedure TMainForm.ButtonSearchFileClick(Sender: TObject);
var
  ResSearch: TStringList;
  MessageDlgResult: Integer;
begin
  MessageDlgResult := MessageDlg('Search may take some time.' + #13#10 + 'You sure you want to search?', mtConfirmation, [], 0);
  if (MessageDlgResult <> mrOk) then
    Exit;
  Screen.Cursor := crSQLWait;
  SearchThread := TSearchThread.Create(False);
  SearchThread.FreeOnTerminate := True;
  SearchThread.Priority := tpNormal;
  SearchThread.Path := ComboBoxSearch.Text;
  SearchThread.FileName := EditSearchFile.Text;
  SearchThread.cbSearch := ComboBoxSearch;
  SearchThread.cbFilter := ComboBoxFilter;
  SearchThread.lSearching := LabelSearching;
  SearchThread.lvFilesPrint := lvFilesPrint;
  SearchThread.Resume;
  LabelSearching.Visible := True;
  Screen.Cursor := crDefault;
  lvFilesPrint.Clear;
//  ResSearch := SearchFile(EditSearchFile.Text, ComboBoxSearch.Text);
//  LabelTitle.Caption := IntToStr(ResSearch.Count);
//  ShowCatalog(lvFilesPrint, ComboBoxSearch.Text, ComboBoxFilter, ComboBoxSearch);
end;

procedure TMainForm.ButtonRefreshPageClick(Sender: TObject);
begin
  ShowCatalog(lvFilesPrint, ComboBoxSearch.Text, ComboBoxFilter, ComboBoxSearch);
end;

procedure TMainForm.ButtonDeleteClick(Sender: TObject);
var
  Item: TListItem;
  MsgAnswer: Integer;
  FileType: String;
  Exception: TException;
  Action: TActionItem;
  DeletePath: String;
  DeleteFileName: String;
begin
  Item := lvFilesPrint.Selected;
  DeletePath := TPath.Combine(ComboBoxSearch.Text, Item.Caption);
  DeleteFileName := Item.Caption;
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

  FileType := 'Directory';
  if (Item.ImageIndex = 2) then // File
    FileType := 'File';
  MsgAnswer := MessageDlg(
      'Are you sure you want to delete ' + FileType + ' "' + Item.Caption + '"?' + #13#10 +
      'The data will not remain in the basket!',
      mtWarning,
      [mbYes, mbNo],
      0
    );
  if (MsgAnswer = mrYes) then
  begin
    if (FileType = 'Directory') then
      Exception := DeleteFolder(DeletePath)
    else
      Exception := DeleteFile(DeletePath);
    if (Exception.Code = 0) then
    begin
      Self.ButtonRefreshPageClick(Sender);
      MessageDlg(Exception.Desc, mtInformation, mbOKCancel, 0);
      Action.Target := DeleteFileName;
      Action.Action := 'Deleted';
      Action.TargetType := FileType;
      Action.Path := DeletePath;
      Action.Date := DateToStr(Now) + ' ' + TimeToStr(Now);
      AddAction(Action);
    end
    else
      MessageDlg(Exception.Desc, mtError, mbOKCancel, 0);
  end;
end;

procedure TMainForm.ButtonRouterLeftClick(Sender: TObject);
var
  PrevPath: String;
begin
  PrevPath := RouterPrev();
  ComboBoxSearch.Text := PrevPath;
  PrevPage(lvFilesPrint, PrevPath, ComboBoxFilter, ComboBoxSearch);
  RouterAdd(PrevPath, False);
  CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
end;

procedure TMainForm.ButtonRouterRightClick(Sender: TObject);
var
  NextPath: String;
begin
  NextPath := RouterNext();
  ComboBoxSearch.Text := NextPath;
  PrevPage(lvFilesPrint, NextPath, ComboBoxFilter, ComboBoxSearch);
  CheckRouterArrows(ButtonRouterLeft, ButtonRouterRight);
end;

end.


