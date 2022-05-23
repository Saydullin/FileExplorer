object FormNewFile: TFormNewFile
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FormNewFile'
  ClientHeight = 228
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 20
  Padding.Top = 20
  Padding.Right = 20
  Padding.Bottom = 20
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 475
    Height = 19
    Align = alTop
    Alignment = taCenter
    Caption = 'New File'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 60
  end
  object Label2: TLabel
    Left = 20
    Top = 56
    Width = 94
    Height = 16
    Caption = 'Path for new file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 364
    Top = 56
    Width = 57
    Height = 16
    Caption = 'File Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EditPath: TEdit
    Left = 20
    Top = 75
    Width = 221
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object EditFileName: TEdit
    Left = 364
    Top = 75
    Width = 121
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 368
    Top = 175
    Width = 117
    Height = 33
    Caption = 'Add File'
    TabOrder = 2
    OnClick = Button1Click
  end
  object cbHidden: TCheckBox
    Left = 20
    Top = 120
    Width = 61
    Height = 17
    Caption = 'Hidden'
    TabOrder = 3
  end
  object cbSystem: TCheckBox
    Left = 20
    Top = 142
    Width = 61
    Height = 17
    Caption = 'System'
    TabOrder = 4
  end
  object cbTemp: TCheckBox
    Left = 20
    Top = 163
    Width = 77
    Height = 17
    Caption = 'Temp'
    TabOrder = 5
  end
  object cbReadOnly: TCheckBox
    Left = 20
    Top = 183
    Width = 77
    Height = 17
    Caption = 'Read only'
    TabOrder = 6
  end
end
