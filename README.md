# prism-sol

*prism-sol* is a Solidity project for PRISM, which is a Provable Data Possession (PDP) system.

## Features

- Implements PRISM in Solidity
- Seamless integration with Ethereum-based smart contracts
- Easy setup using Docker and Foundry

## Technologies Used

- <a href="https://soliditylang.org/" target="_blank">**Solidity**</a>: For developing smart contracts
- <a href="https://www.docker.com/" target="_blank">**Docker**</a>: For environment virtualization and management
- <a href="https://book.getfoundry.sh/">**Foundry**</a>: For smart contract development and testing

## Installation

### 1. Install Docker

Follow the <a href="https://docs.docker.com/get-docker/">official guide</a> to install Docker.

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

