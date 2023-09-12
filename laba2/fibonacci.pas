Program fibonacci;

var sum, input: Integer;

function count(n: Integer):integer;
var
   result: integer;
   
begin
    if (n = 0) then
        result := 0
    else if (n = 1) then
        result := 1
    else
        result := count(n - 1) + count(n - 2);

    count := result;
end;

begin
    Write('Enter the number: ');
    Readln(input);

    write (count(input));
end.
