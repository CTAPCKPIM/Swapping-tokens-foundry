// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import '../src/interfaces/IERC20.sol';
import '../src/interfaces/IUniswapV2Router02.sol';
import '../src/interfaces/IWETH9.sol';

/**
 * @author by CTAPCKPIM;
 * @title Smart contract for token exchange;
 * @notice This smart contract uses Uniswap to exchange tokens;
 */
contract SwapTokensII{
    // Show the amount and sender
    event Swapped(uint amount, address user);

    /**
     * {uinswapRouter} - address of the 'UniswapV2Router02';
     * {WETH} - address of the 'WETH' token;
     * {USDC} - address of the 'USDC' token;
     */
    address public uinswapRouter = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    /**
     * Interfaces of the 'Uniswap' and 'ERC20';
     */
    IUniswapV2Router02 private router = IUniswapV2Router02(uinswapRouter);
    IWETH9 private weth = IWETH9(WETH);
    IERC20 private usdc = IERC20(USDC);

    /**
     * Swap WETH to USDC
     *  {path} - array with addresses of tokens;
     *  {amountOutMin} - amount of the token;
     *  {balance} - balance of the user;
     *  {amounts} - array with data from the function;
     * @return {amounts[1]}
     */
    function swapTokenAToB(uint256 _amountIn) public returns(uint256) {
        require(_amountIn >= 1000000000, 'Amount is wrong');
        // Need to approve the token: msg.sender > address(this), amount;
        weth.transferFrom(msg.sender, address(this), _amountIn);
        weth.approve(address(router), _amountIn);
        address[] memory path = new address[](2);
        path[0] = WETH;
        path[1] = USDC;
        uint256[] memory amountOutMin = router.getAmountsOut(_amountIn, path);
        // User gives WETH(18 decimal) and get USDC(6 decimal);   
        uint256[] memory amounts = router.swapExactTokensForTokens(
            _amountIn,
            amountOutMin[1] - (amountOutMin[1] * 1 / 100), // Tolerance to price changes 
            path,
            msg.sender,
            block.timestamp
        );
        emit Swapped(amounts[1], msg.sender);
        // Amounts[1] = USDC amount;
        return amounts[1]; 
    }

    /**
     * Swap USDC to WETH
     *  {path} - array with addresses of tokens;
     *  {amountOutMin} - amount of the token;
     *  {balance} - balance of the user;
     *  {amounts} - array with data from the function;
     * @return {amounts[1]}
     */
    function swapTokenBToA(uint256 _amountIn) public returns(uint256) {
        require(_amountIn >= 1, 'Amount is wrong');
        // Need to approve the token: msg.sender > address(this), amount;
        usdc.transferFrom(msg.sender, address(this), _amountIn);
        usdc.approve(address(router),  _amountIn);
        address[] memory path = new address[](2);
        path[0] = USDC;
        path[1] = WETH;
        uint256[] memory amountOutMin = router.getAmountsOut(_amountIn, path);
        // User gives WETH(18 decimal) and get USDC(6 decimal);
        uint256[] memory amounts = router.swapExactTokensForTokens(
            _amountIn,
            amountOutMin[1] - (amountOutMin[1] * 1 / 100), // Tolerance to price changes
            path,
            msg.sender,
            block.timestamp
        );
        emit Swapped(amounts[1], msg.sender);
        // Amounts[1] = WETH amount;
        return amounts[1];
    }
} 