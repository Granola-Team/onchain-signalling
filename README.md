<h1 align="center">Mina On-Chain Voting</h1>

<p align="center">
  <b>On-Chain Voting is a protocol developed to govern the Mina Blockchain.</b>
</p>

## Protocol Specifications (WIP)

The On-Chain Voting Protocol is designed to provide community members with a transparent and secure method of participating in the decision-making process for the Mina blockchain. The aim for this protocol is to provide stake holders with the ability to vote on MIPs (Mina Improvement Proposals) in a clear & concise way.

Individual MIPs can be created on Github. ([https://github.com/MinaProtocol/MIPs](https://github.com/MinaProtocol/MIPs))

### Voting on a MIP

To cast a vote on a particular MIP, users must send a transaction to the **themselves** with a specific memo.<br>
The memo field must adhere to the following convention:<br>

**For example:**

```
To vote in favor of 'MIP1', the memo field would be populated with: 'MIP1'
Similarly - if your intent is to vote against 'MIP1', the memo field would contain: 'no MIP1'
```

**The transaction amount must be 0, with the user only paying for the transaction fee.**

### Protocol Flow

This flow chart illustrates the process of voting for a specific MIP on Mina blockchain.<br>
**Documentation will be updated.**

## Development

### Make sure to have the necessary installations and dependencies

- If not installed, install [`pnpm`](https://pnpm.io/)

  ```bash
  brew install pnpm

  # or ...

  curl -fsSL https://get.pnpm.io/install.sh | sh -
  ```

- Set the NodeJS version to be used:

  ```bash
  pnpm env use --global 18
  ```

- If not installed, install 'libpq' (which is required by Diesel). On some
  Linux distros, this is accomplished, for example, by issuing:

  ```bash
  sudo apt-get install libpq-dev
  ```

- If not installed, install [Rust](https://www.rust-lang.org/) - [Cargo-Make](https://github.com/sagiegurari/cargo-make) - [Diesel-CLI](https://crates.io/crates/diesel_cli/2.0.1)

  ```bash
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # install rust
  cargo install --force cargo-make # install cargo-make
  cargo install diesel_cli --no-default-features --features postgres # install diesel-cli

  ```

### Start developing

- Checkout this repository via `git` or the [Github CLI](https://cli.github.com/)

  ```bash
  git clone git@github.com:Granola-Team/mina-on-chain-voting.git

  # or ...

  gh repo clone Granola-Team/mina-on-chain-voting
  ```

- In the new directory, install dependencies

  ```bash
  pnpm clean && pnpm install
  ```

- Make sure your .env file is set-up correctly

  Please see the [`.env.example`](./.env.example) file in the root of the project for more details.

### Building, Linting, and Testing

Linting the Rust code:

```bash
pnpm cargo:audit
pnpm cargo:clippy
```

Lint-and-unit-test the Rust code:

```bash
pnpm cargo:make
```

Lint the front end (web):

```bash
pnpm web ts-lint
```

Test the front end (web):

```bash
pnpm web test
```

Building the front end (web):

```bash
pnpm web build
```

### Running in Docker

Run `docker-compose --profile all up` to mount the cluster, and then run all
pending migrations.

- Make sure the `DATABASE_URL`, the connection URL for the application
  database, and `ARCHIVE_DATABASE_URL`, the connection URL for the archive in
  your .env file correspond to those in Docker, especially if you are changing
  these environment variables.

> **IMPORTANT:**
When running locally, modify the respective variables in the `.env` file to
point to `db` and `server` (the internal Docker host).

### Running in the console

You can run the web-app in console and mount only both the database and the
server in Docker when developing the web app locally.

> **IMPORTANT:** When running this way, the database URL in the `.env` file has to point to `localhost`.</br>
See [`.env.example`](./.env.example) for more information on the `DATABASE_URL` env var.

- Mount the database and server in Docker. The db and backend should be up and running now.

  ```sh
  docker-compose --profile server-db up
  ```

- Run migrations.

  ```sh
  diesel migration run
  ```

- Run the app (frontend) in development mode.

  ```sh
  pnpm web dev
  ```

### Managing the database and migrations

The development database is mounted in Docker and managed via the
[Diesel CLI](https://diesel.rs/guides/getting-started)

- `diesel database reset` — reset the database (**all data will be wiped out!**)

- `diesel database setup` — create the database if it doesn't exist and run all migrations.

- `diesel migration generate [name]` — create a new migration for changes to the schema.

For more commands and options, see [the official docs.](https://crates.io/crates/diesel_cli)

## Resources

- [Next.js Documentation](https://nextjs.org/docs/getting-started)
- [Rust Programming Language](https://doc.rust-lang.org/book/)
- [Typescript](https://www.typescriptlang.org/docs/)

## License

This project is licensed under the Mozilla Public License 2.0. See the [LICENSE](LICENSE) file for the full license text.
