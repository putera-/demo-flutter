import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_construction_model.dart';
import 'package:pgnpartner_mobile/data/models/request_model.dart';
import 'package:pgnpartner_mobile/services/http_service.dart';

class JobConstructionProvider {
  final HttpService _httpService;
  JobConstructionProvider(this._httpService);

  Future<dynamic> getJobConstruction(RequestModel request) async {
    final response = await _httpService.post('/task/list', request.toQueryParameters());
    if (response.statusCode == 200) {
      return response.data['list'];
    } else {
      throw Exception('Failed to load jobs list construction');
    }
  }

  Future<dynamic> getAvailableJobConstruction(Map<String, dynamic> request) async {
    final response = await _httpService.post('/task/search', request);
    if (response.statusCode == 200) {
      return response.data['list'];
    } else {
      throw Exception('Failed to load jobs list construction');
    }
  }

  Future<JobConstructionModel> getJobConstructionById(int id) async {
    final response = await _httpService.post('/task/read', {"id": id});
    if (response.statusCode == 200) {
      return JobConstructionModel.fromJson(response.data['task_management.task']);
    } else {
      throw Exception('Failed to load jobs list construction');
    }
  }
}
