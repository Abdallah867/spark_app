import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quizz_state.dart';

class QuizzCubit extends Cubit<QuizzState> {
  QuizzCubit() : super(QuizzInitial());
}
