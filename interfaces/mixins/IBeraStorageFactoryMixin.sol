

/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;


/** 
 * @title IBeraStorageFactoryMixin
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice Interface of BeraStorageFactoryMixin
 */
interface IBeraStorageFactoryMixin {

    //=================================================================================================================
    // Errors
    //=================================================================================================================
    
    error BeraStorageFactoryMixin__ContractNotFoundByAddressOrIsOutdated(address contractAddress);
    error BeraStorageFactoryMixin__ContractNotFoundByNameOrIsOutdated(bytes32 contractName);
    error BeraStorageFactoryMixin__UserIsNotGuardian(address user);
        

}




