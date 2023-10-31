unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,FileUtil,LResources,ShellAPI,Windows,ExtCtrls;

type

  { TListForm }

  TListForm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Lin: TButton;
    FileOpenButton: TButton;
    FileSaveButton: TButton;
    FileMemo: TMemo;
    FileSaveDIalog: TSaveDialog;
    FileOpenDialog: TOpenDialog;
    Upor: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
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
  A,B,C,Y:array of integer;
  IT:TStrings;
  p1,p2,p3:integer;
  end;

var
  ListForm: TListForm;

implementation
{$R *.lfm}

{ TListForm }
procedure S(var X,Y:array of integer; b1,e1,e2:integer);
  var i1,i2,j:integer;
begin
  i1:=b1; i2:=e1+1; j:=b1;
  while (i1<=e1)and(i2<=e2) do begin
    if X[i1]<=X[i2] then begin
      Y[j]:=X[i1]; i1:=i1+1;
    end
    else  begin
    Y[j]:=X[i2]; i2:=i2+1;
    end;
    j:=j+1
  end;
  while i1<=e1 do begin
    Y[j]:=X[i1]; i1:=i1+1; j:=j+1;
  end;
  while i2<=e2 do begin
    Y[j]:=X[i2]; i2:=i2+1; j:=j+1;
  end;
end;
procedure sort(var X,Y: array of integer; b,e:integer);
  var c,k:integer;
  begin
    if b<e then begin
      c:=(b+e) div 2;
      sort(X,Y,b,c);
      sort(X,Y,c+1,e);
      S(X,Y,b,c,e);
      for k:=b to e do X[k]:=Y[k]
    end
  end;
procedure TListForm.FileSaveButtonClick(Sender: TObject);
var outf:textfile;
begin
  ListForm.FileMemo.Lines.Clear;
  ListForm.FileMemo.Lines.Add('Укажите файл для сохранения списка');
  if ListForm.FileSaveDialog.Execute then begin
    assignfile(outf,ListForm.FileSaveDialog.FileName);
    with IT do
    try
      SaveToFile(ListForm.FileSaveDialog.FileName);
    finally
    end;
    ListForm.FileMemo.Lines.Clear;
    ListForm.FileMemo.Lines.Add('Список записан в файл '+ListForm.FileSaveDialog.FileName);
    end
  else;
end;

procedure TListForm.FormCreate(Sender: TObject);
begin
  IT:=TStringList.Create;
end;


procedure TListForm.LinClick(Sender: TObject);
var i:integer;
begin
  ListBox1.Items.Clear;
  p2:=StrToInt(Edit1.Text);
  if p2<1 then exit;
  setlength(A,p2);
  for i:=1 to p2 do begin
    A[i]:=random(1999)-999;
    if i<=40 then
    ListBox1.Items.Add(IntToStr(A[i]));
end;
  if p2>40 then ListBox1.Items.Add('...');
end;

procedure TListForm.SliyClick(Sender: TObject);
var i,j,k:integer;
begin
  if (p1>0) and (p2>0) then begin
    p3:=p1+p2;
    ListBox3.Items.Clear;
    setlength(C,p3+1);
    setlength(Y,p3+1);
    i:=1;
    j:=1;
    k:=1;
    sort(A,Y,1,p2);
    while (i<=p2) and (j<=p1) do begin
      if A[i]<=B[j] then begin
      C[k]:=A[i];
      k:=k+1;
      i:=i+1;
      end
      else begin
        C[k]:=B[j];
        k:=k+1;
        j:=j+1;
      end;
    end;
    while i<=p2 do begin;
      C[k]:=A[i];
      k:=k+1;
      i:=i+1;
  end;
    while j<=p1 do begin
      C[k]:=B[j];
      k:=k+1;
      j:=j+1;
end;
    IT.Clear;
    for i:=1 to p3 do begin
      IT.Add(IntToStr(C[i]));
end;
    if p3>40 then begin
    for i:=1 to 40 do ListBox3.Items.Add(IntToStr(C[i]));
    ListBox3.Items.Add('...');
    end
    else if p3<=40 then begin
    For i:=1 to p3 do ListBox3.Items.Add(IntToStr(C[i]));
    end;
end;
  setlength(Y,0);
end;

procedure TListForm.UporClick(Sender: TObject);
          var i:integer;
begin
  p1:=StrToInt(Edit1.Text);
     if p1<1 then exit;
  ListBox2.Clear;
  setlength(B,p1+1);
  setlength(Y,p1+1);
  for i:=1 to p1 do begin
    B[i]:=random(1999)-999;
end;
  sort(B,Y,1,p1);
  if p1<=40 then for i:=1 to p1 do ListBox2.Items.Add(IntToStr(B[i]))
  else begin for i:=1 to 40 do ListBox2.Items.Add(IntToStr(B[i]));
    ListBox2.Items.Add('...');
end;
  setlength(Y,0);
end;

procedure TListForm.FileOpenButtonClick(Sender: TObject);
var err_code:integer;
begin
  FileMemo.Lines.Clear;
  FileMemo.Lines.Add('Укажите файл');
  if FileOpenDialog.Execute then begin
    if FileExists(FileOpenDialog.FileName) then begin
      FileMemo.Lines.Add('Открыт файл '+FileOpenDialog.Filename);
      err_code:=ShellExecute(ListForm.Handle,'open',
      PChar(FileOpenDialog.FileName),nil,nil,SW_SHOW);
      if err_code<=32 then begin
        ListForm.FileMemo.Lines.Clear;
        ListForm.FileMemo.Lines.Add('Ошибка чтения файла '+FileOpenDialog.Filename);
        ListForm.FileMemo.Lines.Add('Код='+IntToStr(err_code));
      end

    end
     else FileMemo.Lines.Add('Файл '+FileOpenDialog.Filename+ ' не найден');
end;
end;
end.

