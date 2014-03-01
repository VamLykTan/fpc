program vdp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, SysUtils, IniFiles, uData, sett, Main, About, webhelp, edit,
  { API-Units }
  konvert;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  if not FileExists('Setting.svp') then
  begin
    Application.CreateForm(TForm1, Form1);
  end;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TInfo, Info);
  Application.CreateForm(TPlanEdit, PlanEdit);
//  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

