// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

/**
 * @title BeraStorageKeys
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice Stores keys to use for lookup in the BeraStorage contract
 */
abstract contract BeraStorageKeys {
    //=================================================================================================================
    // Declarations
    //=================================================================================================================

    _contract internal contracts = _contract("contract.addressof", "contract.name", "contract.registered");

    //=================================================================================================================
    // Definitions
    //=================================================================================================================

    struct _contract {
        bytes addressof;
        bytes name;
        bytes registered;
    }
}
