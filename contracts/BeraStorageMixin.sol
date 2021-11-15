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

    IBeraStorage internal BeraStorage_ = IBeraStorage(address(0));

    //=================================================================================================================
    // BeraStorageMixin.onlyFromNetworkContract
    //=================================================================================================================

    modifier onlyFromRegisteredContracts() {
        if (!BeraStorage_.getBool(keccak256(abi.encodePacked(BeraStorageKeys.contracts.registered, msg.sender))))
            revert BeraStorageMixin__ContractNotFoundByAddressOrIsOutdated(msg.sender);
        _;
    }

    //=================================================================================================================
    // BeraStorageMixin.onlyLatestContract
    //=================================================================================================================

    modifier onlyFromContract(string memory inName, address inAddress) {
        if (inAddress != BeraStorage_.getAddress(keccak256(abi.encodePacked(BeraStorageKeys.contracts.name, inName))))
            revert BeraStorageMixin__ContractNotFoundByNameOrIsOutdated(inName);
        _;
    }

    //=================================================================================================================
    // BeraStorageMixin.onlyFromGuardian
    //=================================================================================================================

    modifier onlyFromGuardian() {
        if (msg.sender != BeraStorage_.getGuardian()) revert BeraStorageMixin__UserIsNotGuardian(msg.sender);
        _;
    }

    //=================================================================================================================
    // BeraStorageMixin.getContractAddressByName
    //=================================================================================================================

    function getContractAddressByName(string memory inName) internal view returns (address) {
        address contractAddress = BeraStorage_.getAddress(
            keccak256(abi.encodePacked(BeraStorageKeys.contracts.addressof, inName))
        );
        if (contractAddress == address(0x0)) revert BeraStorageMixin__ContractNotFoundByNameOrIsOutdated(inName);
        return contractAddress;
    }
}
