import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_controller.dart';
import 'package:dw9_delivery_app/app/pages/auth/login/login_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: BlocListener<LoginController, LoginState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? '');
            },
            logging: () => showLoader(),
            loginError: () {
              hideLoader();
              showError(state.errorMessage ?? '');
            },
            success: () {
              hideLoader();
              Navigator.pop(context, true);
            },
          );
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: context.textStyles.textTitle,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailCtrl,
                        validator: Validatorless.multiple([
                          Validatorless.email('Email inválido'),
                          Validatorless.required('Email obrigatório')
                        ]),
                        decoration: const InputDecoration(label: Text('Email')),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordCtrl,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                        ]),
                        decoration: const InputDecoration(label: Text('Senha')),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: DeliveryButton(
                          label: 'Entrar',
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;
                            if (valid) {
                              context
                                  .read<LoginController>()
                                  .login(emailCtrl.text, passwordCtrl.text);
                            }
                          },
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text.rich(TextSpan(
                      text: 'Não possuí uma conta? ',
                      style: context.textStyles.textMedium,
                      children: [
                        TextSpan(
                            text: 'Cadastre-se',
                            style: context.textStyles.textMedium
                                .copyWith(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed('/auth/register');
                              })
                      ])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
