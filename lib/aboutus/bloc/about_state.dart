import 'package:equatable/equatable.dart';

abstract class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

class AboutInitial extends AboutState {
  @override
  List<Object> get props => [];
}

class AboutBackToHomeState extends AboutState {}
