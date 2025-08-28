import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/reuse/reusablecard.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:project/views/dashboard/invoicedetails.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late final ScrollController _innerController;

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
    return Scaffold(
        backgroundColor: colorController.whiteColor,
        appBar: AppBar(
          backgroundColor: colorController.mainColor,
          title: Center(
              child: reusableText('Home',
                  color: colorController.textColorLight,
                  fontsize: 25,
                  fontweight: FontWeight.bold)),
        ),
        body: asyncInvoices.when(
        data: (invoices) {
          if (invoices.isEmpty) {
            return Center(child: reusableText('No Invoice Found',color: colorController.textColorDark,fontsize: 25));
          }

          return CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
               SliverAppBar(
                floating: true,
                snap: true,
                title: Center(child: reusableText('Invoices',fontsize: 22,fontweight: FontWeight.bold)),
              ),
              SliverPadding(
                padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.007,),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final invoice = invoices[index];
                      return Padding(padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02,),
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
                              trim: invoice.trim, type: invoice.type, vin: invoice.vinNo??'', year: invoice.year);
                          },));
                        }),);
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
            )
            ;
  }
}
