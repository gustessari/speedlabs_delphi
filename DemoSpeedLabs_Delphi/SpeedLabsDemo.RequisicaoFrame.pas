unit SpeedLabsDemo.RequisicaoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TRequisicaoFrame = class(TFrame)
  edtLinkkAPI: TEdit;
    cbbTipoRequisicao: TComboBox;
    lblLinkAPI: TLabel;
    grpRequisicao: TGroupBox;
    grpAutenticacao: TGroupBox;
    btnEnviar: TButton;
    idhttp: TIdHTTP;
    mmoRetorno: TMemo;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    lblParam: TLabel;
    pgcAbaParams: TPageControl;
    tsJSON: TTabSheet;
    mmoJson: TMemo;
    btnLoadExemp: TButton;
    mmoAutenticacao: TMemo;
    chkAutenticacao: TCheckBox;
    btnPlugZap: TButton;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnLoadExempClick(Sender: TObject);
    procedure chkAutenticacaoClick(
      Sender: TObject);
    procedure btnPlugZapClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRequisicaoFrame.btnEnviarClick(Sender: TObject);
var
  _Url, _Json: string;
  _ResponseCode: integer;
  _IOHandler: TIdSSLIOHandlerSocketOpenSSL;
  _HTTP : TIdHTTP;
  _JsonToSend: TStringStream;

begin
  _Json := mmoJson.Text;
  { Neste ponto ele cria um Stream com o conte�do JSON que vai ser enviada na requisi��o }
  _JsonToSend := TStringStream.Create(_Json, TEncoding.UTF8);

  { Neste ponto ele seleciona a URL }
  _Url := edtLinkkAPI.Text;
  _Http := TIdHTTP.Create(nil);
  _IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    { Neste ponto ele configura algumas propriedades do Componente,
      necess�rios para realizar corretamente a comunica��o }
    _Http.Request.ContentType := 'application/json';
    _HTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';



    if chkAutenticacao.Checked and (mmoAutenticacao.Text <> '') then
    begin
      _Http.Request.CustomHeaders.Clear;
      _Http.Request.Clear;
      _Http.Request.CharSet := 'utf-8';

      { Neste ponto � configurado a autentica��o/token }
      _Http.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + mmoAutenticacao.Text;
      _Http.HTTPOptions := [];
      _Http.IOHandler := _IOHandler;
    end;

    { Neste ponto tomar� a decis�o conforme o tipo de requisi��o selecionado }
    if cbbTipoRequisicao.Text = 'GET' then
      mmoRetorno.Text := _Http.Get(_Url)
    else if cbbTipoRequisicao.Text = 'POST' then
    begin
      _Http.Post(_Url, _JsonToSend);
      { Obtendo o c�digo do retorno da requisi��o }
      _ResponseCode := _http.ResponseCode;
      if (_ResponseCode = 200) or (_ResponseCode = 201) then
        mmoRetorno.Text := 'Opera��o realizada com sucesso';
    end
    else
      raise Exception.Create('Escolha o tipo de requisi��o.');
  finally
    _IOHandler.Free;
    if _Http.Socket <> nil then
    begin
      if _Http.Socket.Connected then
        _Http.Socket.Close;
    end;
  end;
end;

procedure TRequisicaoFrame.btnLoadExempClick(
  Sender: TObject);
begin
  mmoJson.Lines.LoadFromFile('../../ExemploProduto_APIMarket.txt');
end;

procedure TRequisicaoFrame.btnPlugZapClick(Sender: TObject);
begin
  mmoJson.Lines.LoadFromFile('../../ExemploProduto_PlugZap.txt');
end;

procedure TRequisicaoFrame.chkAutenticacaoClick(
  Sender: TObject);
begin
  if chkAutenticacao.Checked then
    mmoAutenticacao.Enabled := True
  else
    mmoAutenticacao.Enabled := False;
end;

end.
