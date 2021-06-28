const DappToken 		= artifacts.require("DappToken");
const DappTokenSale 	= artifacts.require("DappTokenSale");

module.exports = async function(deployer) {
	// deploy DappToken
	await deployer.deploy(DappToken, 1000000);
	const dapptoken = await DappToken.deployed();
    console.log("DappToken address: ", dapptoken.address);

	// deploy DappTokenSale
	var tokenPrice = 1000000000000;
	await deployer.deploy(DappTokenSale, DappToken.address, tokenPrice); // 0.01 ether
	const dapptokensale = await DappTokenSale.deployed();
    console.log("DappTokenSale address: ", dapptokensale.address);

};