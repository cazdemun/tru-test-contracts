pragma solidity ^0.8.0;

import "./PiggyBank.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract PiggyBankFactory {
    event UserRegistered(address user, address bankAccount);

    mapping(address => address) piggyBankAccounts;
    address implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    // updateImplementation()
    // implementation()

    function getPiggyBankAccount() external view returns (address) {
        return piggyBankAccounts[msg.sender];
    }

    function register() external returns (address) {
        require(
            piggyBankAccounts[msg.sender] == address(0),
            "Account already registered!"
        );

        address newAccount = Clones.clone(implementation);
        piggyBankAccounts[msg.sender] = newAccount;

        PiggyBank piggyBank = PiggyBank(payable(newAccount));
        piggyBank.init(msg.sender);
        
        emit UserRegistered(msg.sender, newAccount);

        return newAccount;
    }
}
