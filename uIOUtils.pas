unit uIOUtils;

interface

uses
  WinApi.Windows, System.IOUtils, System.SysUtils, System.Classes, uTypes;
  
function CreateFolder(Path: String; FolderName: String): TException;
function DeleteFolder(Path: String): TException;
function DeleteFile(Path: String): TException;
function SearchFile(FileName: String; SearchPath: String): TStringList;
function CreateFile(Path: String; FileName: String): TException;
function RenameFile(const OldName: String; NewName: String): TException;
function RenameDirectory(const OldName: String; NewName: String): TException;
function GetDirectorySize(Path: String): UInt64;
function IsFilePath(Path: String): Boolean;

implementation

function GetFileSize(const aFilename: String): Int64;
var
  info: TWin32FileAttributeData;
begin
  Result := -1;

  If Not GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @info) then
    Exit;

  Result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
end;

function CreateFolder(Path: String; FolderName: String): TException;
var
  Exc: TException;
  FilePath: String;
begin
  FilePath := TPath.Combine(Path, FolderName);
  try
    if Not TDirectory.Exists(FilePath) then
    begin
      TDirectory.CreateDirectory(FilePath);
      Exc.Code := 0;
      Exc.Desc := 'Folder created successfully!';
    end
    else
    begin
      Exc.Code := 1;
      Exc.Desc := 'Folder "' + FolderName + '" already exist';
    end;
  except
    on E: Exception do
    begin
      Exc.Code := 1;
      Exc.Desc := 'Error occurred while creating folder in ' + Path + #13#10 +
      E.Message;
    end;

  end;

  Result := Exc;
end;

function DeleteFolder(Path: String): TException;
var
  Exc: TException;
begin
  try
    if TDirectory.Exists(Path) then
    begin
      TDirectory.Delete(Path);
      Exc.Code := 0;
      Exc.Desc := 'Folder deleted successfully!';
    end
    else
    begin
      Exc.Code := 1;
      Exc.Desc := 'Folder not found in ' + Path;
    end;
  except
    on E: Exception do
    begin
      Exc.Code := 1;
      Exc.Desc := 'Error occurred while deleting folder in ' + Path + #13#10 +
      E.Message;
    end;

  end;

  Result := Exc;
end;

function DeleteFile(Path: String): TException;
var
  Exc: TException;
begin
  try
    if TFile.Exists(Path) then
    begin
//      TFile.Create(TPath.GetHomePath() + TPath.DirectorySeparatorChar + 'lastMoves.txt');
      TFile.Delete(Path);
      Exc.Code := 0;
      Exc.Desc := 'File deleted successfully!';
    end
    else
    begin
      Exc.Code := 1;
      Exc.Desc := 'File not found in ' + Path;
    end;
  except
    on E: Exception do
    begin
      Exc.Code := 1;
      Exc.Desc := 'Error occurred while deleting file in ' + Path + #13#10 +
      E.Message;
    end;
  end;

  Result := Exc;
end;

function SearchFile(FileName: String; SearchPath: String): TStringList;
var
  Results: TStringList;
  ResFilePath: String;
begin
  Results := TStringList.Create;
  Results.Duplicates := dupIgnore;
  Results.Sorted := True;

  for ResFilePath in TDirectory.GetFiles(SearchPath, '*', TSearchOption.soAllDirectories) do
    if (TPath.GetFileName(ResFilePath) = FileName) then
      Results.Add(ResFilePath);

  Result := Results;
end;

function CreateFile(Path: String; FileName: String): TException;
var
  Exc: TException;
  FilePath: String;
begin
  FilePath := TPath.Combine(Path, FileName);
  try
    if Not TFile.Exists(FilePath) then
    begin
      TFile.Create(FilePath);
      Exc.Code := 0;
      Exc.Desc := 'File created successfully';
    end
    else
    begin
      Exc.Code := 1;
      Exc.Desc := 'File "' + FileName + '" already exist';
    end;
  except
    on E: Exception do
    begin
      Exc.Code := 1;
      Exc.Desc := 'Error occurred while creating file in ' + Path + #13#10 +
      E.Message;
    end;
  end;

  Result := Exc;
end;

function RenameFile(const OldName: String; NewName: String): TException;
var
  Exc: TException;
begin
  try
    TFile.Move(OldName, NewName);
    Exc.Code := 0;
    Exc.Desc := 'File edited successfully';
  except
    on E: Exception do
    begin
      Exc.Code := 1;
      Exc.Desc := 'Error occurred while editing file to ' + NewName + #13#10 +
      E.Message;
    end;
  end;

  Result := Exc;
end;

function RenameDirectory(const OldName: String; NewName: String): TException;
var
  Exc: TException;
begin
  try
    TDirectory.Move(OldName, NewName);
    Exc.Code := 0;
    Exc.Desc := 'Directory edited successfully';
  except
    on E: Exception do
    begin
      Exc.Code := 1;
      Exc.Desc := 'Error occurred while editing directory to ' + NewName + #13#10 +
      E.Message;
    end;
  end;

  Result := Exc;
end;

function GetDirectorySize(Path: String): UInt64;
var
  TotalSize: UInt64;
  FileName: String;
begin
  TotalSize := 0;

  if (IsFilePath(Path)) then
    TotalSize := GetFileSize(Path)
  else
    for FileName in TDirectory.GetFiles(Path, '*', TSearchOption.soAllDirectories) do
      TotalSize := TotalSize + GetFileSize(FileName);

  Result := TotalSize;
end;

function IsFilePath(Path: String): Boolean;
var
  IsFile: Boolean;
begin
  IsFile := True;
  try
    IsFile := Not (TFileAttribute.faDirectory in TPath.GetAttributes(Path))
  except
    IsFile := False;
  end;

  Result := IsFile;
end;

end.
