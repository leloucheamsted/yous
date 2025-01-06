import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_options_view_state.dart';

class SearchOptionsViewCubit extends Cubit<SearchOptionsViewState> {
  SearchOptionsViewCubit() : super(SearchOptionsViewInitial());
}
