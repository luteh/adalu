part of 'track_order_bloc.dart';

class TrackOrderState {
  final TrackOrder trackOrder;
  final bool isLoading;

  TrackOrderState({
    this.trackOrder,
    this.isLoading=false
  });

  TrackOrderState copyWith({
    TrackOrder trackOrder,
    bool isLoading,
  }) {
    return TrackOrderState(
      trackOrder: trackOrder ?? this.trackOrder,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TrackOrderStateFailure extends TrackOrderState {
  final String message;

  TrackOrderStateFailure(this.message);
}