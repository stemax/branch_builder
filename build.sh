#! /bin/sh
clear
buildNumber=1
buildName='Build_'$buildNumber"_$(date +'%Y_%m_%d')"
# Please enter your git PROD/MAIN parent branch name
mainParentBranch="sales-env"

echo "Start a \033[32mnew build\033[0m process now? [y/n]:"
read startBuildProccess

if [ "$startBuildProccess" != "${startBuildProccess#[Yy]}" ]; then
  echo "Ok. Let's start with creating a new build branches..."
  echo "Please enter new \033[33mBuild Number\033[0m:"
  read buildNumber
  echo 'Please enter \033[33mNew branch name\033[0m [Build_'$buildNumber"_$(date +'%Y_%m_%d')]:"
  read buildName
  if [ "$buildName" = "" ]; then
    buildName='Build_'$buildNumber"_$(date +'%Y_%m_%d')"
    echo "Detect that Build name is empty! Set auto:"$buildName
  fi
  echo '-------------------------\033[32m'"$buildName"'\033[0m----------------------------'


  cd ..

  create_build() {
      directoryName=$1
      if [ -d $directoryName ]; then
        echo "Detected directory \033[33m$directoryName\033[0m. Should we start creating a new build here? [y/n]:"
        read startBuild
        if [ "$startBuild" != "${startBuild#[Yy]}" ]; then
          cd $directoryName || null
          currentBranch=$(git rev-parse --abbrev-ref HEAD)
          echo "Current branch for \033[33m$directoryName\033[0m is: \033[33m$currentBranch\033[0m"
          if [ "$(git status -s)" = "" ]; then
                        isStashed=0
                        echo "No changes in the current branch. Nothing to stash."
                      else
                        echo "\033[32mChanges in the current branch will be stashed.\033[0m"
                        git stash save --include-untracked " Stashed changes before build $buildName"
                        isStashed=1
          fi

          echo "Changing to main parent branch: \033[32m$mainParentBranch\033[0m"
            git fetch
            git checkout $mainParentBranch
            git pull --rebase
            git status

          if [ "$(git rev-parse --verify $buildName 2>/dev/null)" ]; then
            echo "Branch \033[33m$buildName\033[0m already exists."
            git checkout $buildName
            else
              echo "Creating new branch: \033[32m$buildName\033[0m from \033[33m$mainParentBranch\033[0m"
              git checkout -b "$buildName"
          fi

            echo "Almost ready for Pushing? So Service: \033[31m$directoryName\033[0m, Build: \033[31m$buildName\033[0m. Start pushing [y/n]:"
            read startPushingBuild
            if [ "$startPushingBuild" != "${startPushingBuild#[Yy]}" ]; then
            echo "Pushing new branch \033[32m$buildName\033[0m to origin!!!"
            git push --set-upstream origin $buildName
            fi
          cd ..
        fi
      else
        ls -la
        echo "\033[31m$directoryName\033[0m not found!"
      fi
      return 1
    }

# List of microservices (directories)
  create_build "monolith-lambda"
  create_build "case-management"
  create_build "hwa-application"
  create_build "hwa-scheduler"
#  create_build "hwa-notifications-manager"

else
  echo '\033[33m Canceled. So, than in another time. Thank you!\033[0m'
fi
