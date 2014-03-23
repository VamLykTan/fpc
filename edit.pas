unit edit;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ComCtrls;

type

  { TPlanEdit }

  TPlanEdit = class(TForm)
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PlanEdit: TPlanEdit;

implementation

Uses main, Konvert;

{$R *.lfm}

{ TPlanEdit }

procedure TPlanEdit.FormShow(Sender: TObject);
begin
  //
end;

procedure TPlanEdit.MenuItem2Click(Sender: TObject);
begin

end;

procedure TPlanEdit.StringGrid1Click(Sender: TObject);

  procedure FTA(Row: Word);
  var a: Byte;
      Info: Array of String;
  begin
    SetLength(Info, 4);
    Form2.LabeledEdit0.Text := PlanEdit.StringGrid1.Cells[a+1, Row];
    Form2.ComboBox1.Text    := PlanEdit.StringGrid1.Cells[a+1, Row];
    for a:= 0 to 3 do begin
      info[a]               := PlanEdit.StringGrid1.Cells[a+1, Row];
    end;
    StrResult(Info, '#', Form2.LabeledEdit1.Text);
  end;

begin
  FTA(Row);
  Form2.Show;
end;

end.

