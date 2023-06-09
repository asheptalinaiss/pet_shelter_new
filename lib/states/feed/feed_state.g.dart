// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedState on FeedStateBase, Store {
  late final _$petTypeAtom =
      Atom(name: 'FeedStateBase.petType', context: context);

  @override
  PetType? get petType {
    _$petTypeAtom.reportRead();
    return super.petType;
  }

  @override
  set petType(PetType? value) {
    _$petTypeAtom.reportWrite(value, super.petType, () {
      super.petType = value;
    });
  }

  late final _$announcementsAtom =
      Atom(name: 'FeedStateBase.announcements', context: context);

  @override
  List<AnnouncementWithAddress> get announcements {
    _$announcementsAtom.reportRead();
    return super.announcements;
  }

  @override
  set announcements(List<AnnouncementWithAddress> value) {
    _$announcementsAtom.reportWrite(value, super.announcements, () {
      super.announcements = value;
    });
  }

  late final _$selectedAnnouncementAtom =
      Atom(name: 'FeedStateBase.selectedAnnouncement', context: context);

  @override
  AnnouncementWithAddress? get selectedAnnouncement {
    _$selectedAnnouncementAtom.reportRead();
    return super.selectedAnnouncement;
  }

  @override
  set selectedAnnouncement(AnnouncementWithAddress? value) {
    _$selectedAnnouncementAtom.reportWrite(value, super.selectedAnnouncement,
        () {
      super.selectedAnnouncement = value;
    });
  }

  late final _$inProgressAtom =
      Atom(name: 'FeedStateBase.inProgress', context: context);

  @override
  bool get inProgress {
    _$inProgressAtom.reportRead();
    return super.inProgress;
  }

  @override
  set inProgress(bool value) {
    _$inProgressAtom.reportWrite(value, super.inProgress, () {
      super.inProgress = value;
    });
  }

  late final _$onSelectedAnnouncementWithoutAddressAsyncAction = AsyncAction(
      'FeedStateBase.onSelectedAnnouncementWithoutAddress',
      context: context);

  @override
  Future<void> onSelectedAnnouncementWithoutAddress(
      Announcement announcement, VoidCallback onSuccess) {
    return _$onSelectedAnnouncementWithoutAddressAsyncAction.run(() =>
        super.onSelectedAnnouncementWithoutAddress(announcement, onSuccess));
  }

  late final _$getAdsAsyncAction =
      AsyncAction('FeedStateBase.getAds', context: context);

  @override
  Future<void> getAds({PetType? petType}) {
    return _$getAdsAsyncAction.run(() => super.getAds(petType: petType));
  }

  late final _$FeedStateBaseActionController =
      ActionController(name: 'FeedStateBase', context: context);

  @override
  Future<void> onPetTypeChanged(PetType? petType) {
    final _$actionInfo = _$FeedStateBaseActionController.startAction(
        name: 'FeedStateBase.onPetTypeChanged');
    try {
      return super.onPetTypeChanged(petType);
    } finally {
      _$FeedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectedAnnouncement(AnnouncementWithAddress? announcement) {
    final _$actionInfo = _$FeedStateBaseActionController.startAction(
        name: 'FeedStateBase.onSelectedAnnouncement');
    try {
      return super.onSelectedAnnouncement(announcement);
    } finally {
      _$FeedStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
petType: ${petType},
announcements: ${announcements},
selectedAnnouncement: ${selectedAnnouncement},
inProgress: ${inProgress}
    ''';
  }
}
