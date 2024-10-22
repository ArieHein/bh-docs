# bh-docs

The idea behind this project is to use a platform that uses git repo as the source of all content documentation creation.
Splitting the authoring and publishing process into two separate steps.

Authoring is done via markdown files and then published via a CI/CD pipeline to multiple target locations.

## Getting Started

The main folders in this project consist of:

| Folder or File | Description |
| --- | --- |
| config/config.json | Contains the main configuration file for the platform and general target location configurations. |
| private | Contains the content that should be private to the team managing the documentation. |
| private/assets | Contains all the images referenced from the markdown. |
| private/docs.include | Contains the names of the files that should be published to private target locations. This allows a *draft* feature where commits do not get published until the file is included. Filenames removed from this file, will be unpublished. |
| private/config.json | Contains specific configuration for the private target location. |
| public | Contains the content that should be public to the users of this platform. |
| scripts | Contains the scripts used in the pipelines to publish the content to the target locations. |
| tests | Contains the tests for the scripts used in the pipelines. |
| README.md | This file. |
