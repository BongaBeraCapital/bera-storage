/* SPDX-License-Identifier: MIT */
pragma solidity =0.8.10;

/* Package Imports */
import { u60x18_t } from "@bonga-bera-capital/bera-utils/contracts/Math.sol";

/** 
 * @title IBeraStorage
 * @author 0xrebased @ Bonga Bera Capital: https://github.com/BongaBeraCapital
 * @notice Interface of BeraStorage
 */
interface IBeraStorage {

    //=================================================================================================================
    // Errors
    //=================================================================================================================
    
    error BeraStorage__ContractNotRegistered(address contractAddress);
    error BeraStorage__NotStorageGuardian(address user);
    error BeraStorage__NoGuardianInvitation(address user);

    //=================================================================================================================
    // Events
    //=================================================================================================================

    event GuardianChanged(address oldStorageGuardian, address newStorageGuardian);

    //=================================================================================================================
    // Deployment Status
    //=================================================================================================================

    function getDeployedStatus() external view returns (bool);

    //=================================================================================================================
    // Guardian
    //=================================================================================================================

    function getGuardian() external view returns(address);
    function sendGuardianInvitation(address _newAddress) external;
    function acceptGuardianInvitation() external;

    //=================================================================================================================
    // Accessors
    //=================================================================================================================

    function getAddress(bytes32 _key) external view returns (address);
    function getUint(bytes32 _key) external view returns (uint);
    function getUD60x18(bytes32 _key) external view returns (u60x18_t);
    function getString(bytes32 _key) external view returns (string memory);
    function getBytes(bytes32 _key) external view returns (bytes memory);
    function getBool(bytes32 _key) external view returns (bool);
    function getInt(bytes32 _key) external view returns (int);
    function getBytes32(bytes32 _key) external view returns (bytes32);

    //=================================================================================================================
    // Mutators
    //=================================================================================================================
    
    function setAddress(bytes32 _key, address _value) external;
    function setUint(bytes32 _key, uint _value) external;
    function setUD60x18(bytes32 _key, u60x18_t _value) external;
    function setString(bytes32 _key, string calldata _value) external;
    function setBytes(bytes32 _key, bytes calldata _value) external;
    function setBool(bytes32 _key, bool _value) external;
    function setInt(bytes32 _key, int _value) external;
    function setBytes32(bytes32 _key, bytes32 _value) external;

    //=================================================================================================================
    // Deletion
    //=================================================================================================================

    function deleteAddress(bytes32 _key) external;
    function deleteUint(bytes32 _key) external;
    function deleteUD60x18(bytes32 _key) external;
    function deleteString(bytes32 _key) external;
    function deleteBytes(bytes32 _key) external;
    function deleteBool(bytes32 _key) external;
    function deleteInt(bytes32 _key) external;
    function deleteBytes32(bytes32 _key) external;

    //=================================================================================================================
    // Arithmetic
    //=================================================================================================================

    function addUint(bytes32 _key, uint256 _amount) external;
    function subUint(bytes32 _key, uint256 _amount) external;
    function addUD60x18(bytes32 _key, u60x18_t _amount) external;
    function subUD60x18(bytes32 _key, u60x18_t _amount) external;
}
