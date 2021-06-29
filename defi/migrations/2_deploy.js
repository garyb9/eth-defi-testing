const Dai = artifacts.require("Dai");

module.exports = async function(deployer) {
	// deploy Dai
	await deployer.deploy(Dai);
	const dai = await Dai.deployed();
    console.log("Dai address: ", dai.address);

};
