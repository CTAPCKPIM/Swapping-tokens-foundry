# __Swapping tokens, using the Foundry__
___
__Smart contract__ for swapping _tokens_, and _testing_ with help ___[Foundry](https://book.getfoundry.sh/)___.
> __Mainnet fork is used__

### Functions of the smart contract:
 `swapTokenAToB();` - the _function_ of swapping a __token A => B__; 
 `swapTokenBToA();` - the _function_ of swapping a __token A => B__; 

## __Tokens:__
- [WETH](https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2);
- [USDC](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
- LP: [ WETH + USDC](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc);

___
# __Foundry__

### __Install:__
[__On Windows__](https://book.getfoundry.sh/getting-started/installation#on-windows-build-from-source)
[__On Linux and macOS__](https://book.getfoundry.sh/getting-started/installation#on-linux-and-macos)

### __First Steps with Foundry [here](https://book.getfoundry.sh/getting-started/first-steps#first-steps-with-foundry)__

### __Main commands:__
+ `forge build` - for compile contracts;
+ `forge test` - for testing contracts;
+ `forge coverage` - for see coverage;
+ `froge help` - will show you more commands;

> Forge can produce [__traces__](https://book.getfoundry.sh/forge/traces#understanding-traces) either for failing tests (-vvv) or all tests (-vvvv). 
> `forge test -vvv/vvvv`

#### Command 'test':
If you want to _start_ your tests in the [__fork__](https://book.getfoundry.sh/forge/fork-testing#fork-testing):

    forge test --fork-url <your_rpc_url>

#### Command 'coverage':
If you want to see your _coverage_ in tests in the [__fork__](https://book.getfoundry.sh/forge/fork-testing#fork-testing):

    forge coverage --fork-url <your_rpc_url>

### __About tests:__
__Forge__ uses the following keywords in [__tests__](https://book.getfoundry.sh/forge/writing-tests#writing-tests):

> All functions must be __public/external__.

`setUp()`- An optional function invoked before each test case is run.

    function setUp() public {}

`test`- Functions prefixed with test are run as a test case.

    function testNumberIs42() public {}

`testFail`- The inverse of the test prefix - if the function does not revert, the test fails.

    function testFailSubtract43() public {}

### __Cheatcodes__

[__Cheatcodes__](https://book.getfoundry.sh/forge/cheatcodes#cheatcodes) allow you to change the block number, your identity, and more.

#### Used cheatcodes:
`hoax();` - [Sets](https://book.getfoundry.sh/reference/forge-std/hoax#hoax) up a prank from an address that has some ether.

    hoax(address, ether);

`makeAddr("");` - [Creates](https://book.getfoundry.sh/reference/forge-std/make-addr#makeaddr) an address derived from the provided name.

    address alice = makeAddr("alice");
    emit log_address(alice); // 0x328809bc894f92807417d2dad6b7c998c1afdac6

`vm.stopPrank();` - [Stops](https://book.getfoundry.sh/cheatcodes/stop-prank#stopprank) an active prank started by.

    vm.stopPrank();

`vm.expectEmit(bool, bool, bool, bool);` - [Assert](https://book.getfoundry.sh/cheatcodes/expect-emit?highlight=expectEmit#expectemit) a specific log is emitted before the end of the current function.;

    vm.expectEmit(false, true, false, false);

`vm.expectRevert(bytes("message"));` - [If the next call](https://book.getfoundry.sh/cheatcodes/expect-revert?highlight=vm.expectRevert#expectrevert) does not revert with the expected data message, then expectRevert will.

    vm.expectRevert(bytes("Amount is wrong"));
