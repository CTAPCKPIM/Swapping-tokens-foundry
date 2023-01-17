// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/SwapTokensII.sol";
import "../src/interfaces/IERC20.sol"; 
import "../src/interfaces/IWETH9.sol";

/**
 * @notice Writing of tests for 'SwapTokensII';
 */
contract CounterTest is Test{
    SwapTokensII public swap;
    
    // Addresses of tokens and other;
    address public WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public user = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
    address public withWETH = 0xa6BfEFa3055826E6554D834088A930B727d36a6D;

    /**
     * Amount of the tokens for testing:
     *  {amountTransfer} - amount to manipulate;
     *  {ETH} - 1000 ETH;
     */
    uint256 public amountTransfer = 100000000000000;
    uint256 public ETH = 1000 ether;

    // Event for the testing;
    event Swapped(uint256 amount, address user);

    // Interface of the 'ERC20'; 
    IWETH9 private weth = IWETH9(WETH);
    IERC20 private usdc = IERC20(USDC);

    // How beforeEach();
    function setUp() public {
        // Creating the smart contract;
        swap = new SwapTokensII();

        /**
         * Connect from an address 'user', 
         * and approve the smart contract for spending tokens.
         */
        hoax(user, ETH);
        weth.approve(address(swap), amountTransfer);
        usdc.approve(address(swap), amountTransfer);

        vm.stopPrank(); // Stops an active prank started by 'user'

        /**
         * Connect from an address with WETH on balance, 
         * and approve the user can spend a token.
         */
        hoax(withWETH, ETH);
        weth.approve(user, amountTransfer);
               
    }

    /**
     * Testing the function of the swap WETH on USDC;
     *  {balanceBefore} - Before the manipulate ;
     *  {balanceAfter} - After the manipulate ;  
     */
    function testSwapTokenAToB() public {
        /**
         * Connect from an address 'user': 
         *  - Transferring on balance a 'user' the WETH;
         *  - Calling function 'swapTokenAToB();' for the testing;
         *  {amountWETH} - amount of the WETH on balance 'user';  
         */
        hoax(user, ETH);
        weth.transferFrom(withWETH, user, amountTransfer);
        uint256 balanceBefore = usdc.balanceOf(user);
        uint256 amountWETH = swap.swapTokenAToB(amountTransfer);
        uint256 balanceAfter = usdc.balanceOf(user) - balanceBefore;
        assertEq(balanceAfter, amountWETH);    
    }

    /**
     * Testing the function of the swap USDC on WETH;
     *  {balanceBefore} - Before the manipulate;
     *  {balanceAfter} - After the manipulate;
     *  {amountUSDC} - amount of the USDC on balance 'user';
     *  {amountWETH} - amount of the WETH on balance 'user';  
     */
    function testSwapTokenBToA() public {
        /**
         * Connect from an address 'user': 
         *  - Transferring on balance a 'user' the WETH;
         *  - Calling function 'swapTokenBToA();' for the USDC on balance 'user';
         *  - Calling function 'swapTokenBToA();' for the testing;  
         */
        hoax(user, ETH);
        weth.transferFrom(withWETH, user, amountTransfer);
        uint256 amountUSDC = swap.swapTokenAToB(amountTransfer);
        uint256 balanceBefore = weth.balanceOf(user);
        uint256 amountWETH = swap.swapTokenBToA(amountUSDC);
        uint256 balanceAfter = weth.balanceOf(user) - balanceBefore;
        assertEq(balanceAfter, amountWETH);    
    }

    /**
     * Testing the 'emit' of the swap WETH on USDC;
     */
    function testEmitSwapTokenAToB() public {
        /**
         * Connect from an address 'user': 
         *  - Transferring on balance a 'user' the WETH;
         *  {vm.expectEmit();} - checking the 2nd index in emit;
         *  - event Swapped(uint256 amount, address user);
         *  A - what are we check(indexes);
         *  B - what are we check the 'emit'(A) from function, and your 'emit'(B) 
         */
        hoax(user, ETH);
        weth.transferFrom(withWETH, user, amountTransfer); 
        vm.expectEmit(false, true, false, false); // Comparison (A)*
        emit Swapped(777, user); // What are we comparing (B)*
        swap.swapTokenAToB(amountTransfer); // For calling the event from function
    }

    /**
     * Testing the 'emit' of the swap USDC on WETH;
     */
    function testEmitSwapTokenBToA() public {
        /**
         * Connect from an address 'user': 
         *  - Transferring on balance a 'user' the WETH;
         *  {amountUSDC} - amount of the USDC on balance 'user';
         *  {vm.expectEmit();} - checking the 2nd index in emit;
         *  - event Swapped(uint256 amount, address user);
         *  A - what are we check(indexes);
         *  B - what are we check the 'emit'(A) from function, and your 'emit'(B) 
         */
        hoax(user, ETH);
        weth.transferFrom(withWETH, user, amountTransfer);
        uint256 amountUSDC = swap.swapTokenAToB(amountTransfer);
        vm.expectEmit(false, true, false, false); // Comparison (A)*
        emit Swapped(888, user); // What are we comparing (B)*
        swap.swapTokenBToA(amountUSDC); // For calling the event from function  
    }

    /**
     * Testing the 'revert' of the swap WETH on USDC;
     */
    function testRevertSwapTokenAToB() public {
        /**
         * Connect from an address 'user': 
         *  - Transferring on balance a 'user' the WETH;
         *  {vm.expectRevert();} - expecting revert message;
         *  A - the message;
         *  B - call the function for 'revert' message; 
         */
        hoax(user, ETH);
        weth.transferFrom(withWETH, user, amountTransfer); 
        vm.expectRevert(bytes("Amount is wrong")); // A*
        swap.swapTokenAToB(999999999); // B*
    }

    /**
     * Testing the 'revert' of the swap USDC on WETH;
     */
    function testRevertSwapTokenBToA() public {
        /**
         * Connect from an address 'user': 
         *  {vm.expectRevert();} - expecting revert message;
         *  A - the message;
         *  B - call the function for 'revert' message; 
         */
        hoax(user, ETH);
        vm.expectRevert(bytes("Amount is wrong")); // A*
        swap.swapTokenBToA(0); // For calling the event from function  
    }
}
