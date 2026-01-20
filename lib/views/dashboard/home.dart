import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/connectivitynotifier.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/dropdownmodel.dart';
import 'package:project/repo/perfect_repo.dart';
import 'package:project/repo/utils.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusablecard.dart';
import 'package:project/reuse/reusabledropdown.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';
import 'package:project/views/dashboard/carevalutiondetails.dart';
import 'package:project/views/dashboard/invoicedetails.dart';

// 🔹 Provider to store selected date range
final dateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);
final selectedTabProvider = StateProvider<int>((ref) => 0);


class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late final ScrollController _innerController;
  PerfectRepo repo = PerfectRepo();
  DropdownItem? selectedStatus;
  DropdownItem? selectedUser;
  DateTimeRange? selectedRange;

  @override
  void initState() {
    super.initState();
    _innerController = ScrollController();
  }

  @override
  void dispose() {
    _innerController.dispose();
    _tabController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final asyncInvoices = ref.watch(invoiceProvider);
    final filter = ref.watch(invoiceFilterProvider);
    final statusAsync = ref.watch(dropdownProvider(const DropdownParams("action_status=1", "status_name")));
    final userAsync = ref.watch(dropdownProvider(const DropdownParams("admin_id=1", "user_name")));
    final isConnected = ref.watch(connectivityProvider);
    final isRefreshing = ref.watch(isRefreshingProvider);
    return Scaffold(
        backgroundColor: colorController.whiteColor,
        appBar: AppBar(
          backgroundColor: colorController.mainColor,
          title: Center(
              child: 
              reusableText('Perfect',
                  color: colorController.whiteColor,
                  fontsize: 25,
                  fontweight: FontWeight.bold)
                  ),
        ),
        body: Container(
          child: Stack(
            children: [
              Center(
        child: Transform.rotate(
          angle: -0.8, // radians me (≈ -30 degree)
          child: Opacity(
            opacity: 0.1, // halka watermark jesa
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
              Padding(
                padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.00,),
                child: Column(
                  children: [
              //       reusablaSizaBox(context, 0.005),
              //       Row(
              //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              // Expanded(
              //             child: GestureDetector(
              //                             onTap: () => repo.selectDateRange(context,ref),
              //                             child: Container(
              //             padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.05,vertical: MediaQuery.sizeOf(context).height * 0.006,),
              //             decoration: BoxDecoration(
              //               border: Border.all(color: colorController.btnColor),
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              // Expanded(
              //   child: Text(
              //     filter.dateRange.isEmpty
              //         ? "Select Date Range"
              //         : filter.dateRange, // 👈 default aj ki date show hogi
              //     style: TextStyle(
              //       fontSize: 12.5,
              //       color: colorController.btnColor,
              //     ),
              //   ),
              // ),
              // Icon(Icons.date_range, color: colorController.btnColor, size: 12.5),
              //       ],
              //     ),
              //                             ),
              //                       ),
              //           ),
              //         SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
              //         Expanded(child: reusableTextField(context, reusabletextfieldcontroller.search, 'Search', colorController.btnColor, FocusNode(), (){},onChanged: (value) {
              //             ref.read(invoiceFilterProvider.notifier).state = ref.read(invoiceFilterProvider).copyWith(text: value);
              //           },))
              //         ],
              //       ),




              //       reusablaSizaBox(context, 0.015),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: GestureDetector(
              //                             onTap: () => repo.selectDateRange(context,ref),
              //                             child: Container(
              //             padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.05,vertical: MediaQuery.sizeOf(context).height * 0.017,),
              //             decoration: BoxDecoration(
              //               border: Border.all(color: colorController.btnColor),
              //               borderRadius: BorderRadius.circular(8),
              //             ),
              //             child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              // Expanded(
              //   child: Text(
              //     filter.dateRange.isEmpty
              //         ? "Select Date Range"
              //         : filter.dateRange, // 👈 default aj ki date show hogi
              //     style: TextStyle(
              //       fontSize: 12.5,
              //       color: colorController.btnColor,
              //     ),
              //   ),
              // ),
              // Icon(Icons.date_range, color: colorController.btnColor, size: 12.5),
              //       ],
              //     ),
              //                             ),
              //                       ),
              //           ),
              //           // SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                        
              //         ],
              //       ),


                    // reusablaSizaBox(context, 0.005),
                    /// 🔹 Dynamic Tabs (API based)
                statusAsync.when(
                  data: (statusList) {
                    _tabController ??= TabController(
                      length: statusList.length,
                      vsync: this,
                      initialIndex: ref.watch(selectedTabProvider),
                    );

                    _tabController!.addListener(() {
                      if (_tabController!.indexIsChanging) {
                        final status = statusList[_tabController!.index];
                        ref.read(selectedTabProvider.notifier).state =
                            _tabController!.index;

                        /// 🔑 Update filter on tab change
                        ref
                            .read(invoiceFilterProvider.notifier)
                            .state = filter.copyWith(
                          actionStatus: status.id,
                        );

                        setState(() => selectedStatus = status);
                      }
                    });

                    return Container(
                      decoration: BoxDecoration(
    color: colorController.mainColor, // 👈 background
    border: Border.all(color: colorController.whiteColor,width: BorderSide.strokeAlignOutside)
  ),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: colorController.whiteColor,
                        indicatorPadding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height *0.004),
                        labelColor: colorController.whiteColor,
                        unselectedLabelColor: colorController.whiteColor,
                        splashBorderRadius: BorderRadius.circular(15),
                        overlayColor: WidgetStatePropertyAll(colorController.mainColor),
                        tabs: statusList
                            .map((e) => Tab(text: e.name))
                            .toList(),
                      ),
                    );
                  },
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                ),
                    reusablaSizaBox(context, 0.015),
                    Expanded(
                      child: asyncInvoices.when(
                      data: (invoices) {
                        if (isRefreshing) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (invoices.isEmpty) {
                          return Center(child: reusableText('No Invoice Found',color: colorController.textColorDark,fontsize: 25));
                        }
                        // 🔽 Sort invoices in descending order by invoiceDate
                        invoices.sort((a, b) => b.invoiceDate.compareTo(a.invoiceDate));
                        return RefreshIndicator(
                          color: colorController.mainColor,
                          onRefresh: () => onRefresh(ref),
                          child: CustomScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            slivers: [
                              //  SliverAppBar(
                              //   floating: true,
                              //   snap: true,
                              //   title: Center(child: reusableText('Invoices',fontsize: 22,fontweight: FontWeight.bold)),
                              // ),
                              
                              SliverPadding(
                                padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.015,),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final invoice = invoices[index];
                                      return Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.01,),
                                        child: VehicleListCard(
                                          context, 
                                          "${Utils.baseUrlImages+invoice.makeImage}", 
                                          "${invoice.year}"+ " ${invoice.make}"+ " ${invoice.model}", 
                                          invoice.customerName ?? '', 
                                          invoice.invoiceDate, 
                                          invoice.status_name ?? '',
                                          invoice.statusAction == '3' ? 'assets/images/paid.png' : invoice.statusAction == '2' ? 'assets/images/unpaid.png' : invoice.statusAction == '1' ? 'assets/images/pending.png' : '',
                                           (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return Invoicedetails(
                                              address: invoice.address ?? '', applicationNo: invoice.applicationNo.toString(), 
                                              carCondition: invoice.carCondition ?? '', color: invoice.color, invoiceDate: invoice.invoiceDate,
                                              customerName: invoice.customerName ?? '', cylinder: invoice.cylindersNo??'', 
                                              engineNo: invoice.engineNumber, fuel: invoice.fuel, model: invoice.model, 
                                              odometer: invoice.odometer, option: invoice.options??'', platno: invoice.plateNumber, 
                                              requestfor: invoice.requestedFor??'', specification: invoice.specification, customerEmail: invoice.customer_email ?? '',
                                              total: invoice.total, tranmissiontype: invoice.transmissionType??'', make: invoice.make, makeImage: invoice.makeImage,
                                              trim: invoice.trim, type: invoice.type, vin: invoice.vinNo??'', year: invoice.year,id: invoice.id,
                                              totalValue: invoice.totalValue,bankName: invoice.bankName ?? '',status_name: invoice.status_name ?? '',code: invoice.code,
                                              statusAction: invoice.statusAction ?? '',image1: invoice.image1 ?? '',image2: invoice.image2 ?? '',image3: invoice.image3 ?? '',
                                              image4: invoice.image4 ?? '',image5: invoice.image5 ?? '',image6: invoice.image6 ?? '',image7: invoice.image7 ?? '',image8: invoice.image8 ?? '',);
                                          },));
                                           })
                                        // reusableCard(
                                        // context, 
                                        // invoice.applicationNo, 
                                        // invoice.invoiceDate, 
                                        // invoice.requestedFor ?? '',
                                        // invoice.address ?? '',
                                        // invoice.model, 
                                        // invoice.year, 
                                        // (){
                                        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        //     return Invoicedetails(
                                        //       address: invoice.address ?? '', applicationNo: invoice.applicationNo.toString(), 
                                        //       carCondition: invoice.carCondition ?? '', color: invoice.color, invoiceDate: invoice.invoiceDate,
                                        //       customerName: invoice.customerName ?? '', cylinder: invoice.cylindersNo??'', 
                                        //       engineNo: invoice.engineNumber, fuel: invoice.fuel, model: invoice.model, 
                                        //       odometer: invoice.odometer, option: invoice.options??'', platno: invoice.plateNumber, 
                                        //       requestfor: invoice.requestedFor??'', specification: invoice.specification, 
                                        //       total: invoice.total, tranmissiontype: invoice.transmissionType??'', make: invoice.make,
                                        //       trim: invoice.trim, type: invoice.type, vin: invoice.vinNo??'', year: invoice.year,id: invoice.id,
                                        //       totalValue: invoice.totalValue,);
                                        //   },));
                                        // },
                                        // (){
                                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => Carevalutiondetails(
                                        //     applicationNo: invoice.applicationNo, 
                                        //     bank: invoice.bankName ?? '', 
                                        //     statusName: invoice.status_name ?? '', 
                                        //     customerName: invoice.customerName ?? '', 
                                        //     make: invoice.make, 
                                        //     model: invoice.model, 
                                        //     year: invoice.year, 
                                        //     total: invoice.total, 
                                        //     paymentUrl: invoice.code,
                                        //     totalValue: invoice.totalValue,
                                        //     ),));
                                        // }
                                        // ),
                                        );
                                    },
                                    childCount: invoices.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) {
                        if (!isConnected) {
                          return const NoInternetWidget();
                        }
                        if (err.toString().contains('SocketException')) {
                          return const NoInternetWidget();
                        }
                        return Center(
                          child: Text(
                            "Something went wrong",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
            )
            ;
  }
}
