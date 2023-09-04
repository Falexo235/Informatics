program Exercise2;

var
    a, b, c: integer;

begin
    writeln('Enter the value of a:');
    readln(a);

    writeln('Enter the value of b:');
    readln(b);

    writeln('Enter the value of c:');
    readln(c);

    if a > b then
    begin
    a := a + b;
    b := a - b;
    a := a - b;
    end;

    if b > c then
    begin
    b := b + c;
    c := b - c;
    b := b - c;
    end;

    if a > b then
    begin
    a := a + b;
    b := a - b;
    a := a - b;
    end;

    writeln('Exercise 2: Numbers in ascending order: ', a, ', ', b, ', ', c);
end.
