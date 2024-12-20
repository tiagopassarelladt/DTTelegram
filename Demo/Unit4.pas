unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DTTelegram;

type
  TForm4 = class(TForm)
    edtBotToken: TEdit;
    Label1: TLabel;
    edtChatID: TEdit;
    Label2: TLabel;
    Button1: TButton;
    M: TMemo;
    DTTelegram1: TDTTelegram;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DTTelegram1MsgEnviada(Sender: TObject; const JsonReturn: string);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  procedure ConfiguraComponente;
  public

  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
     ConfiguraComponente;

     DTTelegram1.SendTextMessage('testando uma mensagem de texto');

end;

procedure TForm4.Button2Click(Sender: TObject);
begin
     ConfiguraComponente;

     DTTelegram1.SendPhoto('https://files.dtloja.com.br/imagens/logoDT.jpeg','Teste de envio de mensagem com imagem via URL')
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
     ConfiguraComponente;

     DTTelegram1.SendDocument('D:\Dropbox\Componentes\DTPro\DTTelegram\Demo\Win32\Debug\planilha.xlsx','Teste de envio de documento')
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
     ConfiguraComponente;

     edtchatid.text := DTTelegram1.getChatid;
end;

procedure TForm4.ConfiguraComponente;
begin
      DTTelegram1.Configuracoes.BotTOKEN := edtBotToken.Text;
      DTTelegram1.Configuracoes.ChatID   := edtChatID.Text;
end;

procedure TForm4.DTTelegram1MsgEnviada(Sender: TObject;
  const JsonReturn: string);
begin
     m.Lines.Clear;
     m.Lines.Add(JsonReturn);
end;

end.
