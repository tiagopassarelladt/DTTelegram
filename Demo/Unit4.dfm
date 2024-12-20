object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Demo - DTTelegram'
  ClientHeight = 492
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 15
    Caption = 'Bot Token'
  end
  object Label2: TLabel
    Left = 447
    Top = 8
    Width = 36
    Height = 15
    Caption = 'ChatID'
  end
  object edtBotToken: TEdit
    Left = 8
    Top = 29
    Width = 433
    Height = 23
    TabOrder = 0
    Text = '7952055082:AAE-RFrDHQ6LvnBgNEDLAcFau1GW0RLNdoY'
  end
  object edtChatID: TEdit
    Left = 447
    Top = 29
    Width = 289
    Height = 23
    TabOrder = 1
    Text = '-1002290313489'
  end
  object Button1: TButton
    Left = 193
    Top = 72
    Width = 177
    Height = 25
    Cursor = crHandPoint
    Caption = 'Enviar Mensagem de Texto'
    TabOrder = 2
    OnClick = Button1Click
  end
  object M: TMemo
    Left = 8
    Top = 112
    Width = 728
    Height = 372
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object Button2: TButton
    Left = 376
    Top = 72
    Width = 177
    Height = 25
    Cursor = crHandPoint
    Caption = 'Enviar Imagem'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 559
    Top = 72
    Width = 177
    Height = 25
    Cursor = crHandPoint
    Caption = 'Enviar Documento'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 72
    Width = 177
    Height = 25
    Cursor = crHandPoint
    Caption = 'Obter ChatID'
    TabOrder = 6
    OnClick = Button4Click
  end
  object DTTelegram1: TDTTelegram
    onMsgEnviada = DTTelegram1MsgEnviada
    Left = 336
    Top = 232
  end
end
