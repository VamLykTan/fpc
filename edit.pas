unit edit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ComCtrls, ValEdit;

type

  { TPlanEdit }

  TPlanEdit = class(TForm)
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PlanEdit: TPlanEdit;

implementation

{$R *.lfm}

{ TPlanEdit }

procedure TPlanEdit.FormCreate(Sender: TObject);
begin
  // Aufbau des Fenstern
end;

end.

