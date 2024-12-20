unit DTTelegram;

interface

uses
  System.SysUtils, System.Classes,System.Net.HttpClient,system.NetEncoding,
  System.Net.URLClient, System.Net.Mime,json;

type
  TOnMsgEnviada = procedure(Sender: TObject;
                                   const JsonReturn: string) of object;

type TConfigTelegram = class
    private
    FBotTOKEN: string;
    FChatID: string;
    procedure SetBotTOKEN(const Value: string);
    procedure SetChatID(const Value: string);


    published
     property ChatID : string read FChatID write SetChatID;
     property BotTOKEN : string read FBotTOKEN write SetBotTOKEN;
end;

type
  TDTTelegram = class(TComponent)
  private
    FConfiguracoes: TConfigTelegram;
    FVersao: string;
    FSoftwareHouse: string;
    FonMsgEnviada: TOnMsgEnviada;

  protected

  public

    function GetChatID: string;
    procedure SendTextMessage(Text: string);
    procedure SendPhoto(FileNameURL, Caption: string);
    procedure SendDocument(FileName, Caption: string);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published

     property Configuracoes : TConfigTelegram   read FConfiguracoes         write FConfiguracoes;
     property Versao        : string            read FVersao;
     property Empresa       : string            read FSoftwareHouse;

     property onMsgEnviada  : TOnMsgEnviada     read FonMsgEnviada          write FonMsgEnviada;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DT Inovacao', [TDTTelegram]);
end;

{ TDTelegram }

function TDTTelegram.GetChatID: string;
var
  HTTP     : THTTPClient;
  URL      : string;
  Response : IHTTPResponse;
  JSONObj  : TJSONObject;
  ChatID   : string;
begin
  HTTP := THTTPClient.Create;
  try
    URL := Format('https://api.telegram.org/bot%s/getUpdates', [FConfiguracoes.BotTOKEN]);

    Response := HTTP.Get(URL);

    if Response.StatusCode <> 200 then
      raise Exception.Create('Erro ao obter chat ID: ' + Response.ContentAsString);

    JSONObj := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
    try
      if JSONObj.GetValue<Boolean>('ok') then
      begin
        ChatID := JSONObj.GetValue<TJSONArray>('result')
                        .Items[0]
                        .GetValue<TJSONObject>('channel_post')
                        .GetValue<TJSONObject>('sender_chat')
                        .GetValue<string>('id');

        Result := ChatID;
        onMsgEnviada(Self, Response.ContentAsString);
      end
      else
        onMsgEnviada(Self, 'Erro: ' + Response.ContentAsString);
    finally
      JSONObj.Free;
    end;

  finally
    HTTP.Free;
  end;
end;

procedure TDTTelegram.SendTextMessage(Text: string);
var
  HTTP     : THTTPClient;
  URL      : string;
  Response : IHTTPResponse;
  Params   : TStringStream;
begin
  HTTP   := THTTPClient.Create;
  Params := TStringStream.Create(
    Format('{"chat_id": "%s", "text": "%s"}',
      [FConfiguracoes.ChatID, Text]),
    TEncoding.UTF8
  );
  try
    URL := Format('https://api.telegram.org/bot%s/sendMessage', [FConfiguracoes.BotTOKEN]);

    Response := HTTP.Post(URL, Params, nil, [TNameValuePair.Create('Content-Type', 'application/json')]);

    if Response.StatusCode <> 200 then
      onMsgEnviada(Self,'Erro ao enviar mensagem: ' + Response.ContentAsString)
    else
      onMsgEnviada(Self, Response.ContentAsString);
  finally
    Params.Free;
    HTTP.Free;
  end;
end;

procedure TDTTelegram.SendPhoto(FileNameURL, Caption: string);
var
  HTTP: THTTPClient;
  MultipartFormData: TMultipartFormData;
  Response: IHTTPResponse;
begin
  HTTP := THTTPClient.Create;
  MultipartFormData := TMultipartFormData.Create;
  try
    MultipartFormData.AddField('chat_id', FConfiguracoes.ChatID);
    MultipartFormData.AddField('photo', FileNameURL);
    if Caption <> '' then
      MultipartFormData.AddField('caption', Caption);

    Response := HTTP.Post(
      Format('https://api.telegram.org/bot%s/sendPhoto', [FConfiguracoes.BotTOKEN]),
      MultipartFormData
    );

    if Response.StatusCode <> 200 then
      onMsgEnviada(Self,'Erro ao enviar imagem: ' + Response.ContentAsString)
    else
      onMsgEnviada(Self, Response.ContentAsString);
  finally
    MultipartFormData.Free;
    HTTP.Free;
  end;
end;

procedure TDTTelegram.SendDocument(FileName, Caption: string);
var
  HTTP: THTTPClient;
  MultipartFormData: TMultipartFormData;
  Response: IHTTPResponse;
begin
  HTTP := THTTPClient.Create;
  MultipartFormData := TMultipartFormData.Create;
  try
    MultipartFormData.AddField('chat_id', FConfiguracoes.ChatID);
    MultipartFormData.AddFile('document', FileName);
    if Caption <> '' then
      MultipartFormData.AddField('caption', Caption);

    Response := HTTP.Post(
      Format('https://api.telegram.org/bot%s/sendDocument', [FConfiguracoes.BotTOKEN]),
      MultipartFormData
    );

    if Response.StatusCode <> 200 then
      onMsgEnviada(Self,'Erro ao enviar documento: ' + Response.ContentAsString)
    else
      onMsgEnviada(Self, Response.ContentAsString);
  finally
    MultipartFormData.Free;
    HTTP.Free;
  end;
end;

constructor TDTTelegram.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

  FConfiguracoes           := TConfigTelegram.Create;
  FConfiguracoes.FChatID   := '';
  FConfiguracoes.FBotTOKEN := '';
  FVersao                  := '25.0.0.3000';
  FSoftwareHouse           := 'DT Inovacao em Tecnologia Ltda';

end;

destructor TDTTelegram.Destroy;
begin
  FreeAndNil(FConfiguracoes);

  inherited Destroy;
end;

{ TConfigTelegram }

procedure TConfigTelegram.SetBotTOKEN(const Value: string);
begin
  FBotTOKEN := Value;
end;

procedure TConfigTelegram.SetChatID(const Value: string);
begin
  FChatID := Value;
end;

end.
