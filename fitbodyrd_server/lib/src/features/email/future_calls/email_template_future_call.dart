import 'package:fitbodyrd_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

part 'default_templates.dart';

class EmailTemplateFutureCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    final count = await EmailTemplate.db.count(session);

    if (count >= defaultEmailTemplates.length) {
      return;
    }

    await EmailTemplate.db.deleteWhere(
      session,
      where: (p0) => Constant.bool(true),
    );

    await EmailTemplate.db.insert(
      session,
      defaultEmailTemplates,
    );
  }
}
