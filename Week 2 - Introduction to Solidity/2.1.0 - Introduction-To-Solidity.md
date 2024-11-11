# Introduction to Solidity: Variable Types

Welcome to the **Introduction to Solidity** course! This module will guide you through the **basics of variable types in Solidity**, one of the most essential components of the language.

## Learning Objectives

By the end of this module, you should be able to:

1. Understand the fundamental variable types in Solidity.
2. Know how and when to use different variable types in smart contract development.
3. Write basic Solidity code using various data types.

---

## 1. What is Solidity?

**Solidity** is a high-level programming language designed for writing smart contracts that run on the Ethereum Virtual Machine (EVM). It's syntactically similar to JavaScript, making it easier to learn if you're familiar with web development.

In Solidity, variables are used to store data within a smart contract, and understanding variable types is key to writing efficient and secure code.

---

## 2. Types of Variables in Solidity

Solidity has several types of variables categorized mainly as:

- **Value Types**: Store data directly.
- **Reference Types**: Store data by reference to their memory location.
- **Mapping Types**: Special types that store key-value pairs.

We'll go through each category and explore the most commonly used types within them.

---

### 2.1 Value Types

**Value types** store the data directly within the variable and are typically more efficient to work with in Solidity. Common value types include:

#### 2.1.1 `uint` (Unsigned Integer)

- **Definition**: Stores non-negative whole numbers.
- **Range**: 0 to \(2^{256} - 1\) for `uint256`. Variants like `uint8`, `uint16`, etc., are also available, specifying the bit width (e.g., `uint8` ranges from 0 to 255).
  
**Example**:

```solidity
uint256 myNumber = 100;  // uint256 is the default unsigned integer type
uint8 smallNumber = 25;   // Limited to values 0-255
