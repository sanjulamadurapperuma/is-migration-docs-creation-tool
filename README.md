#### ⚠️ DISCLAIMER

The artifacts and this tool's execution is completely depend upon the changes committed into `wso2-enterprise/migration-docs` repository. `is-migration-dcos-creation-tool` is not syncronizly getting updated with `wso2-enterprise/migration-docs` changes. Usually It may take 5-6 business days at least.

------------------------------------------------------------------

# is-migration-docs-generator
##### This repository is exclusive for WSO2 IAM Customer Success Team

### Prerequisites
1. Valid Personal Access Token from GitHub.
2. `tree` installed in Linux/Mac/Windows (WSL) OS.

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
1. Clone the repository.
```
git clone https://github.com/DInuwan97/is-migration-docs-generator.git
```
2. Browse into `./is-migration-docs-generator/bash-client/` and add required parameters to the `values.config` file as follows.
```config
git_pat=<VALID GIT PAT>
customer_account_name=ABC-Institute
source_is_version=5.7.0
target_is_version=6.0.0
migration_cleint_veesion=1.0.227
```
3. Don't keep any spaces when specifiy a customer's account name. Add `-` sign instead of blan spaces.
4. Keep the other values as it is in the `values.config` file.
5. Browse into './is-migration-docs-creation-tool/' and execute `sh startup.sh`
6. Relevant docs will be created in the `root` directory with the follwoing.

     * Customer specific migration docs directory.
     * zip file of above directory.
     * `.log` file with md5sum value for above ziped file.
