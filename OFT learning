// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { OFTCore } from "./OFTCore.sol";

/**
 * @title OFT Contract
 * @dev OFT is an ERC-20 token that extends the functionality of the OFTCore contract.
 */
contract OFT is OFTCore, ERC20 {
    constructor(
        string memory _name,
        string memory _symbol,
        address _lzEndpoint,
        address _owner
    ) ERC20(_name, _symbol) OFTCore(decimals(), _lzEndpoint, _owner) {}

    function oftVersion() external pure returns (uint64 major, uint64 minor) {
        return (1, 1);
    }

    /**
     * @dev Retrieves the address of the underlying ERC20 implementation.
     * @return The address of the OFT token.
     *
     * @dev In the case of OFT, address(this) and erc20 are the same contract.
     */
    function token() external view returns (address) {
        return address(this);
    }

    function _debitSender(
        uint256 _amountToSendLD,
        uint256 _minAmountToCreditLD,
        uint32 _dstEid
    ) internal virtual override returns (uint256 amountDebitedLD, uint256 amountToCreditLD) {
        (amountDebitedLD, amountToCreditLD) = _debitView(_amountToSendLD, _minAmountToCreditLD, _dstEid);

        // @dev In NON-default OFT, amountDebited could be 100, with a 10% fee, the credited amount is 90,
        // therefore amountDebited CAN differ from amountToCredit.

        // @dev Default OFT burns on src.
        _burn(msg.sender, amountDebitedLD);
    }

    function _debitThis(
        uint256 _minAmountToReceiveLD,
        uint32 _dstEid
    ) internal virtual override returns (uint256 amountDebitedLD, uint256 amountToCreditLD) {
        
    }

    function _credit(
        address _to,
        uint256 _amountToCreditLD,
        uint32 /*_srcEid*/
    ) internal virtual override returns (uint256 amountReceivedLD) {
        // @dev Default OFT mints on dst.
        _mint(_to, _amountToCreditLD);
        // @dev In the case of NON-default OFT, the amountToCreditLD MIGHT not == amountReceivedLD.
        return _amountToCreditLD;
    }
}
 //Learning to build on blockchain alongside my studies

