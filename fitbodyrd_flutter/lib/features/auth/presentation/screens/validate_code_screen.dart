import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_text_field.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/style/style_constants.dart';
import 'package:fitbodyrd_flutter/src/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ValidateCodeScreen extends StatefulWidget {
  const ValidateCodeScreen({super.key});

  @override
  State<ValidateCodeScreen> createState() => _ValidateCodeScreenState();
}

class _ValidateCodeScreenState extends State<ValidateCodeScreen> {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loseFocus() {
    FocusScope.of(context).unfocus();
  }

  Future<void> validateCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final validationCode = codeController.text.trim();
      await context
          .read<AuthCubit>()
          .validateCode(validationCode: validationCode);
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        if (previous is AuthLoading && current is! AuthLoading) {
          if (current is! AuthSuccess) {
            context.pop();
          }
        }

        return previous != current;
      },
      listener: (context, state) async {
        if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.failure.message);
        }

        if (state is AuthLoading) {
          if (context.mounted) {
            await CoreUtils.showLoadingDialog(context);
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: StyleConstants.screenPadding,
                child: ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: KColors.primary.p500,
                        radius: 50.h,
                      ),
                    ),
                    KSizedBox.s5(),
                    Center(child: KText.headlineLarge('FitBody RD')),
                    KSizedBox.s5(),
                    KText.headlineSmall('Validar código'),
                    KSizedBox.s10(),
                    CTextField(
                      placeholderText: 'Código de validación',
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => validateCode(),
                      controller: codeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa el código de validación';
                        }
                        return null;
                      },
                    ),
                    KSizedBox.s10(),
                    CButton.primary(
                      text: 'Validar código',
                      onPressed: validateCode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
