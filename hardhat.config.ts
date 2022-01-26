import type { HardhatUserConfig } from "hardhat/types"; 

import "@nomiclabs/hardhat-ethers";
import "@openzeppelin/hardhat-upgrades";

const config: HardhatUserConfig = {
  solidity: '0.8.2',
};
export default config;