const PiggyBankFactory = artifacts.require("PiggyBankFactory");
const PiggyBank = artifacts.require("PiggyBank");

module.exports = (deployer) => {
  deployer.deploy(PiggyBank)
    .then(() => deployer.deploy(PiggyBankFactory, PiggyBank.address));
};
