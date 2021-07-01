require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

module.exports = {
  solidity: "0.8.4",
  networks: {
    // ropsten: {
    //   url: `https://eth-ropsten.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
    //   accounts: [`0x${ROPSTEN_PRIVATE_KEY}`]
    // },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${process.env.WEB3_INFURA_PROJECT_ID}`,
      accounts: [`0x${process.env.RINKEBY_PRIVATE_KEY}`]
    }
  }
};
