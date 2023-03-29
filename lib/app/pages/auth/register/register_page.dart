import 'package:dw9_delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<RegisterController, RegisterState>(
            listener: (context, state) {
              state.status.matchAny(
                any: () => hideLoader(),
                register: () => showLoader(),
                error: () {
                  hideLoader();
                  showError('Erro ao registrar usuário');
                },
                success: () {
                  hideLoader();
                  showSuccessful('Cadastro realizado com sucesso');
                  Navigator.pop(context);
                }
              );
            },
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  const Text(
                      'Preencha os campos abaixo para criar o seu cadastro'),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: nameCtrl,
                    validator: Validatorless.required('Nome obrigatório'),
                    decoration: const InputDecoration(label: Text('Nome')),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailCtrl,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('Email inválido')
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
                      Validatorless.min(
                          6, 'A senha deve ter pelo menos 6 caracteres')
                    ]),
                    decoration: const InputDecoration(label: Text('Senha')),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar Senha obrigatório'),
                      Validatorless.compare(
                          passwordCtrl, 'Senha diferente de confirma senha')
                    ]),
                    decoration:
                        const InputDecoration(label: Text('Confirmar senha')),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      label: 'Cadastrar',
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          context.read<RegisterController>().register(
                            nameCtrl.text, 
                            emailCtrl.text, 
                            passwordCtrl.text
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
