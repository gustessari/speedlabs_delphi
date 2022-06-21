object CriptoMessageFrame: TCriptoMessageFrame
  Left = 0
  Top = 0
  Width = 574
  Height = 501
  TabOrder = 0
  object lblPrivateKey: TLabel
    Left = 16
    Top = 8
    Width = 135
    Height = 13
    Caption = 'Chave Privada / Private Key'
  end
  object lblJson: TLabel
    Left = 16
    Top = 88
    Width = 76
    Height = 13
    Caption = 'Json Mensagem'
  end
  object lblResposta: TLabel
    Left = 16
    Top = 285
    Width = 45
    Height = 13
    Caption = 'Resposta'
  end
  object btnDecrypt: TButton
    Left = 13
    Top = 239
    Width = 548
    Height = 42
    Caption = 'Descriptografar Mensagem'
    TabOrder = 0
    OnClick = btnDecryptClick
  end
  object mmoJson: TMemo
    Left = 13
    Top = 104
    Width = 548
    Height = 129
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object mmoResult: TMemo
    Left = 13
    Top = 304
    Width = 548
    Height = 137
    TabOrder = 2
  end
  object mmoPrivateKey: TMemo
    Left = 13
    Top = 24
    Width = 548
    Height = 58
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
