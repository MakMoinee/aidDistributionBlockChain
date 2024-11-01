async function main() {
    // Fetch the contract factory for AidDistribution
    const AidDistribution = await ethers.getContractFactory("AidDistribution");
  
    // Deploy the contract
    const aidDistribution = await AidDistribution.deploy();
  
    // Wait for the deployment to be completed
    // await aidDistribution.deployed();
  
    console.log("AidDistribution deployed to:", AidDistribution.address);
  }
  
  // Execute the main function
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  