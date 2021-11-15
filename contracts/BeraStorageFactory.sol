/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Package Imports */
import {u60x18, u60x18_t} from "@bonga-bera-capital/bera-utils/contracts/Math.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {TypeSwaps} from "@bonga-bera-capital/bera-utils/contracts/TypeSwaps.sol";

/* Internal Imports */
import {BeraStorage, IBeraStorage} from "./BeraStorage.sol";
import {BeraStorageMixin} from "./BeraStorageMixin.sol";

/* Internal Interface Imports */
import {IBeraStorageFactory} from "../interfaces/IBeraStorageFactory.sol";

/**
 * @title BeraStorageFactory
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice A contract that uses the factory design pattern to deploy BeraStorage contracts. Usage of this contract is
 * total optional. BeraStorage can also be deployed indivually without a factory.
 */
contract BeraStorageFactory is BeraStorageMixin, IBeraStorageFactory, Ownable { // TODO: Update from Ownable to a Guardian
    //=================================================================================================================
    // Storage Maps
    //=================================================================================================================

    mapping(bytes32 => IBeraStorage) private storageContracts;

    //=================================================================================================================
    // Constructor
    //=================================================================================================================

    constructor(uint256 numStorageContracts, bytes32[] memory inContractNames) Ownable() {
        for (uint256 i = 0; i < numStorageContracts; i += 1) {
            deployStorageContract(inContractNames[i]);
        }
    }

    //=================================================================================================================
    // BeraStorageFactory.deployStorageContract
    //=================================================================================================================

    function deployStorageContract(bytes32 inContractName) public virtual override onlyOwner {
        if (storageContracts[inContractName] != IBeraStorage(address(0)))
            revert BeraStorageFactory_ContractAlreadyExists(inContractName);
        storageContracts[inContractName] = IBeraStorage(new BeraStorage());
    }

    //=================================================================================================================
    // BeraStorageFactory.removeStorageContract
    //=================================================================================================================

    function removeStorageContract(bytes32 inContractName) public virtual override onlyOwner {
        if (storageContracts[inContractName] == BeraStorage(address(0)))
            revert BeraStorageFactory_ContractDoesNotExist(inContractName);
        delete storageContracts[inContractName];
    }

    //=================================================================================================================
    // BeraStorageFactory.getStorageContractByName
    //=================================================================================================================

    function getStorageContractByName(bytes32 inContractName) external view virtual override returns (IBeraStorage) {
        return storageContracts[inContractName];
    }
}
