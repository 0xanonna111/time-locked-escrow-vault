const hre = require("hardhat");

async function main() {
  const [deployer, beneficiary] = await hre.ethers.getSigners();
  
  // Set release time to 1 week from now
  const oneWeek = 7 * 24 * 60 * 60;
  const releaseTime = Math.floor(Date.now() / 1000) + oneWeek;

  const Escrow = await hre.ethers.getContractFactory("TimeLockedEscrow");
  const escrow = await Escrow.deploy(beneficiary.address, releaseTime);

  await escrow.waitForDeployment();
  const address = await escrow.getAddress();

  console.log("Escrow Vault deployed to:", address);
  console.log("Beneficiary:", beneficiary.address);
  console.log("Unlock Date (Unix):", releaseTime);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
