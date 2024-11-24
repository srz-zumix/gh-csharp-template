# Development

## Develop

To develop this project, follow these steps:

* Clone the repository

```sh
git clone <repository-url>
cd <repository-directory>
```

* Create extension commands

Edit the source files in the GhCSharpExtension.Command directory. The main entry point is in Program.cs.

We are using [Cocona][] as the framework for the console application.
Refer to the [Cocona][] documentation for instructions on how to implement the command.

* Run tests

To run the tests, use the following command:

```sh
dotnet test
```

* Commit and push changes

```sh
git add .
git commit -m "Your commit message"
git push origin <branch-name>
```

* Create a pull request

Open a pull request on GitHub to merge your changes into the main branch.

Please label the pull request. [Release drafter](./.github/release-drafter.yml) will create a draft release based on the labels.

## Release

Please manually trigger the [Release drafter workflow](../../actions/workflows/release-drafter.yml). A release will be created shortly.

[Cocona]:https://github.com/mayuki/Cocona
