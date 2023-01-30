# reading the values from config file
while IFS="=" read -r key value; do
    eval "$key=$value"
done < values.config


if [ "$source_is_version" = "5.7.0" ] || [ "$source_is_version" = "5.8.0" ] || [ "$source_is_version" = "5.9.0" ] || [ "$source_is_version" = "5.10.0" ] || [ "$source_is_version" = "5.11.0" ]
then
 if [ "$target_is_version" = "5.11.0" ] || [ "$target_is_version" = "6.0.0" ]
 then
  if [ "$source_is_version" = "$target_is_version" ]
  then
   echo "Source and Target versions should not be same."
  else

# moving back to root directory
cd ./../../

# check if migration-docs from wso2-enterprise already avaialble
if [ -d "migration-docs" ]; then
  echo "migration-docs directory already available"
else
  echo "migration-docs directory is not available....."
   echo "Do you want to clone migration docs from wso2-exterprise ? (Y/N) || (y/n)"
   read cloning_option
    if [ "$cloning_option" = "Y" ] || [ "$cloning_option" = "y" ]
    then
      # clone migration docs from wso2-enterprise
      echo "Accessing wso2-enterprise....."
      git clone "https://$git_pat@github.com/wso2-enterprise/migration-docs.git"
        if [ -d "migration-docs" ]; then
          echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
          echo "---------------------------------------------------------------------Cloning Completed----------------------------------------------------------------------------"
          echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
        else
          echo "Unauthorized access to access wso2-enterprise"
        fi

    else
      echo "Clone wso2-enterprise manually and perform the docs creation..."
      echo "Use https://github.com/wso2-enterprise/migration-docs"
    fi
fi



if [ -d "migration-docs" ]; then
cd ./is-migration-docs-creation-tool/bash-client

echo "Customer Account : $customer_account_name"
echo "Source Version   : $source_is_version"
echo "Target Version   : $target_is_version"
# pick the directory name
directory_name="WSO2x$customer_account_name-Identity-Server-Migration-$source_is_version-$target_is_version"
directory_to_be_named="[WSO2 x $customer_account_name] Identity Server Migration from $source_is_version to $target_is_version"
zip_file_to_be_name="$renamed_directory.zip"
# move back to root
cd ./../../

if [ -d "$directory_name" ]; then
  echo "Directory already exists...."
  echo "Migration docs creation gracefully stopped...."
else

if [ -d "$directory_to_be_named" ]; then
  echo "Directory already exists...."
  echo "Migration docs creation gracefully stopped...."
else


# creating the customized migration doc directory
mkdir "WSO2x$customer_account_name-Identity-Server-Migration-$source_is_version-$target_is_version"
echo "Directory created : $directory_name"

cd "$directory_name"
mkdir "migration-client"


#copy and paster migration clirnt zip
cp -f "$migration_cleint_path/wso2is-migration-$migration_cleint_veesion.zip" "$PWD/migration-client"

mkdir "migration-docs"
cd "migration-docs"

# creating sub directories of migration-docs directory
mkdir "1-What-has-changed"
mkdir "2-Migration-process"
mkdir "3-Migration-docs"



################################
################################
# moving into 1-What-has-changed
cd "1-What-has-changed"

# declared functions for what-has-changed process
migrating_what_has_changed_57_to_58 () {
  mkdir "5.7.0-to-5.8.0"
  cd "5.7.0-to-5.8.0"
  cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.8.0/understanding-what-has-changed.md" "$PWD"
  cd ..
}

migrating_what_has_changed_58_to_59 () {
  mkdir "5.8.0-to-5.9.0"
  cd "5.8.0-to-5.9.0"
  cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.9.0/migrating-what-has-changed.md" "$PWD"
  cd ..
}

migrating_what_has_changed_59_to_510 () {
  mkdir "5.9.0-to-5.10.0"
  cd "5.9.0-to-5.10.0"
  cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.10.0/migrating-what-has-changed.md" "$PWD"
  cd ..
}

migrating_what_has_changed_510_to_511 () {
  mkdir "5.10.0-to-5.11.0"
  cd "5.10.0-to-5.11.0"
  cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.11.0/migrating-what-has-changed.md" "$PWD"
  cd ..
}

migrating_what_has_changed_511_to_600 () {
  mkdir "5.11.0-to-6.0.0"
  cd "5.11.0-to-6.0.0"
  cp -f "$migration_docs_is_versions_wso2_enterprise/is-6.0.0/what-has-changed.md" "$PWD"
  cd ..
}


if [ "$source_is_version" = "5.7.0" ]
then
  migrating_what_has_changed_57_to_58
  migrating_what_has_changed_58_to_59
  migrating_what_has_changed_59_to_510
    if [ "$target_is_version" = "6.0.0" ]
    then
      migrating_what_has_changed_510_to_511
      migrating_what_has_changed_511_to_600
    else
      migrating_what_has_changed_510_to_511
    fi
elif [ "$source_is_version" = "5.8.0" ]
then
  migrating_what_has_changed_58_to_59
  migrating_what_has_changed_59_to_510
    if [ "$target_is_version" = "6.0.0" ]
    then
      migrating_what_has_changed_510_to_511
      migrating_what_has_changed_511_to_600
    else
      migrating_what_has_changed_510_to_511
    fi
elif [ "$source_is_version" = "5.9.0" ]
then
  migrating_what_has_changed_59_to_510
    if [ "$target_is_version" = "6.0.0" ]
    then
      migrating_what_has_changed_510_to_511
      migrating_what_has_changed_511_to_600
    else
      migrating_what_has_changed_510_to_511
    fi
elif [ "$source_is_version" = "5.10.0" ]
then
  if [ "$target_is_version" = "6.0.0" ]
  then
    migrating_what_has_changed_510_to_511
    migrating_what_has_changed_511_to_600
  else
    migrating_what_has_changed_510_to_511
  fi
elif [ "$source_is_version" = "5.11.0" ]
then
  if [ "$target_is_version" = "6.0.0" ]
  then
    migrating_what_has_changed_511_to_600
  else
    echo "Target Version $target_is_version not supported"
  fi
else
 echo "Source Version $source_is_version not supported"
fi

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------"What Has Changed" step completed----------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"

# exit from what-has-changed directory
cd ..


###########################################
###########################################
# moving into 2-Migration-process directory
cd "2-Migration-process"

mkdir "$target_is_version"
# moving into migration-process/target-is-version directory
cd "$target_is_version"

mkdir "db-scripts"
cd "db-scripts"
mkdir "prepare-for-migration"
cd "prepare-for-migration"
# copying version cleaning scripts
cp -a "$version_cleaning_scripts_path" "$PWD"
# moving back from is-5.10.0/migrating-preparing-for-migration/
cd ./../../

if [ "$target_is_version" = "5.11.0" ]
then
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.11.0/migrating-preparing-for-migration.md" "$PWD"
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.11.0/migration-process.md" "$PWD"
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.11.0/migrating-userstore-managers.md" "$PWD"
  if [ "$source_is_version" = "5.7.0" ] || [ "$source_is_version" = "5.8.0" ] || [ "$source_is_version" = "5.9.0" ]
  then
   cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.10.0/migrating-to-log4j2.md" "$PWD"
  else
   echo "Source IS version : $source_is_version. Log4j2 Migration steps not required."
  fi
elif [ "$target_is_version" = "6.0.0" ]
then
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-6.0.0/prepare-for-migration.md" "$PWD"
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-6.0.0/migration-process.md" "$PWD"
   if [ "$source_is_version" = "5.7.0" ] || [ "$source_is_version" = "5.8.0" ] || [ "$source_is_version" = "5.9.0" ]
  then
   cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.10.0/migrating-to-log4j2.md" "$PWD"
  else
   echo "Source IS version : $source_is_version. Log4j2 Migration steps not required."
  fi
else
 echo "2-Migration Process : Target Version $target_is_version not supported."
fi

echo "-----------------------------------------------------------------"Migration Process" step completed----------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"

# moving back from /2-Migration-process/6.0.0
cd ./../../


########################################
########################################
# moving into 3-Migration-docs directory
cd "3-Migration-docs"
mkdir "$target_is_version"
cd "$target_is_version"

if [ "$target_is_version" = "5.11.0" ]
then
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-5.11.0/migrating-to-5110.md" "$PWD"
elif [ "$target_is_version" = "6.0.0" ]
then
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-6.0.0/migrate-to-600.md" "$PWD"
else
 echo "3-Migration-docs : Target Version $target_is_version not supported"
fi

echo "-------------------------------------------------------------------"Migration Docs" step completed-----------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"

cd ./../../../


#########################
#########################
# Gracefully shuting down
echo "Migration Docs creation sucessfully completed."

# readme file creation
touch README.md
echo "READMME created."
echo "## [WSO2 x $customer_account_name] Identity Server Migration from $source_is_version to $target_is_version" >> README.md
current_time_gmt=$(date -u +"%Y-%m-%d %H:%M:%S")
echo "\n #### Created at : $current_time_gmt GMT" >> README.md
echo '\n ```' >> README.md
tree -a >> README.md
echo '```' >> README.md
echo "README content updated."


renamed_directory="[WSO2 x $customer_account_name] Identity Server Migration from $source_is_version to $target_is_version"
echo "$renamed_directory"

# tree diagram of created migration docs directory
tree -a

cd ..

# Rename the directory
mv "$directory_name" "$renamed_directory"
echo "Directory renamed as : $renamed_directory"

# zipping the created migration Docs
zip_file_name="$renamed_directory.zip"

if [ -d "$zip_file_name" ]; then
  echo 'Zip file is already present.'
else
  zip -r "$zip_file_name" "$renamed_directory"
  echo 'Files zipped successfully.'
  echo "$zip_file_name"

  # observing md5sum
  touch "$zip_file_name.log"
  md5sum "$zip_file_name" >> "$zip_file_name.log"

  echo "md5sum value taken for the zip file."
  echo "$zip_file_name.log"
fi

# EOIF of the initial check of directory name
fi
# EOIF of the initial check of directory name, suppose to rename
fi

# In user input was no, to clone the wso2-enterprise/migration-docs
else
  echo "WSO2 Identity Server Docs creation has been forced shutdown for $customer_account_name"
  echo "Manually clone the wso2-enterprise/migration-docs and perform the docs creation again."
fi


# EOIF of comparing to taregt with source
fi
  else
    echo "$target_is_version is unsupported target version via migration-docs tool."
  fi
else
 echo "$source_is_version is unsupported source version via migration-docs tool."
fi
