import 'package:dio/dio.dart';
import 'package:home/data/model/dthPrepaid.res.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/data/model/fastTag.res.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/fetchBiller.res.model.dart';
import 'package:home/data/model/lic.res.dart';
import 'package:home/data/model/loadRepayment.res.dart';
import 'package:home/data/model/login.body.model.dart';
import 'package:home/data/model/lpgBillerList.model.dart';
import 'package:home/data/model/mobilePrepaid.res.dart';
import 'package:home/data/model/otpverfiy.model.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/data/model/register.body.validate.dart';
import 'package:home/data/model/register.model1.dart';
import 'package:home/data/model/wallet.statementBody.dart';
import 'package:home/data/model/walletModel.res.dart';
import 'package:home/data/model/watterBillers.res.dart';
import 'package:retrofit/retrofit.dart' hide Headers;

part 'api.state.g.dart';

@RestApi(baseUrl: 'https://uat.smplraj.in/b2c/appapi/')
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;
  //Regsiter API
  @POST('outlet/b2c_register/initiate')
  Future<HttpResponse> registerUserInit(@Body() UserRegisterBody user);
  @POST('outlet/b2c_register/validate')
  Future<HttpResponse> registerUserValidate(
    @Body() RegisterBodyValidate userValidate,
  );
  // get billers
  @POST('bbps/b2c_bills_electricity/get_billers')
  Future<HttpResponse<ElectricityModel>> getElectritcity(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_lpg/get_billers')
  Future<HttpResponse<LpgResponseModel>> getGasBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_Insurance/get_billers')
  Future<HttpResponse<LicModelResponse>> getLicBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_Insurance/get_billers')
  Future<HttpResponse<LoanRepaymentResponse>> getLoanRepaymentBillers(
    @Body() ElectricityBody body,
  );
  @POST('recharges/b2c_prepaid_mobile/get_billers')
  Future<HttpResponse<MobilePrepaidResponse>> getMoblePrepaidBillers(
    @Body() ElectricityBody body,
  );
  @POST('recharges/b2c_prepaid_dth/get_billers')
  Future<HttpResponse<DthPrepaidResponse>> getDTHPrepaidBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_fastag/get_billers')
  Future<HttpResponse<FastTagmodel>> getFastTagBillers(
    @Body() ElectricityBody body,
  );
  // Login api
  @POST('outlet/b2c_login/otp_initiate')
  Future<HttpResponse<LoginResponse>> login(@Body() LoginBodyRequest body);
  @POST('outlet/b2c_login/otp_validate')
  Future<HttpResponse<VerfiyOtpResponse>> verfyiLogin(
    @Body() VerfiyOtpBody body,
  );
  @POST('bbps/b2c_bills_water/get_billers')
  Future<HttpResponse<WatterBilersModel>> fetchWaterList(
    @Body() ElectricityBody body,
  );
  // fetch bill
  @POST('bbps/{path}/fetchnow')
  Future<HttpResponse<FetchResponseModel>> ferchBill(
    @Path('path') String path,
    @Body() FetchBillModel body,
  );
  @POST('bbps/{path}/paynow')
  Future<HttpResponse> payNow(
    @Path('path') String path,
    @Body() PayNowModel body,
  );

  // Wallet 
  @POST('profile/b2c_wallet/wallet_balance')
  Future<WalletBalancemodel> getWallet();
  @POST('profile/b2c_wallet/wallet_statement_main')
  Future<WalletStateMentRes> getWalleStatement(@Body() WalletStateMentBody body);
  @POST('request/b2c_wallet/addwallet_request_pageload')
  Future<> 
  
}
