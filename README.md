# DTTelegram - Integração com o Telegram 📢

Este documento explica como configurar e utilizar o componente **DTTelegram** para enviar mensagens, imagens e documentos a um canal do Telegram. O guia aborda desde a criação do bot até o envio de dados utilizando o componente.

---

## **Passo 1: Configurando o Componente 🔧**

### Propriedades do Componente
O componente **TDTTelegram** possui as seguintes propriedades que precisam ser configuradas antes do uso:

- **Configuracoes.BotTOKEN**: Token do bot gerado pelo BotFather.
- **Configuracoes.ChatID**: ID do chat ou canal onde as mensagens serão enviadas.

Exemplo de configuração no Delphi:

```delphi
var
  Telegram: TDTTelegram;
begin
  Telegram := TDTTelegram.Create(Self);
  try
    Telegram.Configuracoes.BotTOKEN := '7952055082:AAE-RFrDHQ6LvnBgNEDLAcFau1GW0RLNdoY';
    Telegram.Configuracoes.ChatID := '-1002290313489';

    // Usar o componente para enviar mensagens, fotos ou documentos.
  finally
    Telegram.Free;
  end;
end;
```

---

## **Passo 2: Criando o Bot no BotFather 🤖**

1. Abra o Telegram e procure pelo usuário `@BotFather`.
2. Inicie uma conversa e digite `/start`.
3. Envie o comando `/newbot` para criar um novo bot.
4. Siga as instruções do BotFather:
   - Dê um nome ao bot (exemplo: `MeuBotDT`).
   - Escolha um nome de usuário para o bot, terminando com `bot` (exemplo: `MeuBotDT_bot`).
5. Após concluir, o BotFather fornecerá um token de acesso. 🔐 Copie e guarde este token.

---

## **Passo 3: Obtendo o Chat ID do Canal 🔎**

1. Adicione o bot ao canal como administrador.
2. Envie uma mensagem qualquer no canal.
3. Chame o endpoint abaixo para obter informações do canal:
   ```
   https://api.telegram.org/bot<SEU_TOKEN>/getUpdates
   ```
4. Procure pela propriedade `chat` no retorno JSON. O `id` do canal será um valor negativo.

---

## **Passo 4: Enviando Mensagens de Texto 📝**

Utilize o método `SendTextMessage` para enviar mensagens de texto:

### Exemplo:
```delphi
Telegram.SendTextMessage('Esta é uma mensagem enviada com sucesso ao canal DTLog!');
```

### Implementação Interna:
O componente realiza uma requisição POST ao endpoint:
```
https://api.telegram.org/bot<SEU_TOKEN>/sendMessage
```
Com o seguinte corpo JSON:
```json
{
  "chat_id": "-1002290313489",
  "text": "Esta é uma mensagem enviada com sucesso ao canal DTLog!"
}
```

---

## **Passo 5: Enviando Imagens 🖼**

### Como URL
Para enviar uma imagem a partir de uma URL, utilize o método `SendPhoto`:

### Exemplo:
```delphi
Telegram.SendPhoto('https://example.com/minha-imagem.jpg', 'Legenda para a imagem');
```

### Como Arquivo Local
Para enviar uma imagem local, passe o caminho do arquivo:
```delphi
Telegram.SendPhoto('C:\\imagens\\minha-imagem.jpg', 'Legenda para a imagem local');
```

### Implementação Interna:
O componente realiza uma requisição POST ao endpoint:
```
https://api.telegram.org/bot<SEU_TOKEN>/sendPhoto
```
Com suporte a multipart/form-data para upload de arquivos.

---

## **Passo 6: Enviando Documentos 📄**

Utilize o método `SendDocument` para enviar documentos:

### Exemplo:
```delphi
Telegram.SendDocument('C:\\documentos\\relatorio.pdf', 'Relatório Mensal');
```

### Implementação Interna:
O componente realiza uma requisição POST ao endpoint:
```
https://api.telegram.org/bot<SEU_TOKEN>/sendDocument
```
Com suporte a multipart/form-data para upload de documentos.

---

## **Considerações Finais 📊**

- Utilize o evento **onMsgEnviada** para capturar o retorno da API:
  ```delphi
  Telegram.onMsgEnviada := procedure(Sender: TObject; const JsonReturn: string)
  begin
    ShowMessage('Retorno da API: ' + JsonReturn);
  end;
  ```

- Lembre-se de proteger o token do bot para evitar acessos indesejados.
- Consulte a [documentação oficial da API do Telegram](https://core.telegram.org/bots/api) para mais informações.

https://www.youtube.com/live/s1ZGixQqZ1M

