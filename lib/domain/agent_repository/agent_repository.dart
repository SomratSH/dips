import 'dart:io';

import 'package:dips/data/agent_model/agent_dashboard_model.dart';
import 'package:dips/data/agent_model/agent_profile_model.dart';
import 'package:dips/data/agent_model/notification_model.dart';
import 'package:dips/data/agent_model/offfer_model.dart';
import 'package:dips/data/model/property_json.dart';
import 'package:dips/domain/entity/property_model.dart';

abstract class AgentRepository {
  Future<AgentDashboardModel> getDashboardAgent();
  Future<List<PropertyModel>> getPropertyAgent();
  Future<AgentProfileModel> getAgentProfile();
  Future<bool> updateAgentProfile(
    Map<String, dynamic> data,
    File? logo,
    File? image,
  );
  Future<bool> addProperty(Map<String, dynamic> data, File image);
  Future<List<dynamic>> getPropertyType();

  Future<List<PropertyModel>> getPropertySearch(String type);

  Future<OfferModel> getOffer();

  Future<bool> offerAccept(String id);

  Future<bool> offerRejected(String id);
  Future<bool> markLead(String id);

  Future<bool> counterOffer(String id, Map<String, dynamic> data);

  Future<List<NotificaitonModel>> getNotification();

  Future<bool> markAsRead(String id);

  Future<List<PropertyModel>> getMyPropertyAgent();

  Future<String> createBoard();

  Future<String> assignBoard(String id, String propertyId);

}
