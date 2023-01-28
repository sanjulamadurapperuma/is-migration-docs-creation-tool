# reading the values from config file
while IFS="=" read -r key value; do
    eval "$key=$value"
done < values.config

echo "Customer Account : $customer_account_name" 
echo "Source Version   : $source_is_version"
echo "Target Version   : $target_is_version"
# pick the directory name
directory_name="WSO2x$customer_account_name-Identity-Server-Migration-$source_is_version-$target_is_version"

# move back to root
cd ..
# creating the customized migration doc directory
mkdir "WSO2x$customer_account_name-Identity-Server-Migration-$source_is_version-$target_is_version"
echo "Directory created : $directory_name"

rootPath=$PWD
echo "root path $rootPath"
source_directory="$rootPath/migration-docs-main/identity-server/migration-clients"
echo "source directory : $source_directory"
destination_directory="$rooPath/$directory_name"
echo "destination directory : $destination_directory"
cd "$directory_name"
mkdir "migration-client"


#cp "./../migration-docs-main/identity-server/migration-clients/wso2is-migration-1.0.225.zip" "~/Desktop/IAM-Migration/Migration-Docs/WSO2xMobitel-Identity-Server-Migration-5.7.0-6.1.0/migration-client"
#cp "./../migration-docs-main/identity-server/migration-clients/wso2is-migration-1.0.225.zip" "~/Desktop/IAM-Migration/Migration-Docs/WSO2xMobitel-Identity-Server-Migration-5.7.0-6.1.0/"

#copy and paster migration clirnt zip
cp -f "./../migration-docs-main/identity-server/migration-clients/wso2is-migration-$migration_cleint_veesion.zip" "$PWD/migration-client"

mkdir "migration-docs"
cd "migration-docs"

mkdir "1-What-has-changed"
mkdir "2-Migration-process"
mkdir "3-Migration-docs"

cd "1-What-has-changed"


echo "current directroy : $PWD"


if [ "$source_is_version" = "5.7.0" ]
then
  mkdir "5.7.0-to-5.8.0"
  cd "5.7.0-to-5.8.0"
  cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.8.0/understanding-what-has-changed.md.md" "$PWD"
  cd ..

  mkdir "5.8.0-to-5.9.0"
  cd "5.8.0-to-5.9.0"
  cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.9.0/migrating-what-has-changed.md" "$PWD"
  cd ..

  mkdir "5.9.0-to-5.10.0"
  cd "5.9.0-to-5.10.0"
  cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.10.0/migrating-what-has-changed.md" "$PWD"
  cd ..

    if [ "$target_is_version" = "6.0.0" ]
    then
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..

      mkdir "5.11.0-to-6.0.0"
      cd "5.11.0-to-6.0.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/what-has-changed.md" "$PWD"
      cd ..
    else
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..
    fi
elif [ "$source_is_version" = "5.8.0" ]
then
  mkdir "5.8.0-to-5.9.0"
  cd "5.8.0-to-5.9.0"
  cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.9.0/migrating-what-has-changed.md" "$PWD"
  cd ..

  mkdir "5.9.0-to-5.10.0"
  cd "5.9.0-to-5.10.0"
  cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.10.0/migrating-what-has-changed.md" "$PWD"
  cd ..
    if [ "$target_is_version" = "6.0.0" ]
    then
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..

      mkdir "5.11.0-to-6.0.0"
      cd "5.11.0-to-6.0.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/what-has-changed.md" "$PWD"
      cd ..
    else
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..
    fi
elif [ "$source_is_version" = "5.9.0" ]
then
  mkdir "5.9.0-to-5.10.0"
  cd "5.9.0-to-5.10.0"
  cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.10.0/migrating-what-has-changed.md" "$PWD"
  cd ..
    if [ "$target_is_version" = "6.0.0" ]
    then
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..

      mkdir "5.11.0-to-6.0.0"
      cd "5.11.0-to-6.0.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/what-has-changed.md" "$PWD"
      cd ..
    else
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..
    fi
elif [ "$source_is_version" = "5.10.0" ]
then
  if [ "$target_is_version" = "6.0.0" ]
  then
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..

      mkdir "5.11.0-to-6.0.0"
      cd "5.11.0-to-6.0.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/what-has-changed.md" "$PWD"
      cd ..
    else
      mkdir "5.10.0-to-5.11.0"
      cd "5.10.0-to-5.11.0"
      cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-what-has-changed.md" "$PWD"
      cd ..
    fi
elif [ "$source_is_version" = "5.11.0" ]
then
  if [ "$target_is_version" = "6.0.0" ]
  then
    mkdir "5.11.0-to-6.0.0"
    cd "5.11.0-to-6.0.0"
    cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/what-has-changed.md" "$PWD"
    cd ..
  else
    echo "Target Version $target_is_version not supported"
  fi
else
 echo "Source Version $source_is_version not supported"
fi

# exit from what-has-changed directory
cd ..

# moving into migration-process directory
cd "2-Migration-process"

echo "2-Migration-process : current directroy : $PWD"
mkdir "$target_is_version"

# moving into migration-process/target-is-version directory
cd "$target_is_version"

mkdir "db-scripts"
cd "db-scripts"
mkdir "prepare-for-migration"
cd "prepare-for-migration"

# copying version cleaning scripts
cp -a "./../../../../../../migration-docs-main/identity-server/migration-docs/is-5.10.0/migrating-preparing-for-migration/." "$PWD"

# moving back from is-5.10.0/migrating-preparing-for-migration/
cd ./../../
echo "$PWD"

if [ "$target_is_version" = "5.11.0" ]
then
 cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-preparing-for-migration.md" "$PWD"
 cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migration-process.md" "$PWD"
elif [ "$target_is_version" = "6.0.0" ]
then
 cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/prepare-for-migration.md" "$PWD"
 cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/migration-process.md" "$PWD"
else
 echo "2-Migration Process : Target Version $target_is_version not supported"
fi

# moving back from /2-Migration-process/6.0.0
cd ./../../

cd "3-Migration-docs"
mkdir "$target_is_version"
cd "$target_is_version"

if [ "$target_is_version" = "5.11.0" ]
then
 cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-5.11.0/migrating-to-5110.md" "$PWD"
elif [ "$target_is_version" = "6.0.0" ]
then
 cp -f "./../../../../migration-docs-main/identity-server/migration-docs/is-6.0.0/migrate-to-600.md" "$PWD"
else
 echo "3-Migration-docs : Target Version $target_is_version not supported"
fi

echo "$PWD"

cd ./../../../
echo "$PWD"
