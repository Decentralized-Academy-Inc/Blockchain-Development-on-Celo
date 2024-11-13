pragma solidity >=0.4.22 <0.9.0;

// Importing OpenZeppelin's SafeMath Implementation
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// IERC-20 contract
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SavingsGroup {
  // SafeMath for safe integer operations
  using SafeMath for uint256;

  // List of all the projects
  Group[] private groups;

  // event for when new project starts
  event GroupStarted(
    address contractAddress,
    address projectCreator,
    string title,
    string description,
    string imageLink,
    uint256 goalAmount
  );

  function startGroup(
    IERC20 cUSDToken,
    string calldata title,
    string calldata description,
    string calldata imageLink,
    uint amountToRaise
  ) external {

    Group newGroup = new Group(cUSDToken, payable(msg.sender), title, description, imageLink, amountToRaise);
    groups.push(newGroup);

    emit GroupStarted(
      address(newGroup),
      msg.sender,
      title,
      description,
      imageLink,
      amountToRaise
    );
  }

  function returnGroup() external view returns(Group[] memory) {
    return groups;
  }

}


contract Group {
  using SafeMath for uint256;

  IERC20 private cUSDToken;

  // Initialize public variables
  address payable public creator;
  uint public goalAmount;
  uint256 public currentBalance;
  string public title;
  string public description;
  string public imageLink;

  mapping (address => uint) public contributions;

  // Event when funding is received
  event ReceivedFunding(address contributor, uint amount, uint currentTotal);

  // Event for when the project creator has received their funds
  event InvestmentOwnerPaid(address recipient);

  constructor
  (

    IERC20 token,
    address payable groupCreator,
    string memory groupTitle,
    string memory groupDescription,
    string memory groupImageLink,
    uint256 groupGoalAmount,

  ) {
    cUSDToken = token;
    creator = groupCreator;
    title = groupTitle;
    description = groupDescription;
    imageLink = groupImageLink;
    goalAmount = groupGoalAmount;
    currentBalance = 0;
  }

  // Fund a Savings Group Investment
  function contribute(uint256 amount) external payable {
    cUSDToken.transferFrom(msg.sender, address(this), amount);

    contributions[msg.sender] = contributions[msg.sender].add(amount);
    currentBalance = currentBalance.add(amount);
    emit ReceivedFunding(msg.sender, amount, currentBalance);
  }

  function payOut() external returns (bool result) {
    require(msg.sender == creator);

    uint256 totalRaised = currentBalance;
    currentBalance =  0;

    if (cUSDToken.transfer(msg.sender, totalRaised)) {
      emit CreatorPaid(creator);
      return  true;
    }
    else {
      currentBalance = totalRaised;
    }

    return  false;
  }

  function getGroupDetails() public  view  returns
 (
    address payable groupCreator,
    string memory groupTitle,
    string memory groupDescription,
    string memory groupImageLink,
    uint256 groupGoalAmount,
    uint256 currentAmount
  ) {
    groupCreator = creator;
    groupTitle = title;
    groupDescription = description;
    groupImageLink = imageLink;
    groupGoalAmount = goalAmount;
    currentAmount = currentBalance;
  }

}
