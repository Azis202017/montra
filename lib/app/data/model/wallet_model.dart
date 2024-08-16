// To parse this JSON data, do
//
//     final wallet = walletFromJson(jsonString);

import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

class Wallet {
    int? id;
    String? name;
    String? type;

    Wallet({
        this.id,
        this.name,
        this.type,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
    };
}
