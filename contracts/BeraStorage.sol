// SPDX-License-Identifier: GPL-3.0-only
pragma solidity =0.8.10;

/* Package Imports */
import { u60x18, u60x18_t } from "@bonga-bera-capital/bera-utils/contracts/Math.sol";

/* Interfaces */
import { IBeraStorage } from "../interfaces/IBeraStorage.sol";

contract BeraStorage is IBeraStorage {
    /* Events */
    event GuardianChanged(address oldGuardian, address newGuardian);

    /* Libraries  */
    using u60x18 for uint256;
    using u60x18 for u60x18_t;

    /* Storage maps  */
    mapping(bytes32 => string) private stringStorage;
    mapping(bytes32 => bytes) private bytesStorage;
    mapping(bytes32 => uint256) private uintStorage;
    mapping(bytes32 => int256) private intStorage;
    mapping(bytes32 => address) private addressStorage;
    mapping(bytes32 => bool) private booleanStorage;
    mapping(bytes32 => bytes32) private bytes32Storage;

    // Guardian address
    address guardian;
    address newGuardian;

    // Flag storage has been initialised
    bool storageInit = false;

    /// @dev Only allow access to approved cotracts
    modifier onlyRegisteredContracts() {
        if (storageInit == true) {
            // Make sure the access is permitted to only contracts in our Dapp
            require(
                booleanStorage[keccak256(abi.encodePacked("contract.registered", msg.sender))],
                "Invalid or outdated network contract"
            );
        } else {
            // tx.origin is only safe to use in this case for deployment since no external contracts are interacted with
            require(
                (booleanStorage[keccak256(abi.encodePacked("contract.registered", msg.sender))] || tx.origin == guardian),
                "Invalid or outdated network contract attempting access during deployment"
            );
        }
        _;
    }

    /// @dev Construct TropicalStorage
    constructor() {
        // Set the guardian upon deployment
        guardian = msg.sender;
    }

    // Get guardian address
    function getGuardian() external view override returns (address) {
        return guardian;
    }

    // Transfers guardianship to a new address
    function setGuardian(address _newAddress) external override {
        // Check tx comes from current guardian
        require(msg.sender == guardian, "Is not guardian account");
        // Store new address awaiting confirmation
        newGuardian = _newAddress;
    }

    // Confirms change of guardian
    function confirmGuardian() external override {
        // Check tx came from new guardian address
        require(msg.sender == newGuardian, "Confirmation must come from new guardian address");
        // Store old guardian for event
        address oldGuardian = guardian;
        // Update guardian and clear storage
        guardian = newGuardian;
        delete newGuardian;
        // Emit event
        emit GuardianChanged(oldGuardian, guardian);
    }

    // Set this as being deployed now
    function getDeployedStatus() external view override returns (bool) {
        return storageInit;
    }

    // Set this as being deployed now
    function setDeployedStatus() external {
        // Only guardian can lock this down
        require(msg.sender == guardian, "Is not guardian account");
        // Set it now
        storageInit = true;
    }

    /// @param _key The key for the record
    function getAddress(bytes32 _key) external view override returns (address r) {
        return addressStorage[_key];
    }

    /// @param _key The key for the record
    function getUint(bytes32 _key) external view override returns (uint256 r) {
        return uintStorage[_key];
    }

    /// @param _key The key for the record
    function getUD60x18(bytes32 _key) external view override returns (u60x18_t r) {
        return uintStorage[_key].asUD60x18();
    }

    /// @param _key The key for the record
    function getString(bytes32 _key) external view override returns (string memory) {
        return stringStorage[_key];
    }

    /// @param _key The key for the record
    function getBytes(bytes32 _key) external view override returns (bytes memory) {
        return bytesStorage[_key];
    }

    /// @param _key The key for the record
    function getBool(bytes32 _key) external view override returns (bool r) {
        return booleanStorage[_key];
    }

    /// @param _key The key for the record
    function getInt(bytes32 _key) external view override returns (int256 r) {
        return intStorage[_key];
    }

    /// @param _key The key for the record
    function getBytes32(bytes32 _key) external view override returns (bytes32 r) {
        return bytes32Storage[_key];
    }

    /// @param _key The key for the record
    function setAddress(bytes32 _key, address _value) external override onlyRegisteredContracts {
        addressStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setUint(bytes32 _key, uint256 _value) external override onlyRegisteredContracts {
        uintStorage[_key] = _value;
    }

    // @param _key The key for the record
    function setUD60x18(bytes32 _key, u60x18_t _value) external override onlyRegisteredContracts {
        uintStorage[_key] = _value.asUint();
    }

    /// @param _key The key for the record
    function setString(bytes32 _key, string calldata _value) external override onlyRegisteredContracts {
        stringStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBytes(bytes32 _key, bytes calldata _value) external override onlyRegisteredContracts {
        bytesStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBool(bytes32 _key, bool _value) external override onlyRegisteredContracts {
        booleanStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setInt(bytes32 _key, int256 _value) external override onlyRegisteredContracts {
        intStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBytes32(bytes32 _key, bytes32 _value) external override onlyRegisteredContracts {
        bytes32Storage[_key] = _value;
    }

    /// @param _key The key for the record
    function deleteAddress(bytes32 _key) external override onlyRegisteredContracts {
        delete addressStorage[_key];
    }

    /// @param _key The key for the record
    function deleteUint(bytes32 _key) external override onlyRegisteredContracts {
        delete uintStorage[_key];
    }

    /// @param _key The key for the record
    function deleteUD60x18(bytes32 _key) external override onlyRegisteredContracts {
        delete uintStorage[_key];
    }

    /// @param _key The key for the record
    function deleteString(bytes32 _key) external override onlyRegisteredContracts {
        delete stringStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBytes(bytes32 _key) external override onlyRegisteredContracts {
        delete bytesStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBool(bytes32 _key) external override onlyRegisteredContracts {
        delete booleanStorage[_key];
    }

    /// @param _key The key for the record
    function deleteInt(bytes32 _key) external override onlyRegisteredContracts {
        delete intStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBytes32(bytes32 _key) external override onlyRegisteredContracts {
        delete bytes32Storage[_key];
    }

    /// @param _key The key for the record
    /// @param _amount An amount to add to the record's value
    function addUint(bytes32 _key, uint256 _amount) external override onlyRegisteredContracts {
        uintStorage[_key] = uintStorage[_key] + _amount;
    }

    /// @param _key The key for the record
    /// @param _amount An amount to subtract from the record's value
    function subUint(bytes32 _key, uint256 _amount) external override onlyRegisteredContracts {
        uintStorage[_key] = uintStorage[_key] - _amount;
    }

    /// @param _key The key for the record
    /// @param _amount An amount to add to the record's value
    function addUD60x18(bytes32 _key, u60x18_t _amount) external override onlyRegisteredContracts {
        uintStorage[_key] = uintStorage[_key] - _amount.asUint();
    }

    /// @param _key The key for the record
    /// @param _amount An amount to subtract from the record's value
    function subUD60x18(bytes32 _key, u60x18_t _amount) external override onlyRegisteredContracts {
        uintStorage[_key] = uintStorage[_key] - _amount.asUint();
    }
}
