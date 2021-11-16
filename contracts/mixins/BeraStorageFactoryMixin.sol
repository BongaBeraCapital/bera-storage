/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Package Imports */
import {u60x18, u60x18_t} from "@bonga-bera-capital/bera-utils/contracts/Math.sol";
import {TypeSwaps} from "@bonga-bera-capital/bera-utils/contracts/TypeSwaps.sol";

/* Internal Imports */
import {BeraStorageKeys} from "../BeraStorageKeys.sol";

/* Interface Imports */
import {IBeraStorage} from "../../interfaces/IBeraStorage.sol";
import {IBeraStorageFactory} from "../../interfaces/IBeraStorageFactory.sol";
import {IBeraStorageFactoryMixin} from "../../interfaces/mixins/IBeraStorageFactoryMixin.sol";

/**
 * @title BeraStorageFactoryMixin
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice A mixin that allows the child class to access eternal BeraStorage contracts via a BeraStorageFactory
 */
abstract contract BeraStorageFactoryMixin is BeraStorageKeys, IBeraStorageFactoryMixin {
    //=================================================================================================================
    // State Variables
    //=================================================================================================================

    uint256 public contractVersion;
    IBeraStorageFactory internal BeraStorageFactory;

    //=================================================================================================================
    // Internal Functons
    //=================================================================================================================

    function getContractAddressByName(bytes32 contractName, bytes32 storageContractName)
        internal
        view
        returns (address)
    {
        IBeraStorage storageContract = BeraStorageFactory.getStorageContractByName(storageContractName);
        address contractAddress = storageContract.getAddress(
            keccak256(abi.encodePacked(BeraStorageKeys.contracts.addressof, contractName))
        );
        if (contractAddress == address(0x0))
            revert BeraStorageFactoryMixin__ContractNotFoundByNameOrIsOutdated(contractName);
        return contractAddress;
    }

    //=================================================================================================================
    // Modifiers
    //=================================================================================================================

    modifier onlyRegisteredContracts(bytes32 storageContractName) {
        IBeraStorage storageContract = BeraStorageFactory.getStorageContractByName(storageContractName);
        if (!storageContract.getBool(keccak256(abi.encodePacked(BeraStorageKeys.contracts.registered, msg.sender))))
            revert BeraStorageFactoryMixin__ContractNotFoundByAddressOrIsOutdated(msg.sender);
        _;
    }

    modifier onlyContract(
        bytes32 contractName,
        address inAddress,
        bytes32 storageContractName
    ) {
        IBeraStorage storageContract = BeraStorageFactory.getStorageContractByName(storageContractName);
        if (
            inAddress !=
            storageContract.getAddress(keccak256(abi.encodePacked(BeraStorageKeys.contracts.name, contractName)))
        ) revert BeraStorageFactoryMixin__ContractNotFoundByNameOrIsOutdated(contractName);
        _;
    }

    modifier onlyFromStorageGuardianOf(bytes32 storageContractName) {
        IBeraStorage storageContract = BeraStorageFactory.getStorageContractByName(storageContractName);
        if (msg.sender != storageContract.getGuardian()) revert BeraStorageFactoryMixin__UserIsNotGuardian(msg.sender);
        _;
    }
}
