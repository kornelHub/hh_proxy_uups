// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Mars is Initializable, ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {
    function initialize() public initializer {
        __Ownable_init();
        __ERC20_init("Mars", "MARS");
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function version() public pure virtual returns (string memory) {
        return "v1!";
    }
}
contract MarsV2 is Mars {
    uint256 fee;

    function version() public pure virtual override returns (string memory) {
        return "v2!";
    }

    function assingFee(uint256 _newFee) public virtual {
        fee = _newFee;
    }

    function getFee() public view virtual returns(uint256) {
        return fee;
    }
}

contract MarsV3 is MarsV2 {
    uint256 tax;

    function version() public pure virtual override returns (string memory) {
        return "v3!";
    }

    function assingTax(uint256 _newTax) public virtual {
        tax = _newTax;
    }

    function getTax() public view virtual returns(uint256) {
        return tax;
    }
}