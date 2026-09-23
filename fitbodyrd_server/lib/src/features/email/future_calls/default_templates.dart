part of 'email_template_future_call.dart';

const defaultValidationCodeSubject = 'Codigo de validación';
const defaultValidationCodeTemplate = '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Código de validación</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }
    .email-container {
      width: 100%;
      max-width: 600px;
      margin: 0 auto;
      background-color: #ffffff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    .header {
      text-align: center;
      padding: 20px 0;
    }
    .header h1 {
      font-size: 24px;
      color: #333333;
    }
    .content {
      margin-top: 20px;
      color: #333333;
      font-size: 16px;
    }
    .code-box {
      background-color: #f1f1f1;
      border-radius: 5px;
      padding: 15px;
      text-align: center;
      font-size: 24px;
      font-weight: bold;
      color: #333;
      letter-spacing: 2px;
      margin: 20px 0;
    }
    .button {
      display: inline-block;
      background-color: #4CAF50;
      color: #ffffff;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 16px;
      text-align: center;
    }
    .footer {
      margin-top: 20px;
      font-size: 12px;
      color: #888888;
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="email-container">
    <div class="header">
      <h1>Bienvenido a FitBodyRD!</h1>
    </div>
    <div class="content">
      <p>Hola,</p>
      <p>Gracias por registrarte con nosotros! Para completar tu registro, por favor usa el codigo de verificación debajo:</p>
      <div class="code-box">{{validationCode}}</div>
      <p>Si no solicitaste este codigo, por favor ignora este email o contacta nuestro equipo de soporte para ayuda.</p>
    </div>
    <div class="footer">
      <p>Mucha suerte,<br>Equipo de FitBodyRD</p>
    </div>
  </div>
</body>
</html>
''';
const defaultValidationCodePlainText = '''
Bienvenido a FitBodyRD!

Gracias por registrarte con nosotros! Para completar tu registro, por favor usa el codigo de verificación debajo:

{{validationCode}}

Si no solicitaste este codigo, por favor ignora este email o contacta nuestro equipo de soporte para ayuda.

Mucha suerte,
Equipo de FitBodyRD
''';

const defaultForgotPasswordCodeSubject = 'Restablecimiento de Contraseña';
const defaultForgotPasswordCodeTemplate = '''<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Restablecimiento de Contraseña</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }
    .email-container {
      width: 100%;
      max-width: 600px;
      margin: 0 auto;
      background-color: #ffffff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    .header {
      text-align: center;
      padding: 20px 0;
    }
    .header h1 {
      font-size: 24px;
      color: #333333;
    }
    .content {
      margin-top: 20px;
      color: #333333;
      font-size: 16px;
    }
    .code-box {
      background-color: #f1f1f1;
      border-radius: 5px;
      padding: 15px;
      text-align: center;
      font-size: 24px;
      font-weight: bold;
      color: #333;
      letter-spacing: 2px;
      margin: 20px 0;
    }
    .button {
      display: inline-block;
      background-color: #FF5733;
      color: #ffffff;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 16px;
      text-align: center;
    }
    .footer {
      margin-top: 20px;
      font-size: 12px;
      color: #888888;
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="email-container">
    <div class="header">
      <h1>Solicitud de Restablecimiento de Contraseña</h1>
    </div>
    <div class="content">
      <p>Hola {{fullName}},</p>
      <p>Hemos recibido una solicitud para restablecer tu contraseña. Utiliza el siguiente código para continuar con el proceso:</p>
      <div class="code-box">{{validationCode}}</div>
      <p>Si no solicitaste el restablecimiento de tu contraseña, ignora este correo o comunícate con nuestro equipo de soporte para obtener ayuda.</p>
      <p>Si tienes alguna pregunta, no dudes en contactarnos.</p>
    </div>
    <div class="footer">
      <p>Saludos,<br>Equipo de FitBodyRD</p>
    </div>
  </div>
</body>
</html>
''';
const defaultForgotPasswordCodePlainText = '''
Solicitud de Restablecimiento de Contraseña

Hola {{fullName}},

Hemos recibido una solicitud para restablecer tu contraseña. Utiliza el siguiente código para continuar con el proceso:

{{validationCode}}

Si no solicitaste el restablecimiento de tu contraseña, ignora este correo o comunícate con nuestro equipo de soporte para obtener ayuda.
Si tienes alguna pregunta, no dudes en contactarnos.

Saludos,
Equipo de FitBodyRD
''';

final defaultEmailTemplates = [
  EmailTemplate(
    type: EmailTemplatesEnum.validationCode,
    content: defaultValidationCodeTemplate,
    subject: defaultValidationCodeSubject,
    plainTextContent: defaultValidationCodePlainText,
  ),
  EmailTemplate(
    type: EmailTemplatesEnum.forgotPassword,
    content: defaultForgotPasswordCodeTemplate,
    subject: defaultForgotPasswordCodeSubject,
    plainTextContent: defaultForgotPasswordCodePlainText,
  ),
];
