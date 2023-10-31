unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TIterForm }

  { TForm1 }

  TForm1 = class(TForm)
    ArgEdit: TEdit;
    ArgLabel: TLabel;
    ExitButton: TButton;
    CalcButton: TButton;
    EpsEdit: TEdit;
    IterLabel: TLabel;
    HeaderLabel: TLabel;
    FuncValueLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure ArgEditChange(Sender: TObject);
    procedure EpsEditChange(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure CalcButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionLabelClick(Sender: TObject);
    procedure FuncValueLabelClick(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

procedure TForm1.ExitButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ArgEditChange(Sender: TObject);
begin

end;

procedure TForm1.EpsEditChange(Sender: TObject);
begin

end;

procedure TForm1.CalcButtonClick(Sender: TObject);
var
  x1, x2, eps, f1, f2, s, x, x0: real;
var
  i, j, n: integer;
begin
  try
    x1 := StrToFloat(ArgEdit.Text);
  except
    ShowMessage('Error in start');
    Exit;
  end;
  try
    x2 := StrToFloat(EpsEdit.Text);
  except
    ShowMessage('Error in end');
    Exit;
  end;
  with TStringList.Create do
    try

      s := (abs(x2 - x1) / 10);
      x0 := (x1);
      x := 0 - x0;
      for i := 1 to 10 do
      begin
        f1 := (1 / (1 + x0));
        Add('значения ' + IntToStr(i));
        Add('eps  f  n');
        eps := 0.1;
        n := 1;
        f2 := 1;
        for j := 1 to 6 do
        begin
          while (abs(f2 - f1)) > eps do
          begin
            f2 := f2 + x;
            n := n + 1;
            x := x * x0 * (-1);
          end;
          Add(floattostr(eps) + '  ' + floattostr(f2) + '  ' + IntToStr(n));
          eps := eps * 0.1;
        end;
        x0 := x0 + s;
        x := 0 - x0;
        f1 := (1 / (1 + x));
      end;
      SaveToFile('Results.txt');
    finally
      Free;
    end;
  FuncValueLabel.Caption := 'Результат записан в Results.txt';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.FunctionLabelClick(Sender: TObject);
begin

end;

procedure TForm1.FuncValueLabelClick(Sender: TObject);
begin

end;

initialization
      {$I unit1.lrs}
end.
