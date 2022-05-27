unit uSort;

interface

uses
  uTypes;

procedure SortListByName(var List: TFilesList; IsDesc: Boolean);
procedure SortListBySize(var List: TFilesList; IsDesc: Boolean);
procedure SortListByDate(var List: TFilesList; IsDesc: Boolean);
procedure SortListByAttr(var List: TFilesList; IsDesc: Boolean);

implementation

procedure SortListByName(var List: TFilesList; IsDesc: Boolean);
var
  I: Integer;
  P: Integer;
  Min: TFileItem;
  MinId: Integer;
  Temp: TFileItem;
begin
  for I := 0 to Length(List)-1 do
  begin
    Min := List[I];
    MinId := I;
    for P := I + 1 to Length(List)-1 do
    begin
      if (IsDesc) then
      begin
        if (List[P].Name < Min.Name) then
        begin
          Min := List[P];
          MinId := P;
        end;
      end
      else
      begin
        if (List[P].Name > Min.Name) then
        begin
          Min := List[P];
          MinId := P;
        end;
      end;
    end;
    Temp := List[I];
    List[I] := Min;
    List[MinId] := Temp;
  end;
end;

procedure SortListBySize(var List: TFilesList; IsDesc: Boolean);
var
  I: Integer;
  P: Integer;
  Min: TFileItem;
  MinId: Integer;
  Temp: TFileItem;
  Desc: Integer;
begin
  if (IsDesc) then
    Desc := 1
  else
    Desc := -1;

  for I := 0 to Length(List)-1 do
  begin
    Min := List[I];
    MinId := I;
    for P := I + 1 to Length(List)-1 do
    begin
      if ((List[P].Size * Desc) < (Min.Size * Desc)) then
      begin
        Min := List[P];
        MinId := P;
      end;
    end;
    Temp := List[I];
    List[I] := Min;
    List[MinId] := Temp;
  end;
end;

procedure SortListByDate(var List: TFilesList; IsDesc: Boolean);
var
  I: Integer;
  P: Integer;
  Min: TFileItem;
  MinId: Integer;
  Temp: TFileItem;
begin
  for I := 0 to Length(List)-1 do
  begin
    Min := List[I];
    MinId := I;
    for P := I + 1 to Length(List)-1 do
    begin
      if (IsDesc) then
      begin
        if (List[P].Date < Min.Date) then
        begin
          Min := List[P];
          MinId := P;
        end;
      end
      else
      begin
        if (List[P].Date > Min.Date) then
        begin
          Min := List[P];
          MinId := P;
        end;
      end;
    end;
    Temp := List[I];
    List[I] := Min;
    List[MinId] := Temp;
  end;
end;

procedure SortListByAttr(var List: TFilesList; IsDesc: Boolean);
var
  I: Integer;
  P: Integer;
  Min: TFileItem;
  MinId: Integer;
  Temp: TFileItem;
begin
  for I := 0 to Length(List)-1 do
  begin
    Min := List[I];
    MinId := I;
    for P := I + 1 to Length(List)-1 do
    begin
      if (IsDesc) then
      begin
        if (List[P].Attributes < Min.Attributes) then
        begin
          Min := List[P];
          MinId := P;
        end;
      end
      else
      begin
        if (List[P].Attributes > Min.Attributes) then
        begin
          Min := List[P];
          MinId := P;
        end;
      end;
    end;
    Temp := List[I];
    List[I] := Min;
    List[MinId] := Temp;
  end;
end;

end.
