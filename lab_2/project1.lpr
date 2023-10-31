program project1;

uses
  DateUtils,
  SysUtils;

var
  FromTime, ToTime: TDateTime;
var
  X, Y, A: array of integer;
var
  i, n, k, d, j, b1, e1, e2, c, b, e, z: integer;

  procedure S(var X, Y: array of integer; b1, e1, e2: integer);
  var
    i1, i2, j: integer;
  begin
    i1 := b1;
    i2 := e1 + 1;
    j := b1;
    while (i1 <= e1) and (i2 <= e2) do
    begin
      if X[i1] <= X[i2] then
      begin
        Y[j] := X[i1];
        i1 := i1 + 1;
      end
      else
      begin
        Y[j] := X[i2];
        i2 := i2 + 1;
      end;
      j := j + 1;
    end;
    while i1 <= e1 do
    begin
      Y[j] := X[i1];
      i1 := i1 + 1;
      j := j + 1;
    end;
    while i2 <= e2 do
    begin
      Y[j] := X[i2];
      i2 := i2 + 1;
      j := j + 1;
    end;
  end;

  procedure sort(var X, Y: array of integer; b, e: integer);
  var
    c, k: integer;
  begin
    if b < e then
    begin
      c := (b + e) div 2;
      sort(X, Y, b, c);
      sort(X, Y, c + 1, e);
      S(X, Y, b, c, e);
      for k := b to e do X[k] := Y[k];
    end;
  end;

begin
  n := 10;
  for k := 1 to 7 do
  begin
    writeln('n = ', n);
    setlength(X, n + 2);
    setlength(Y, n + 2);
    setlength(A, n + 2);
    for i := 1 to n do
    begin
      A[i] := random(1000);
      //write(X[i],' ');
    end;
    writeln('Сортировка слиянием');
    for i := 1 to n do X[i] := A[i];
    FromTime := Now;
    b := 1;
    e := n;
    sort(X, Y, 1, n);
    ToTime := Now;
    for i := 1 to n - 1 do
    begin
      //write(X[i],' ');
      if X[i] > X[i + 1] then
      begin
        //writeln(X[i+1]);
        Write('Ошибка, массив сортирован неверно');
        exit;
      end;
    end;
    //writeln(x[i+1]);
    writeln('Массив сортирован успешно');
    d := MilliSecondsBetween(ToTime, FromTime);
    writeln('Время выполнения: ', d);
    writeln();
    if n < 10001 then
    begin
      writeln('Сортировка обменом');
      FromTime := Now;
      for i := 1 to n do X[i] := A[i];
      i := 1;
      j := 1;
      while i < n do
      begin
        if X[i] > X[i + 1] then
        begin
          z := X[i + 1];
          X[i + 1] := X[i];
          X[i] := z;
          if i > 1 then i := i - 1;
        end
        else
        begin
          j := j + 1;
          i := j;
        end;
      end;
      ToTime := Now;
      for i := 1 to n - 1 do
      begin
        ;
        if X[i] > X[i + 1] then
        begin
          Write('Ошибка, массив сортирован неверно');
          exit;
        end;
      end;
      writeln('Массив сортирован успешно');
      d := MilliSecondsBetween(ToTime, FromTime);
      writeln('Время выполнения: ', d);
    end
    else
      writeln('Массив слишком велик для сортировки обменом');
    writeln();
    if n < 1001 then
    begin
      writeln('Простейшая сортировка');
      for i := 1 to n do X[i] := A[i];
      i := 1;
      FromTime := Now;
      while i < n do
      begin
        if X[i] > X[i + 1] then
        begin
          z := X[i];
          X[i] := X[i + 1];
          X[i + 1] := z;
          i := 1;
        end
        else
          i := i + 1;
      end;
      ToTime := Now;
      for i := 1 to n - 1 do
      begin
        ;
        if X[i] > X[i + 1] then
        begin
          Write('Ошибка, массив сортирован неверно');
          exit;
        end;
      end;
      writeln('Массив сортирован успешно');
      d := MilliSecondsBetween(ToTime, FromTime);
      writeln('Время выполнения: ', d);
    end
    else
      writeln('Массив слишком велик для простейшей сортировки');
    n := n * 10;
    writeln();
  end;
  readln();
end.
