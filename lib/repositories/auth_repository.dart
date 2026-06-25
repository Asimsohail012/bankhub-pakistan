import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/api_result.dart';
import '../models/user_model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ApiResult<void>> createUserProfile(String uid, String email, String displayName) async {
    try {
      final userModel = UserModel(
        uid: uid,
        email: email,
        displayName: displayName,
        createdAt: DateTime.now(),
        lastSignIn: DateTime.now(),
      );

      await _firestore.collection('users').doc(uid).set(userModel.toJson());
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to create user profile');
    }
  }

  Future<ApiResult<UserModel>> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        return ApiResult.error('User profile not found');
      }
      return ApiResult.success(UserModel.fromJson(doc.data() as Map<String, dynamic>));
    } catch (e) {
      return ApiResult.error('Failed to fetch user profile');
    }
  }

  Future<ApiResult<void>> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to update user profile');
    }
  }

  Future<ApiResult<void>> addFavorite(String uid, String bankId) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'favorites': FieldValue.arrayUnion([bankId]),
      });
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to add favorite');
    }
  }

  Future<ApiResult<void>> removeFavorite(String uid, String bankId) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'favorites': FieldValue.arrayRemove([bankId]),
      });
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to remove favorite');
    }
    }

  Future<ApiResult<void>> addRecentlyViewed(String uid, String bankId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data() ?? <String, dynamic>{};
      final recentList = List<String>.from(userData['recentlyViewed'] ?? []);

      if (recentList.contains(bankId)) {
        recentList.remove(bankId);
      }
      recentList.insert(0, bankId);
      if (recentList.length > 20) {
        recentList.removeLast();
      }

      await _firestore.collection('users').doc(uid).update({
        'recentlyViewed': recentList,
      });
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to add recently viewed');
    }
  }

  Future<ApiResult<void>> saveBankComparison(String uid, String comparisonId, List<String> bankIds) async {
    try {
      await _firestore.collection('users').doc(uid).collection('comparisons').doc(comparisonId).set({
        'bankIds': bankIds,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to save comparison');
    }
  }

  Future<ApiResult<List<Map<String, dynamic>>>> getBankComparisons(String uid) async {
    try {
      final snapshot = await _firestore.collection('users').doc(uid).collection('comparisons').get();
      return ApiResult.success(snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      return ApiResult.error('Failed to fetch comparisons');
    }
  }

  Future<ApiResult<void>> saveChatMessage(String uid, String assistantId, String role, String message) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('chatHistory')
          .add({
        'assistantId': assistantId,
        'role': role,
        'message': message,
        'timestamp': DateTime.now().toIso8601String(),
      });
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to save chat message');
    }
  }

  Future<ApiResult<List<Map<String, dynamic>>>> getChatHistory(String uid, String assistantId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('chatHistory')
          .where('assistantId', isEqualTo: assistantId)
          .orderBy('timestamp', descending: false)
          .get();
      return ApiResult.success(snapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      return ApiResult.error('Failed to fetch chat history');
    }
  }

  Future<ApiResult<void>> deleteUserAccount(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.error('Failed to delete user account');
    }
  }
}
