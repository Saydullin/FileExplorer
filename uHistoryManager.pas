unit uHistoryManager;

interface

uses
  IOUtils, SysUtils, Classes, uTypes;

procedure InitHistoryStorage();
procedure ClearFile();
procedure AddAction(HistoryActionData: TActionItem);
function GetHistoryActions(): TAHistory;

implementation

var
  FileName: String = 'HistoryActions.dat';

function GetStorageFilePath(): String;
begin
  Result := TPath.Combine(TPath.GetTempPath, FileName);
end;

procedure InitHistoryStorage();
var
  FHistory: File of TActionItem;
  Item: TActionItem;
begin
  if Not (TFile.Exists(GetStorageFilePath())) then
  begin
    TFile.Create(GetStorageFilePath());
    AssignFile(FHistory, GetStorageFilePath());
    Rewrite(FHistory);
    Item.Target := 'History Manager';
    Item.Action := 'Created';
    Item.Path := GetStorageFilePath();
    Item.Date := 'Current Date';
    Write(FHistory, Item);
    CloseFile(FHistory);
  end;
end;

procedure AddAction(HistoryActionData: TActionItem);
var
  TempPath: String;
  FHistory: File of TActionItem;
  Item: TActionItem;
  FilePath: String;
  FStream: TFileStream;
begin
  InitHistoryStorage();
  FilePath := GetStorageFilePath();
  AssignFile(FHistory, FilePath);
  Reset(FHistory);
  Seek(FHistory, Filesize(FHistory));
  Write(FHistory, HistoryActionData);
  CloseFile(FHistory);
  AssignFile(FHistory, FilePath);
  Reset(FHistory);
  while not EOF(FHistory) do
    Read(FHistory, Item);
  CloseFile(FHistory);
end;

procedure AddActionItem(var List: TAHistory; Data: TActionItem);
var
  Item: TActionHistory;
begin
  New(Item);
  Item.Data := Data;
  Item.Next := nil;
  Item.Prev := nil;

  if (List.First = nil) then
  begin
    List.First := Item;
    List.Last := Item;
  end
  else
  begin
    Item.Next := List.First;
    List.First.Prev := Item;
    List.First := Item;
  end;
end;

procedure ClearFile();
var
  FHistory: File of TActionItem;
begin
  AssignFile(FHistory, GetStorageFilePath);
  Rewrite(FHistory);
  CloseFile(FHistory);
end;

function GetHistoryActions(): TAHistory;
var
  FHistory: File of TActionItem;
  HistoryActions: TAHistory;
  HistoryItem: TActionItem;
begin
  HistoryActions.First := nil;
  HistoryActions.Last := nil;
  InitHistoryStorage();
  AssignFile(FHistory, GetStorageFilePath());
  Reset(FHistory);

  try
    While not EOF(FHistory) do
    begin
      Read(FHistory, HistoryItem);
      AddActionItem(HistoryActions, HistoryItem);
    end;
  finally
   CloseFile(FHistory);
  end;

  Result := HistoryActions;
end;

end.



