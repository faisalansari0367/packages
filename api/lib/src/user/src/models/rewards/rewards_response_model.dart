class RewardsResponseModel {
  int? status;
  List<Rewards>? rewardsAllow;

  RewardsResponseModel({this.status, this.rewardsAllow});

  RewardsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['rewards_allow'] != null) {
      rewardsAllow = <Rewards>[];
      json['rewards_allow'].forEach((v) {
        rewardsAllow!.add(Rewards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (rewardsAllow != null) {
      data['rewards_allow'] = rewardsAllow!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Rewards {
  int? rewardid;
  String? title;
  String? mainimage;
  String? details;
  int? points;
  String? isdeleted;

  Rewards({
    this.rewardid,
    this.title,
    this.mainimage,
    this.details,
    this.points,
    this.isdeleted,
  });

  Rewards.fromJson(Map<String, dynamic> json) {
    rewardid = json['rewardid'];
    title = json['title'];
    mainimage = json['mainimage'];
    details = json['details'];
    points = json['points'];
    isdeleted = json['isdeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rewardid'] = rewardid;
    data['title'] = title;
    data['mainimage'] = mainimage;
    data['details'] = details;
    data['points'] = points;
    data['isdeleted'] = isdeleted;
    return data;
  }
}
