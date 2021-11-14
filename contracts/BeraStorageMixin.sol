/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Package Imports */
import {u60x18, u60x18_t} from "@bonga-bera-capital/bera-utils/contracts/Math.sol";
import {TypeSwaps} from "@bonga-bera-capital/bera-utils/contracts/TypeSwaps.sol";

/* Internal Imports */
import {BeraStorageKeys} from "./BeraStorageKeys.sol";

/* Interface Imports */
import {IBeraStorage} from "../interfaces/IBeraStorage.sol";
import {IBeraStorageMixin} from "../interfaces/IBeraStorageMixin.sol";

/**
 * @title BeraStorageMixin
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice A mixin that allows the child class to access eternal BeraStorage contracts
 */
abstract contract BeraStorageMixin is BeraStorageKeys, IBeraStorageMixin {
    //=================================================================================================================
    // State Variables
    //=================================================================================================================

    uint256 public contractVersion;

    //=================================================================================================================
    // Connections
    //=================================================================================================================

    IBeraStorage internal BeraStorage = IBeraStorage(address(0));

    //=================================================================================================================
    // BeraStorageMixin.getContractAddressByName
    //=================================================================================================================

    function getContractAddressByName(string memory inName) internal view returns (address) {
        address contractAddress = BeraStorage.getAddress(
            keccak256(abi.encodePacked(BeraStorageKeys.contracts.addressof, inName))
        );
        if (contractAddress == address(0x0)) revert BeraStorageMixin__ContractNotFound(inName);
        return contractAddress;
    }
}
