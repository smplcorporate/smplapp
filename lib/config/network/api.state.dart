import 'dart:io';

import 'package:dio/dio.dart';
import 'package:home/data/model/addwallet_request_pageloadModel.dart';
import 'package:home/data/model/allTickets.res.dart';
import 'package:home/data/model/billerParms.model.dart';
import 'package:home/data/model/billerParms.req.model.dart';
import 'package:home/data/model/checkCopoun.model.dart';
import 'package:home/data/model/dthPrepaid.res.dart';
import 'package:home/data/model/electritysityModel.dart';
import 'package:home/data/model/fastTag.res.dart';
import 'package:home/data/model/fetchBill.model.dart';
import 'package:home/data/model/fetchBiller.res.model.dart';
import 'package:home/data/model/getbankModel.dart';
import 'package:home/data/model/ipAddreess.req.dart';
import 'package:home/data/model/kycList.model.dart';
import 'package:home/data/model/lic.res.dart';
import 'package:home/data/model/loadRepayment.res.dart';
import 'package:home/data/model/login.body.model.dart';
import 'package:home/data/model/loginRequest.req.dart';
import 'package:home/data/model/lpgBillerList.model.dart';
import 'package:home/data/model/mobilePrepaid.res.dart';
import 'package:home/data/model/mobileplanRes.model.dart';
import 'package:home/data/model/offersModel.res.dart';
import 'package:home/data/model/order.details.body.dart';
import 'package:home/data/model/orderDetails.res.dart';
import 'package:home/data/model/orderList.res.dart';
import 'package:home/data/model/otpverfiy.model.dart';
import 'package:home/data/model/passwordResponse.dart';
import 'package:home/data/model/passwordUpdatae.req.dart';
import 'package:home/data/model/paynow.model.dart';
import 'package:home/data/model/profileDetails.model.dart';
import 'package:home/data/model/register.body.validate.dart';
import 'package:home/data/model/register.model1.dart';
import 'package:home/data/model/updateProfilereq.dart';
import 'package:home/data/model/updateUserProfile.res.dart';
import 'package:home/data/model/userDetails.res.dart';
import 'package:home/data/model/userupdateModel.dart';
import 'package:home/data/model/wallet.statementBody.dart';
import 'package:home/data/model/walletModel.res.dart';
import 'package:home/data/model/watterBillers.res.dart';
import 'package:retrofit/retrofit.dart' hide Headers;

part 'api.state.g.dart';

@RestApi(baseUrl: 'https://uat.smplraj.in/b2c/appapi/')
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;
  //Regsiter API
  @POST('outlet/b2c_login/with_password')
  Future<HttpResponse> loginwithPassword(@Body() LoginRequest body);

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
  @POST('transactions/b2c_wallet/order_list_bbps')
  Future<OrderListResponse> getAllOrderList();
  @POST('bbps/b2c_bills_lpg/get_billers')
  Future<HttpResponse<LpgResponseModel>> getGasBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_Insurance/get_billers')
  Future<HttpResponse<ElectricityModel>> getLicBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_pipedgas/get_billers')
  Future<HttpResponse<ElectricityModel>> getPipeGasBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_loanrepayment/get_billers')
  Future<HttpResponse<ElectricityModel>> getLoanRepaymentBillers(
    @Body() ElectricityBody body,
  );
  @POST('bbps/b2c_bills_broadband/get_billers')
  Future<HttpResponse<ElectricityModel>> getBroadBandBillers(
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
  Future<HttpResponse<ElectricityModel>> getFastTagBillers(
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
  Future<HttpResponse<ElectricityModel>> fetchWaterList(
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
  @POST('/bbps/{path}/get_billers_param')
  Future<BillerParamResponse> fetchBillerParm(
    @Path('path') String path,
    @Body() BillerParamRequest body,
  );
  @POST('bbps/b2c_bills_electricity/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupn(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_water/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnWater(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_lpg/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnGas(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_loanrepayment/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnLoan(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_broadband/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnBroadband(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_Insurance/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnInsurance(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_pipedgas/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnPipeGas(@Body() CheckCouponModel body);
  @POST('bbps/b2c_bills_fastag/check_coupon')
  Future<HttpResponse<dynamic>> checkCoupnFastTag(@Body() CheckCouponModel body);

  // Wallet
  @POST('profile/b2c_wallet/wallet_balance')
  Future<WalletBalancemodel> getWallet();
  @POST('profile/b2c_wallet/wallet_statement_main')
  Future<WalletStateMentRes> getWalleStatement(
    @Body() WalletStateMentBody body,
  );
  @POST('request/b2c_wallet/addwallet_request_pageload')
  Future<AddwalletRequestPageloadModel> getWalletPageLoad();

  @POST('request/b2c_wallet/addwallet_request_getbank')
  Future<GetBankDetailModel> fetchBankDetail(@Body() GetBankBodymodel body);

  // kyc
  @POST('verify/b2c_kyc_account/kyc_list')
  Future<KycListmodel> fetchKycList();

  // Profile
  @POST('profile/b2c_account/details')
  Future<ProfileDetailsmodel> getProfilDetails();
  @POST('profile/b2c_account/details_update')
  Future<HttpResponse<dynamic>> updateProfile(@Body() UserUpdateeModel body);

  // mobile plan fetch
  @POST('recharges/b2c_prepaid_mobile/get_plan')
  Future<MobilePlansResponseModel> fetchMobilePlan(
    @Body() RechargeRequestModel body,
  );

  @POST('transactions/b2c_wallet/order_details_bbps')
  Future<OrderDetailsRes> getOrderDetails(@Body() GetOrderDetailsBody body);

  /// user
  @POST('profile/b2c_account/password_change')
  Future<PasswordChangeResponse> updatePassword(
    @Body() PasswordChangeRequest body,
  );
  @POST("profile/b2c_account/logout")
  Future<HttpResponse> logout(@Body() IpAddressRequest body);
  @POST('profile/b2c_account/details')
  Future<UserProfileDetailsRes> userDEtails();

  @POST("others/b2c_dashboard/ticket_raise")
  @MultiPart()
  Future<HttpResponse> ticketRezie(
    @Part(name: 'ip_address') String ipAddreess,
    @Part(name: 'subject') String subject,
    @Part(name: 'description') String description,
    @Part(name: "Issue_proof ") File? proof,
  );
  @POST('others/b2c_dashboard/support')
  Future<SupportLoadResponse> getAllTickets();

  @POST("verify/b2c_kyc_account/kyc_upload")
  @MultiPart()
  Future<HttpResponse> uploadKycDocument(
    @Part(name: 'ip_address') String ipAddreess,
    @Part(name: 'document_id') String subject,
    @Part(name: "kyc_proof") File? proof,
  );

  @POST('others/b2c_dashboard/offers')
  Future<OfferListmodelResponse> getAllOffers();
}
