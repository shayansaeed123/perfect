import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/dropdownlistingnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/models/dropdownmodel.dart';
import 'package:project/repo/perfect_repo.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusablecard.dart';
import 'package:project/reuse/reusabledropdown.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/reuse/reusabletextfield.dart';
import 'package:project/views/dashboard/carevalutiondetails.dart';
import 'package:project/views/dashboard/invoicedetails.dart';

// 🔹 Provider to store selected date range
final dateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final asyncInvoices = ref.watch(invoiceStreamProvider);
    final filter = ref.watch(invoiceFilterProvider);
    final statusAsync = ref.watch(dropdownProvider(const DropdownParams("action_status=1", "status_name")));
    final userAsync = ref.watch(dropdownProvider(const DropdownParams("admin_id=1", "user_name")));
    return Scaffold(
        backgroundColor: colorController.whiteColor,
        appBar: AppBar(
          backgroundColor: colorController.mainColor,
          title: Center(
              child: 
              reusableText('Home',
                  color: colorController.textColorLight,
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
                padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02,),
                child: Column(
                  children: [
                    reusablaSizaBox(context, 0.01),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: statusAsync.when(
                          data: (status){
                            return reusableDropdown(status, selectedStatus, "Status", (item) => item.name,(value) {
                            // setState(() => selectedStatus = value);
                            ref.read(invoiceFilterProvider.notifier).state =
              ref.read(invoiceFilterProvider).copyWith(actionStatus: value?.id ?? "");
                            },);
                          },
                          loading: () => Center(child: const CircularProgressIndicator()),
                          error: (err, _) => const CircularProgressIndicator(),
                                        ),
                        ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                      Expanded(child: reusableTextField(context, reusabletextfieldcontroller.search, 'Search', colorController.btnColor, FocusNode(), (){},onChanged: (value) {
                          ref.read(invoiceFilterProvider.notifier).state = ref.read(invoiceFilterProvider).copyWith(text: value);
                        },))
                      // Expanded(
                      //   child: userAsync.when(
                      //     data: (user){
                      //       return reusableDropdown(user, selectedUser, "User", (item) => item.name,(value) {
                      //       // setState(() => selectedUser = value);
                      //       ref.read(invoiceFilterProvider.notifier).setEnterBy(value!.id.toString());
                      //       },);
                      //     },
                      //     loading: () => const CircularProgressIndicator(),
                      //     error: (err, _) => const CircularProgressIndicator(),
                      //   ),
                      // ),
                      ],
                    ),
                    reusablaSizaBox(context, 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                                          onTap: () => repo.selectDateRange(context,ref),
                                          child: Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.05,vertical: MediaQuery.sizeOf(context).height * 0.017,),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorController.btnColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              Expanded(
                child: Text(
                  filter.dateRange.isEmpty
                      ? "Select Date Range"
                      : filter.dateRange, // 👈 default aj ki date show hogi
                  style: TextStyle(
                    fontSize: 12.5,
                    color: colorController.btnColor,
                  ),
                ),
              ),
              Icon(Icons.date_range, color: colorController.btnColor, size: 12.5),
                    ],
                  ),
                                          ),
                                    ),
                        ),
                        // SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                        
                      ],
                    ),
                    reusablaSizaBox(context, 0.015),
                    Expanded(
                      child: asyncInvoices.when(
                      data: (invoices) {
                        if (invoices.isEmpty) {
                          return Center(child: reusableText('No Invoice Found',color: colorController.textColorDark,fontsize: 25));
                        }
                        // 🔽 Sort invoices in descending order by invoiceDate
                        invoices.sort((a, b) => b.invoiceDate.compareTo(a.invoiceDate));
                        return CustomScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          slivers: [
                             SliverAppBar(
                              floating: true,
                              snap: true,
                              title: Center(child: reusableText('Invoices',fontsize: 22,fontweight: FontWeight.bold)),
                            ),
                            
                            SliverPadding(
                              padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.000,),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final invoice = invoices[index];
                                    return Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.01,),
                                      child: reusableCard(
                                      context, 
                                      invoice.applicationNo, 
                                      invoice.invoiceDate, 
                                      invoice.requestedFor ?? '',
                                      invoice.address ?? '',
                                      invoice.model, 
                                      invoice.year, 
                                      (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Invoicedetails(
                                            address: invoice.address ?? '', applicationNo: invoice.applicationNo.toString(), 
                                            carCondition: invoice.carCondition ?? '', color: invoice.color, invoiceDate: invoice.invoiceDate,
                                            customerName: invoice.customerName ?? '', cylinder: invoice.cylindersNo??'', 
                                            engineNo: invoice.engineNumber, fuel: invoice.fuel, model: invoice.model, 
                                            odometer: invoice.odometer, option: invoice.options??'', platno: invoice.plateNumber, 
                                            requestfor: invoice.requestedFor??'', specification: invoice.specification, 
                                            total: invoice.total, tranmissiontype: invoice.transmissionType??'', make: invoice.make,
                                            trim: invoice.trim, type: invoice.type, vin: invoice.vinNo??'', year: invoice.year,id: invoice.id,);
                                        },));
                                      },
                                      (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Carevalutiondetails(
                                          applicationNo: invoice.applicationNo, 
                                          bank: invoice.bankName ?? '', 
                                          statusName: invoice.status_name ?? '', 
                                          customerName: invoice.customerName ?? '', 
                                          make: invoice.make, 
                                          model: invoice.model, 
                                          year: invoice.year, 
                                          total: invoice.total, 
                                          paymentUrl: invoice.code),));
                                      }
                                      ),
                                      );
                                  },
                                  childCount: invoices.length,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(child: Text("Error: $err")),
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
