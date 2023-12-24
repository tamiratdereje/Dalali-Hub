part of 'get_property_bloc.dart';

@freezed
class GetPropertyEvent with _$GetPropertyEvent {
  const factory GetPropertyEvent.started() = _Started;
  const factory GetPropertyEvent.getProperty(String id) = _GetProperty;
  const factory GetPropertyEvent.updateFavorite(String propertyId) = _UpdateFavorite;
}
