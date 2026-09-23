import 'package:dio/dio.dart';
import 'package:easy_resend/easy_resend.dart';
import 'package:fitbodyrd_server/src/core/agent_client/agent_client.dart';
import 'package:get_it/get_it.dart';
import 'package:serverpod/serverpod.dart';

final sl = GetIt.instance;

Future<void> injectDependencies(Serverpod pod) async {
  await initResend(pod);
  await initAgentClient(pod);
}

Future<void> initResend(Serverpod pod) async {
  final resendApiKey = pod.getPassword('resendApiKey');

  EasyResend.initialize(resendApiKey!);
  sl.registerSingleton<EasyResend>(EasyResend.getInstance());
}

Future<void> initAgentClient(Serverpod pod) async {
  final n8nWebhookKey = pod.getPassword('n8nWebhookKey');
  final n8nWebhookBaseUrl = pod.getPassword('n8nWebhookBaseUrl');

  final dio = Dio(
    BaseOptions(
      baseUrl: n8nWebhookBaseUrl!,
      headers: {
        'aaa-api-key': n8nWebhookKey!,
      },
    ),
  );

  sl.registerSingleton<AgentClient>(
    AgentClient(httpClient: dio),
  );
}
