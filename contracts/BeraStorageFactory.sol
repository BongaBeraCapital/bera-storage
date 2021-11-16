/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Package Imports */
import {u60x18, u60x18_t} from "@bonga-bera-capital/bera-utils/contracts/Math.sol";
import {TypeSwaps} from "@bonga-bera-capital/bera-utils/contracts/TypeSwaps.sol";

/* Internal Imports */
import {BeraStorage, IBeraStorage} from "./BeraStorage.sol";

/* Internal Interface Imports */
import {IBeraStorageFactory} from "../interfaces/IBeraStorageFactory.sol";

/**
 * @title BeraStorageFactory
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice A contract that uses the factory design pattern to deploy BeraStorage contracts. Usage of this contract is
 * total optional. BeraStorage can also be deployed indivually without a factory.
 */
contract BeraStorageFactory is IBeraStorageFactory {
    //=================================================================================================================
    // Storage Maps
    //=================================================================================================================

    mapping(bytes32 => IBeraStorage) private storageContracts;

    //=================================================================================================================
    // Constructor
    //=================================================================================================================

    constructor(bytes32[] memory contractNames) {
        for (uint256 i = 0; i < contractNames.length; i += 1) {
            deployStorageContract(contractNames[i]);
        }
    }

    //=================================================================================================================
    // Public Functions
    //=================================================================================================================

    function deployStorageContract(bytes32 contractName) public virtual override returns (IBeraStorage) {
        if (storageContracts[contractName] != IBeraStorage(address(0)))
            revert BeraStorageFactory_ContractAlreadyExists(contractName);
        storageContracts[contractName] = IBeraStorage(new BeraStorage());
        storageContracts[contractName].sendGuardianInvitation(msg.sender);
        return storageContracts[contractName];
    }

    function removeStorageContract(bytes32 contractName) public virtual override returns (bool) {
        if (storageContracts[contractName] == BeraStorage(address(0)))
            revert BeraStorageFactory_ContractDoesNotExist(contractName);
        delete storageContracts[contractName];
        return true;
    }

    function getStorageContractByName(bytes32 contractName) external view virtual override returns (IBeraStorage) {
        return storageContracts[contractName];
    }
}
