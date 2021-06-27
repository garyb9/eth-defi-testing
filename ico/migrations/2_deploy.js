const DappToken = artifacts.require("DappToken");

module.exports = async function(deployer) {
	//deploy DappToken
	await deployer.deploy(DappToken);
	const dapptoken = await DappToken.deployed();
    console.log("DappToken address: ", dapptoken.address);
};