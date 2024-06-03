{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit Unit1;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IFNDEF KOL_MCK}, mirror, Classes, Controls, mckCtrls, mckObjs, Graphics {$ENDIF (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;
{$ENDIF}

type
  {$IFDEF KOL_MCK}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TForm1class.inc} {$ELSE OBJECTS} PForm1 = ^TForm1; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TForm1.inc}{$ELSE} TForm1 = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TForm1 = class(TForm)
  {$ENDIF KOL_MCK}
    KOLProject1: TKOLProject;
    Timer1: TKOLTimer;
    Label1: TKOLLabel;
    Label2: TKOLLabel;
    Label3: TKOLLabel;
    Label4: TKOLLabel;
    groupOptions: TKOLGroupBox;
    cbQuick: TKOLCheckBox;
    cbCompression: TKOLCheckBox;
    cbStartup: TKOLCheckBox;
    comboCapacity: TKOLComboBox;
    comboFilesystem: TKOLComboBox;
    comboAlloc: TKOLComboBox;
    btnStart: TKOLButton;
    btnClose: TKOLButton;
    editLabel: TKOLEditBox;
    Progress1: TKOLProgressBar;
    KOLForm1: TKOLForm;
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure comboFilesystemChange(Sender: PObj);
    procedure btnCloseClick(Sender: PObj);
    procedure btnStartClick(Sender: PObj);
    procedure Timer1Timer(Sender: PObj);
  private
    procedure FormatDisk;
    procedure PrepareNTFS;
  public
    { Public declarations }
  end;

var
  Form1 {$IFDEF KOL_MCK} : PForm1 {$ELSE} : TForm1 {$ENDIF} ;
  BufLabel: array [0..255] of Char;

{$IFDEF KOL_MCK}
procedure NewForm1( var Result: PForm1; AParent: PControl );
{$ENDIF}

implementation

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I Unit1_1.inc}
{$ENDIF}


function NumBytes(Value: Double): String;
const
  Suffix = 'KMGT';
var
  V, I : Integer;
begin
  Result := '';
  I := 0;
  while (Value >= 1024) and (I < 4) do
  begin
    Inc(I);
    Value := Value/1024.0;
  end;
  Result := Int2Str(Trunc(Value));
  V := Trunc((Value - Trunc(Value))* 100);
  if V <> 0 then
  begin
    if (V mod 10) = 0 then V := V div 10;
    Result := Result + '.' + Int2Str(V);
  end;
  if I > 0 then Result := Result + ' ' + Suffix[I] + 'B';
end;


procedure TForm1.FormatDisk;
begin
  comboCapacity.Enabled := True;
  comboCapacity.Color := clWindow;
  comboFilesystem.Enabled := True;
  comboFilesystem.Color := clWindow;
  comboAlloc.Enabled := True;
  comboAlloc.Color := clWindow;
  editLabel.Enabled := True;
  editLabel.Color := clWindow;
  cbQuick.Enabled := True;
  cbCompression.Enabled := True;
  btnStart.Enabled := True;
  btnClose.Caption := 'Close';
  Progress1.Progress := 0;
end;

procedure TForm1.PrepareNTFS;
begin
  comboAlloc.Clear;
  comboAlloc.Items[0] := 'Default allocation size';
  comboAlloc.Items[1] := '512 bytes';
  comboAlloc.Items[2] := '1024 bytes';
  comboAlloc.Items[3] := '2048 bytes';
  comboAlloc.Items[4] := '4096 bytes';
  cbCompression.Enabled := True;
  comboAlloc.CurIndex := 4;
end;

procedure TForm1.KOLForm1FormCreate(Sender: PObj);
var
  NotUsed: DWORD;
  Total_size: I64;
begin
  GetVolumeInformation(PChar('C:\'), BufLabel, DWORD(SizeOf(BufLabel)), nil, NotUsed, NotUsed, nil, 0);
  Form.Caption := 'Format (C:) ' + BufLabel;     // set form caption

  GetDiskFreeSpaceEx(PChar('C:\'), NotUsed, Total_size, nil);
  comboCapacity.Items[0] := NumBytes(Int64_2Double(Total_size));    // set Capacity
  PrepareNTFS;   // set default parameters: allocation unit size + enable compression (NTFS)
  editLabel.Text := BufLabel;
end;

procedure TForm1.comboFilesystemChange(Sender: PObj);
begin
  if comboFilesystem.CurIndex = 0 then PrepareNTFS       // if NTFS selected
  else                                  // if FAT32 selected
  begin
    comboAlloc.Clear;
    comboAlloc.Items[0] := 'Default allocation size';
    comboAlloc.CurIndex := 0;
    cbCompression.Enabled := False;
  end;
end;

procedure TForm1.btnCloseClick(Sender: PObj);
begin
  if btnClose.Caption = 'Close' then PostQuitMessage(0)
  else                            // if Close button is Cancel (during formatting)
  begin
    Timer1.Enabled := False;
    Form.Caption := 'Format (C:) ' + BufLabel;
    FormatDisk;
  end;
end;

procedure TForm1.btnStartClick(Sender: PObj);      // formatting
begin
  if MessageBox(Form.Handle, PChar('WARNING: Formatting will erase ALL data on this disk.' + #13 + 'To format the disk, click OK. To quit, click CANCEL.'),
  PChar('Format (C:) ' + BufLabel), MB_OKCANCEL or MB_DEFBUTTON1 or MB_ICONWARNING) = 1 then
  begin
    Form.Caption := 'Formatting (C:) ' + BufLabel;
    comboCapacity.Enabled := False;
    comboCapacity.Color := clBtnFace;
    comboFilesystem.Enabled := False;
    comboFilesystem.Color := clBtnFace;
    comboAlloc.Enabled := False;
    comboAlloc.Color := clBtnFace;
    editLabel.Enabled := False;
    editLabel.Color := clBtnFace;
    cbQuick.Enabled := False;
    cbCompression.Enabled := False;
    btnStart.Enabled := False;
    btnClose.Caption := 'Cancel';
    Timer1.Enabled := True;
  end;
end;

procedure TForm1.Timer1Timer(Sender: PObj);          // progress of formatting process
begin
  if cbQuick.Checked then Progress1.Progress := 25
  else Progress1.Progress := Progress1.Progress + 1;

  if Progress1.Progress = 25 then
  begin
    Timer1.Enabled := False;
    if MessageBox(Form.Handle, PChar('Format Complete.'), PChar('Formatting (C:) ' + BufLabel), MB_OK or MB_ICONINFORMATION) = 1 then
    begin
      Form.Caption := 'Format (C:) ' + editLabel.Text;
      FormatDisk;
    end;
  end;
end;

end.