# grand-designs
Shell script for starting a Minetest server.

I made this shell script because I wanted to easily start and stop my own Minetest server. It backs up the state of the game world in a tar file, which can be uploaded the next time a new server is used.

## Usage:

`./mine.sh <path to SSH key> <remote server> <path to world tar file>`

Example:
`./mine.sh ~/.ssh/aws-eu-west-1.pem ec2-user@123.456.789.012 ~/minetest-backup/world-2020-12-28T1719.tar`

## Steps:

- Copies the world tar file to the server.
- Connects to the server.
- Installs Minetest.
- Extracts the tar to the Minetest worlds directory.
- Starts Minetest in server mode.

It will run in this console until interrupted. Then it:

- Reconnects to the server
- Creates a new tar file of the world (with a timestamp).
- Copies that new tar file to the same directory as the original local world tar file.
