# gh-csharp-template

This extension supports the installation and generation of templates for C# gh extension projects.

## Installation

```sh
gh extension install srz-zumix/gh-csharp-template
gh csharp-template install
```

## Create new project

1. gh repo create --public --clone gh-\<your extension name>
1. cd \<clone directory>
1. gh csharp-template new

## Upgrade this extension

```sh
gh extension upgrade srz-zumix/gh-csharp-template
gh csharp-template install --force
```
