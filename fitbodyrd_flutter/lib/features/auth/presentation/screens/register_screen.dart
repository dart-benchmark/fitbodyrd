import 'package:fitbodyrd_flutter/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_text_field.dart';
import 'package:fitbodyrd_flutter/src/core/gen/assets.gen.dart';
import 'package:fitbodyrd_flutter/src/core/routing/app_routes.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_sizedbox.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/style/style_constants.dart';
import 'package:fitbodyrd_flutter/src/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isShowingPassword = false;
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hasSubmitted = false;

  void togglePasswordVisibility() {
    setState(() {
      isShowingPassword = !isShowingPassword;
    });
  }

  void loseFocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _formKey.currentState?.dispose();

    super.dispose();
  }

  Future<void> register() async {
    if (!hasSubmitted) {
      setState(() {
        hasSubmitted = true;
      });
    }
    if (_formKey.currentState?.validate() ?? false) {
      final email = emailController.text.trim();
      final fullName = fullNameController.text.trim();
      final password = passwordController.text.trim();

      await context.read<AuthCubit>().signUp(
            email: email,
            password: password,
            fullName: fullName,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        if (previous is AuthLoading && current is! AuthLoading) {
          context.pop();
        }

        return previous != current;
      },
      listener: (context, state) async {
        if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.failure.message);
        }
        if (state is AuthNeedsValidation) {
          await context.pushNamed(AppRoutes.validateCode.name);
        }

        if (state is AuthLoading) {
          if (context.mounted) await CoreUtils.showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            autovalidateMode: hasSubmitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: SafeArea(
              child: Padding(
                padding: StyleConstants.screenPadding,
                child: ListView(
                  children: [
                    Center(
                      child: Assets.appIcon.image(
                        width: 125.w,
                        height: 125.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    KSizedBox.s5(),
                    Center(child: KText.headlineLarge('FitBody RD')),
                    KSizedBox.s5(),
                    KText.headlineSmall('Registrarse'),
                    KSizedBox.s10(),
                    CTextField(
                      leadingIcon: Icon(Icons.email_outlined),
                      placeholderText: 'Correo electrónico',
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Por favor ingresa un correo electrónico'
                              ' válido';
                        }
                        return null;
                      },
                    ),
                    KSizedBox.s10(),
                    CTextField(
                      leadingIcon: Icon(Icons.person_outline),
                      placeholderText: 'Nombre completo',
                      keyboardType: TextInputType.name,
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.next,
                      controller: fullNameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor ingresa tu nombre completo';
                        }
                        return null;
                      },
                    ),
                    KSizedBox.s10(),
                    CTextField(
                      leadingIcon: Icon(Icons.lock_outline),
                      placeholderText: 'Contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isShowingPassword,
                      focusNode: _passwordFocusNode,
                      trailingIcon: IconButton(
                        icon: Icon(
                          isShowingPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe tener al '
                              'menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    KSizedBox.s10(),
                    CTextField(
                      leadingIcon: Icon(Icons.lock_outline),
                      placeholderText: 'Confirmar Contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isShowingPassword,
                      focusNode: _confirmPasswordFocusNode,
                      trailingIcon: IconButton(
                        icon: Icon(
                          isShowingPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                      onTapOutside: (_) => loseFocus(),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => register(),
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirma tu contraseña';
                        }
                        if (value != passwordController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    KSizedBox.s20(),
                    CButton.primary(
                      text: 'Registrarse',
                      onPressed: register,
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
