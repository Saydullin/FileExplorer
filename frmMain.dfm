object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = 'File Explorer'
  ClientHeight = 685
  ClientWidth = 1176
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Roboto'
  Font.Style = []
  Padding.Left = 20
  Padding.Top = 20
  Padding.Right = 20
  Padding.Bottom = 20
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object LabelTitle: TLabel
    Left = 20
    Top = 20
    Width = 1136
    Height = 19
    Align = alTop
    Alignment = taCenter
    Caption = 'File Explorer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 1093
  end
  object ButtonRouterLeft: TSpeedButton
    Left = 20
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Get Back'
    ImageIndex = 1
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonRouterLeftClick
  end
  object ButtonRouterRight: TSpeedButton
    Left = 52
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Get Prev'
    ImageIndex = 3
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonRouterRightClick
  end
  object ButtonCreateFile: TSpeedButton
    Left = 766
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Create file'
    ImageIndex = 5
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonCreateFileClick
  end
  object ButtonDelete: TSpeedButton
    Left = 796
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Delete'
    ImageIndex = 7
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonDeleteClick
  end
  object ButtonRefreshPage: TSpeedButton
    Left = 827
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Refresh'
    ImageIndex = 9
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonRefreshPageClick
  end
  object ButtonCreateFolder: TSpeedButton
    Left = 736
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Create Folder'
    ImageIndex = 4
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonCreateFolderClick
  end
  object LabelFilesInfo: TLabel
    Left = 860
    Top = 104
    Width = 242
    Height = 15
    Caption = 'Select file or folder to see information here'
  end
  object ButtonSearch: TSpeedButton
    Left = 695
    Top = 100
    Width = 27
    Height = 27
    Hint = 'Refresh'
    ImageIndex = 10
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    OnClick = ButtonRefreshPageClick
  end
  object lvFIlesPrint: TListView
    Left = 20
    Top = 133
    Width = 834
    Height = 532
    Align = alCustom
    BevelWidth = 5
    Columns = <
      item
        Caption = 'Name'
        Width = 360
      end
      item
        Caption = 'Size'
        Width = 100
      end
      item
        Caption = 'Date'
        Width = 200
      end
      item
        Caption = 'Attributes'
        Width = 145
      end>
    DragCursor = crHandPoint
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    FullDrag = True
    LargeImages = ImageList1
    GroupHeaderImages = ImageList1
    RowSelect = True
    ParentFont = False
    SmallImages = ImageList1
    StateImages = ImageList1
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvFIlesPrintColumnClick
    OnDblClick = lvFIlesPrintDblClick
    OnEdited = lvFIlesPrintEdited
    OnSelectItem = lvFIlesPrintSelectItem
  end
  object ComboBoxFilter: TComboBox
    Left = 433
    Top = 102
    Width = 130
    Height = 23
    Hint = 'Filter'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = 'any'
    OnKeyDown = ComboBoxFilterKeyDown
    OnSelect = ButtonSearchClick
  end
  object ComboBoxSearch: TComboBox
    Left = 86
    Top = 102
    Width = 341
    Height = 23
    Hint = 'Search Path'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = 'C:\\'
    OnKeyDown = ComboBoxSearchKeyDown
  end
  object lvFileInfo: TListView
    Left = 860
    Top = 133
    Width = 296
    Height = 532
    Columns = <
      item
        Caption = 'MAIN'
        Width = 120
      end
      item
        Caption = 'VALUES'
        Width = 170
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
  end
  object EditSearchFile: TEdit
    Left = 569
    Top = 102
    Width = 121
    Height = 23
    Hint = 'Search'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Roboto'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    TextHint = 'Search'
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
    end
    object History1: TMenuItem
      Caption = 'History'
      OnClick = History1Click
    end
    object Help1: TMenuItem
      Caption = 'Help'
      OnClick = Help1Click
    end
  end
  object ImageList1: TImageList
    Left = 1048
    Top = 65528
    Bitmap = {
      494C01010B001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF0000000000000000000000FF0000
      00FF060606F90000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000000000000000000000000000000000000000000000F2F2
      F20D000000FF000000FF000000FF000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FFF4F4F40B0000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000070707F8000000FF0000
      00FFF0F0F00F0000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF262626D9000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF00000000000000FF000000FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000E8E8E8170000
      000000000000000000FF000000FF000000FF0000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB04000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000000000000000000000B3B3
      B34C000000FF000000FF0000000000000000000000FF000000FFFBFBFB040000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF00000000000000FF121212ED0000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF00000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      0000000000FF040404FB00000000000000000000000000000000000000000000
      000000000000000000FF000000FF00000000000000FF00000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000FF000000FF1C1C1CE300000000000000FF030303FC000000000000
      000000000000000000000000000000000000000000FFB0B0B04F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000000000000000000000171717E8000000FF0000
      00FF000000FF000000FF0000000000000000FCFCFC03000000FF000000000000
      0000000000000000000000000000141414EB000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF0000000000000000000000FF000000FF000000FF0000
      00FFC8C8C83700000000000000000000000000000000000000FF000000FF0202
      02FD0000000000000000000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000E6E6E6190000
      00FF000000FF000000FF0000000000000000000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE010000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      000000000000000000FF0000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF0000000000000000000000530000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF00000096000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF00000000000000000000
      00DF000000FF000000FF000000FF000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00DF000000FF000000FF000000FF00000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF0000000000000000000000D50000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF00000000000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF0000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000DD00000000000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000DD0000000000000000000000FF00000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000FF0000000000000000000000FF000000FF00000000000000000000
      0000000000000000000000000000000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000FF000000000000000000000000000000FF000000FF000000000000
      0000000000000000000000000000000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF0000000000000000000000FF00000000000000000000
      0000000000FF000000FF000000000000000000000000000000FF000000FF0000
      0000000000000000000000000000000000FF0000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000030000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF0000000000000000000000FF00000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000FF0000
      00FF000000000000000000000000000000FF0000000000000069000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000790000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF0000000000000000000000FF00000000000000000000
      00000000000000000000000000FF000000FF0000000000000000000000000000
      00FF000000FF00000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000000000000000000000000000FF0000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF0000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000FF000000FF00000000000000000000
      0000000000FF000000FF000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF0000000000000000000000FF000000000000
      00000000000000000000000000000000007B000000DD000000DD000000DD0000
      00DD000000DD000000DD000000FF000000000000000000000000000000FF0000
      00000000000000000000000000000000000000000000000000FF000000220000
      0022000000FE000000FF0000000000000000000000FF00000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000000000
      00000000000000000000000000BD000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FC000000000000000000000000000000FF0000
      00000000000000000000000000000000000000000000000000FF000000000000
      00F8000000FF000000000000000000000000000000FF00000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00000000000000000000000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF00000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF00000000000000FF000000FF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      000000000000000000000000000000000000000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF0000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF00000000000000000000
      0000000000FF0000000000000000000000000000000000000000000000000000
      000000000020000000FF000000FF000000FF000000FF000000FF000000FF0000
      0020000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      007E000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF0000007E0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082D7FF006EC3FF006EC3FF006EC3
      FF006EC3FF006EC3FF006EC3FF006EC3FF006EC3FF006EC3FF006EC3FF006EC3
      FF006EC3FF006EC3FF006EC3FF0082D7FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF000000000000000000000000000000
      000000000000000000DF000000DF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000DF000000DF0000
      00000000000000000000000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF000000000000000000000000000000
      000000000020000000FF000000DF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000DF000000FF0000
      00200000000000000000000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF000000000000000000000000000000
      00DF000000FF0000002000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000200000
      00FF000000DF00000000000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF000000000000000000000000200000
      00FF000000DF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00DF000000FF00000020000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0000000000000000DF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000DF000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF00000000000000000000000000000000000000DF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000DF0000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0000000000000000DF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000DF000000000000000000000000000000000000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000FF00000000000000000000000000000000000000DF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000DF0000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF00FAF2EF00FAF2
      EF00FAF2EF00FAF2EF00FAF2EF0082D7FF000000000000000000000000200000
      00FF000000DF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF0000000000000000000000000000000000000008000000FC000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00DF000000FF00000020000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF00FAF2EF00FAF2
      EF00FAF2EF00FAF2EF00FAF2EF0082D7FF000000000000000000000000000000
      00DF000000FF0000002000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF00000000000000000000000000000000000000FF00000006000000000000
      009D000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000200000
      00FF000000DF00000000000000000000000082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7FF00FAF2EF00FAF2
      EF00FAF2EF00FAF2EF00FAF2EF0082D7FF000000000000000000000000000000
      000000000020000000FF000000DF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF00000000000000000000000000000000000000FF00000000000000960000
      00FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000DF000000FF0000
      00200000000000000000000000000000000082D7FF00F2E6E100F2E6E100F2E6
      E100F2E6E100F2E6E10082D7FF0082D7FF0082D7FF0082D7FF0082D7FF0082D7
      FF0082D7FF0082D7FF0082D7FF0082D7FF000000000000000000000000000000
      000000000000000000DF000000DF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF00000000000000000000000000000000000000FF00000096000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000DF000000DF0000
      00000000000000000000000000000000000000000000FAF2EF00FAF2EF00FAF2
      EF00FAF2EF00FAF2EF00FAF2EF00FAF2EF00FAF2EF00FAF2EF00FAF2EF00FAF2
      EF00FAF2EF00FAF2EF00FAF2EF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF00000000000000000000000000000000000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0081000000FF000000FF000000FF000000FF000000F900000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00F81FFCC7FFF90000E007E0C1FFF00000
      C183C0C3FFE00000818187C1FFC1000081819FC9FF83000001801FD8FF870000
      01803FFCE30F000001803FFCC03F000001803FFC9E7F000001803FFC3F7F0000
      00001FF87F3F0000818193F97F3F0000818183F13F3F0000C003C3833E7F0000
      E00783078CFF0000F81FC33FC1FF0000FFFFFFFF0000E007FFFBC03B7FFEC003
      8061DFE17FFEC003BFFBDFFB7FFEC003BFFBDFFB70FEC003BFFFDFFF767EC003
      BFFDDFFF773EC003BFFDDFFB739EC001BFFDDFFB79CE80018001DFFB7CE78001
      BFFDDF837E738001BE01DF837F39FFFFBC01DFA77F9C000081FFDF8F7FC90000
      FFFFC01F7FE30000FFFFFFFF0077F00FFFFFFFFFFFFFFFFFFFFFFFFFE007FFFF
      0000FFFFEFF7FFFF0000F9FFEFF7FF9F0000F1FFEFF7FF8F0000E3FFEFF7FFC7
      0000C7FFEFF7FFE300008001EFF7800100008001EFF780010000C7FFEF07FFE3
      0000E3FFEF27FFC70000F1FFEF4FFF8F0000F9FFEF1FFF9F8001FFFFEF3FFFFF
      FFFFFFFFE07FFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end