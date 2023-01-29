# reading the values from config file
while IFS="=" read -r key value; do
    eval "$key=$value"
done < values.config

# moving back to rrot directory
cd ..

# check if migration-docs from wso2-enterprise already avaialble
if [ -d "migration-docs" ]; then
  echo "migration-docs directory already available"
else
  echo "migration-docs directory is not available....."
   echo "Do you want to clone migration docs from wso2-exterprise ? (Y/N)"
   read cloning_option
    if [ "$cloning_option" = "Y" ]; then
      # clone migration docs from wso2-enterprise
      echo "Accessing wso2-enterprise....."
      git clone "https://$git_pat@github.com/wso2-enterprise/migration-docs.git"
      echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
      echo "---------------------------------------------------------------------Cloning Complted----------------------------------------------------------------------------"
      echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"
    else
      echo "Clone wso2-enterprise manually and perform the docs creation..."
      echo "Use https://github.com/wso2-enterprise/migration-docs"
    fi
fi



if [ -d "migration-docs" ]; then
cd ./is-migration-docs-generator

echo "Customer Account : $customer_account_name"
echo "Source Version   : $source_is_version"
echo "Target Version   : $target_is_version"
# pick the directory name
directory_name="WSO2x$customer_account_name-Identity-Server-Migration-$source_is_version-$target_is_version"

# move back to root
cd ..

if [ -d "$directory_name" ]; then
  echo "Directory already exsists...."
  echo "Migration docs creation gracefully stoped...."
else
# creating the customized migration doc directory
mkdir "WSO2x$customer_account_name-Identity-Server-Migration-$source_is_version-$target_is_version"
echo "Directory created : $directory_name"

rootPath=$PWD
source_directory="$rootPath/migration-docs-main/identity-server/migration-clients"
destination_directory="$rooPath/$directory_name"
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
echo "------------------------------------------------------------------What Has Changed step completed----------------------------------------------------------------"
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
elif [ "$target_is_version" = "6.0.0" ]
then
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-6.0.0/prepare-for-migration.md" "$PWD"
 cp -f "$migration_docs_is_versions_wso2_enterprise/is-6.0.0/migration-process.md" "$PWD"
else
 echo "2-Migration Process : Target Version $target_is_version not supported"
fi

echo "-----------------------------------------------------------------Migration Process step completed----------------------------------------------------------------"
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

echo "-------------------------------------------------------------------Migration Docs step completed-----------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------"

cd ./../../../


#########################
#########################
# Gracefully shuting down
echo "Docs creation sucessfully completed."
echo "Current directory : $PWD"
# tree diagram of created migration doc directory
tree -a
fi

# In user input was no, to clone the wso2-enterprise/migration-docs
else
  echo "WSO2 Identity Server Docs creation has forced shiutdown for $customer_account_name"
  echo "Mannulay clone the wso2-enterprise/migration-docs and perform the docs creation again."
fi
