import 'package:pgnpartner_mobile/core/constants/api_constant.dart';
import 'package:pgnpartner_mobile/data/models/jobs_konstruksi/job_construction_model.dart';
import 'package:pgnpartner_mobile/data/models/request_model.dart';
import 'package:pgnpartner_mobile/data/providers/job_construction_provider.dart';
import 'package:pgnpartner_mobile/services/http_service.dart';

class JobConstructionRepository {
  late final JobConstructionProvider _subJobsConstructionProvider;

  JobConstructionRepository() {
    final httpService = HttpService(baseUrl: ApiConstant.baseUrlAretaMobile);
    _subJobsConstructionProvider = JobConstructionProvider(httpService);
  }

  Future<dynamic> getJobConstruction(RequestModel request) async {
    return await _subJobsConstructionProvider.getJobConstruction(request);
  }

  Future<dynamic> getAvailableJobConstruction(Map<String, dynamic> request) async {
    return await _subJobsConstructionProvider.getAvailableJobConstruction(request);
  }

  Future<JobConstructionModel> getJobConstructionById(int id) async {
    return await _subJobsConstructionProvider.getJobConstructionById(id);
  }
}
