program Exercise1;

var
  a, b, product: integer;

begin
  writeln('Enter two numbers');
  readln(a, b);
  product := a * b;
  writeln('Multiplication:', product);
end.

program LabWork0;

// Exercise 1: Calculate the product of two integers
procedure Exercise1;
var
  num1, num2, product: integer;
begin
  num1 := 5; // Replace with your first integer
  num2 := 7; // Replace with your second integer
  product := num1 * num2;
  writeln('Exercise 1: Product of ', num1, ' and ', num2, ' is ', product);
end;

// Exercise 2: Sort three numbers in ascending order
procedure Exercise2;
var
  a, b, c: integer;
begin
  a := 10; // Replace with your first number
  b := 5;  // Replace with your second number
  c := 8;  // Replace with your third number

  if a > b then
    begin
      // Swap a and b
      a := a + b;
      b := a - b;
      a := a - b;
    end;
  
  if b > c then
    begin
      // Swap b and c
      b := b + c;
      c := b - c;
      b := b - c;
    end;
  
  if a > b then
    begin
      // Swap a and b again
      a := a + b;
      b := a - b;
      a := a - b;
    end;

  writeln('Exercise 2: Numbers in ascending order: ', a, ', ', b, ', ', c);
end;

// Exercise 3: Check if a point is inside a circle
procedure Exercise3;
var
  centerX, centerY, radius, pointX, pointY: real;
  distance: real;
begin
  centerX := 0.0;  // Replace with the center X-coordinate of the circle
  centerY := 0.0;  // Replace with the center Y-coordinate of the circle
  radius := 5.0;  // Replace with the radius of the circle
  pointX := 3.0;  // Replace with the X-coordinate of the point
  pointY := 4.0;  // Replace with the Y-coordinate of the point

  distance := sqrt(sqr(pointX - centerX) + sqr(pointY - centerY));

  if distance <= radius then
    writeln('Exercise 3: The point is inside the circle.')
  else
    writeln('Exercise 3: The point is outside the circle.');
end;

// Exercise 4: Calculate the integer quotient and remainder without division
procedure Exercise4;
var
  dividend, divisor, quotient, remainder: integer;
begin
  dividend := 17;  // Replace with your dividend
  divisor := 5;   // Replace with your divisor

  quotient := 0;
  remainder := dividend;

  while remainder >= divisor do
  begin
    remainder := remainder - divisor;
    quotient := quotient + 1;
  end;

  writeln('Exercise 4: Integer quotient: ', quotient);
  writeln('Exercise 4: Remainder: ', remainder);
end;

// Exercise 5: Swap the last maximum and first minimum elements of an array
procedure Exercise5;
const
  N = 6; // Replace with the size of your array
var
  arr: array[1..N] of integer;
  i, maxIndex, minIndex, temp: integer;
begin
  // Initialize the array (replace with your values)
  arr[1] := 8;
  arr[2] := 2;
  arr[3] := 7;
  arr[4] := 3;
  arr[5] := 6;
  arr[6] := 1;

  maxIndex := 1;
  minIndex := 1;

  // Find the index of the first minimum and last maximum elements
  for i := 2 to N do
  begin
    if arr[i] < arr[minIndex] then
      minIndex := i;
    
    if arr[i] >= arr[maxIndex] then
      maxIndex := i;
  end;

  // Swap the elements
  temp := arr[minIndex];
  arr[minIndex] := arr[maxIndex];
  arr[maxIndex] := temp;

  // Display the modified array
  writeln('Exercise 5: Swapped array: ');
  for i := 1 to N do
    write(arr[i], ' ');
  writeln;
end;

begin
  // Call each exercise procedure
  Exercise1;
  Exercise2;
  Exercise3;
  Exercise4;
  Exercise5;
end.

