unit unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, LCLProc, strutils, LazUTF8, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// Функция FindInMemo: Возвращает позицию найденной строки
function FindInMemo(AMemo: TMemo; AString: String; StartPos: Integer): Integer;
begin
  Result := PosEx(AString, AMemo.Text, StartPos);
  if Result > 0 then
  begin
    AMemo.SelStart := UTF8Length(PChar(AMemo.Text), Result - 1);
    AMemo.SelLength := Length(AString);
    AMemo.SetFocus;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.Button2Click(Sender: TObject);
const
  SearchStr: String = '';                     // Строка, которую ищем
  SearchStart: Integer = 0;                   // Позиция, с которой начинаем искать строку
begin
  if SearchStr <> Edit1.Text then begin
    SearchStart := 0;
    SearchStr := Edit1.Text;
  end;
  SearchStart := FindInMemo(Memo1, SearchStr, SearchStart + 1);

  if SearchStart > 0 then
    Caption := 'Найдена в позиции['+IntToStr(SearchStart)+']!'
  else
    Caption := 'Нет совпадений!';
end;

end.

