program Exercise5;

const
    MAX_N = 100; // Adjust this maximum size as needed

var
    N, i, maxIndex, minIndex, temp: integer;
    arr: array[1..MAX_N] of integer;

begin
    writeln('Enter the size of the array (N):');
    readln(N);

    writeln('Enter the elements of the array (separated by spaces):');
    for i := 1 to N do
        read(arr[i]);

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
end.