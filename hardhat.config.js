require('@nomiclabs/hardhat-ethers');
require('dotenv').config(); // Pastikan dotenv di-load

module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`, // URL RPC Infura
      accounts: [process.env.PRIVATE_KEY], // Akun diambil dari file .env, pastikan itu adalah array
      chainId: 11155111,
    }
  }
};
