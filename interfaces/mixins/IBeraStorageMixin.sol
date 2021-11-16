

/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;


/** 
 * @title IBeraStorageMixin
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice Interface of BeraStorageMixin
 */
interface IBeraStorageMixin {

    //=================================================================================================================
    // Errors
    //=================================================================================================================
    
    error BeraStorageMixin__ContractNotFoundByAddressOrIsOutdated(address contractAddress);
    error BeraStorageMixin__ContractNotFoundByNameOrIsOutdated(bytes32 contractName);
    error BeraStorageMixin__UserIsNotGuardian(address user);
        

}




