// TEST :  flutter run -d web-server
import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:flutter_web3/ethers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niku/niku.dart';
import 'package:intl/intl.dart';
import 'package:wave_portal_dapp/widgets/loading.dart';
import 'package:wave_portal_dapp/widgets/messages.dart';
import 'constants.dart';
import 'models/wave.dart';
import 'widgets/footer.dart';

String waveMessage = '';
final textController = TextEditingController();

extension StringE on String {
  NikuText get text => NikuText(this);
}

extension ListE on List<Widget> {
  NikuColumn get column => NikuColumn(this);
  NikuRow get row => NikuRow(this);
  NikuWrap get wrap => NikuWrap(this);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const GetMaterialApp(title: Constants.appTitle, home: Home());
}

class HomeController extends GetxController {
  Contract? contract;
  BigInt totalWaves = BigInt.zero;
  var wavesRaw = [];
  List<Wave> waves = [];
  bool isLoading = false;
  bool isDone = false;
  int currentChain = -1;
  String currentAddress = '';
  static const operatingChain = 4; // Rinkeby

  /*
  Check if we can access the Ethereum object getter. From the implementation below, the Etherum object can be null if the browser doesn’t have any provider available. 
  i.e. Metamask, Wallet Connect, Binance Chain Wallet, etc.
  */
  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Web3Provider? get provider => Web3Provider(ethereum!);

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accs) {
        clear();
      });

      ethereum!.onChainChanged((chain) {
        clear();
      });
      update();
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();

      if (accs.isNotEmpty) {
        currentAddress = accs.first;
      }

      currentChain = await ethereum!.getChainId();

      update();
    }
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    totalWaves = BigInt.zero;
    update();
  }

  wave() async {
    isLoading = true;
    isDone = true;
    update();

    contract = Contract(
      Constants.address,
      Constants.abi,
      provider!.getSigner(),
    );

    await contract!
        .send(
          'wave',
          [
            textController.text,
          ],
          TransactionOverride(gasLimit: BigInt.from(300000)),
        )
        .then((value) => isLoading = false)
        .then((value) => update());
  }

  getContractInformation() async {
    isLoading = true;
    update();
    contract = Contract(
      Constants.address,
      Constants.abi,
      provider!.getSigner(),
    );

    totalWaves = await contract!.call<BigInt>('getTotalWaves');
    wavesRaw = await contract!.call<List<dynamic>>('getAllWaves');
    wavesRaw = wavesRaw.toList();

    for (var v in wavesRaw) {
      waves.add(Wave(
        address: v[0].toString(),
        message: v[1].toString(),
        timeStamp: v[2].toString(),
      ));
    }
    isLoading = false;
    update();
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (h) => Scaffold(
        body: h.isLoading
            ? const Loading()
            : Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: [
                          Builder(builder: (ctx) {
                            var shown = '';
                            if (h.isConnected && h.isInOperatingChain) {
                              shown = Constants.connectedText_1;
                            } else if (h.isConnected && !h.isInOperatingChain) {
                              shown = Constants.errText_1;
                            } else if (h.isEnabled) {
                              h.totalWaves = BigInt.zero;
                              return NikuButton.outlined(
                                Constants.connectWalletText_1.text
                                    .bold()
                                    .fontSize(20)
                                    .paddingAll(10),
                              ).onPressed(h.connect);
                            } else {
                              shown = Constants.errText_2;
                            }
                            return shown.text.bold().fontSize(30);
                          }),
                          Niku().height(30),
                          if (h.isConnected && h.isInOperatingChain) ...[
                            [
                              h.totalWaves == BigInt.zero
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        NikuButton(Constants.buttonText_1.text
                                                .fontSize(20))
                                            .onPressed(
                                                h.getContractInformation),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        '${Constants.subtitleText_1} ${h.totalWaves}'
                                            .text
                                            .fontSize(18),
                                      ],
                                    ),
                            ].wrap.spacing(10).crossCenter(),
                            Niku().height(30),
                            h.isDone == true
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        height: 50,
                                        child: TextField(
                                            decoration: const InputDecoration(
                                              hintText: Constants
                                                  .textFieldPlaceholderText_1,
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: textController,
                                            onEditingComplete: () {
                                              waveMessage = textController.text;
                                            }),
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        height: 50,
                                        child: NikuButton.outlined(
                                                const Icon(Icons.send))
                                            .onPressed(h.wave),
                                      ),
                                    ],
                                  ),
                            Niku().height(30),
                          ],
                          h.totalWaves != BigInt.zero
                              ? Messages(waves: h.waves)
                              : const SizedBox(),
                        ].column,
                      ),
                      const Footer(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
