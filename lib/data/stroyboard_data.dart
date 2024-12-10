
class Scene {
  final int sceneId;
  final int storyboardId;
  final int orderNum;
  final String description;
  final String cameraAngle;
  final String cameraMovement;
  final String composition;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Scene(
      this.sceneId,
      this.storyboardId,
      this.orderNum,
      this.description,
      this.cameraAngle,
      this.cameraMovement,
      this.composition,
      this.imageUrl,
      this.createdAt,
      this.updatedAt,
      );

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      json['scene_id'],
      json['storyboard_id'],
      json['order_num'],
      json['description'],
      json['camera_angle'],
      json['camera_movement'],
      json['composition'],
      json['image_url'],
      DateTime.parse(json['created_at']),
      DateTime.parse(json['updated_at']),
    );
  }
}

class Storyboard {
  final int storyboardId;
  late List<Scene> scenesList;
  final int userId;
  final String title;
  final String destination;
  final String companions;
  final String purpose;
  final DateTime createdAt;
  final DateTime updatedAt;

  Storyboard(
      this.storyboardId,
      this.userId,
      this.title,
      this.destination,
      this.companions,
      this.purpose,
      this.createdAt,
      this.updatedAt,
      );

  factory Storyboard.fromJson(Map<String, dynamic> json) {
    return Storyboard(
      json['storyboard_id'],
      json['userId'],
      json['title'],
      json['destination'],
      json['companions'],
      json['purpose'],
      DateTime.parse(json['createdAt']),
      DateTime.parse(json['updatedAt']),
    )..scenesList =
    (json['scenesList'] as List).map((s) => Scene.fromJson(s)).toList();
  }
}

class StoryboardSet {
  final int travelId;
  final int sbSetId;
  late List<Storyboard> storyboardList;

  StoryboardSet(this.travelId, this.sbSetId);

  factory StoryboardSet.fromJson(Map<String, dynamic> json) {
    return StoryboardSet(
      json['travel_id'],
      json['sbSet_id'],
    )..storyboardList = (json['StroyboardList'] as List)
        .map((sb) => Storyboard.fromJson(sb))
        .toList();
  }
}

class Travel {
  final int travelId;
  final String travelTitle;
  late List<StoryboardSet> sbSet;

  Travel(this.travelId, this.travelTitle, [List<StoryboardSet>? sbSet]) {
    this.sbSet = sbSet ?? []; // 기본값 빈 리스트 설정
  }

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      json['travelId'] ?? 0, // 기본값으로 0 설정
      json['travelTitle'] ?? '재밌는 여행', // 기본값으로 0 설정
      (json['sbSet'] as List<dynamic>?) // sbSet이 null일 수 있으므로 검사
          ?.map((sbSet) => StoryboardSet.fromJson(sbSet))
          .toList(),
    );
  }
}

