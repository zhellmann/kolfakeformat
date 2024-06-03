{ KOL MCK } // Do not remove this line!

procedure NewForm1( var Result: PForm1; AParent: PControl );
begin

  {$IFDEF KOLCLASSES}
  Result := PForm1.Create;
  {$ELSE OBJECTS}
  New( Result, Create );
  {$ENDIF KOL CLASSES/OBJECTS}
  Result.Form := NewForm( AParent, 'Form1' ).SetPosition( 257, 120 );
  Applet :=  Result.Form;
  Result.Form.Add2AutoFree( Result );
    Result.Form.SetClientSize( 253, 370 );

    Result.Timer1 := NewTimer( 1000 );
  Result.Form.Add2AutoFree( Result.Timer1 );
      Result.Timer1.OnTimer := Result.Timer1Timer;
    Result.Label1 := NewLabel( Result.Form, 'Capacity:' ).SetPosition( 10, 10 ).SetSize( 103, 17 );
    Result.Label1.Font.FontHeight := -11;
    Result.Label1.Font.FontName := 'Tahoma';
    Result.Label2 := NewLabel( Result.Form, 'File system' ).SetPosition( 10, 58 ).SetSize( 151, 17 );
    Result.Label2.Font.FontHeight := -11;
    Result.Label2.Font.FontName := 'Tahoma';
    Result.Label3 := NewLabel( Result.Form, 'Allocation unit size' ).SetPosition( 10, 106 ).SetSize( 151, 17 );
    Result.Label3.Font.FontHeight := -11;
    Result.Label3.Font.FontName := 'Tahoma';
    Result.Label4 := NewLabel( Result.Form, 'Volume label' ).SetPosition( 10, 154 ).SetSize( 151, 17 );
    Result.Label4.Font.FontHeight := -11;
    Result.Label4.Font.FontName := 'Tahoma';
    Result.btnClose := NewButton( Result.Form, 'Close' ).SetPosition( 168, 334 ).SetSize( 75, 24 ).LikeSpeedButton;
    Result.btnClose.Font.FontHeight := -11;
    Result.btnClose.Font.FontName := 'Tahoma';
    Result.btnStart := NewButton( Result.Form, 'Start' ).SetPosition( 88, 334 ).SetSize( 75, 24 ).LikeSpeedButton;
    Result.btnStart.Font.FontHeight := -11;
    Result.btnStart.Font.FontName := 'Tahoma';
    Result.groupOptions := NewGroupBox( Result.Form, 'Format options  ' ).SetPosition( 10, 200 ).SetSize( 235, 88 );
    Result.groupOptions.TabStop := FALSE;
    Result.groupOptions.Font.FontHeight := -11;
    Result.groupOptions.Font.FontName := 'Tahoma';
      Result.cbStartup := NewCheckBox( Result.groupOptions, 'Create an MS-DOS startup disk ' ).SetPosition( 8, 56 ).SetSize( 193, 25 );
      Result.cbStartup.Enabled := False;
      Result.cbCompression := NewCheckBox( Result.groupOptions, 'Enable Compression' ).SetPosition( 8, 36 ).SetSize( 145, 25 );
      Result.cbCompression.IgnoreDefault := TRUE;
      Result.cbQuick := NewCheckBox( Result.groupOptions, 'Quick Format' ).SetPosition( 8, 16 ).SetSize( 129, 25 );
    Result.comboCapacity := NewComboBox( Result.Form, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 10, 28 ).SetSize( 235, 25 );
    Result.comboCapacity.Font.FontHeight := -11;
    Result.comboCapacity.Font.FontName := 'Tahoma';
    Result.comboCapacity.Color := TColor(clWindow);
    Result.comboCapacity.Items[ 0 ] := '';
    Result.comboCapacity.CurIndex := 0;
    Result.comboFilesystem := NewComboBox( Result.Form, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 10, 76 ).SetSize( 235, 25 );
    Result.comboFilesystem.Font.FontHeight := -11;
    Result.comboFilesystem.Font.FontName := 'Tahoma';
    Result.comboFilesystem.Color := TColor(clWindow);
    Result.comboFilesystem.Items[ 0 ] := 'NTFS';
    Result.comboFilesystem.Items[ 1 ] := 'FAT32';
    Result.comboFilesystem.CurIndex := 0;
    Result.comboAlloc := NewComboBox( Result.Form, [ coReadOnly, coNoIntegralHeight ] ).SetPosition( 10, 124 ).SetSize( 235, 25 );
    Result.comboAlloc.Font.FontHeight := -11;
    Result.comboAlloc.Font.FontName := 'Tahoma';
    Result.comboAlloc.Color := TColor(clWindow);
    Result.editLabel := NewEditBox( Result.Form, [  ] ).SetPosition( 10, 168 ).SetSize( 235, 0 );
    Result.editLabel.Font.FontHeight := -11;
    Result.editLabel.Font.FontName := 'Tahoma';
    Result.Progress1 := NewProgressBar( Result.Form ).SetPosition( 10, 302 ).SetSize( 235, 14 );
    Result.Progress1.MaxProgress := 25;
      Result.btnClose.OnClick := Result.btnCloseClick;
    Result.btnClose.CancelBtn := TRUE;
      Result.btnStart.OnClick := Result.btnStartClick;
    Result.btnStart.DefaultBtn := TRUE;
      Result.comboFilesystem.OnChange := Result.comboFilesystemChange;
    Result.editLabel.Color := TColor(clWindow);

end;

