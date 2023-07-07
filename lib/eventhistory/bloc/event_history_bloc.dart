import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grambunny_customer/eventhistory/model/event_detail_model.dart';
import 'package:meta/meta.dart';

import '../../hm_root/user_repository.dart';
import '../../networking/network_api_call_state.dart';
import '../../utils/enumerations.dart';
import '../model/event_history_model.dart';

part 'event_history_event.dart';

part 'event_history_state.dart';

class EventHistoryBloc extends Bloc<EventHistoryEvent, EventHistoryState> {
  UserRepository? _userRepository;

  EventHistoryBloc({required UserRepository userRepository})
      : super(EventHistoryInitial()) {
    _userRepository = userRepository;

    on<EventHistoryEventReset>(mapEventHistoryEventReset);

    on<EventViewDetailEventClicked>(mapEventViewDetailEventClicked);

    on<EventHistorybtnEvent>(mapEventHistorybtnEvent);

    on<EventHistoryStateReset>(mapEventHistoryStateReset);

    on<EventListDetailEventForViewDetail>(mapEventListDetailEventForViewDetail);

    on<EventDetailStateReset>(mapEventDetailStateReset);
  }

  mapEventHistoryEventReset(
      EventHistoryEventReset event, Emitter<EventHistoryState> emitter) async {
    // _userRepository.ScreenName = OrderHistoryPageScreen;
    emitter(EventHistoryInitial());
  }

  mapEventViewDetailEventClicked(EventViewDetailEventClicked event,
      Emitter<EventHistoryState> emitter) async {
    emitter(EventHistoryListApiLoadingResetState());
    emitter(EventDetailPageState(event.order_id));
  }

  mapEventHistorybtnEvent(
      EventHistorybtnEvent event, Emitter<EventHistoryState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.getEventHistoryApi(event.pageNumber);
    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      _userRepository!.ScreenName = ScreenNavigation.EventHistoryPage;
      emit(EventHistoryApiLoadingCompleteState(
          _userRepository?.getEventHistoryData()!, 0));
    } else {
      print("EventHostoryLoadingErrortate");
      emit(EventHisyoryLoadingErrorState(apiCallState.message!));
    }
  }

  mapEventHistoryStateReset(
      EventHistoryStateReset event, Emitter<EventHistoryState> emitter) async {
    emitter(EventHistoryInitial());
  }

  mapEventListDetailEventForViewDetail(EventListDetailEventForViewDetail event,
      Emitter<EventHistoryState> emitter) async {
    NetworkApiCallState<bool> apiCallState =
        await _userRepository!.EventDetailAPi(event.order_id, event.vendorId);

    if (apiCallState.status == NetworkRequestStatus.COMPLETED) {
      print("Complete state");
      emit(EventListDetailApiLoadingCompleteState(_userRepository?.eventDetail,
          _userRepository?.eventItems, _userRepository!.eventmultipleDetail));
    } else {
      print("EventListDetailLoadingErrorStatetate");
      emit(EventListDetailLoadingErrorState(apiCallState.message!));
    }
  }

  mapEventDetailStateReset(
      EventDetailStateReset event, Emitter<EventHistoryState> emitter) async {
    emitter(EventHistoryInitial());
  }
}
