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

	$ debuild -S -sa -k<LONG-KEY>

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

# TODO:

- right now there is a lot of stuff which isnt perfect. there are many lintian warnings and errors that need to be fixed on the packages
- for the opensim package, maybe that is most important, if you want to have multiple versions installed, you may want to have the libraries have versions on them (why would you want that tho?)
- maybe more importantly for size sake is that we want to separate dev files from opensim specially when the whole stuff is finally done (we want to have a complete interface in ros-opensimrt, so you wont need the dev files anymore if you just want to use it)
- for that to work, we need to remove the required things from spdlog and simbody and make them private, idk.. i think simbody is always exposed in things like vec3. so target_link_library for spdlog should be marked PRIVATE and the find_package marked QUIET instead of REQUIRED, the same for catch2. simbody is different and should remain PUBLIC. we also need to make sure control reflects this. 


