unit uData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

Type


  TFirma = Record
    User, Lizenz: String;
  end;

  TKabel = Array[0..7] of String;

  TLizenz = class
    fFirma    : TFirma;
    fPath,
    fFilename : String;
  private
    function GetFirma: TFirma;
    procedure SetFirma(Value: TFirma);
  public
    constructor Create;
    destructor Done;
    property Firma: TFirma read GetFirma write SetFirma;
  end;

  TPlan = class
    fKabel      : array of TKabel; //TKABEL: Array [0..7] of String;
    fData       : record
      Filename,
      Geraet    : String;
      index     : int64;
      end;
  private
    function    GetFile  : String;
    procedure   Setfile(Value: String);
  public
    constructor Create;
    destructor  Done;
    procedure   GetKabel;
    procedure   SetKabel;
    property    _File: String read GetFile  write SetFile;
  end;

implementation

{ TLizenz }

constructor TLizenz.Create;
begin
  inherited;
  fFilename:= Format('%s', ['Setting.svp']);
  if FileExists(fFilename) then fFirma:= GetFirma;
end;

Destructor TLizenz.Done;
begin
  inherited;
end;

function TLizenz.GetFirma: TFirma;
var s: String;
begin
  s:= Format('[%s]', ['Lizenznehmer']);
  if FileExists(FPath + fFilename) then begin
    with TIniFile.Create(fFilename) do try
      fFirma.User   := ReadString(s, 'Firma' , ' ');
      fFirma.Lizenz := ReadString(s, 'Lizenz', ' ');
    finally
      Free;
    end;
  end;
  Result:= fFirma;
end;

procedure TLizenz.SetFirma(Value: TFirma);
var s: String;
begin
  s:= Format('[%s]', ['Lizenznehmer']);
  if FileExists(fFilename) then DeleteFile(fFilename);
  with TIniFile.Create(fFilename) do try
    WriteString(s, 'Firma',  Value.User);
    WriteString(s, 'Lizenz', Value.Lizenz);
  finally
    Free;
  end;
end;

{ TPlan }

constructor TPlan.Create;
var Temp : TStringlist;
    i    : Integer;
begin
  inherited;
  if fData.Filename <> '' then begin
     fData.Filename:= Format('%s', [fData.Geraet + '.vpl']);
     if FileExists(fData.Filename) then begin
       Temp:= TStringlist.Create;
       Temp.LoadFromFile(fData.Filename);
       i:= Temp.Count div 9;
       SetLength(fKabel, i);
       fData.index:= i;
       end;
     end
  else begin
    SetLength(fKabel, 2);
    fData.index:= 2;
  end;
end;

destructor TPlan.Done;
begin
  inherited;
end;

procedure TPlan.GetKabel;
var Temp : TStringlist;
    s: String;
    a, b: Word;
begin
  fData.Filename := Format('%s', [fData.Geraet + '.vpl']);
  B:= 0;
  if FileExists(fData.Filename) then begin
    with TIniFile.Create(fData.Filename) do try
      Temp:= TStringList.Create; try
        ReadSections(Temp);
        SetLength(fKabel, Temp.Count);
        for A:= 0 to Temp.Count-1 do begin
          s:= Format('[%s]', ['Leitung'+IntToStr(a)]);
          if (ReadString(s, 'Quelle', '') <> '') then begin
            fKabel[b, 0] := ReadString(s, 'Quelle'              , '');
            fKabel[b, 1] := ReadString(s, 'Kontaktart Quelle'   , '');
            fKabel[b, 2] := ReadString(s, 'Leitungstyp'         , '');
            fKabel[b, 3] := ReadString(s, 'Leitungsquerschnitt' , '');
            fKabel[b, 4] := ReadString(s, 'Leitungslänge'       , '');
            fKabel[b, 5] := ReadString(s, 'Leitungsfarbe'       , '');
            fKabel[b, 6] := ReadString(s, 'Kontaktart Ziel'     , '');
            fKabel[b, 7] := ReadString(s, 'Zielkontakt'         , '');
            inc(b);
          end;
        end;
      finally
        Temp.Free;
      end;
    finally
      Free;
    end;
  end;
end;

function TPlan.GetFile: String;
begin
  result:= fData.Filename;
end;

procedure TPlan.SetKabel;
var s: String;
    a: int64;
begin
  fData.Filename:= Format('%s', [fData.Geraet + '.vpl']);
  if FileExists(fData.Filename) then DeleteFile(fData.Filename);
  with TIniFile.Create(fData.Filename) do try
    for a := low(fKabel) to High(fKabel) do begin
      s:= Format('[%s]', ['Leitung'+IntToStr(a)]);
      WriteString(s, 'Quelle'              , fKabel[a, 0]);
      WriteString(s, 'Kontaktart Quelle'   , fKabel[a, 1]);
{      if ((fKabel[a, 2] = 'm') or (fKabel[a, 2] = 'M')) then
        WriteString(s, 'Leitungstyp'         , 'Mantelleitung');
      if ((fKabel[a, 2] = 'l') or (fKabel[a, 2] = 'L')) then
        WriteString(s, 'Leitungstyp'         , 'Schaltlitze');}
      WriteString(s, 'Leitungstyp'         , fKabel[a, 2]);
      WriteString(s, 'Leitungsquerschnitt' , fKabel[a, 3]);
      WriteString(s, 'Leitungslänge'       , fKabel[a, 4]);
      WriteString(s, 'Leitungsfarbe'       , fKabel[a, 5]);
      WriteString(s, 'Kontaktart Ziel'     , fKabel[a, 6]);
      WriteString(s, 'Zielkontakt'         , fKabel[a, 7]);
      end;
    finally
      fData.index:= a;
      Free;
    end;
end;

procedure TPlan.Setfile(Value: String);
begin
  fData.Filename:= Value;
end;

end.

