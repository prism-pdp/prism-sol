# prism-sol

*prism-sol* is a Solidity project for PRISM, which is a Provable Data Possession (PDP) system.

## Features

- Implements PRISM in Solidity
- Seamless integration with Ethereum-based smart contracts
- Easy setup using Docker and Foundry

## Technologies Used

- [**Solidity**](https://soliditylang.org/): For developing smart contracts
- [**Docker**](https://www.docker.com/): For environment virtualization and management
- [**Foundry**](https://book.getfoundry.sh/): For smart contract development and testing

## Installation

### 1. Install Docker

Follow the [official guide](https://docs.docker.com/get-docker/) to install Docker.

### 2. Clone the repository

```bash
git clone --recursive https://github.com/prism-pdp/prism-sol.git
```

### 3. Build the Docker image

```bash
make build-img
```

## Testing

```bash
make test
```

