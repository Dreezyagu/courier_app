import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ojembaa_courier/features/authentication/models/banks_model.dart';
import 'package:ojembaa_courier/features/authentication/providers/get_banks_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/user_provider.dart';
import 'package:ojembaa_courier/features/authentication/providers/vehicle_provider.dart';
import 'package:ojembaa_courier/features/authentication/screens/guarantor_info.dart';
import 'package:ojembaa_courier/features/authentication/widgets/create_account_widgets.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart';
import 'package:ojembaa_courier/utils/components/image_util.dart';
import 'package:ojembaa_courier/utils/components/validators.dart';
import 'package:ojembaa_courier/utils/widgets/circle.dart';
import 'package:ojembaa_courier/utils/widgets/custom_appbar.dart';
import 'package:ojembaa_courier/utils/widgets/custom_button.dart';
import 'package:ojembaa_courier/utils/widgets/custom_textfield.dart';
import 'package:ojembaa_courier/utils/widgets/snackbar.dart';

class EnterBankDetails extends ConsumerStatefulWidget {
  const EnterBankDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnterBankDetailsState();
}

class _EnterBankDetailsState extends ConsumerState<EnterBankDetails> {
  final TextEditingController bvn = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController accountName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BanksModel? bank;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_background,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.width(.06), vertical: context.height(.015)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi ${ref.watch(userProvider).data?.firstName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: context.width(.062),
                      color: AppColors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: context.height(.005)),
                Text(
                  "Get paid for wallet transactions please enter your bank details matchings the info provided.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: context.width(.04), color: AppColors.black),
                ),
                SizedBox(height: context.height(.035)),
                const StageBarWidget(level: 4),
                SizedBox(height: context.height(.015)),
                Row(
                  children: [
                    Circle(
                        borderColor: AppColors.accent,
                        width: context.width(.07),
                        color: AppColors.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(ImageUtil.bank),
                        )),
                    SizedBox(width: context.width(.02)),
                    Text(
                      "Bank details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.width(.035),
                          color: AppColors.accent),
                    ),
                  ],
                ),
                SizedBox(height: context.height(.05)),
                Consumer(builder: (context, ref, child) {
                  final data = ref.watch(getBanksProvider);

                  if (data.data != null) {
                    return DropdownSearch<BanksModel>(
                      items: data.data,
                      onChanged: (value) {
                        if (value != null) {
                          bank = value;
                          //   bankId = bankList!.indexWhere(
                          //       (element) =>
                          //           element.code == bankCode);

                          //   _accountNameController.clear();
                          //   accountModel = null;

                          //   setState(() {});
                          //   if (_accountNumController.text.length ==
                          //           10 &&
                          //       bankCode != null &&
                          //       _validateBankTransferCubit.state
                          //           is! ValidateBankTransferLoading) {
                          //     FocusScope.of(context).unfocus();
                          //     _validateBankTransferCubit
                          //         .validateBankTransfer({
                          //       "accountNumber":
                          //           _accountNumController.text,
                          //       "bankCode": bankCode
                          //     });
                          //   }
                        }
                      },
                      itemAsString: (item) => item?.name ?? "",
                      showSearchBox: true,
                      mode: Mode.MENU,
                      maxHeight: context.height(.5),
                      searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.width(.03),
                                vertical: context.width(.035),
                              ),
                              hintText: "Search Bank",
                              hintStyle: const TextStyle(
                                color: AppColors.hintColor,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(
                                Icons.search,
                              ))),
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: context.width(.06),
                          vertical: context.width(.045),
                        ),
                        label: const Text(
                          "Select Bank",
                          style: TextStyle(color: AppColors.hintColor),
                        ),
                        labelStyle: const TextStyle(
                          color: AppColors.red,
                          fontFamilyFallback: ["Work Sans"],
                        ),
                        fillColor: AppColors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: .5, color: Colors.black38)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: .5, color: Colors.black38)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                                width: .5, color: Colors.black38)),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      dropdownBuilder: (context, selectedItem) => Text(
                        selectedItem?.name ?? "",
                        style: TextStyle(
                            fontSize: context.width(.038),
                            color: AppColors.black),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: accountNumber,
                  hintText: "Enter account number",
                  validator: Validators.notEmpty(),
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: accountName,
                  hintText: "Account holder",
                  validator: Validators.notEmpty(),
                  // fillColor: const Color(0xffFFF5E1),
                ),
                SizedBox(height: context.height(.015)),
                CustomTextFormField(
                  controller: bvn,
                  hintText: "Enter BVN",
                  validator: Validators.notEmpty(),
                  maxLength: 11,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: context.height(.03)),
                Consumer(builder: (context, ref, child) {
                  final data = ref.watch(vehicleProvider);
                  final reader = ref.read(vehicleProvider.notifier);
                  return CustomContinueButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        if (bank == null) {
                          CustomSnackbar.showErrorSnackBar(context,
                              message: "Please select a bank");
                          return;
                        }
                        reader.bankInfo(
                          payload: {
                            "bankName": bank?.name, //bank name
                            "bankCode": bank?.code, //bank code
                            "bvn": bvn.text,
                            "holder": accountName.text,
                            "accountNumber": accountNumber.text
                          },
                          onError: (p0) => CustomSnackbar.showErrorSnackBar(
                              context,
                              message: p0),
                          onSuccess: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GuarantorInfo(),
                                ));
                          },
                        );
                      }
                    },
                    isActive: !data.isLoading,
                    sidePadding: 0,
                    disabledBgColor: AppColors.hintColor.withOpacity(.5),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
