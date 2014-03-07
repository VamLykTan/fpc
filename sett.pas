unit sett;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LabeledEdit1: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses lclintf, main, webhelp, about;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
//  Lizenz:= TLizenz.Create;
  Form1.Caption:= 'Verdrahtungsplaner - Setting';
  LabeledEdit1.EditLabel.Caption:= 'Bitte Firmenamen eingeben';;
  with Button1 do
    begin
    Caption    := '&OK';
    ShowHint   := True;
    Hint       := 'Speichert die Daten, Legt die Lizenz an und startet das Programm';
    end;
  with Button2 do
    begin
    Caption    := 'A&bbrechen';
    ShowHint   := True;
    Hint       := 'Beendet das Programm ohne weitere Aktionen';
    end;
  with Button3 do
    begin
    Caption    := '&?';
    end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//  Lizenz.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
  procedure Savelizenz(Value: String);
  var i: Byte;
      L: String;
  Const
      L_Start : String = '<';
      L_Stop  : String = '>';
  begin
    with Info do begin
      Firma.User     := LabeledEdit1.Text;
      Firma.Lizenz   := L_Start;
      Randomize;
      for i:= 0 to Length(Value) do begin
        L:= IntToStr(random(Length(Value) - i));
        Firma.Lizenz := Firma.Lizenz + L;
      end;
      Firma.Lizenz   := Firma.Lizenz + L_Stop;
      Lizenz.Firma   := Firma;
    end;
  end;

begin
  SaveLizenz(LabeledEdit1.Text);
  Form2.ShowModal;
  Visible:= False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Setthelp;
  OpenURL('help.html');
end;

end.

