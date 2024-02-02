# Install rustup and cargo-lambda

``` shell
curl https://sh.rustup.rs -sSf | sh
brew tap cargo-lambda/cargo-lambda
brew install cargo-lambda
```

Create the Rust package

``` shell
cd lambda
cargo lambda new --http rust
cargo add serde

```

Edit the lambda per instructions
[LogRocket example](https://blog.logrocket.com/deploy-lambda-functions-rust/)

Debug the lambda

``` shell
cargo lambda watch
```

Build the exe

```
cargo lambda build
ls -la target/lambda/hello/bootstrap
```
