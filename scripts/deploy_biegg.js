const hre = require("hardhat");

async function main() {
    const Contract = await hre.ethers.getContractFactory("BiEgg");
    const contract = await Contract.deploy(
        "0xcE40aBB392db6ab6D058ecceE2203FAA1Db8a8B8",
        "0x4779794D08d60F73F80EAEaC8A4891033b979342"
    );
    await contract.deployed();
    console.log("Contract deployed to:", contract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
