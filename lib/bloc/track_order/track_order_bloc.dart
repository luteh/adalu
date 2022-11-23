import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_rekret_ecommerce/data/model/response/track_order.dart';
import 'package:flutter_rekret_ecommerce/data/repository/track_order_repo.dart';

part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  final TrackOrderRepo trackOrderRepo;
  TrackOrderBloc(this.trackOrderRepo) : super(TrackOrderState());

  @override
  Stream<TrackOrderState> mapEventToState(TrackOrderEvent event) async* {
    if (event is InitialTrackOrderEvent) {
      yield state.copyWith(isLoading: true);

      ApiResponse apiResponse = await trackOrderRepo.getTrackOrder(event.orderID);

      if (apiResponse != null) {
        TrackOrder trackOrder = TrackOrder.fromJson(apiResponse.response.data);

        add(UpdateTrackOrderEvent(
          isLoading: false,
          trackOrder: trackOrder
        ));

      } else {
        yield state.copyWith(isLoading: false);
        yield TrackOrderStateFailure(apiResponse.response.data['message'] ?? "Failed");
      }

    } else if (event is UpdateTrackOrderEvent) {
      yield state.copyWith(
        isLoading: event.isLoading,
        trackOrder: event.trackOrder
      );
    }
  }
}
