const path = require('path');
const fs = require('fs');
const solc = require('solc');

const contractPath = path.resolve(__dirname, '..', 'contracts', 'Dai.sol');
const rawData = fs.readFileSync(contractPath, 'utf8');
module.exports = solc.compile(rawData, 1).contracts[':Dai'];