const dToken = artifacts.require("dToken");
const dBank = artifacts.require("dBank");

module.exports = async function(deployer) {
	//deploy dToken
	await deployer.deploy(dToken);
	const dtoken = await dToken.deployed();

	// deploy dBank and set address of dToken
	await deployer.deploy(dBank, dtoken.address);
	const dbank = await dBank.deployed();

	//change dtoken's owner/minter from deployer to dBank - should emit proper event
	await dtoken.passMinterRole(dbank.address);
};