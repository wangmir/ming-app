import 'package:json_annotation/json_annotation.dart';

import '../common/utils.dart';
import 'entities.dart';

part 'shelter.g.dart';

@JsonSerializable()
class ShelterOverviewResponse {
  final String id;
  final String name;
  final String adminName;
  final String description;
  final String phoneNumber;
  final String location;
  final String thumbnailUrl;
  final UserListOverviewResponse volunteerOverview;
  @ListConverter<AnimalInShelterOverview>()
  final List<AnimalInShelterOverview> animalOverview;

  ShelterOverviewResponse(
    this.id,
    this.name,
    this.adminName,
    this.description,
    this.phoneNumber,
    this.location,
    this.thumbnailUrl,
    this.volunteerOverview,
    this.animalOverview,
  );

  factory ShelterOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ShelterOverviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShelterOverviewResponseToJson(this);
}

@JsonSerializable()
class AnimalInShelterOverview {
  final int count;
  final AnimalType type;

  AnimalInShelterOverview(this.count, this.type);

  factory AnimalInShelterOverview.fromJson(Map<String, dynamic> json) =>
      _$AnimalInShelterOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalInShelterOverviewToJson(this);
}

@JsonSerializable()
class ShelterByRegionResponse {
  final int adoptedAnimalCount;
  final int animalInShelterCount;
  final int count;
  final RegionResponse region;
  final UserListOverviewResponse volunteerOverview;

  ShelterByRegionResponse(
    this.adoptedAnimalCount,
    this.animalInShelterCount,
    this.count,
    this.region,
    this.volunteerOverview,
  );

  factory ShelterByRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$ShelterByRegionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShelterByRegionResponseToJson(this);
}

@JsonSerializable()
class ShelterImagesResponse {
  final String id;
  final String thumbnailUrl;

  ShelterImagesResponse(this.id, this.thumbnailUrl);

  factory ShelterImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ShelterImagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShelterImagesResponseToJson(this);
}
