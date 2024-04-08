part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final StateStatus status;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = StateStatus.loading,
  });

  LoginState copyWith({
    String? email,
    String? password,
    StateStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
  

  @override
  List<Object> get props => [ email, password, status];
}

