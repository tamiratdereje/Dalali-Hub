part of 'my_listing_bloc.dart';

@freezed
class MyListingEvent with _$MyListingEvent {
  const factory MyListingEvent.started() = _Started;
  const factory MyListingEvent.myListing(bool? isApproved) = _MyListing;
  const factory MyListingEvent.updateFavorite(String propertyId) = _UpdateFavorite;
}