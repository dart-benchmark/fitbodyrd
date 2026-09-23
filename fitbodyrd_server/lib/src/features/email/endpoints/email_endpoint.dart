import 'package:easy_resend/easy_resend.dart';
import 'package:fitbodyrd_server/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

@doNotGenerate
class EmailEndpoint extends Endpoint {
  static Future<void> sendVerificationCodeEmail(
    Session session,
    String email,
    String validationCode,
  ) async {
    final emailFrom = session.serverpod.getPassword('authEmailFrom');
    final emailTemplate = await EmailTemplate.db.findFirstRow(
      session,
      where: (p0) => p0.type.equals(EmailTemplatesEnum.validationCode),
    );

    await sl<EasyResend>().sendEmail(
      from: emailFrom!,
      to: [email],
      subject: emailTemplate!.subject,
      html: emailTemplate.content
          .replaceAll('{{validationCode}}', validationCode),
      text: emailTemplate.plainTextContent
          .replaceAll('{{validationCode}}', validationCode),
    );
  }

  static Future<void> sendForgotPasswordCodeEmail(
    Session session,
    UserInfo userInfo,
    String validationCode,
  ) async {
    final emailFrom = session.serverpod.getPassword('authEmailFrom');
    final emailTemplate = await EmailTemplate.db.findFirstRow(
      session,
      where: (p0) => p0.type.equals(EmailTemplatesEnum.forgotPassword),
    );

    await sl<EasyResend>().sendEmail(
      from: emailFrom!,
      to: [
        userInfo.email!,
      ],
      subject: emailTemplate!.subject,
      html: emailTemplate.content
          .replaceAll('{{validationCode}}', validationCode)
          .replaceAll('{{fullName}}', userInfo.fullName!),
      text: emailTemplate.plainTextContent
          .replaceAll('{{validationCode}}', validationCode)
          .replaceAll('{{fullName}}', userInfo.fullName!),
    );
  }
}
