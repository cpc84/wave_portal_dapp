class Constants {
  // App Strings
  static const String appTitle = 'Flutter dApp - Wave Portal';
  static const String loadingText = 'Mining in progress..';
  static const String connectedText_1 = '🔥 You\'re connected! 🔥';
  static const String connectWalletText_1 = 'Connect your Wallet';
  static const String errText_1 = 'Wrong chain! Please connect to Rinkeby.';
  static const String errText_2 = 'Your browser is not supported!';
  static const String requirementsText_1 =
      'Requirements: MetaMask wallet, Account on Rinkeby network. To wave -> Some fake ETH :)';
  static const String footerText_1 =
      'dApp (Web3.0) on Rinkeby Network - Code: Flutter + Solidity';
  static const String subtitleText_1 = 'Total number of waves:';
  static const String textFieldPlaceholderText_1 = 'Your message :)';
  static const String buttonText_1 = 'Fetch Waves from Blockchain!';
  static const String buttonText_2 = 'Fetch Waves from Blockchain!';
  static const String messageText_1 = 'ADDRESS:';
  static const String messageText_2 = 'MESSAGE:';
  static const String messageText_3 = 'DATE:';

  // Address & Contract
  static const String address = '0x23A2F155dd41B7856540aB4328d059fC04BaaF8A';
  static const String abi = '''[

    {
      "inputs": [],
      "stateMutability": "payable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "from",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "timestamp",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "string",
          "name": "message",
          "type": "string"
        }
      ],
      "name": "NewWave",
      "type": "event"
    },
    {
      "inputs": [],
      "name": "getAllWaves",
      "outputs": [
        {
          "components": [
            {
              "internalType": "address",
              "name": "waver",
              "type": "address"
            },
            {
              "internalType": "string",
              "name": "message",
              "type": "string"
            },
            {
              "internalType": "uint256",
              "name": "timestamp",
              "type": "uint256"
            }
          ],
          "internalType": "struct WavePortal.Wave[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getTotalWaves",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "name": "lastWavedAt",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "_message",
          "type": "string"
        }
      ],
      "name": "wave",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]''';
}
