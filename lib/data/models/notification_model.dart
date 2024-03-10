class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String payload;
  final String model;
  final String path;


  NotificationModel({
    required this.title,
    required this.body,
    required this.payload,
    required this.model,
    required this.path,
    required this.id,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
      model: map['model'],
      path: map['path'],
      id: map['id'],
    );
  }
}

class NotificationModelList {
  List<NotificationModel> notificationModelList;

  NotificationModelList({required this.notificationModelList});

  factory NotificationModelList.fromList(List<dynamic> list) {
    List<NotificationModel> notificationModelList = [];
    list.forEach((element) {
      notificationModelList.add(NotificationModel.fromMap(element));
    });
    return NotificationModelList(notificationModelList: notificationModelList);
  }
}