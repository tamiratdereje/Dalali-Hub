import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart'
    as realm_models;

class RealmConfig {
  final App atlasApp;
  Realm? _realm;

  Realm get realm => _realm!;

  RealmConfig._(this.atlasApp);

  static Future<RealmConfig> init(App atlasApp) async {
    final realmConfig = RealmConfig._(atlasApp);
    if (atlasApp.currentUser == null) {
      debugPrint('RealmConfig.init: currentUser is null');
    } else {
      realmConfig._realm = await _getRealm(atlasApp);
    }
    return realmConfig;
  }

  Future<void> reinit(User user) async {
    if (_realm != null && !_realm!.isClosed) {
      _realm!.close();
    }
    _realm = await _getRealm(atlasApp, user: user);
  }

  static Future<Realm> _getRealm(App atlasApp, {User? user}) async {
    final user0 = user ?? atlasApp.currentUser;
    if (user0 == null) {
      throw Exception('User is null');
    }

    final realm = Realm(Configuration.flexibleSync(
      user0,
      [
        realm_models.User.schema,
        realm_models.Rooms.schema,
        realm_models.Photo.schema,
        realm_models.Messages.schema,
      ],
    ));

    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<realm_models.User>());
      mutableSubscriptions.add(realm.all<realm_models.Rooms>());
      mutableSubscriptions.add(realm.all<realm_models.Photo>());
      mutableSubscriptions.add(realm.all<realm_models.Messages>());
    });

    try {
      CancellationToken cancellationToken =
          TimeoutCancellationToken(const Duration(seconds: 3));

      await realm.subscriptions.waitForSynchronization(cancellationToken);
    } on TimeoutException catch (e) {
      debugPrint('RealmConfig.getRealm subscriptions timeout $e');
    }
    realm.refresh();
    debugPrint(
        'RealmConfig.getRealm subscriptions states ${realm.subscriptions.state}');
    return realm;
  }
}
