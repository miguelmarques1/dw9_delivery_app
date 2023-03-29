// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'login_state.g.dart';

@match
enum LoginStatus {
  initial, 
  logging,
  error,
  loginError,
  success
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;
  const LoginState({required this.status, required this.errorMessage});

  const LoginState.initial() : status = LoginStatus.initial, errorMessage = null;
  
  @override
  List<Object?> get props => [status];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
