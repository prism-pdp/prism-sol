# prism-sol

## Description

prism-sol is a solidity project for prism.
This project is created from [foundry][link:foundry].

## Tips for developers

### Coding

Solidity source codes should be placed in `src` directory.

### Building

You can build solidity source codes with following command.

```sh
make build
```

This command also generates Go bindings.
The bindings is placed in `go-bindings` directory.

### Testing

Test codes should be placed in `test` directory.
You can run tests with following command.

```sh
make test
```

[link:foundry]: https://book.getfoundry.sh/ "foundry"