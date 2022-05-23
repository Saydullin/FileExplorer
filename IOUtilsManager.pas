unit IOUtilsManager;

interface

implementation

uses
  System.IOUtils, System.SysUtils;

function SetSlashEnd(Path: String): String;
begin
  if (Path[Length(Path) - 1] <> '\') then
    Result := Path + '\'
  else
    Result := Path;
end;

procedure CreateFolder(Path: String; FolderName: String); export; stdcall;
begin
  TDirectory.CreateDirectory(Path + FolderName);
end;

end.

Exports CreateFolder;
