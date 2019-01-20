unit unit2;
// приложуха с напоминанием дел.

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, strutils, LazUTF8, lclintf, FileUtil, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    TrayIcon1: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    FirstTime: Boolean;
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
    //AMemo.SetFocus;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
if FileExists('TODO.txt') then
 Memo1.Lines.LoadFromFile('TODO.txt')
else
 Memo1.Lines.AddText('Файл TODO.txt не был найден в домашнем каталоге.'+LineEnding+'После правки списка, сохраните его как TODO.txt и он будет показываться автоматически при старте программы.'+LineEnding+'Предлагаю начать работу с кнопки "нумерация жёстко".');
end;

procedure TForm1.Button3Click(Sender: TObject); // EXIT
begin
  Form1.Close();
end;

procedure TForm1.Button4Click(Sender: TObject); // OPEN
begin
     if OpenDialog1.Execute then
     Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject); // CLOSE
begin
     if SaveDialog1.Execute then
     Memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.Button1Click(Sender: TObject); // hard add list
var
  i: Integer; 
begin
  Memo1.Clear;
  for i := 1 to 9 do
    Memo1.Lines[i-1]:='0'+IntToStr(i)+'. ';
end;

procedure TForm1.Button5Click(Sender: TObject); // soft add list
var
  i,j: Integer;
begin
  i := Memo1.Lines.Count + 1; // добавляем в конец.
  for j := i to i+9 do
    Memo1.Lines.Add(IntToStr(j)+'. ');
end;

procedure TForm1.Button7Click(Sender: TObject); // find text
// переделать поиск. не ахти.
const
  SearchStr: String = '';     // Строка, которую ищем
  SearchStart: Integer = 0;   // Позиция, с которой начинаем искать строку
begin
  if SearchStr <> Edit1.Text then begin
    SearchStart := 0;
    SearchStr := Edit1.Text;
  end;
  SearchStart := FindInMemo(Memo1, SearchStr, SearchStart + 1);
  if SearchStart > 0 then
    Label2.Caption := 'позиция['+IntToStr(SearchStart)+']'
  else
    Label2.Caption := 'не найдено';
  Button7.SetFocus;
end;

procedure TForm1.Button8Click(Sender: TObject); // Убрать готовое. Строки, начинающиеся с + удалить.
// недоделка: При удалении строк, мы меняем сам массив с которым работаем. И соответственно, могут быть глюки.
// подумать как переделать. Скорее всего, сначала запомнить нужные строки, а потом хором удалить.
var
  cnt, i : Integer;
begin
  cnt := Memo1.Lines.Count -1; 
  for i:=0 to cnt do // цикл по массиву TMemo с нуля, а номера строк с 1.
    begin
      if CompareStr('+', LeftStr(Memo1.Lines[i], 1)) = 0 then
        Memo1.Lines.Delete(i);
    end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  MyURL: String;
begin
  MyURL := 'http://csn.net4me.net';
  OpenURL(MyURL);
end;


procedure TForm1.Button6Click(Sender: TObject); // Поддержка.
// Захотелось мне иметь такую кнопочку. Лично мне приятно её нажимать. =)
var
   S: String;
begin
     Memo1.Clear;
     S := 'Здравствуй родной, любимый мой. Ты уже молодец!'+LineEnding+'Я рад тебе и верю в тебя. Сейчас, здесь.'+LineEnding+'Ты очень нужен мне. Нужен. Любой.'+LineEnding+LineEnding+'У тебя получится всё чему должно получиться. Обязательно!'+LineEnding+'Ты же у меня такой умничка!'+LineEnding+'Люблю тебя и обнимаю.'+LineEnding;
     Memo1.Text:= S;
end;

// END
end.

