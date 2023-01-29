@echo off

REM UNKNOWN: {"type":"While","clause":{"type":"CompoundList","commands":[{"type":"Command","name":{"text":"read","type":"Word"},"prefix":[{"text":"IFS==","type":"AssignmentWord"}],"suffix":[{"text":"-r","type":"Word"},{"text":"key","type":"Word"},{"text":"value","type":"Word"}]}]},"do":{"type":"CompoundList","commands":[{"type":"Command","name":{"text":"eval","type":"Word"},"suffix":[{"text":"\"$key=$value\"","expansion":[{"loc":{"start":1,"end":4},"parameter":"key","type":"ParameterExpansion"},{"loc":{"start":6,"end":11},"parameter":"value","type":"ParameterExpansion"}],"type":"Word"}]}]},"redirections":[{"type":"Redirect","op":{"text":"<","type":"less"},"file":{"text":"values.config","type":"Word"}}]}
IF "%source_is_version%" "=" "5.7.0" "]" || [ "%source_is_version%" "=" "5.8.0" "]" || [ "%source_is_version%" "=" "5.9.0" "]" || [ "%source_is_version%" "=" "5.10.0" "]" || [ "%source_is_version%" "=" "5.11.0" (
  IF "%target_is_version%" "=" "5.11.0" "]" || [ "%target_is_version%" "=" "6.0.0" (
    IF "%source_is_version%" "=" "%target_is_version%" (
      echo "Source and Target versions shoul not be same."
    ) ELSE (
      cd ".."
      IF "-d" "migration-docs" (
        echo "migration-docs directory already available"
      ) ELSE (
        echo "migration-docs directory is not available....."
        echo "Do you want to clone migration docs from wso2-exterprise ? (Y/N)"
        read "cloning_option"
        IF "%cloning_option%" "=" "Y" (
          echo "Accessing wso2-enterprise....."
          git "clone" "https://%git_pat%@github.com/wso2-enterprise/migration-docs.git"
          echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
          echo "---------------------------------------------------------------------Cloning Complted----------------------------------------------------------------------------"
          echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
        ) ELSE (
          echo "Clone wso2-enterprise manually and perform the docs creation..."
          echo "Use https://github.com/wso2-enterprise/migration-docs"
        )
      )
      IF "-d" "migration-docs" (
        cd "%CD%\is-migration-docs-generator"
        echo "Customer Account : %customer_account_name%"
        echo "Source Version   : %source_is_version%"
        echo "Target Version   : %target_is_version%"
        SET %target_is_version%directory_name="WSO2x%customer_account_name%-Identity-Server-Migration-%source_is_version%-%target_is_version%"
        SET %target_is_version%%customer_account_name%%source_is_version%%target_is_version%directory_to_be_named="[WSO2 x %customer_account_name%] Identity Server Migration from %source_is_version% to %target_is_version%"
        SET %target_is_version%%customer_account_name%%source_is_version%%target_is_version%%customer_account_name%%source_is_version%%target_is_version%zip_file_to_be_name="%renamed_directory%.zip"
        cd ".."
        IF "-d" "%directory_name%" (
          echo "Directory already exsists...."
          echo "Migration docs creation gracefully stoped...."
        ) ELSE (
          IF "-d" "%directory_to_be_named%" (
            echo "Directory already exsists...."
            echo "Migration docs creation gracefully stoped...."
          ) ELSE (
            mkdir "WSO2x%customer_account_name%-Identity-Server-Migration-%source_is_version%-%target_is_version%"
            echo "Directory created : %directory_name%"
            SET %directory_name%rootPath=%PWD%
            SET %directory_name%%PWD%source_directory="%rootPath%/migration-docs-main/identity-server/migration-clients"
            SET %directory_name%%PWD%%rootPath%destination_directory="%rooPath%/%directory_name%"
            cd "%directory_name%"
            mkdir "migration-client"
            COPY  "%migration_cleint_path%/wso2is-migration-%migration_cleint_veesion%.zip" "%PWD%/migration-client"
            mkdir "migration-docs"
            cd "migration-docs"
            mkdir "1-What-has-changed"
            mkdir "2-Migration-process"
            mkdir "3-Migration-docs"
            cd "1-What-has-changed"





            IF "%source_is_version%" "=" "5.7.0" (
              CALL :migrating_what_has_changed_57_to_58
              CALL :migrating_what_has_changed_58_to_59
              CALL :migrating_what_has_changed_59_to_510
              IF "%target_is_version%" "=" "6.0.0" (
                CALL :migrating_what_has_changed_510_to_511
                CALL :migrating_what_has_changed_511_to_600
              ) ELSE (
                CALL :migrating_what_has_changed_510_to_511
              )
            ) ELSE (
              IF "%source_is_version%" "=" "5.8.0" (
                CALL :migrating_what_has_changed_58_to_59
                CALL :migrating_what_has_changed_59_to_510
                IF "%target_is_version%" "=" "6.0.0" (
                  CALL :migrating_what_has_changed_510_to_511
                  CALL :migrating_what_has_changed_511_to_600
                ) ELSE (
                  CALL :migrating_what_has_changed_510_to_511
                )
              ) ELSE (
                IF "%source_is_version%" "=" "5.9.0" (
                  CALL :migrating_what_has_changed_59_to_510
                  IF "%target_is_version%" "=" "6.0.0" (
                    CALL :migrating_what_has_changed_510_to_511
                    CALL :migrating_what_has_changed_511_to_600
                  ) ELSE (
                    CALL :migrating_what_has_changed_510_to_511
                  )
                ) ELSE (
                  IF "%source_is_version%" "=" "5.10.0" (
                    IF "%target_is_version%" "=" "6.0.0" (
                      CALL :migrating_what_has_changed_510_to_511
                      CALL :migrating_what_has_changed_511_to_600
                    ) ELSE (
                      CALL :migrating_what_has_changed_510_to_511
                    )
                  ) ELSE (
                    IF "%source_is_version%" "=" "5.11.0" (
                      IF "%target_is_version%" "=" "6.0.0" (
                        CALL :migrating_what_has_changed_511_to_600
                      ) ELSE (
                        echo "Target Version %target_is_version% not supported"
                      )
                    ) ELSE (
                      echo "Source Version %source_is_version% not supported"
                    )
                  )
                )
              )
            )
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
            echo "------------------------------------------------------------------What Has Changed step completed----------------------------------------------------------------"
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
            cd ".."
            cd "2-Migration-process"
            mkdir "%target_is_version%"
            cd "%target_is_version%"
            mkdir "db-scripts"
            cd "db-scripts"
            mkdir "prepare-for-migration"
            cd "prepare-for-migration"
            COPY  "%version_cleaning_scripts_path%" "%PWD%"
            cd "./../../"
            IF "%target_is_version%" "=" "5.11.0" (
              COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.11.0/migrating-preparing-for-migration.md" "%PWD%"
              COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.11.0/migration-process.md" "%PWD%"
              COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.11.0/migrating-userstore-managers.md" "%PWD%"
              IF "%source_is_version%" "=" "5.7.0" "]" || [ "%source_is_version%" "=" "5.8.0" "]" || [ "%source_is_version%" "=" "5.9.0" (
                COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.10.0/migrating-to-log4j2.md" "%PWD%"
              ) ELSE (
                echo "Source IS version : %source_is_version%. Log4j2 Migration steps not required."
              )
            ) ELSE (
              IF "%target_is_version%" "=" "6.0.0" (
                COPY  "%migration_docs_is_versions_wso2_enterprise%/is-6.0.0/prepare-for-migration.md" "%PWD%"
                COPY  "%migration_docs_is_versions_wso2_enterprise%/is-6.0.0/migration-process.md" "%PWD%"
                IF "%source_is_version%" "=" "5.7.0" "]" || [ "%source_is_version%" "=" "5.8.0" "]" || [ "%source_is_version%" "=" "5.9.0" (
                  COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.10.0/migrating-to-log4j2.md" "%PWD%"
                ) ELSE (
                  echo "Source IS version : %source_is_version%. Log4j2 Migration steps not required."
                )
              ) ELSE (
                echo "2-Migration Process : Target Version %target_is_version% not supported"
              )
            )
            echo "-----------------------------------------------------------------Migration Process step completed----------------------------------------------------------------"
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
            cd "./../../"
            cd "3-Migration-docs"
            mkdir "%target_is_version%"
            cd "%target_is_version%"
            IF "%target_is_version%" "=" "5.11.0" (
              COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.11.0/migrating-to-5110.md" "%PWD%"
            ) ELSE (
              IF "%target_is_version%" "=" "6.0.0" (
                COPY  "%migration_docs_is_versions_wso2_enterprise%/is-6.0.0/migrate-to-600.md" "%PWD%"
              ) ELSE (
                echo "3-Migration-docs : Target Version %target_is_version% not supported"
              )
            )
            echo "-------------------------------------------------------------------Migration Docs step completed-----------------------------------------------------------------"
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
            cd "./../../../"
            echo "Docs creation sucessfully completed."
            touch "README.md"
            echo "READMME created."
            echo "## [WSO2 x %customer_account_name%] Identity Server Migration from %source_is_version% to %target_is_version%" REM UNKNOWN: {"type":"Redirect","op":{"text":">>","type":"dgreat"},"file":{"text":"README.md","type":"Word"}}
            SET current_time_gmt=%undefined%
            echo "\n #### Created at : %current_time_gmt% GMT" REM UNKNOWN: {"type":"Redirect","op":{"text":">>","type":"dgreat"},"file":{"text":"README.md","type":"Word"}}
            echo "
             ```" REM UNKNOWN: {"type":"Redirect","op":{"text":">>","type":"dgreat"},"file":{"text":"README.md","type":"Word"}}
            tree "-a" REM UNKNOWN: {"type":"Redirect","op":{"text":">>","type":"dgreat"},"file":{"text":"README.md","type":"Word"}}
            echo "```" REM UNKNOWN: {"type":"Redirect","op":{"text":">>","type":"dgreat"},"file":{"text":"README.md","type":"Word"}}
            echo "README content updated."
            SET renamed_directory="[WSO2 x %customer_account_name%] Identity Server Migration from %source_is_version% to %target_is_version%"
            echo "%renamed_directory%"
            tree "-a"
            cd ".."
            mv "%directory_name%" "%renamed_directory%"
            echo "Directory renamed as : %renamed_directory%"
            SET %renamed_directory%zip_file_name="%renamed_directory%.zip"
            IF "-d" "%zip_file_name%" (
              echo "Zip file is already there."
            ) ELSE (
              zip "-r" "%zip_file_name%" "%renamed_directory%"
              echo "File zipped successfully."
              echo "%zip_file_name%"
              touch "%zip_file_name%.log"
              md5sum "%zip_file_name%" REM UNKNOWN: {"type":"Redirect","op":{"text":">>","type":"dgreat"},"file":{"text":"\"$zip_file_name.log\"","expansion":[{"loc":{"start":1,"end":14},"parameter":"zip_file_name","type":"ParameterExpansion"}],"type":"Word"}}
              echo "md5sum value taken for the zip"
              echo "%zip_file_name%.log"
            )
          )
        )
      ) ELSE (
        echo "WSO2 Identity Server Docs creation has forced shiutdown for %customer_account_name%"
        echo "Mannulay clone the wso2-enterprise/migration-docs and perform the docs creation again."
      )
    )
  ) ELSE (
    echo "%target_is_version% is unsupported target version via migration-docs tool."
  )
) ELSE (
  echo "%source_is_version% is unsupported source version via migration-docs tool."
)

EXIT /B %ERRORLEVEL%

:migrating_what_has_changed_57_to_58
mkdir "5.7.0-to-5.8.0"
cd "5.7.0-to-5.8.0"
COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.8.0/understanding-what-has-changed.md" "%PWD%"
cd ".."
EXIT /B 0

:migrating_what_has_changed_58_to_59
mkdir "5.8.0-to-5.9.0"
cd "5.8.0-to-5.9.0"
COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.9.0/migrating-what-has-changed.md" "%PWD%"
cd ".."
EXIT /B 0

:migrating_what_has_changed_59_to_510
mkdir "5.9.0-to-5.10.0"
cd "5.9.0-to-5.10.0"
COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.10.0/migrating-what-has-changed.md" "%PWD%"
cd ".."
EXIT /B 0

:migrating_what_has_changed_510_to_511
mkdir "5.10.0-to-5.11.0"
cd "5.10.0-to-5.11.0"
COPY  "%migration_docs_is_versions_wso2_enterprise%/is-5.11.0/migrating-what-has-changed.md" "%PWD%"
cd ".."
EXIT /B 0

:migrating_what_has_changed_511_to_600
mkdir "5.11.0-to-6.0.0"
cd "5.11.0-to-6.0.0"
COPY  "%migration_docs_is_versions_wso2_enterprise%/is-6.0.0/what-has-changed.md" "%PWD%"
cd ".."
EXIT /B 0