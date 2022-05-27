object FormInfo: TFormInfo
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Info'
  ClientHeight = 217
  ClientWidth = 518
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
  object Label2: TLabel
    Left = 20
    Top = 20
    Width = 478
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'File Explorer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 196
    ExplicitTop = 23
    ExplicitWidth = 115
  end
  object Label1: TLabel
    Left = 20
    Top = 60
    Width = 475
    Height = 15
    Margins.Top = 10
    Caption = 'CopyRight @ 2022 - Saydullin'
  end
  object Label3: TLabel
    Left = 22
    Top = 91
    Width = 475
    Height = 15
    Caption = 'Version 1.0'
  end
  object Label4: TLabel
    Left = 23
    Top = 152
    Width = 39
    Height = 15
    Caption = 'GitHub'
  end
  object Label5: TLabel
    Left = 23
    Top = 178
    Width = 31
    Height = 15
    Caption = 'Email'
  end
  object lkGithub: TLinkLabel
    Left = 79
    Top = 153
    Width = 197
    Height = 19
    Hint = 'Github link'
    Caption = 'github.com/Saydullin/FileExplorer'
    TabOrder = 0
    OnClick = lkGithubClick
  end
  object LinkLabel2: TLinkLabel
    Left = 79
    Top = 178
    Width = 149
    Height = 19
    Caption = 'saydullinDev@gmail.com'
    TabOrder = 1
  end
end
