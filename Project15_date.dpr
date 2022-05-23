library Project15_date;

uses
  System.SysUtils,
  System.Classes;

{$R *.res}

type
  TFormatDate = record
    Day: Integer;
    Hours: Integer;
    Minutes: Integer;
    Month: Integer;
    Year: Integer;
    Seconds: Integer;
  end;

Function FormatDate(Date: TDateTime): TFormatDate; stdcall; export;
var
  FDate: TFormatDate;
  Year, Month, Day: Integer;
begin
end;

begin
end.

Exports FormatDate;
