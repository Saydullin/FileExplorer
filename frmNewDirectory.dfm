object FormNewFolder: TFormNewFolder
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'New Directory'
  ClientHeight = 225
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Roboto'
  Font.Style = []
  Padding.Left = 20
  Padding.Top = 20
  Padding.Right = 20
  Padding.Bottom = 20
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 475
    Height = 19
    Align = alTop
    Alignment = taCenter
    Caption = 'New Directory'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 100
  end
  object Label2: TLabel
    Left = 20
    Top = 56
    Width = 127
    Height = 15
    Caption = 'Path for new directory'
  end
  object Label3: TLabel
    Left = 364
    Top = 56
    Width = 73
    Height = 15
    Caption = 'Folder Name'
  end
  object EditPath: TEdit
    Left = 20
    Top = 75
    Width = 221
    Height = 23
    AutoSelect = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object EditFolderName: TEdit
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
    Left = 364
    Top = 172
    Width = 117
    Height = 33
    Caption = 'Add Directory'
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
