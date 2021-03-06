pragma solidity ^0.5.0;

// imported PupperCoin token contract
import "./PupperCoin.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
        // @TODO: Fill in the constructor parameters!
        uint rate,
        address payable wallet,
        PupperCoin coin
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        public
    {
        // constructor can stay empty
    }
}

contract PupperCoinSaleDeployer {

    address public tokenSaleAddress;
    address public tokenAddress;

    constructor(
        // @TODO: Fill in the constructor parameters!
        string public name,
        string public symbol,
        address public wallet,
        uint256 public goal,
    )
        public
    {
        // @TODO: create the PupperCoin and keep its address handy
        PupperCoin coin = new PupperCoin(name, symbol, 0);
        tokenAddress = address(coin);

        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        PupperCoinSale pupperCoinSale = new PupperCoinSale(1, wallet, coin);
        tokenSaleAddress = address(pupperCoinSale)

        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        coin.addMinter(tokenSaleAddress);
        coin.renounceMinter();
    }
}