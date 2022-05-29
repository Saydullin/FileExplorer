object History: THistory
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'History'
  ClientHeight = 451
  ClientWidth = 783
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
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 743
    Height = 18
    Align = alTop
    Alignment = taCenter
    Caption = 'History'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 50
  end
  object lvHistory: TListView
    Left = 20
    Top = 58
    Width = 743
    Height = 373
    Columns = <
      item
        Caption = 'Target'
        Width = 110
      end
      item
        Caption = 'Action'
        Width = 100
      end
      item
        Caption = 'Type'
        Width = 110
      end
      item
        Caption = 'Path'
        Width = 260
      end
      item
        Caption = 'Date'
        Width = 140
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
    object Update1: TMenuItem
      Caption = 'Update'
      OnClick = Update1Click
    end
  end
end
