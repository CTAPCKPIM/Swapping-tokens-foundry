# __Swapping tokens, using the Foundry__

__Smart contract__ for swapping tokens, and testing with help ___[Foundry](https://book.getfoundry.sh/)___.
> __Mainnet fork is used__

### Functions of the smart contract:
 + `swapTokenAToB();` - the function of swapping a token A => B; 
 + `swapTokenBToA();` - the function of swapping a token A => B; 

## __Tokens:__
- [WETH](https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2);
- [USDC](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
- LP: [ WETH + USDC](https://etherscan.io/address/0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc);

# __Foundry__

### __Install:__
[__On Windows__](https://book.getfoundry.sh/getting-started/installation#on-windows-build-from-source) __|__
[__On Linux and macOS__](https://book.getfoundry.sh/getting-started/installation#on-linux-and-macos)

### __First Steps with Foundry [here](https://book.getfoundry.sh/getting-started/first-steps#first-steps-with-foundry)__

### __Files in a project:__
__About dependencies read [here](https://book.getfoundry.sh/projects/dependencies?highlight=rem#dependencies)__

`remappings.txt` - helps to [remmaping](https://book.getfoundry.sh/projects/dependencies?highlight=rem#remapping-dependencies) dependencies for import in a project.

    $ remappings.txt
    solmate/=/lib/solmate/src/

`.gitmodules` - this pulls the library, stages the [.gitmodules](https://book.getfoundry.sh/projects/dependencies?highlight=.gitmodules#adding-a-dependency) file in git and makes a commit with the message "Installed".

__Configuring with foundry.toml [here](https://book.getfoundry.sh/config/?highlight=foundry.toml#configuring-with-foundrytoml)__

`foundry.toml` - configurations for Forge.

__Continuous Integration [here](https://book.getfoundry.sh/config/continous-integration?highlight=workflows#continuous-integration)__

`.github/workflows` - git action [installed](https://book.getfoundry.sh/config/continous-integration?highlight=workflows#github-actions) automatically Forge.

### __Main commands:__
+ `forge build` - for compile contracts;
+ `forge test` - for testing contracts;
+ `forge coverage` - for see coverage;
+ `froge help` - will show you more commands;

> Forge can produce [__traces__](https://book.getfoundry.sh/forge/traces#understanding-traces) either for failing tests (-vvv) or all tests (-vvvv). 
 `forge test -vvv/vvvv`

#### Command 'test':
If you want to _start_ your tests in the [__fork__](https://book.getfoundry.sh/forge/fork-testing#fork-testing):

    forge test --fork-url <your_rpc_url>

#### Command 'coverage':
If you want to see your _coverage_ in tests in the [__fork__](https://book.getfoundry.sh/forge/fork-testing#fork-testing):

    forge coverage --fork-url <your_rpc_url>

#### __About tests [here](https://book.getfoundry.sh/forge/writing-tests#writing-tests)__

#### __Used cheat codes [example](https://book.getfoundry.sh/forge/cheatcodes#cheatcodes):__

```Solidity
function testExample() public {
    address alice = makeAddr("alice"); // Creating the address 0x4Fa...Tt
    address bob = makeAddr("bob"); // Creating the address 0xR6a...Hf

    hoax(alice, ETH); // analog '.connect(alice)' in ethers
    IERC20(address).approve(bob, amountTransfer);

    vm.stopPrank(); // Stops an active prank started by 'hoax(alice);'

    hoax(bob, ETH); // analog '.connect(bob)' in ethers
    IERC20(address).transferFrom(alice, bob, amountTransfer);
}
```