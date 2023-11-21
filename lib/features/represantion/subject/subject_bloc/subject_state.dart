part of 'subject_cubit.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();
}

class SubjectInitial extends SubjectState {
  @override
  List<Object> get props => [];
}
class SubjectLoading extends SubjectState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class SubjectLoaded extends SubjectState{

  final List<SubjectEntities> Subject;

  const SubjectLoaded({required this.Subject});
  @override
  List<Object> get props => [Subject];


}
class SubjectFailure extends SubjectState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}