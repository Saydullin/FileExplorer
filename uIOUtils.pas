unit uIOUtils;

interface

uses
  System.IOUtils, System.SysUtils, System.Classes;

type
  TException = record
    Code: Integer;
    Desc: String;
  end;

function CreateFolder(Path: String; FolderName: String): TException;
function DeleteFolder(Path: String): TException;
function DeleteFile(Path: String): TException;
function CreateFile(Path: String; FileName: String): TException;
function IsFilePath(Path: String): Boolean;

implementation

function CreateFolder(Path: String; FolderName: String): TException;
var
  Exception: TException;
begin
  try
    if Not TDirectory.Exists(Path + FolderName) then
    begin
      TDirectory.CreateDirectory(Path + FolderName);
      Exception.Code := 0;
      Exception.Desc := 'Folder created successfully!';
    end
    else
    begin
      Exception.Code := 1;
      Exception.Desc := 'Folder "' + FolderName + '" already exist';
    end;
  except
    Exception.Code := 1;
    Exception.Desc := 'Error occurred while creating folder in ' + Path;
  end;

  Result := Exception;
end;

function DeleteFolder(Path: String): TException;
var
  Exceptionq: TException;
begin
  try
    if TDirectory.Exists(Path) then
    begin
      TDirectory.Delete(Path);
      Exceptionq.Code := 0;
      Exceptionq.Desc := 'Folder deleted successfully!';
    end
    else
    begin
      Exceptionq.Code := 1;
      Exceptionq.Desc := 'Folder not found in ' + Path;
    end;
  except
    on E: Exception do
    begin
      Exceptionq.Code := 1;
      Exceptionq.Desc := 'Error occurred while deleting folder in ' + Path + #13 + #10 +
      E.Message;
    end;

  end;

  Result := Exceptionq;
end;

function DeleteFile(Path: String): TException;
var
  Exception: TException;
begin
  try
    if TFile.Exists(Path) then
    begin
      TFile.Delete(Path);
      Exception.Code := 0;
      Exception.Desc := 'File deleted successfully!';
    end
    else
    begin
      Exception.Code := 1;
      Exception.Desc := 'File not found in ' + Path;
    end;
  except
    Exception.Code := 1;
    Exception.Desc := 'Error occurred while deleting file in ' + Path;
  end;

  Result := Exception;
end;

function CreateFile(Path: String; FileName: String): TException;
var
  Exception: TException;
begin
  try
    if Not TFile.Exists(Path + FileName) then
    begin
      TFile.Create(Path + FileName);
      Exception.Code := 0;
      Exception.Desc := 'File created successfully';
    end
    else
    begin
      Exception.Code := 1;
      Exception.Desc := 'File "' + FileName + '" already exist';
    end;
  except
    Exception.Code := 1;
    Exception.Desc := 'Error occurred while creating file in ' + Path;
  end;

  Result := Exception;
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
