unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil,
  LResources, ExtCtrls, Grids;

type

  { TListForm }

  TListForm = class(TForm)
    Edit1: TEdit;
    FileSaveButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Lin: TButton;
    FileOpenButton: TButton;
    FileMemo: TMemo;
    FileOpenDialog: TOpenDialog;
    ListBox1: TListBox;
    ListBox2: TListBox;
    StringGrid1: TStringGrid;
    Upor: TButton;
    Sliy: TButton;
    procedure FileOpenButtonClick(Sender: TObject);
    procedure FileSaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LinClick(Sender: TObject);
    procedure SliyClick(Sender: TObject);
    procedure UporClick(Sender: TObject);
  private

  public
  var
    A1, A2: array of array of string;
    A1i, A2i: array of integer;
    p1, p2, p3: integer;
    txtf: TextFile;
    sl: TStringList;
    st: string;
  end;

var
  ListForm: TListForm;

implementation

{$R *.lfm}

{ TListForm }

procedure sortat(k: integer);
var
  i, c: integer;
begin
  if (k < 1) or (k > 5) then exit;
  i := 1;
  if k < 4 then
  begin
    while i < (length(ListForm.A1i) - 1) do
    begin
      if ListForm.A2[ListForm.A2i[i], k] <= ListForm.A2[ListForm.A2i[i + 1], k] then
        i := i + 1
      else
      begin
        c := ListForm.A1i[i];
        ListForm.A1i[i] := ListForm.A1i[i + 1];
        ListForm.A1i[i + 1] := c;
        c := ListForm.A2i[i];
        ListForm.A2i[i] := ListForm.A2i[i + 1];
        ListForm.A2i[i + 1] := c;
        i := i - 1;
      end;
    end;
  end
  else
  begin
    k := k - 2;
    while i < (length(ListForm.A1i) - 1) do
      if ListForm.A1[ListForm.A1i[i], k] <= ListForm.A1[ListForm.A1i[i + 1], k] then
        i := i + 1
      else
      begin
        c := ListForm.A1i[i];
        ListForm.A1i[i] := ListForm.A1i[i + 1];
        ListForm.A1i[i + 1] := c;
        c := ListForm.A2i[i];
        ListForm.A2i[i] := ListForm.A2i[i + 1];
        ListForm.A2i[i + 1] := c;
        i := i - 1;
      end;
  end;
end;

procedure TListForm.LinClick(Sender: TObject);
var
  i, c, k: integer;
begin
  if length(A1i) <= 1 then exit;
  k := StrToInt(ListForm.Edit1.Text);
  sortat(1);
  sortat(k);
  StringGrid1.RowCount := length(A2i);
  for i := 1 to length(A2i) - 1 do
  begin
    StringGrid1.Cells[0, i] := (A2[A2i[i], 1]);
    StringGrid1.Cells[1, i] := (A2[A2i[i], 2]);
    StringGrid1.Cells[2, i] := (A2[A2i[i], 3]);
    StringGrid1.Cells[3, i] := (A1[A1i[i], 2]);
    StringGrid1.Cells[4, i] := (A1[A1i[i], 3]);

  end;
  FileMemo.Lines.Clear;
  FileMemo.Lines.Add('Таблица сортирована по столбцу ' +
    IntToStr(k));
end;

procedure TListForm.SliyClick(Sender: TObject);
var
  i, k: integer;
begin
  if length(A1i) <= 1 then exit;
  sortat(1);
  StringGrid1.RowCount := 1;
  i := 1;
  for k := 1 to length(A2i) - 1 do
  begin
    if (A1[A1i[k], 2] <> 'Россия') then
    begin
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      StringGrid1.Cells[0, i] := (A2[A2i[k], 1]);
      StringGrid1.Cells[1, i] := (A2[A2i[k], 2]);
      StringGrid1.Cells[2, i] := (A2[A2i[k], 3]);
      StringGrid1.Cells[3, i] := (A1[A1i[k], 2]);
      StringGrid1.Cells[4, i] := (A1[A1i[k], 3]);
      i := i + 1;
    end;
  end;
  FileMemo.Lines.Clear;
  FileMemo.Lines.Add('Выведен список иностранных студентов');
end;

procedure TListForm.UporClick(Sender: TObject);
var
  i, c: integer;
begin
  if length(A1i) <= 1 then exit;
  ListBox1.Items.Clear;
  sortat(5);
  sortat(4);
  for i := 1 to length(A1i) - 1 do
  begin
    if (A1[A1i[i], 2] = 'Россия') and (A1[A1i[i], 3] <> A1[A1i[i + 1], 3]) then
      ListBox1.Items.Add(A1[A1i[i], 3]);
  end;
  FileMemo.Lines.Clear;
  FileMemo.Lines.Add('Выведен список субъектов');
end;

procedure TListForm.FileOpenButtonClick(Sender: TObject);
var
  n, c, i: integer;
begin
  n := 0;
  FileMemo.Lines.Clear;
  FileMemo.Lines.Add('Укажите файл 1');
  if FileOpenDialog.Execute then
  begin
    if FileExists(FileOpenDialog.FileName) then
    begin
      FileMemo.Lines.Add('Открыт файл ' + FileOpenDialog.Filename);
      AssignFile(txtf, FileOpenDIalog.Filename);
      try
        Reset(txtf);
        while not EOF(txtf) do
        begin
          n := n + 1;
          SetLength(A1i, n + 1);
          SetLength(A2i, n + 1);
          SetLength(A1, n + 1, 4);
          SetLength(A2, n + 2, 4);
          readln(txtf, st);
          sl.DelimitedText := st;
          A1[n, 1] := sl[0];
          A1[n, 2] := sl[1];
          A1[n, 3] := sl[2];
          A1i[n] := n;
        end;
      finally
      end;
    end;

  end;
  FileMemo.Lines.Add('Укажите файл 2');
  if FileOpenDialog.Execute then
  begin
    if FileExists(FileOpenDialog.FileName) then
    begin
      FileMemo.Lines.Add('Открыт файл' + FileOpenDialog.Filename);
      AssignFile(txtf, FileOpenDIalog.Filename);
      try
        Reset(txtf);
        while not EOF(txtf) do
        begin
          n := n + 1;
          SetLength(A1i, n + 1);
          ;
          SetLength(A2i, n + 1);
          SetLength(A1, n + 1, 4);
          SetLength(A2, n + 2, 4);
          A1i[n] := n;
          readln(txtf, st);
          sl.DelimitedText := st;
          A1[n, 1] := sl[0];
          A1[n, 2] := sl[1];
          A1[n, 3] := sl[2];
        end;
      finally
      end;
    end;

  end;
  n := 0;
  FileMemo.Lines.Add('Укажите файл 3');
  if FileOpenDialog.Execute then
  begin
    if FileExists(FileOpenDialog.FileName) then
    begin
      FileMemo.Lines.Add('Открыт файл ' + FileOpenDialog.Filename);
      AssignFile(txtf, FileOpenDIalog.Filename);
      try
        Reset(txtf);
        while not EOF(txtf) do
        begin
          n := n + 1;
          readln(txtf, st);
          sl.DelimitedText := st;
          A2[n, 1] := sl[0];
          A2[n, 2] := sl[1];
          A2[n, 3] := sl[2];
          A2i[n] := n;
        end;
      finally
      end;
    end;

  end;

  FileMemo.Lines.Add('Укажите файл 4');
  if FileOpenDialog.Execute then
  begin
    if FileExists(FileOpenDialog.FileName) then
    begin
      FileMemo.Lines.Add('Открыт файл' + FileOpenDialog.Filename);
      AssignFile(txtf, FileOpenDIalog.Filename);
      try
        Reset(txtf);
        while not EOF(txtf) do
        begin
          n := n + 1;
          A2i[n] := n;
          readln(txtf, st);
          sl.DelimitedText := st;
          A2[n, 1] := sl[0];
          A2[n, 2] := sl[1];
          A2[n, 3] := sl[2];
        end;
      finally
      end;
    end;

  end
  else
    FileMemo.Lines.Add('Файл ' + FileOpenDialog.Filename + ' не найден');
  i := 1;
  while i < (length(A1i) - 1) do
  begin
    if A1[A1i[i], 1] <= A1[A1i[i + 1], 1] then i := i + 1
    else
    begin
      c := A1i[i];
      A1i[i] := A1i[i + 1];
      A1i[i + 1] := c;
      i := i - 1;
    end;
  end;
  i := 1;
  while i < (length(A2i) - 1) do
  begin
    if A2[A2i[i], 1] <= A2[A2i[i + 1], 1] then i := i + 1
    else
    begin
      c := A2i[i];
      A2i[i] := A2i[i + 1];
      A2i[i + 1] := c;
      i := i - 1;
    end;
  end;
end;

procedure TListForm.FileSaveButtonClick(Sender: TObject);
var
  i, min, max: integer;
begin
  if length(A1i) <= 1 then exit;
  sortat(5);
  sortat(4);
  min := 3000;
  max := 0;
  ListForm.ListBox2.Clear;
  i := 1;
  while A1[A1i[i], 2] <> 'Россия' do i := i + 1;
  while A1[A1i[i], 2] = 'Россия' do
  begin
    if (A1[A1i[i], 3]) <> (A1[A1i[i + 1], 3]) then
    begin
      ListForm.ListBox2.Items.Add(A1[A1i[i], 3] + ' ' + A2[A2i[i], 3]);
      if StrToInt(A2[A2i[i], 3]) > max then max := StrToInt(A2[A2i[i], 3]);
      if StrToInt(A2[A2i[i], 3]) < min then min := StrToInt(A2[A2i[i], 3]);
    end
    else
      while A1[A1i[i], 3] = A1[A1i[i + 1], 3] do i := i + 1;
    i := i + 1;
  end;
  FileMemo.Lines.Clear;
  FileMemo.Lines.Add(
    'Выведен список субъектов с 1 студентом и год его рождения');
  FileMemo.Lines.Add('Диапазон: ' + IntToStr(min) + '-' + IntToStr(max));
end;

procedure TListForm.FormCreate(Sender: TObject);
begin
  SetLength(A1, 0, 4);
  SetLength(A2, 0, 4);
  sl := TStringList.Create;
  sl.Delimiter := ' ';
end;


end.
