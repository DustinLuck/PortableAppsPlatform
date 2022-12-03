object frmColorMixer: TfrmColorMixer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Color Mixer'
  ClientHeight = 243
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblRed: TLabel
    Left = 8
    Top = 8
    Width = 19
    Height = 13
    Caption = 'Red'
  end
  object lblGreen: TLabel
    Left = 8
    Top = 64
    Width = 29
    Height = 13
    Caption = 'Green'
  end
  object lblBlue: TLabel
    Left = 8
    Top = 120
    Width = 20
    Height = 13
    Caption = 'Blue'
  end
  object lblColorHex: TLabel
    Left = 8
    Top = 184
    Width = 55
    Height = 13
    Caption = 'Color (Hex)'
  end
  object trackBarRed: TTrackBar
    Left = 0
    Top = 24
    Width = 345
    Height = 33
    Max = 255
    Frequency = 16
    TabOrder = 0
    OnChange = btnApplyClick
  end
  object trackBarGreen: TTrackBar
    Left = 0
    Top = 80
    Width = 345
    Height = 33
    Max = 255
    Frequency = 16
    TabOrder = 1
    OnChange = btnApplyClick
  end
  object trackBarBlue: TTrackBar
    Left = 0
    Top = 136
    Width = 345
    Height = 33
    Max = 255
    Frequency = 16
    TabOrder = 2
    OnChange = btnApplyClick
  end
  object edtColor: TEdit
    Left = 8
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object btnApply: TButton
    Left = 270
    Top = 198
    Width = 75
    Height = 25
    Caption = 'Apply'
    Enabled = False
    TabOrder = 4
    Visible = False
    OnClick = btnApplyClick
  end
end
