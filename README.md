# Neovim Configuration

This repository contains my neovim configuration.

## Quick Start Guide

1. Installing packer.nvim

Install Packer - the neovim package manager using the instructions [here](https://github.com/wbthomason/packer.nvim#:~:text=for%20this%20note)-,Quickstart,-To%20get%20started)

2. Downloading all required packages

Navigate into the `lua/szymon/packer.lua` file, open it in neovim and execute
the following command:
```
:source %
```
This will soruce the packer configuration into your currently running neovim.
After you do this, you can install all packages using:
```
:PackerSync
```
