program Exercise4;

var
    dividend, divisor, quotient, remainder: integer;

begin
    writeln('Enter the dividend:');
    readln(dividend);

    writeln('Enter the divisor:');
    readln(divisor);

    quotient := 0;
    remainder := dividend;

    while remainder >= divisor do
    begin
        remainder := remainder - divisor;
        quotient := quotient + 1;
    end;

    writeln('Exercise 4: Integer quotient: ', quotient);
    writeln('Exercise 4: Remainder: ', remainder);
end.