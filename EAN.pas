unit EAN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, NewtonMethod, Types, Math;

type
  TMain = class(TForm)
    label_aritmetic: TLabel;
    radio_floatPoint: TRadioButton;
    radio_Section: TRadioButton;
    label_input_x0: TLabel;
    edit_x0_from: TEdit;
    edit_x0_to: TEdit;
    label_function: TLabel;
    label_numberIteration: TLabel;
    edit_eps: TEdit;
    button_start: TButton;
    label_score: TLabel;
    label_iteration: TLabel;
    label_scoreOutput: TLabel;
    label_faultOutput: TLabel;
    label_from: TLabel;
    label_to: TLabel;
    Label3: TLabel;
    label_blad: TLabel;
    label_blad_number: TLabel;
    label_stan: TLabel;
    label_stan_number: TLabel;
    edit_max_it: TEdit;
    label_max_it: TLabel;
    procedure clearEditNumberIteration(Sender: TObject);
    procedure rewriteNumber(Sender: TObject);
    procedure radioFloatClick(Sender: TObject);
    procedure radioSectionClick(Sender: TObject);
    procedure startClick(Sender: TObject);
    function checkFieldX0(mode : Boolean): Boolean;
    function checkFieldEps():Boolean;
    function checkFieldMit():Boolean;
    function checkFields(mode : Boolean) : Boolean;
    procedure keyPress(Sender: TObject; var Key: Char);



  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Main: TMain;
  wielomian : array of Extended;
  iterator : integer;
  rownanieWielomianu : String;

  x : Extended;  //pocz�tkowe przybli�enie
  f, df : fx;
  mit : Integer; //maksymalna liczba iteracji
  eps : Extended; //b��d wzgl�dny
  fatx : Extended; //warto�� funkcji dla
  it : Integer;
  st : Integer;
  wynik : Extended;




//  function Newton(x : Extended;  f : fx ; df : fx; mit : Integer; eps : Extended; fatx : Extended; it : Integer; st : Integer) : Extended;

implementation

{$R *.dfm}

//FUNKCJE

//**************************************************************
procedure TMain.clearEditNumberIteration(Sender: TObject);
begin
  edit_eps.Clear;
end;

procedure TMain.keyPress(Sender: TObject; var Key: Char);  //w�asna obs�uga klawiszy
begin
   if (not ((ord(key) in [48..57]) or (ord(key) in [44..45]) or (ord(key) = 8))) then key := #0;

end;

procedure TMain.radioFloatClick(Sender: TObject);
begin
  edit_x0_To.ReadOnly := true;
end;

procedure TMain.radioSectionClick(Sender: TObject);
begin
  edit_x0_to.ReadOnly := false;
end;

procedure TMain.rewriteNumber(Sender: TObject);
begin
  if radio_floatPoint.Checked then
    begin
      edit_x0_to.Text := edit_x0_from.Text;
    end;
end;






procedure TMain.startClick(Sender: TObject);
var
  checkX0 : Boolean;
  checkMit : Boolean;
  checkEps : Boolean;
begin

    if radio_floatPoint.Checked then  //wybrano arytmetyk� zwyk��
      begin
        if checkFields(true) then
          begin
            showMessage('Dane si� zgadzaj�');
            //odpal funkcj�
          end;
      end
    else
    begin
      //arytmetyka przedzia�owa
    end;
    it := 0;
    x := 3.14;
    showMessage(Concat('wynik=',FloatToStr(x)));
    x := Newton (x, f, df, mit, eps, fatx , it, st);
    showMessage(Concat('it=',IntToStr(it)));
    showMessage(Concat('wynik=',FloatToStr(x)));
end;

function TMain.checkFields(mode : Boolean) : Boolean;
var
  checkX0 : Boolean;
  checkMit : Boolean;
  checkEps : Boolean;
begin
  checkX0 := false;
  checkMit := false;
  checkEps := false;
        if checkFieldX0(mode) then
        begin
          showMessage('x0 si� zgadza');
          checkX0 := true;
        end;
        if checkFieldEps() then
          begin
            showMessage('Eps si� zgadza');
            checkEps := true;
          end;
        if checkFieldMit() then
          begin
            showMessage('Mit si� zgadza');
            checkMit := true;
          end;
        Result := checkX0 and checkEps and checkMit;
end;

function TMain.checkFieldX0(mode : Boolean): Boolean;
begin
if mode then    //true zwyk�a, false przedzia�owa
  begin
    if edit_x0_from.Text = '' then
      begin
        showMessage('Pole "x0 Od" jest puste');
        Result := false;
      end
    else
      begin
        x:= StrToFloat(edit_x0_from.Text);
        Result := true;
        showMessage(Concat('x0=',FloatToStr(x)));
      end;
  end
else
  begin
    if (edit_x0_from.Text = '') or (edit_x0_to.Text = '') then
      begin
        showMessage('Pola x0 : Od oraz Do nie mog� by� puste!');
        Result := false;
      end;
    //je�li A mniejsze od B


    //arytmetyka przedzia�owa
  end;
end;

function TMain.checkFieldEps():Boolean;
begin
   if edit_eps.Text = '' then
     begin
       showMessage('Pole dok�adno�� nie mo�e by� puste!');
       Result := false;
     end
   else
     begin
        eps := Power(10, StrToInt(edit_eps.Text));
        Result := true;
     end;
end;

function TMain.checkFieldMit():Boolean;
begin
  if edit_max_it.Text = '' then
    begin
      showMessage('Pole maksymalna liczba iteracji nie mo�e by� puste!');
      Result := false;
    end
  else
    begin
      mit := StrToInt(edit_max_it.Text);
      Result := true;
    end;


end;

//function Newton(x : Extended;  f : fx ; df : fx; mit : Integer; eps : Extended; fatx : Extended; it : Integer; st : Integer) : Extended;
//begin
//
//
//end;




end.
