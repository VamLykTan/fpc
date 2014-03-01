unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, ComCtrls, uData,
  { API Units }
  konvert;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    LabeledEdit0: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    MainMenu1: TMainMenu;
    MenuItem0: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    { private declarations }
    Edit   : Array[0..1] of Boolean;
    Index  : Integer;
    procedure Form;
  public
    Lizenz : TLizenz;
    Kabel  : TKabel;
    Plan   : TPlan;
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

Uses About, webhelp, edit;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Form;
begin
  if not Edit[0] and not Edit[1] then begin
    Caption := 'Verdrahtungsplaner ';
  end;
  if not Edit[0] and     Edit[1] then begin
    form2.Width          := 330;
    LabeledEdit0.Visible := False;
    LabeledEdit1.Visible := False;
    with LabeledEdit0 do begin
      Visible                            := True;
      Left                               := 15;
      Top                                := 30;
      Width                              := 300;
      EditLabel.AnchorSideLeft.Control   := LabeledEdit0;
      EditLabel.AnchorSideRight.Control  := LabeledEdit0;
      EditLabel.AnchorSideRight.Side     := asrBottom;
      EditLabel.AnchorSideBottom.Control := LabeledEdit0;
      EditLabel.Caption                  := 'Gerätenamen eingeben';
      EditLabel.ParentColor              := True;
    end;
    with LabeledEdit1 do begin
      Visible                            := True;
      Left                               := 15;
      Top                                := 90;
      Width                              := 300;
      EditLabel.AnchorSideLeft.Control   := LabeledEdit1;
      EditLabel.AnchorSideRight.Control  := LabeledEdit1;
      EditLabel.AnchorSideRight.Side     := asrBottom;
      EditLabel.AnchorSideBottom.Control := LabeledEdit1;
      EditLabel.Caption                  := 'Artikelnummer eingeben, falls vorhanden';
      EditLabel.ParentColor              := False;
    end;
    with Button1 do begin
      Visible                            := True;
      Left                               := 15;
      Top                                := LabeledEdit1.Top + 40;
      Width                              := 64;
      Caption                            := '&Anlegen';
    end;
    with Button2 do begin
      Left                               := 300 - Button2.Width;
      Top                                := Button1.Top;
      Width                              := 64;
      Visible                            := True;
      Caption                            := 'A&bbrechen';
    end;
    Height               := Button1.Top + 40;
  end;
  if     Edit[0] and not Edit[1] then begin
    LabeledEdit0.Visible := False;
    LabeledEdit1.Visible := False;
    Button1.Visible      := False;
    Button2.Visible      := False;
    with LabeledEdit0 do begin
      EditLabel.Caption                  := 'Quellkontakt';
      Hint                               := 'Startpunkt der Verdrahtung hier eingeben.' + #13 +
                                            'Bsp.: X1.1.-1 für Wago Kontakte der Serie 200x' + #13 +
                                            '      A1.X1-1 für Klemm- und Schraubkontakte bei Baugruppen.';
      Text                               := '';
      Width                              := 100;
      Visible                            := True;
    end;
    with LabeledEdit1 do begin
      EditLabel.Caption                  := 'Leitungsinformationen eintragen'#10'als Trenner "#" verwenden';
      Hint                               := 'Leintungstyp, Querschnitt, Länge, Farbe.' + #13 +
                                            'Bsp. f. Litze "L#0.25²#100#ws"' + #10 +
                                            '     f. Mantel 2 Adrig geschirmt "MG#2x0.25²#1900#bn"' + #10 +
                                            '     f. Mantel 4 Adrig ungeschirmt "M#4x0.25²#1300#gn"';
      Text                               := '';
      Left                               := 15;
      Width                              := 294;
      Top                                := 110;
      Visible                            := True;
    end;
    with Label1 do begin
      Left                               := 130;
      Height                             := 16;
      Top                                := 08;
      Width                              := 181;
      Caption                            := 'Art der Kontaktverbindung';
      Visible                            := True;
    end;
    with ComboBox1 do begin
      AnchorSideLeft.Control             := Label1;
      AnchorSideRight.Control            := Label1;
      AnchorSideRight.Side               := asrBottom;
      Left                               := Label1.Left;
      Top                                := Label1.Top + 22;
      ItemHeight                         := 0;
      TabOrder                           := 4;
      Text                               := '';
      Visible                            := True;
      Hint                               := 'Hier die verwendete Kontaklart inkl.' + #13 +
                                            'Querschnitt eintragen.' + #13 + #13 +
                                            'Artikelnummer kann Optional eingegeben Werden';
    end;
    with LabeledEdit2 do begin
      Left                               := 16;
      Top                                := 168;
      Width                              := 100;
      EditLabel.AnchorSideLeft.Control   := LabeledEdit2;
      EditLabel.AnchorSideRight.Control  := LabeledEdit2;
      EditLabel.AnchorSideRight.Side     := asrBottom;
      EditLabel.AnchorSideBottom.Control := LabeledEdit2;
      EditLabel.Caption                  := 'Zielkontakt';
      Visible                            := True;
    end;
    with Label2 do begin
      Left                               := 130;
      Top                                := 146;
      Caption                            := 'Art der Kontaktverbindung';
      ParentColor                        := False;
      Visible                            := True;
    end;
    with ComboBox2 do begin
      Left                               := 130;
      Top                                := 168;
      Width                              := 181;
      Text                               := '';
      Visible                            := True;
    end;
    with Button1 do begin
      Left                               := 15;
      Top                                := 200;
      AutoSize                           := True;
      Caption                            := '&< Prev';
      Visible                            := True;
    end;
    with Button2 do begin
      Left                               := 95;
      Top                                := 200;
      AutoSize                           := True;
      Caption                            := 'Next &>';
      Visible                            := True;
    end;
    with Button3 do begin
      Top                                := 200;
      AutoSize                           := True;
      Caption                            := '&Ende der Erfassung';
      Left                               := Form2.Width - 15 - Width;
      Visible                            := True;
    end;
    Height                               := Button1.Top + 40;
  end;
  if     Edit[0] and     Edit[1] then begin

  end;
end;

procedure TForm2.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 16604) or (Key = 220) then MenuItem5.Click;
  if  Key = 49224                 then MainHelp;
  if  Key = 32833                 then Button1.Click;
  if  Key = 32834                 then Button2.Click;
//  Caption:= IntToStr(Key)
end;

procedure TForm2.Button1Click(Sender: TObject);
var i: byte;
    Filename: String;
Const Version: String = '-A01.01';
begin
  i:= 0;
  // Erstellen des Dokumentes mit laufender Nummerabfrage
  if not edit[0] and     Edit[1] then begin
    Caption := Caption + '- ' + LabeledEdit0.Text + ' Art.: ' + LabeledEdit1.Text;
    repeat
      inc(i);
      case I of
        1..9    : Filename:= LabeledEdit1.Text + '-00' + IntToStr(i) + Version;
        10..99  : Filename:= LabeledEdit1.Text + '-0'  + IntToStr(i) + Version;
      end;
    until not FileExists(Filename + '.vpl');
    Plan.fData.Geraet:= Filename;
    Caption := Caption + ' - ' + Filename + '.vpl';
    Edit[0] := True;
    Edit[1] := False;
    Form;
    StatusBar1.Panels.Items[0].Text:= Plan.fData.Filename;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
  procedure SetKabel;
  var pos  : Byte;
      info : Array [2..5] of String;
  begin
    Kabel[0] := LabeledEdit0.Caption;
    Kabel[1] := ComboBox1.Text;
    {**************************************}
    {**                                  **}
    {**  Leitungsinformationen auslesen  **}
    {**                                  **}
    {**************************************}
    StrResult(LabeledEdit1.Text, '#', Info);
    for pos := 2 to 5 do Kabel[pos] := Info[pos];
    Plan.fKabel[index]:= Kabel;
    Kabel[6] := LabeledEdit2.Text;
    Kabel[7] := ComboBox2.Text;
  end;

var Lauf : Byte;
begin
  if not Edit[0] and     Edit[1] then Close;
  if     Edit[0] and not Edit[1] then begin
    SetKabel;
//    Plan.Kabel := Kabel;
    Caption:= '';
    for lauf:= 0 to 7 do LabeledEdit1.Text := LabeledEdit1.Text + Kabel[lauf] + ' ';
    end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Plan   := TPlan.Create;
  Lizenz := TLizenz.Create;
  StatusBar1.Panels.Items[0].Text:= Lizenz.fFilename;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Form;
  Edit[0] := False;
  Edit[1] := True;
end;

procedure TForm2.MenuItem5Click(Sender: TObject);
  procedure LoadLizenz;
  begin
    with Info do begin
      Firma:= Lizenz.Firma;
    end;
  end;

begin
  LoadLizenz;
  Info.ShowModal;
end;

procedure TForm2.MenuItem8Click(Sender: TObject);
begin
  Form;
end;

procedure TForm2.MenuItem9Click(Sender: TObject);
begin
  PlanEdit.ShowModal;
end;

end.

