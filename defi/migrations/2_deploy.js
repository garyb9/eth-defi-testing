const Dai = artifacts.require("Dai");
const DeFiProj = artifacts.require("DeFiProj");

module.exports = async function(deployer, _network, accounts) {
	// deploy Dai
	await deployer.deploy(Dai);
	const dai = await Dai.deployed();
    console.log("Dai address: ", dai.address);

    // deploy DeFiProj
	await deployer.deploy(DeFiProj, dai.address);
	const defiproj = await DeFiProj.deployed();
    console.log("DeFiProj address: ", defiproj.address);

    // sanity check
    console.log("\nSanity check:\nMinting 100 DAI");
    await dai.faucet(defiproj.address, 100); // minting 100 DAI tokens
    let balance0 = await dai.balanceOf(defiproj.address);
    let balance1 = await dai.balanceOf(accounts[1]);
    console.log('DAI balance of DeFiProj: ', balance0.toString());
    console.log('DAI balance of ', accounts[1], ": ", balance1.toString());
    
    console.log("Transferring 100 DAI to: ", accounts[1]);
    await defiproj.foo(accounts[1], 100); // send 100 tokens to this address, taken from ganache
    
    balance0 = await dai.balanceOf(defiproj.address);
    balance1 = await dai.balanceOf(accounts[1]);
    console.log('DAI balance of DeFiProj: ', balance0.toString());
    console.log('DAI balance of ', accounts[1], ": ", balance1.toString());

};
