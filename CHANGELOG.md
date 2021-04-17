# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2021-04-17

- Correct issue with HAML page title being misaligned
- Avoid deprecation errors when pulling the application name when using Rails > 6.0 vs earlier versions
- Added logic for pulling the `app_name` into a helper to prevent duplicate logic within all the layout templates
- Minor version bump

## 2020-01-23

- Minor cleanup on ruby files (rubocop errors)
- Cleanup gemspec and added metadata so rubygems will display links for them on the gempage