import 'dart:io';

import 'package:dips/data/agent_model/agent_dashboard_model.dart';
import 'package:dips/data/agent_model/agent_profile_model.dart';
import 'package:dips/data/model/property_json.dart';
import 'package:dips/domain/entity/property_model.dart';

abstract class AgentRepository {
  Future<AgentDashboardModel> getDashboardAgent();
  Future<List<PropertyModel>> getPropertyAgent();
   Future<AgentProfileModel> getAgentProfile();
   Future<bool> updateAgentProfile(Map<String, dynamic> data, File ? logo, File ?image); 
}