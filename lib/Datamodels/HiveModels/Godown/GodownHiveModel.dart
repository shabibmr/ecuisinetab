import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'GodownHiveModel.g.dart';

@HiveType(typeId: 61)
class GodownHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? Godown_ID;
  @HiveField(1)
  String? Godown_Name;
  @HiveField(2)
  String? Godown_Location;
  @HiveField(3)
  String? Godown_Narration;
  @HiveField(4)
  bool? isProfitCentre;
  GodownHiveModel({
    this.Godown_ID,
    this.Godown_Name,
    this.Godown_Location,
    this.Godown_Narration,
    this.isProfitCentre,
  });

  GodownHiveModel copyWith({
    String? Godown_ID,
    String? Godown_Name,
    String? Godown_Location,
    String? Godown_Narration,
    bool? isProfitCentre,
  }) {
    return GodownHiveModel(
      Godown_ID: Godown_ID ?? this.Godown_ID,
      Godown_Name: Godown_Name ?? this.Godown_Name,
      Godown_Location: Godown_Location ?? this.Godown_Location,
      Godown_Narration: Godown_Narration ?? this.Godown_Narration,
      isProfitCentre: isProfitCentre ?? this.isProfitCentre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Godown_ID': Godown_ID,
      'Godown_Name': Godown_Name,
      'Godown_Location': Godown_Location,
      'Godown_Narration': Godown_Narration,
      'isProfitCentre': isProfitCentre,
    };
  }

  factory GodownHiveModel.fromMap(Map<String, dynamic> map) {
    return GodownHiveModel(
      Godown_ID: map['Godown_ID'],
      Godown_Name: map['Godown_Name'] ?? '',
      Godown_Location: map['Godown_Location'] ?? '',
      Godown_Narration: map['Godown_Narration'] ?? '',
      isProfitCentre:
          map['isProfitCentre'] == '1' || map['isProfitCentre'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory GodownHiveModel.fromJson(String source) =>
      GodownHiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GodownHiveModel(Godown_ID: $Godown_ID, Godown_Name: $Godown_Name, Godown_Location: $Godown_Location, Godown_Narration: $Godown_Narration, isProfitCentre: $isProfitCentre)';
  }

  @override
  List<Object?> get props {
    return [
      Godown_ID,
      Godown_Name,
      Godown_Location,
      Godown_Narration,
      isProfitCentre,
    ];
  }
}
