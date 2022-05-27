unit uTypes;

interface

type
  TException = record
    Code: Integer;
    Desc: String;
  end;
  TSortStates = record
    IsName: Boolean;
    IsSize: Boolean;
    IsDate: Boolean;
    IsAttributes: Boolean;
  end;
  TFileItem = ^TFilesItem;
  TFilesItem = record
    Name: String;
    Size: UInt64;
    Date: String;
    Attributes: String;
  end;
  TFilesList = Array of TFileItem;
  TActionItem = record
    Target: String[255];
    Action: String[255];
    Path: String[255];
    Date: String[255];
  end;
  TActionHistory = ^TActionHistoryItem;
  TActionHistoryItem = record
    Data: TActionItem;
    Next: TActionHistory;
    Prev: TActionHistory;
  end;
  TAHistory = record
    First: TActionHistory;
    Last: TActionHistory;
  end;


implementation

end.



