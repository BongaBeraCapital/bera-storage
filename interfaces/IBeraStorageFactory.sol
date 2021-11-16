/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Internal Interface Imports */
import {IBeraStorage} from "./IBeraStorage.sol";

/**
 * @title IBeraStorageFactory
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice Interface for BeraStorageFactory
 */

interface IBeraStorageFactory {
    
    //=================================================================================================================
    // Errors
    //=================================================================================================================

    error BeraStorageFactory_ContractAlreadyExists(bytes32 inContractName);
    error BeraStorageFactory_ContractDoesNotExist(bytes32 inContractName);

    //=================================================================================================================
    // Mutators
    //=================================================================================================================

    function deployStorageContract(bytes32 inContractName) external returns (IBeraStorage);
    function removeStorageContract(bytes32 inContractName) external returns (bool);

    //=================================================================================================================
    // Accessors
    //=================================================================================================================

    function getStorageContractByName(bytes32 inContractName) external view returns (IBeraStorage);
    
}
