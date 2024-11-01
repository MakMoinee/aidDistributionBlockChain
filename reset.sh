npx hardhat clean
rm .openzepplin/unknown-*.json
npx hardhat console
> await network.provider.request({method: "hardhat_reset", params: []});