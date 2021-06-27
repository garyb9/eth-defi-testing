const DappToken = artifacts.require("DappToken");

module.exports = async function(deployer) {
	//deploy DappToken
	await deployer.deploy(DappToken, 1000000);
	const dapptoken = await DappToken.deployed();
    console.log("DappToken address: ", dapptoken.address);
};