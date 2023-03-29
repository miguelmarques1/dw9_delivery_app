// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LoginStatusMatch on LoginStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() logging,
      required T Function() error,
      required T Function() loginError,
      required T Function() success}) {
    final v = this;
    if (v == LoginStatus.initial) {
      return initial();
    }

    if (v == LoginStatus.logging) {
      return logging();
    }

    if (v == LoginStatus.error) {
      return error();
    }

    if (v == LoginStatus.loginError) {
      return loginError();
    }

    if (v == LoginStatus.success) {
      return success();
    }

    throw Exception('LoginStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? logging,
      T Function()? error,
      T Function()? loginError,
      T Function()? success}) {
    final v = this;
    if (v == LoginStatus.initial && initial != null) {
      return initial();
    }

    if (v == LoginStatus.logging && logging != null) {
      return logging();
    }

    if (v == LoginStatus.error && error != null) {
      return error();
    }

    if (v == LoginStatus.loginError && loginError != null) {
      return loginError();
    }

    if (v == LoginStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
