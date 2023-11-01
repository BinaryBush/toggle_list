# toggle_list

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.1] - 2023-11-01
### Fixed
- Bug where initially expanded item would only shrunk on second tap
### Changed
- Bump version of flutter_lints to 3.0.0 
- SDK upper constraint to accept 3.x versions
- Example app according to the relevant changes


## [0.3.0] - 2023-03-24
### Added
- Divider property of ToggleListItem
### Fixed
- Unnecessary null checks on PageStorage class
### Changed
- Text types of TextTheme according to Material3 guidelines introduced in Flutter 3.7
- Bump the example app's Gradle version from 6.7 to 7.3.3


## [0.2.1] - 2022-05-20
### Fixed
- Replace deprecated property of Scrollbar 
### Changed
- Bump version of scroll_to_index to 3.0.1 


## [0.2.0] - 2022-02-25
### Added
- innerPadding property of ToggleList 
- expandedTitle property of ToggleListItem
### Changed
- **Breaking** Add a second, index parameter to the onExpansionChanged callback of the ToggleListItem
- Example app according to the relevant changes
- Bump the example app's Kotlin version from 1.3.50 to 1.6.10
### Fixed
- Bug where ToggleListItems would close unwantedly when scrolled far enough from them
- Typos in documentation, README.md and CHANGELOG.md


## [0.1.0] - 2022-01-26
### Added
- Core functionality to ToggleList class
- Core functionality to ToggleListItem class
- Documentation of ToggleList class
- Documentation of ToggleListItem class
- Documentation of ToggleListController class
- Documentation of Section enum
- Example app
