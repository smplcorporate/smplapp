import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/data/controller/mobilePlan.provider.dart';
import 'package:home/data/controller/mobilePrepaid.notifier.dart';
import 'package:home/data/controller/mobilePrepaid.provider.dart';
import 'package:home/data/model/mobileplanRes.model.dart';
import 'package:home/screen/rechargebill3.dart';

class RechargePlansPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RechargePlansPage> createState() => _RechargePlansPageState();
}

class _RechargePlansPageState extends ConsumerState<RechargePlansPage> {
  late final RechargeRequestModel requestModel;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    final userBillerData = ref.read(billerProvider);
    requestModel = RechargeRequestModel(
      ipAddress: "198.168.62.1",
      macAddress: "not found",
      latitude: "42.000",
      longitude: "45.000",
      billerCode: userBillerData.selectedBiller!.billerCode,
      billerName: userBillerData.selectedBiller!.billerName,
      circleCode: userBillerData.selectedCircle!.circleId,
      param1: userBillerData.number ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamicPlan = ref.watch(mobilePlanProvider(requestModel));

    return DefaultTabController(
      length: 4,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: dynamicPlan.when(
          data: (snap) {
            // Filter data based on search query
            final filteredPlans = snap.planData.where((plan) {
              final planAmountStr = plan.planAmount.toString();
              final planNameStr = plan.planName?.toLowerCase() ?? "";
              final query = searchQuery.toLowerCase();
        
              return planAmountStr.contains(query) || planNameStr.contains(query);
            }).toList();
        
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 232, 243, 235),
              appBar: AppBar(
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Recharge Bill',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 232, 243, 235),
                elevation: 0,
                centerTitle: true,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 4, color: Colors.grey.shade300),
                      ],
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(120),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search, color: Colors.black),
                              hintText: "Search by Amount or Plan Name",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: filteredPlans.isEmpty
                  ? const Center(
                      child: Text(
                        "No matching plans found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredPlans.length,
                      itemBuilder: (context, index) {
                        final plan = filteredPlans[index];
                        final isSpecialPlan =
                            plan.planAmount.toString() == '199';
        
                        final planWidget = Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan.planAmount.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Data: ${plan.planAmount ?? '-'}"),
                                    Text("Validity: ${plan.validity ?? '-'}"),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text("Plan Name: ${plan.planName ?? '-'}"),
                                const SizedBox(height: 8),
                                Text(
                                  plan.planDescription ?? '',
                                  style:
                                      TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        );
        
                        return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RechargePage3(plan: plan,),
                                    ),
                                  );
                                },
                                child: planWidget,
                              )
                           ;
                      },
                    ),
            );
          },
          error: (err, stack) {
            return Center(child: Text("$err"));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
