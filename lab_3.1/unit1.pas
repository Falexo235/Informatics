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
    FunctionLabel: TLabel;
    HeaderLabel: TLabel;
    FuncValueLabel: TLabel;
    IterValueLabel: TLabel;
    EpsLabel: TLabel;
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
    {}
  public
    {}
  end;
var Form1: TForm1;
    implementation

procedure TForm1.ExitButtonClick(Sender:TObject);
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
    var x,eps:real;
      s:real;
      k:integer;
      a:real;
    begin
      S:=1; a:=1; k:=2;
      try
        x:=StrToFloat(ArgEdit.Text);
      except
        ShowMessage('Error in argument');
        Exit;
      end;
      try
        eps:=StrToFloat(EpsEdit.Text);
      except
        ShowMessage('Error in eps');
        Exit;
      end;
    s:=1; a:=1; k:=2;
    while abs(a) > eps do
          begin
            a:=-x*a;
            s:=s+a;
            k:= k+1;
          end;
    FuncValueLabel.Caption:=FloatToStr(s);
    FunctionLabel.Caption:=IntToStr(k);
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

