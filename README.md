# branch_builder
Bash script for preparation before BUILD for more that one microservices

## The script is designed to automate the process of creating new build branches for different microservices. 

It prompts the user to start a new build process and asks for a build number and name. 
It then checks for existing directories corresponding to different microservices and prompts the user to create a new build branch for each microservice listed. 
The script checks for changes in the current branch, stashes them if necessary, switches to the main parent branch specified by the user, creates a new build branch based on the input build number and name, and pushes the new branch to the remote repository if instructed to do so.

To use the script, follow these steps:
1. Clone the repository containing the script.
2. Make sure you have bash installed on your system.
3. Run the script by executing the following command:

```bash
$ sh build_script.sh
```

4. Follow the prompts to start the build process and enter the required information.

Example output:
```
Start a new build process now? [y/n]: y
Please enter new Build Number:
1
Please enter New branch name [Build_1_2022_05_10]:
-------------------------Build_1_2022_05_10----------------------------
Detected directory monolith. Should we start creating a new build here? [y/n]: y
Current branch for monolith is: development
No changes in the current branch. Nothing to stash.
Changing to main parent branch: production
Branch Build_1_2022_05_10 already exists.
Almost ready for Pushing? So Service: monolith, Build: Build_1_2022_05_10. Start pushing [y/n]: y
Pushing new branch Build_1_2022_05_10 to origin!!!
Detected directory management. Should we start creating a new build here? [y/n]: n
management not found!
Detected directory application. Should we start creating a new build here? [y/n]: y
...
```

This script simplifies the process of creating new build branches for multiple microservices within a project.
