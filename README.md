# rt package builder

## Normal use:

	Clone this repo with --recursive.

	Go to src and checkout the version you want (you may want to add remotes for the original code to pull from upstream), (TODO: change remotes since we are using patches now to create the packages)

	Edit the build and run script to have the correct version (TODO: i could do like a script to get it from the git branch i suppose)

	$ ./build_and_run.sh

	Then navigate to the /src/<package><version>

	$ dch -i

	Bump the version number and add what you are doing, make sure to change email and distro name.

	$ debuild -us -uc

	(This is a cake recipe, dont question it)

	If everything works out, then stage 2 in a machine with gpg keys:

	$ debuild -Sa -K<LONG-KEY>

	Check key with:

	$ gpg --list-secret-keys

	if everything worksout then do:

	$ dput your-ppa ../<package>-<version>source.changes


	Note i wrote this from memory, some commands may be wrong. 

# Misc

vim expression fyi (can definitely be simplified):

	:%s/\v([^a-zA-Z:])(::)@<!(Body)([^a-zA-Z0-9])/\1OpenSim::\2\3\4\5/gc

TODO: this would be better than the docker to test compilation, but it wasnt working, 

	$ sbuild-createchroot jammy /srv/chroot/jammy-amd64 http://archive.ubuntu.com/ubuntu
	
	$ sbuild -A -s -d jammy

- Attention: there is a problem with spdlog doing funny template matching to everything and colliding with SimTK also doing template matching with everything. I am not great with templates and spdlog is wizard level cpp, i can't debug that. So i did the stupid thing which was putting namespaces in front of all the classes and removing all using namespace SimTK lines. This was a lot of work and i havent finished yet. THere is a script to partially automate it, but the hard parts are still manual and are relying on patches. Good luck updating this.
