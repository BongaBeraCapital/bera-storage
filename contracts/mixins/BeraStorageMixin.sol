/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Package Imports */
import {u60x18, u60x18_t} from "@bonga-bera-capital/bera-utils/contracts/Math.sol";
import {TypeSwaps} from "@bonga-bera-capital/bera-utils/contracts/TypeSwaps.sol";

/* Internal Imports */
import {BeraStorageKeys} from "../BeraStorageKeys.sol";

/* Interface Imports */
import {IBeraStorage} from "../../interfaces/IBeraStorage.sol";
import {IBeraStorageMixin} from "../../interfaces/mixins/IBeraStorageMixin.sol";

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
    IBeraStorage internal BeraStorage_;

    //=================================================================================================================
    // Internal
    //=================================================================================================================

    function getContractAddressByName(bytes32 contractName) internal view returns (address) {
        address contractAddress = BeraStorage_.getAddress(
            keccak256(abi.encodePacked(BeraStorageKeys.contracts.addressof, contractName))
        );
        if (contractAddress == address(0x0)) revert BeraStorageMixin__ContractNotFoundByNameOrIsOutdated(contractName);
        return contractAddress;
    }

    //=================================================================================================================
    // Modifiers
    //=================================================================================================================

    modifier onlyRegisteredContracts() {
        if (!BeraStorage_.getBool(keccak256(abi.encodePacked(BeraStorageKeys.contracts.registered, msg.sender))))
            revert BeraStorageMixin__ContractNotFoundByAddressOrIsOutdated(msg.sender);
        _;
    }

    modifier onlyContract(bytes32 contractName, address contractAddress) {
        if (contractAddress != BeraStorage_.getAddress(keccak256(abi.encodePacked(BeraStorageKeys.contracts.name, contractName))))
            revert BeraStorageMixin__ContractNotFoundByNameOrIsOutdated(contractName);
        _;
    }

    modifier onlyFromStorageGuardian() {
        if (msg.sender != BeraStorage_.getGuardian()) revert BeraStorageMixin__UserIsNotGuardian(msg.sender);
        _;
    }
}
