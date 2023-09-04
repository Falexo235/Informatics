program Exercise3;

var
     centerX, centerY, radius, pointX, pointY, distance: real;
begin
    writeln('Enter the X-coordinate of the center:');
    readln(centerX);

    writeln('Enter the Y-coordinate of the center:');
    readln(centerY);

    writeln('Enter the radius of the circle:');
    readln(radius);

    writeln('Enter the X-coordinate of the point:');
    readln(pointX);

    writeln('Enter the Y-coordinate of the point:');
    readln(pointY);

    distance := sqrt(sqr(pointX - centerX) + sqr(pointY - centerY));

    if distance <= radius then
        writeln('Exercise 3: The point is inside the circle.')
    else
        writeln('Exercise 3: The point is outside the circle.');
end.
