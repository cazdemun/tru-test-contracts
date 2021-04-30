pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";

// contract PiggyBank is Ownable {
contract PiggyBank {
    event ReceiveFunds(address user, uint256 amount, uint256 timestamp);
    event WithdrawFunds(address user, uint256 amount, uint256 timestamp);

    bool flag = false;
    address private _owner;

    // constructor() Ownable() {}
    constructor() {}

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function init(address firstOwner) public {
      require(flag == false, "Contract already initialized");
      _owner = firstOwner;
      flag = true;
    }

    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    receive() external payable onlyOwner {
        emit ReceiveFunds(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Balance too low!");
        payable(msg.sender).transfer(amount);
        emit WithdrawFunds(msg.sender, amount, block.timestamp);
    }
}
