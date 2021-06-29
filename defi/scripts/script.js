const fs = require('fs');
const path = require('path');
const Web3 = require('web3');
const web3 = new Web3('http://localhost:7545');
// const { interface, bytecode } = require('./compile');
const CONTRACT_ADDRESS = '0xde0B295669a9FD93d5F28D9Ec85E40f4cb697BAe';


module.exports = async function(callback) {
    try {
        // Get Accounts
        const accounts = await web3.eth.getAccounts();
        
        const abiPath = path.resolve(__dirname, '..', 'build', 'Dai.json');
        const abi = JSON.parse(fs.readFileSync(abiPath, 'utf8'));
        
        const dai = await new web3.eth.Contract(JSON.parse(interface));

    }
    catch(error) {
        console.log(error)
    }
    callback()
  }