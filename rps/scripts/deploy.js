// npx hardhat run scripts/deploy.js --network <network-name>

// const { ethers, config } = require("@nomiclabs/buidler");
// const { readArtifact } = require("@nomiclabs/buidler/plugins");

async function main() {

    const [deployer] = await ethers.getSigners();
  
    console.log(
      "Deploying contracts with the account:",
      deployer.address
    );
    
    console.log("Account balance:", (await deployer.getBalance()).toString());
    
    // Deployment of libraries
    const Library = await ethers.getContractFactory("StringUtils");
    const library = await Library.deploy();
    await library.deployed();   
    console.log("Library address:", library.address);
    
    // Deployment of Contracts, linking with libraries
    const Contract = await ethers.getContractFactory("RPS", {
        libraries: {
            StringUtils: library.address,
        },
    });
    const contract = await Contract.deploy();
    await contract.deployed();
    console.log("Contract address:", contract.address);
  }

  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
  