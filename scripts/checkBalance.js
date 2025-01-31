const { ethers } = require("hardhat");

async function main() {
    const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3"; // Replace with your contract address
    const provider = ethers.provider; // Get the provider

    const balance = await provider.getBalance(contractAddress);
    console.log(`Contract Balance: ${ethers.formatEther(balance)} ETH`);
    
}

main()
.catch((error) => {
    console.error(error);
    process.exit(1);
});
