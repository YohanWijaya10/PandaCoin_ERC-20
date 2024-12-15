async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const PandaCoin = await ethers.getContractFactory("PandaCoin");
    const initialSupply = 1000000; // Misalnya, 1 juta PandaCoin
    const pandaCoin = await PandaCoin.deploy(initialSupply);

    console.log("PandaCoin deployed to:", pandaCoin.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
