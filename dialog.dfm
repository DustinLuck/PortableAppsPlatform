object frmDialog: TfrmDialog
  Left = 0
  Top = 0
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'frmDialog'
  ClientHeight = 196
  ClientWidth = 462
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = FormClick
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblMessage2: TLabel
    Left = 80
    Top = 146
    Width = 361
    Height = 25
    AutoSize = False
    Caption = 'lblMessage2'
    Transparent = True
    WordWrap = True
    OnClick = lblMessage2Click
  end
  object lblMessage: TLabel
    Left = 80
    Top = 19
    Width = 361
    Height = 121
    AutoSize = False
    Caption = 'lblMessage'
    Transparent = True
    WordWrap = True
    OnClick = lblMessageClick
  end
  object imgIcon: TImage
    Left = 16
    Top = 16
    Width = 48
    Height = 48
    Proportional = True
    Stretch = True
    Visible = False
  end
  object btnCancel: TButton
    Left = 384
    Top = 165
    Width = 68
    Height = 23
    Cancel = True
    Caption = '&Cancel'
    Default = True
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 309
    Top = 165
    Width = 68
    Height = 23
    Caption = '&Ok'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object progProgress: TProgressBar
    Left = 16
    Top = 123
    Width = 427
    Height = 17
    Style = pbstMarquee
    TabOrder = 2
    Visible = False
  end
end
