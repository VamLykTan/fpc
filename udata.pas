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
    procedure   GetKabel(index: Int64; Value: array of TKabel);
    procedure   SetKabel(Value: TKabel);
    property    Kabel: TKabel {read fKabel }write SetKabel;
    property    _File: String read GetFile  write SetFile;
//    property    UpDate
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
       i:= Temp.Capacity div 9;
       SetLength(fKabel, i);
       fData.index:= i;
       end;
     end
  else begin
    SetLength(fKabel, 10);
    fData.index:= 10;
  end;
end;

destructor TPlan.Done;
begin
  inherited;
end;

procedure TPlan.GetKabel(index: Int64; Value: array of TKabel);
var Temp : TStringlist;
    s: String;
    a: int64;
begin
  fData.Filename := Format('%s', [fData.Geraet + 'vpl']);
  if FileExists(fData.Filename) then begin
    Temp := TStringlist.Create;
    Temp.LoadFromFile(fData.Filename);
    a:= (Temp.Capacity div 9);
    Temp.Free;
    with TIniFile.Create(fData.Filename) do try
      s:= Format('[%s]', ['Leitung'+IntToStr(a)]);
      for A:= 0 to (Temp.Capacity div 9) do begin
          Value[a, 0] := ReadString(s, 'Quelle'              , '');
          Value[a, 1] := ReadString(s, 'Kontaktart Quelle'   , '');
          Value[a, 2] := ReadString(s, 'Leitungstyp'         , '');
          Value[a, 3] := ReadString(s, 'Leitungsquerschnitt' , '');
          Value[a, 4] := ReadString(s, 'Leitungslänge'       , '');
          Value[a, 5] := ReadString(s, 'Leitungsfarbe'       , '');
          Value[a, 6] := ReadString(s, 'Kontaktart Ziel'     , '');
          Value[a, 7] := ReadString(s, 'Zielkontakt'         , '');
      end;
    finally
      Free;
    end;
  end;
//  fKabel[fData.index] := GetKabel;
end;

function TPlan.GetFile: String;
begin
  result:= fData.Filename;
end;

procedure TPlan.SetKabel(Value: TKabel);
var s: String;
    a: int64;
begin
  fData.Filename:= Format('%s', [fData.Geraet + '.vpl']);
  if FileExists(fData.Filename) then DeleteFile(fData.Filename);
  with TIniFile.Create(fData.Filename) do try
    for a := 0 to fData.index do begin
      s:= Format('[%s]', ['Leitung'+IntToStr(a)]);
      WriteString(s, 'Quelle'              , Value[0]);
      WriteString(s, 'Kontaktart Quelle'   , Value[1]);
      WriteString(s, 'Leitungstyp'         , Value[2]);
      WriteString(s, 'Leitungsquerschnitt' , Value[3]);
      WriteString(s, 'Leitungslänge'       , Value[4]);
      WriteString(s, 'Leitungsfarbe'       , Value[5]);
      WriteString(s, 'Kontaktart Ziel'     , Value[6]);
      WriteString(s, 'Zielkontakt'         , Value[7]);
      end;
    finally
      Free;
    end;
end;

procedure TPlan.Setfile(Value: String);
begin
  fData.Filename:= Value;
end;

end.

