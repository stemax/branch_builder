# branch_builder - One release -> many microservices.
Bash script for preparation before BUILD for more that one microservices

## The script is designed to automate the process of creating new build branches for different microservices. 

It prompts the user to start a new build process and asks for a build number and name. 
It then checks for existing directories corresponding to different microservices and prompts the user to create a new build branch for each microservice listed. 
The script checks for changes in the current branch, stashes them if necessary, switches to the main parent branch specified by the user, creates a new build branch based on the input build number and name, and pushes the new branch to the remote repository if instructed to do so.

To use the script, follow these steps:
1. Clone the repository containing the script(Or just download build.sh).
2. Move to parent folder **build.sh** (and make sure you have bash installed on your system).
3. **Edit build.sh** and **Set configuration** for your system:
   The script prompts the user to start a new build process by entering a build number and branch name.

   FIRST SET: The **`mainParentBranch`** is set to "production" <- **this parameter is your initial(parent/main) branch!**

   https://github.com/stemax/branch_builder/blob/1a3307476bee19a13992cc5e64179dddc0642bd2/build.sh#L7
   
The script then defines a function create_build that takes a directory name as an argument. It checks if the directory exists and prompts the user to start creating a new build in that directory. If the user agrees, the script changes to the main parent branch, fetches the latest changes, and creates a new branch with the specified build name. It then prompts the user to push the new branch to the remote repository.

The script lists the **microservices/folders** "monolith", "management", and "application" as directories and calls the create_build function for each of them.

SECOND SET:**Just set your subfolders/microservices folders, just search at the end https://github.com/stemax/branch_builder/blob/1a3307476bee19a13992cc5e64179dddc0642bd2/build.sh#L77 `#List of microservices (directories)` and change on your folders!**

Example for folders/microservices:
```
.ProjectFolder
|-monolith
|-management
|-application
build.sh
```

```
  create_build "monolith"
  create_build "management"
  create_build "application"
```

4. Run the script by executing the following command:

```bash
$ sh build_script.sh
```

5. Follow the prompts to start the build process and enter the required information.

Example output:
```
Start a new build process now? [y/n]: y
Please enter new Build Number:
1
Please enter New branch name [Build_1_2024_05_10]:
-------------------------Build_1_2024_05_10----------------------------
Detected directory monolith. Should we start creating a new build here? [y/n]: y
Current branch for monolith is: development
No changes in the current branch. Nothing to stash.
Changing to main parent branch: production
Branch Build_1_2024_05_10 already exists.
Almost ready for Pushing? So Service: monolith, Build: Build_1_2024_05_10. Start pushing [y/n]: y
Pushing new branch Build_1_2024_05_10 to origin!!!
Detected directory management. Should we start creating a new build here? [y/n]: n
management not found!
Detected directory application. Should we start creating a new build here? [y/n]: y
...
```

This script simplifies the process of creating new build branches for multiple microservices within a project.

