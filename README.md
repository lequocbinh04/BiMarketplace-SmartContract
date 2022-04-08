<p align="center">
  <a href="https://www.facebook.com/lequocbinh.04">
    <img src="https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Ethereum-ETH-icon.png" alt="Logo" width=72 height=72>
  </a>

  <h3 align="center">Smart Contract for BiMarketplace</h3>

  <p align="center">
    This branch is the Smart Contract code. If you have any questions, please contact me 😁
    <br>
    <a href="https://www.facebook.com/lequocbinh.04">Report bug</a>
    ·
    <a href="https://www.facebook.com/lequocbinh.04">Request feature</a>
  </p>
</p>

# Infomation

This branch is the Smart Contract code, including: 2 token (BiToken, BiHero), and 3 contract. This code uses [Hardhat](https://hardhat.org/getting-started/) with solidity 0.8.4 compiler in addition to programming tokens or contracts quickly I also use [OpenZeppelin](https://openzeppelin.com/).
&nbsp;

&nbsp;

Some information about the contract I deployed (testnet):

```shell
BiToken (BT) address: 0xcE40aBB392db6ab6D058ecceE2203FAA1Db8a8B8
```

```shell
BiHero(BH) NFT Token: 0x4779794D08d60F73F80EAEaC8A4891033b979342
```

```shell
BiEgg to buy & open egg: 0x358A141Af732a7025d5dC3229513B5FAF20eD78d
```

```shell
BiMarketplace: [updating...]
```

&nbsp;

# Usage

1. Config file `hardhat.config.js` (add mainnet if you want, add BSC API_KEY, change private key to deploy contract)
2. Run the command below to start deploying contract. Change file to run & change network to deploy.

```shell
npx hardhat run scripts/[file].js --network testnet
```

3. Run the command below to start validating contract

```shell
 npx hardhat verify --network testnet <token_address>
```
