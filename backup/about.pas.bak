unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ubarcodes, uData;

type

  { TInfo }

  TInfo = class(TForm)
    BarcodeQR1: TBarcodeQR;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    Lizenz: TLizenz; // Classendefinition
    Firma:  TFirma;  // Typendefinition
    { public declarations }
  end;

var
  Info: TInfo;

Const Version :String = 'V.0.01.08.22022014';

implementation

{$R *.lfm}

{ TInfo }

procedure TInfo.FormCreate(Sender: TObject);
begin
  Lizenz:= TLizenz.Create;
end;

procedure TInfo.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then Info.Close;
end;

procedure TInfo.FormShow(Sender: TObject);
begin
  BarcodeQR1.Text:= 'Verdrahtungsplan Editor ' + Version +
                    ' Idee, Umrestzung und Programmierung von Maik Geßner ' +
                    'Diese Lizens ist Güldig für ' + Firma.User + ' mit der ' +
                    'Lizenznummer: ' + Firma.Lizenz;
end;

end.

