#### ⚠️ DISCLAIMER

The artifacts and this tool's execution is completely depend upon the changes committed into `wso2-enterprise/migration-docs` repository. `is-migration-docs-creation-tool` does not synchronously get updated with `wso2-enterprise/migration-docs` changes. It may take at least 5-6 business days.

------------------------------------------------------------------


# is-migration-docs-creation-tool


https://user-images.githubusercontent.com/38750420/215346762-7bacac9d-b4ca-436e-82a9-deeafd136504.mp4



### Prerequisites
1. Valid Personal Access Token from GitHub.
2. `tree` installed in Linux/Windows (WSL) OS. (If you are using darwin based MacOS, usually `tree` is already there. If not use the `brew` command and continue the intstallation.)

   ```
   sudo apt-get install tree
   ```
   ```
   brew install tree
   ```

### Support Matrix
| Source IS Version | Target IS Version |
|-------------------|-------------------|
| 5.7.0 | 5.11.0 |
| 5.8.0 | 5.11.0 |
| 5.9.0 | 5.11.0 |
| 5.10.0 | 5.11.0 |
| 5.7.0 | 6.0.0 |
| 5.8.0 | 6.0.0 |
| 5.9.0 | 6.0.0 |
| 5.10.0 | 6.0.0 |
| 5.11.0 | 6.0.0 |

### Steps to execute is-migration-docs-creation-tool
1. Create a known directory locally and clone the repository into the directory.
```
git clone https://github.com/DInuwan97/is-migration-docs-creation-tool.git
```
2. Browse into `./is-migration-docs-creation-tool/bash-client/` and add required parameters to the `values.config` file as follows.
```config
git_pat=VALID GIT PAT
customer_account_name=ABC-Institute
source_is_version=5.7.0
target_is_version=6.0.0
migration_client_version=1.0.227
```
3. Don't keep any spaces when specifiy a customer's account name. Add `-` sign instead of blank spaces.
4. Keep the other values as it is in the `values.config` file.
5. Execute `sh startup.sh` command.
6. Relevant docs will be created in the `root` directory with follwoing.

     * Customer specific migration docs directory.
     * zip file of above directory.
     * `.log` file with md5sum value for above zipped file.
