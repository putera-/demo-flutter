import 'package:pgnpartner_mobile/data/models/announcement/announcement_model.dart';
import 'package:pgnpartner_mobile/data/models/announcement/announcement_request_model.dart';
import 'package:pgnpartner_mobile/services/http_service.dart';

class AnnouncementProvider {
  final HttpService _httpService;
  AnnouncementProvider(this._httpService);

  Future<List<Announcement>> getAnnouncement(
      AnnouncementRequestModel request) async {
    final response = await _httpService.post(
        '/announcement/list', request.toQueryParameters());

    if (response.statusCode == 200) {
      final List<dynamic> rows = response.data['list']['rows'];
      return rows.map((item) => Announcement.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load announcements');
    }
  }
}
