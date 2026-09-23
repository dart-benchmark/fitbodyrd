import 'package:fitbodyrd_server/src/features/email/endpoints/email_endpoint.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

Future<void> setupAuth() async {
  auth.AuthConfig.set(
    auth.AuthConfig(
      emailSignInFailureResetTime: Duration(seconds: 15),
      // onUserCreated: (session, userInfo) async {
      //   await userInfo.changeFullName(
      //     session,
      //     userInfo.userName!,
      //   );
      //   await UserEndpoint().createUser(userInfo, session);
      // },
      sendValidationEmail: (session, email, validationCode) async {
        await EmailEndpoint.sendVerificationCodeEmail(
          session,
          email,
          validationCode,
        );
        return true;
      },
      sendPasswordResetEmail: (session, userInfo, validationCode) async {
        await EmailEndpoint.sendForgotPasswordCodeEmail(
          session,
          userInfo,
          validationCode,
        );
        return true;
      },
    ),
  );
}
