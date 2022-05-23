unit uSort;

interface

implementation

procedure MakeSort(var Els: Array of Integer);
var
  I: Integer;
  P: Integer;
  Min: Integer;
  MinId: Integer;
  Temp: Integer;
begin
  for I := 0 to Length(Els)-1 do
  begin
    Min := Els[I];
    MinId := I;
    for P := I + 1 to Length(Els)-1 do
    begin
      if (Els[P] < Min) then
      begin
        Min := Els[P];
        MinId := P;
      end;
    end;
    Temp := Els[I];
    Els[I] := Min;
    Els[MinId] := Temp;
  end;
end;

end.
