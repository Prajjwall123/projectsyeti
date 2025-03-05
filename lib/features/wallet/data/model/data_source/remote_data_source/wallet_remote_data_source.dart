import 'package:dio/dio.dart';
import 'package:projectsyeti/app/constants/api_endpoints.dart';
import 'package:projectsyeti/features/wallet/data/model/data_source/wallet_data_source.dart';
import 'package:projectsyeti/features/wallet/domain/dto/get_wallet_amount_dto.dart';
import 'package:projectsyeti/features/wallet/domain/entity/wallet_entity.dart';

class WalletRemoteDataSource implements IWalletDataSource {
  final Dio _dio;

  WalletRemoteDataSource(this._dio);

  @override
  Future<WalletEntity> getWalletAmount(String walletId) async {
    try {
      var response =
          await _dio.get('${ApiEndpoints.getWalletAmount}/$walletId');
      if (response.statusCode == 200) {
        var walletDTO = GetWalletAmountDTO.fromJson(response.data);
        var walletApiModel = walletDTO.toWalletApiModel();
        return walletApiModel.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
