program BaseConversion;

var
    OldBase, NewBase, NumDigits, Digit, DecimalNum, i: Integer;
    NewNum, _buff: String;

begin

    // Ввод всего что нужно для задания
    Write('Enter the old base: ');
    Readln(OldBase);
    
    Write('Enter the number of digits: ');
    Readln(NumDigits);
    
    Write('Enter the sequence of digits separated by spaces: ');
    DecimalNum := 0;
    for i := 1 to NumDigits do
    begin
        Read(Digit);
        DecimalNum := DecimalNum * OldBase + Digit;
    end;
    // Теперь в DecimalNum хранится значение числа в 10чной системе счисления
    Readln;
    
    Write('Enter the new base: ');
    Readln(NewBase);
    
    // Стандартный алгоритм перевода
    
    NewNum := '';
    while DecimalNum > 0 do
    begin
        Digit := DecimalNum mod NewBase;      // Остаток от деления
        DecimalNum := DecimalNum div NewBase; // Целочисленное деление
        str(Digit, _buff); // Переводим посчитанный знак в строковый тип
        NewNum := ' ' + _buff + NewNum; // Дописываем переведеную "цифру" В НАЧАЛО
    end;
    
    Writeln('Result in the new base:', NewNum);
end.
