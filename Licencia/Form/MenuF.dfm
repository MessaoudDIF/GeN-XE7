object LicenciaForm: TLicenciaForm
  Left = 0
  Top = 0
  Caption = 'Generar n'#250'mero de Licencia'
  ClientHeight = 346
  ClientWidth = 484
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 153
    Width = 51
    Height = 13
    Caption = 'Apellidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 196
    Width = 50
    Height = 13
    Caption = 'Nombres'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 235
    Width = 20
    Height = 13
    Caption = 'DNI'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GenerarBitBtn: TBitBtn
    Left = 40
    Top = 288
    Width = 80
    Height = 50
    Caption = 'Generar'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 5
    OnClick = GenerarBitBtnClick
  end
  object LicenciaMemo: TMemo
    Left = 40
    Top = 16
    Width = 401
    Height = 113
    ReadOnly = True
    TabOrder = 6
  end
  object CopiarBitBtn: TBitBtn
    Left = 194
    Top = 288
    Width = 80
    Height = 50
    Caption = 'Copiar'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 4
    OnClick = CopiarBitBtnClick
  end
  object EnviarPorEmailBitBtn: TBitBtn
    Left = 338
    Top = 288
    Width = 103
    Height = 50
    Caption = 'Enviar Por Email'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clFuchsia
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 3
    OnClick = EnviarPorEmailBitBtnClick
  end
  object NombresEdit: TEdit
    Left = 114
    Top = 192
    Width = 327
    Height = 21
    TabOrder = 1
  end
  object ApellidosEdit: TEdit
    Left = 114
    Top = 149
    Width = 327
    Height = 21
    TabOrder = 0
  end
  object DNIEdit: TEdit
    Left = 114
    Top = 231
    Width = 137
    Height = 21
    TabOrder = 2
  end
end
