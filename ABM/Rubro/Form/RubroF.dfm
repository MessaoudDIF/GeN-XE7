object RubroForm: TRubroForm
  Left = 450
  Top = 246
  Caption = 'Rubro'
  ClientHeight = 415
  ClientWidth = 359
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 359
    Height = 415
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 36
      Top = 208
      Width = 54
      Height = 13
      Caption = 'NOMBRE'
      FocusControl = DBEdit1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 99
      Top = 208
      Width = 227
      Height = 21
      DataField = 'DESCRIPCION'
      DataSource = DM.dstRubro
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 36
      Top = 66
      Width = 290
      Height = 124
      DataSource = DM.dstRubro
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIPCION'
          Width = 207
          Visible = True
        end>
    end
    object DBNavigator1: TDBNavigator
      Left = 36
      Top = 242
      Width = 290
      Height = 50
      DataSource = DM.dstRubro
      Hints.Strings = (
        'Primer registro'
        'Registro anterior'
        'Registro siguiente'
        #218'ltimo registro'
        'Insertar registro'
        'Eliminar registro'
        'Editar registro'
        'Guardar cambios'
        'Cancelar edici'#243'n'
        'Refrescar datos')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 139
      Top = 305
      Width = 80
      Height = 50
      Caption = 'Cerrar'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 3
      OnClick = BitBtn1Click
    end
  end
end
