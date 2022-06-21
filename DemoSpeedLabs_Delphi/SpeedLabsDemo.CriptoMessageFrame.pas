unit SpeedLabsDemo.CriptoMessageFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TCriptoMessageFrame = class(TFrame)
    btnDecrypt: TButton;
    mmoJson: TMemo;
    mmoResult: TMemo;
    mmoPrivateKey: TMemo;
    lblPrivateKey: TLabel;
    lblJson: TLabel;
    lblResposta: TLabel;
    procedure btnDecryptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  OpenSSL.RSAUtils, OpenSSL.Core, IdGlobal, IdCoderMIME,
  System.JSON, System.IOUtils;

procedure TCriptoMessageFrame.btnDecryptClick(
  Sender: TObject);
var
  RSAUtil :TRSAUtil;
  _rbPrivateKey, _rbMessage: RawByteString;
  _Messages: TStringList;
  _Message: string;
  _ssPrivateKey, _ssMessage, _ssMessageDecrypt: TStringStream;
  _i: Integer;

  function Base64Decode(const aText: String): AnsiString;
  var
    _numberOfBytes, _typeSize: Cardinal;
    _bytes: TIdBytes;
  begin
    { Função que decoda a hash base64 }
    _bytes := IdCoderMIME.TIdDecoderMIME.DecodeBytes(aText);
    _typeSize := SizeOf(AnsiChar);
    _numberOfBytes := Length(_bytes);
    SetLength(Result,_numberOfBytes div _typeSize);
    Move(_bytes[0],Result[1],_numberOfBytes);
  end;

  procedure AddMessagesOnList(aListMessages: TStringList);
  var
    _jsonObj, _jsonSubObj: TJSONObject;
    _jsonArrayMessages: TJSONArray;
    _jsonSpecMessage: TJSONValue;
    _i: Integer;
    _jsonMessage: string;
  begin
    try
      { Ler Json e formatar caso necessário }
      _jsonMessage := mmoJson.Text;
      if not (_jsonMessage.StartsWith('{') and _jsonMessage.EndsWith('}')) then
        _jsonMessage := '{' + _jsonMessage + '}';

      { Criando objeto com o json informado }
      _jsonObj := TJSONObject.ParseJSONValue(
        TEncoding.ASCII.GetBytes(_jsonMessage), 0) as TJSONObject;

      { Obtendo o campo "message" e criando um array com as sequencias existentes }
      _jsonSpecMessage := _jsonObj.Get('message').JsonValue;
      _jsonArrayMessages := _jsonSpecMessage as TJSONArray;

      { O tamanho do array foi definido conforme a quantidade
        de "message" encontrado em sequência }
      for _i := 0 to _jsonArrayMessages.Size - 1 do
      begin
        { Obtendo o valor e adicionando a lista }
        _jsonSubObj := (_jsonArrayMessages.Get(_i) as TJSONObject);
        _jsonSpecMessage := _jsonSubObj.Get(1).JsonValue;
        aListMessages.Insert(_i, _jsonSpecMessage.Value);
      end;
    except
      raise Exception.Create(
        'Json referente a mensagem está inválido. Valide-o e tente novamente');
    end;
  end;


begin
  { Criando componente para descriptografar }
  RSAUtil := TRSAUtil.Create;

  { Criando lista de strings e alimentando-a com as
    mensagens do JSON de resposta }
  _Messages := TStringList.Create();
  AddMessagesOnList(_Messages);

  { Decodando o base64 da PrivateKey informada em uma StringStream
     e definindo-a no componente }
  _rbPrivateKey := Base64Decode(mmoPrivateKey.Text);
  _ssPrivateKey := TStringStream.Create(_rbPrivateKey);
  RSAUtil.PrivateKey.LoadFromStream(_ssPrivateKey);

  try
    { As mensagens devem ser descriptografadas uma por vez
      pois o componente não suporta o tamanho da mensagem completa. }
    for _i := 0 to _Messages.Count -1 do
    begin
      _ssMessageDecrypt := TStringStream.Create;
      try
        { Decodando o base64 da mensagem e descriptografando }
        _rbMessage := Base64Decode(_Messages[_i]);
        _ssMessage := TStringStream.Create(_rbMessage);

        RSAUtil.PrivateDecrypt(_ssMessage, _ssMessageDecrypt, rpOAEP);

        { Adicionando as mensagens descriptografadas em uma string }
        _Message := _Message + _ssMessageDecrypt.DataString;
      finally
        _ssMessage.Free;
        _ssMessageDecrypt.Free;
      end;
    end;

    { Decodando o base64 das mensagens concatenadas e descriptografadas
       e jogando resultado em tela }
    mmoResult.Lines.Add(Base64Decode(_Message));

  finally
    RSAUtil.Free;
    _ssPrivateKey.Free;
  end;
end;

end.
