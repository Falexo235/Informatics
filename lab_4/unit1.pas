unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, ActnList, TAGraph;

type

  { TPrimerForm }

  TPrimerForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    Edit3: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit3Click(Sender: TObject);

  private

  public

  end;

var
  PrimerForm: TPrimerForm;


implementation

var
  LangColor: array[1..10] of TColor = (clGreen, clBlue, clFuchsia,
    clRed, clNavy, clMaroon, clTeal, clOlive, clPurple, clBlack);
  Languages: array[1..10] of string = ('C', 'Java', 'Python', 'C++',
    'C#', 'Visual Basic', 'JavaScript', 'PHP', 'R', 'SQL');
  Rating: array[1..10] of real = (16.95, 12.56, 11.28, 6.94, 4.16,
    3.97, 2.14, 2.09, 1.99, 1.57);
  iBeg, jBeg, iEnd, jEnd: integer;

{$R *.lfm}

{ TPrimerForm }
// litovchenkom21@yandex.ru
procedure Draw1;
begin
  with PrimerForm.Image1.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clForm;
    FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
    Pen.Color := clGreen;
    Pen.Width := 3;
    Brush.Color := clRed;
    EllipseC(75, 75, 25, 25);
    Pen.Color := clRed;
    Brush.Color := clGreen;
    Brush.Style := bsCross;
    Rectangle(110, 50, 210, 100);
    Pen.Color := clBlack;
    Pen.Width := 10;
    Line(10, 120, PrimerForm.Image1.Width - 10, 120);
    Brush.Color := clRed;
    Font.Color := clBlue;
    Font.Name := 'Courier';
    Font.Size := 30;
    Font.Style := [fsBold];
    TextOut(60, 150, 'Рисунок');
  end;
end;

procedure Draw2;
var
  x1, x2, f1, s, x0: real;
var
  i, k: integer;
begin
  x1 := StrToFloat(PrimerForm.Edit1.Text);
  x2 := StrToFloat(PrimerForm.Edit2.Text);
  k := StrToInt(PrimerForm.Edit3.Text);
  s := (abs(x2 - x1) / k);
  x0 := (x1);
  for i := 1 to k do
  begin
    if not (x0 = (-1)) then
      f1 := (1 / (1 + x0));
    with PrimerForm.Image1.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clRed;
      Ellipse((PrimerForm.Image1.Width div 2) +
        trunc(x0 * ((PrimerForm.Image1.Width div 8) - 5)) - 2,
        (PrimerForm.Image1.Height div 2) -
        trunc(f1 * ((PrimerForm.Image1.Height div 2) - 5)) - 2,
        (PrimerForm.Image1.Width div 2) +
        trunc(x0 * ((PrimerForm.Image1.Width div 8) - 5)) + 2,
        (PrimerForm.Image1.Height div 2) -
        trunc(f1 * ((PrimerForm.Image1.Height div 2) - 5)) + 2);
    end;
    x0 := x0 + s;
    if not (x0 = -1) then
      f1 := (1 / (1 + x0));
  end;
end;

procedure Draw3;
var
  kollang, Border, xt, yt, step, rad, irad, jrad, i: integer;
  x1, xr, start: real;
begin
  Border := 20;
  iBeg := Border;
  jBeg := Border;
  with PrimerForm.Image1.Canvas do
  begin
    Brush.Color := clForm;
    FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
    kollang := StrToInt(PrimerForm.Edit4.Text);
    if (PrimerForm.Image1.Width - 2 * iBeg) > (PrimerFOrm.Image1.Height - 2 * jBeg) then
      rad := PrimerForm.Image1.Height - 2 * jBeg
    else
      rad := PrimerForm.Image1.Width - 2 * iBeg;
    rad := rad div 2;
    iEnd := iBeg + 2 * rad;
    jEnd := jBeg + 2 * rad;
    irad := iBeg + rad;
    jrad := jBeg + rad;
    start := pi / 2;
    x1 := start;
    for i := 1 to kollang do
    begin
      xr := x1 - 2 * pi * Rating[i] / 100;
      Brush.Color := LangColor[i];
      Pie(iBeg, jBeg, iEnd, jEnd, irad + round(rad * cos(xr)),
        jrad - round(rad * sin(xr)), irad + round(rad * cos(x1)),
        jrad - round(rad * sin(x1)));
      x1 := xr;
    end;
    Brush.Color := clGray;
    xr := start;
    Pie(iBeg, jBeg, iEnd, jEnd, irad + round(rad * cos(xr)),
      jrad - round(rad * sin(xr)), irad + round(rad * cos(x1)), jrad -
      round(rad * sin(x1)));
  end;
  with PrimerForm.Image2.Canvas do
  begin
    Brush.Color := clForm;
    FillRect(0, 0, PrimerForm.Image2.Width, PrimerForm.Image2.Height);
    step := round(PrimerForm.Image2.Height / (kollang + 1));
    xt := Border;
    yt := Border div 2;
    for i := 1 to kollang do
    begin
      Font.Color := LangColor[i];
      TextOut(xt, yt, Languages[i]);
      yt := yt + step;
    end;
    Font.Color := clGray;
    TextOut(xt, yt, 'Другие');
  end;
end;


procedure TPrimerForm.Button1Click(Sender: TObject);
begin
  Draw1;
end;

procedure TPrimerForm.Button2Click(Sender: TObject);
begin
  Draw2;
end;

procedure TPrimerForm.Button3Click(Sender: TObject);
begin
  Draw3;
end;

procedure TPrimerForm.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.Caption = 'Рисунок' then
  begin
    with PrimerForm.Image1.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clForm;
      FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
    end;
    Edit1.Hide;
    Label4.Hide;
    Edit3.Hide;
    Edit2.Hide;
    Label2.Hide;
    Label3.Hide;
    Edit4.Hide;
    Label5.Hide;
    Button2.Hide;
    Image2.Hide;
    Button3.Hide;
    Button1.Show;
    Label1.Caption := 'Рисунок';
  end
  else if ComboBox1.Caption = 'Функция' then
  begin
    with PrimerForm.Image1.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clForm;
      FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
      Pen.Color := clBlack;
      Pen.Width := 1;
      Line(0, (PrimerForm.Image1.Height div 2), PrimerForm.Image1.Width,
        (PrimerForm.Image1.Height div 2));
      Line(PrimerForm.Image1.Width div 2, 0, PrimerForm.Image1.Width div
        2, PrimerForm.Image1.Height);
      Line(PrimerForm.Image1.Width - 5, (PrimerForm.Image1.Height div 2) +
        5, PrimerForm.Image1.Width - 5, (PrimerForm.Image1.Height div 2) - 5);
      Line(5, (PrimerForm.Image1.Height div 2) + 5, 5,
        (PrimerForm.Image1.Height div 2) - 5);
      Line((((PrimerForm.Image1.Width - 10) div 8) * 3) + 7,
        (PrimerForm.Image1.Height div 2) + 5,
        (((PrimerForm.Image1.Width - 10) div 8) * 3) + 7,
        (PrimerForm.Image1.Height div 2) - 5);
      Line((((PrimerForm.Image1.Width - 10) div 8) * 5) + 7,
        (PrimerForm.Image1.Height div 2) + 5,
        (((PrimerForm.Image1.Width - 10) div 8) * 5) + 7,
        (PrimerForm.Image1.Height div 2) - 5);
      Font.Size := 10;
      Font.Style := [fsBold];
      Font.Name := 'Courier';
      Font.Color := clBlue;
      TextOut((PrimerForm.Image1.Width div 2) - 10,
        (PrimerForm.Image1.Height div 2) + 10, '0');
      TextOut(((PrimerForm.Image1.Width - 10) div 8) * 3,
        (PrimerForm.Image1.Height div 2) + 10, '-1');
      TextOut(((PrimerForm.Image1.Width - 10) div 8) * 5 + 4,
        (PrimerForm.Image1.Height div 2) + 10, '1');
      Line((PrimerForm.Image1.Width div 2) - 5, PrimerForm.Image1.Height - 5,
        PrimerForm.Image1.Width div 2 + 5, PrimerForm.Image1.Height - 5);
      Line((PrimerForm.Image1.Width div 2) - 5, 5, PrimerForm.Image1.Width div 2 + 5, 5);
      TextOut((PrimerForm.Image1.Width div 2) - 20, PrimerForm.Image1.Height - 20, '-1');
      TextOut((PrimerForm.Image1.Width div 2) - 15, 10, '1');
    end;
    Button1.Hide;
    Edit1.Show;
    Edit4.Hide;
    Label5.Hide;
    Edit2.Show;
    Label2.Show;
    Label3.Show;
    Label4.Show;
    Edit3.Show;
    Image2.Hide;
    Button3.Hide;
    Button2.Show;
    Label1.Caption := 'Функция (1+x)^-1';
  end
  else if ComboBox1.Caption = 'Диаграмма' then
  begin
    with PrimerForm.Image1.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clForm;
      FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
    end;
    Button1.Hide;
    Edit4.Show;
    Label5.Show;
    Image2.Show;
    Button3.Show;
    Label2.Hide;
    Label3.Hide;
    Button2.Hide;
    Edit1.Hide;
    Edit3.Hide;
    Edit2.Hide;
    Label4.Hide;
    Label1.Caption := 'Диаграмма';
  end
  else
  begin
    with PrimerForm.Image1.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clForm;
      FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
    end;
    Button1.Hide;
    Button2.Hide;
    Button3.Hide;
    Edit1.Hide;
    Edit2.Hide;
    Image2.Hide;
    Edit4.Hide;
    Label5.Hide;
    Label2.Hide;
    Label4.Hide;
    Edit3.Hide;
    Label3.Hide;
    Label1.Caption := 'Выберите режим';
  end;
end;

procedure TPrimerForm.Edit3Click(Sender: TObject);
begin
  with PrimerForm.Image1.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clForm;
    FillRect(0, 0, PrimerForm.Image1.Width, PrimerForm.Image1.Height);
    Pen.Color := clBlack;
    Pen.Width := 1;
    Line(0, (PrimerForm.Image1.Height div 2), PrimerForm.Image1.Width,
      (PrimerForm.Image1.Height div 2));
    Line(PrimerForm.Image1.Width div 2, 0, PrimerForm.Image1.Width div
      2, PrimerForm.Image1.Height);
    Line(PrimerForm.Image1.Width - 5, (PrimerForm.Image1.Height div 2) +
      5, PrimerForm.Image1.Width - 5, (PrimerForm.Image1.Height div 2) - 5);
    Line(5, (PrimerForm.Image1.Height div 2) + 5, 5,
      (PrimerForm.Image1.Height div 2) - 5);
    Line((((PrimerForm.Image1.Width - 10) div 8) * 3) + 7,
      (PrimerForm.Image1.Height div 2) + 5,
      (((PrimerForm.Image1.Width - 10) div 8) * 3) + 7,
      (PrimerForm.Image1.Height div 2) - 5);
    Line((((PrimerForm.Image1.Width - 10) div 8) * 5) + 7,
      (PrimerForm.Image1.Height div 2) + 5,
      (((PrimerForm.Image1.Width - 10) div 8) * 5) + 7,
      (PrimerForm.Image1.Height div 2) - 5);
    Font.Size := 10;
    Font.Style := [fsBold];
    Font.Name := 'Courier';
    Font.Color := clBlue;
    TextOut((PrimerForm.Image1.Width div 2) - 10,
      (PrimerForm.Image1.Height div 2) + 10, '0');
    TextOut(((PrimerForm.Image1.Width - 10) div 8) * 3,
      (PrimerForm.Image1.Height div 2) + 10, '-1');
    TextOut(((PrimerForm.Image1.Width - 10) div 8) * 5 + 4,
      (PrimerForm.Image1.Height div 2) + 10, '1');
    Line((PrimerForm.Image1.Width div 2) - 5, PrimerForm.Image1.Height - 5,
      PrimerForm.Image1.Width div 2 + 5, PrimerForm.Image1.Height - 5);
    Line((PrimerForm.Image1.Width div 2) - 5, 5, PrimerForm.Image1.Width div 2 + 5, 5);
    TextOut((PrimerForm.Image1.Width div 2) - 20, PrimerForm.Image1.Height - 20, '-1');
    TextOut((PrimerForm.Image1.Width div 2) - 15, 10, '1');
  end;
end;




{ TPrimerForm }
begin

end.
