part of 'track_order_bloc.dart';

abstract class TrackOrderEvent extends Equatable {
  const TrackOrderEvent();
}

class UpdateTrackOrderEvent extends TrackOrderEvent {
  final TrackOrder trackOrder;
  final bool isLoading;

  UpdateTrackOrderEvent({
    this.trackOrder,
    this.isLoading=true
  });

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitialTrackOrderEvent extends TrackOrderEvent {
  String orderID;

  InitialTrackOrderEvent(this.orderID);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}