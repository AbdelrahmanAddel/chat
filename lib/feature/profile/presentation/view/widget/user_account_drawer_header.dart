import 'package:flutter/material.dart';

UserAccountsDrawerHeader userAccountDrawerHeader({
  required String accountName,
  required String accountEmail,
  required String networkImage,
}) {
  return UserAccountsDrawerHeader(
    accountName: Text(accountName),
    accountEmail: Text(accountEmail),
    currentAccountPicture: CircleAvatar(
      backgroundImage: NetworkImage(networkImage),
    ),
  );
}
