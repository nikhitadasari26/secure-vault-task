import hre from "hardhat";

async function main() {
  console.log("Starting deployment...");

  // Destructure ethers from hre to ensure it's initialized
  const { ethers } = hre;

  if (!ethers) {
    throw new Error("Ethers not found in Hardhat Runtime Environment");
  }

  // 1. Get the contract factories
  const AuthManagerFactory = await ethers.getContractFactory("AuthorizationManager");
  const VaultFactory = await ethers.getContractFactory("SecureVault");

  // 2. Deploy AuthorizationManager
  const auth = await AuthManagerFactory.deploy();
  await auth.waitForDeployment();
  const authAddress = await auth.getAddress();

  // 3. Deploy SecureVault with the Manager's address
  const vault = await VaultFactory.deploy(authAddress);
  await vault.waitForDeployment();
  const vaultAddress = await vault.getAddress();

  console.log("--- DEPLOYMENT SUCCESS ---");
  console.log("AuthorizationManager:", authAddress);
  console.log("SecureVault:", vaultAddress);
}

main().catch((error) => {
  console.error("Deployment failed:", error);
  process.exit(1);
});