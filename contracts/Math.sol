// SPDX-License-Identifier: MIT
pragma solidity =0.8.10;

import "@hifi-finance/prb-math/contracts/PRBMathUD60x18.sol";

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
type u60x18_t is uint256;

library u60x18 {
    using PRBMathUD60x18 for uint256;

    function asUint(u60x18_t a) internal pure returns ( uint256 ) {
        return u60x18_t.unwrap(a);
    }

    function asUD60x18(uint256 a) internal pure returns ( u60x18_t ) {
        return u60x18_t.wrap(a);
    }

    /**
     * @dev Returns a + b
     */
    function add(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return u60x18_t.wrap(u60x18_t.unwrap(a) + u60x18_t.unwrap(b));
    }

    /**
     * @dev Returns a subtract b
     */
    function sub(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return u60x18_t.wrap(u60x18_t.unwrap(a) - u60x18_t.unwrap(b));
    }

    /**
     * @dev Returns a * b
     */
    function mul(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return u60x18_t.wrap(u60x18_t.unwrap(a).mul(u60x18_t.unwrap(b)));
    }

    /**
     * @dev Returns a / b
     */
    function div(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return u60x18_t.wrap(u60x18_t.unwrap(a).div(u60x18_t.unwrap(b)));
    }

    /**
     * @dev Returns a ^ b
     */
    function pow(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return u60x18_t.wrap(u60x18_t.unwrap(a).pow(u60x18_t.unwrap(b)));
    }

    /**
     * @dev Returns if a greater than b
     */
    function gt(u60x18_t a, u60x18_t b) internal pure returns (bool) {
        return (u60x18_t.unwrap(a) > u60x18_t.unwrap(b));
    }

    /**o
     * @dev Returns if a is less than b
     */
    function lt(u60x18_t a, u60x18_t b) internal pure returns (bool) {
        return (u60x18_t.unwrap(a) < u60x18_t.unwrap(b));
    }

    /**
     * @dev Returns if a is greater than or equal to b
     */
    function gte(u60x18_t a, u60x18_t b) internal pure returns (bool) {
        return (u60x18_t.unwrap(a) >= u60x18_t.unwrap(b));
    }

    /**
     * @dev Returns if a is less than or equal to b
     */
    function lte(u60x18_t a, u60x18_t b) internal pure returns (bool) {
        return (u60x18_t.unwrap(a) <= u60x18_t.unwrap(b));
    }

    /**
     * @dev Returns if numbers are equal.
     */
    function equals(u60x18_t a, u60x18_t b) internal pure returns (bool) {
        return (u60x18_t.unwrap(a) == u60x18_t.unwrap(b));
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return gte(a, b) ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(u60x18_t a, u60x18_t b) internal pure returns (u60x18_t) {
        return lt(a, b) ? a : b;
    }
}