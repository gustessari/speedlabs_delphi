object RequisicaoFrame: TRequisicaoFrame
  Left = 0
  Top = 0
  Width = 817
  Height = 476
  Align = alClient
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  DesignSize = (
    817
    476)
  object lblLinkAPI: TLabel
    Left = 15
    Top = 14
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object grpRequisicao: TGroupBox
    Left = 8
    Top = 140
    Width = 426
    Height = 707
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Requisitos'
    TabOrder = 2
    DesignSize = (
      426
      707)
    object lblParam: TLabel
      Left = 3
      Top = 51
      Width = 55
      Height = 13
      Hint = '(Informe via JSON ou preencha os campos)'
      HelpType = htKeyword
      HelpKeyword = '(Informe via JSON ou preencha os campos)'
      Caption = 'Par'#226'metros'
    end
    object cbbTipoRequisicao: TComboBox
      Left = 16
      Top = 14
      Width = 169
      Height = 21
      TabOrder = 0
      TextHint = 'Escolha o tipo da requisi'#231#227'o...'
      Items.Strings = (
        'GET'
        'POST')
    end
    object pgcAbaParams: TPageControl
      Left = 3
      Top = 70
      Width = 422
      Height = 266
      ActivePage = tsJSON
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
      object tsJSON: TTabSheet
        Caption = 'JSON'
        ExplicitWidth = 409
        ExplicitHeight = 588
        object mmoJson: TMemo
          Left = 0
          Top = 0
          Width = 414
          Height = 238
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Font.Quality = fqClearType
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          ExplicitLeft = -3
          ExplicitWidth = 409
          ExplicitHeight = 548
        end
      end
    end
    object btnEnviar: TButton
      Left = 191
      Top = 14
      Width = 74
      Height = 50
      Caption = 'Enviar'
      TabOrder = 2
    end
    object btnLoadExemp: TButton
      Left = 271
      Top = 14
      Width = 74
      Height = 50
      Caption = 'Carregar Json Produto APIMarket'
      TabOrder = 3
      WordWrap = True
    end
    object btnPlugZap: TButton
      Left = 351
      Top = 14
      Width = 75
      Height = 50
      Caption = 'Carregar Json PlugZap'
      TabOrder = 4
      WordWrap = True
    end
  end
  object edtLinkkAPI: TEdit
    Left = 52
    Top = 10
    Width = 369
    Height = 21
    TabOrder = 0
    Text = 'https://api.sandbox.plug4market.com.br/products'
  end
  object grpAutenticacao: TGroupBox
    Left = 8
    Top = 66
    Width = 426
    Height = 68
    Caption = 'Autentica'#231#227'o'
    TabOrder = 1
    object mmoAutenticacao: TMemo
      Left = 3
      Top = 16
      Width = 420
      Height = 46
      Hint = 'Token de Autentica'#231#227'o'
      Enabled = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
    end
  end
  object mmoRetorno: TMemo
    Left = 440
    Top = 14
    Width = 369
    Height = 459
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object chkAutenticacao: TCheckBox
    Left = 15
    Top = 43
    Width = 114
    Height = 17
    Caption = 'Utilizar Autentica'#231#227'o'
    TabOrder = 4
  end
  object idhttp: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 384
    Top = 40
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 416
    Top = 40
  end
end
