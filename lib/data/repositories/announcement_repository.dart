import 'package:pgnpartner_mobile/core/constants/api_constant.dart';
import 'package:pgnpartner_mobile/data/models/announcement/announcement_model.dart';
import 'package:pgnpartner_mobile/data/models/announcement/announcement_request_model.dart';
import 'package:pgnpartner_mobile/data/providers/announcement_provider.dart';
import 'package:pgnpartner_mobile/services/http_service.dart';

class AnnouncementRepository {
  late final AnnouncementProvider _announcementProvider;

  AnnouncementRepository() {
    final httpService = HttpService(baseUrl: ApiConstant.baseUrlAretaMobile);
    _announcementProvider = AnnouncementProvider(httpService);
  }

  Future<List<Announcement>> getListAnnouncement(AnnouncementRequestModel request) async {
    return await _announcementProvider.getAnnouncement(request);
  }
}
