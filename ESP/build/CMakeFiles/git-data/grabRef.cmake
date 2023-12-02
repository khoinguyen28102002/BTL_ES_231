#
# Internal file for GetGitRevisionDescription.cmake
#
# Requires CMake 2.6 or newer (uses the 'function' command)
#
# Original Author:
# 2009-2010 Ryan Pavlik <rpavlik@iastate.edu> <abiryan@ryand.net>
# http://academic.cleardefinition.com
# Iowa State University HCI Graduate Program/VRAC
#
# Copyright Iowa State University 2009-2010.
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

set(HEAD_HASH)

<<<<<<< HEAD:ESP/build/CMakeFiles/git-data/grabRef.cmake
file(READ "D:/HK231/HTN/BTL/Code/Code/sample_project/build/CMakeFiles/git-data/HEAD" HEAD_CONTENTS LIMIT 1024)

string(STRIP "${HEAD_CONTENTS}" HEAD_CONTENTS)
set(GIT_DIR "D:/HK231/HTN/BTL/Code/.git")
=======
file(READ "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/CMakeFiles/git-data/HEAD" HEAD_CONTENTS LIMIT 1024)

string(STRIP "${HEAD_CONTENTS}" HEAD_CONTENTS)
set(GIT_DIR "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/.git")
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/CMakeFiles/git-data/grabRef.cmake
# handle git-worktree
if(EXISTS "${GIT_DIR}/commondir")
	file(READ "${GIT_DIR}/commondir" GIT_DIR_NEW LIMIT 1024)
	string(STRIP "${GIT_DIR_NEW}" GIT_DIR_NEW)
	if(NOT IS_ABSOLUTE "${GIT_DIR_NEW}")
		get_filename_component(GIT_DIR_NEW ${GIT_DIR}/${GIT_DIR_NEW} ABSOLUTE)
	endif()
	if(EXISTS "${GIT_DIR_NEW}")
		set(GIT_DIR "${GIT_DIR_NEW}")
	endif()
endif()
if(HEAD_CONTENTS MATCHES "ref")
	# named branch
	string(REPLACE "ref: " "" HEAD_REF "${HEAD_CONTENTS}")
	if(EXISTS "${GIT_DIR}/${HEAD_REF}")
<<<<<<< HEAD:ESP/build/CMakeFiles/git-data/grabRef.cmake
		configure_file("${GIT_DIR}/${HEAD_REF}" "D:/HK231/HTN/BTL/Code/Code/sample_project/build/CMakeFiles/git-data/head-ref" COPYONLY)
	elseif(EXISTS "${GIT_DIR}/logs/${HEAD_REF}")
		configure_file("${GIT_DIR}/logs/${HEAD_REF}" "D:/HK231/HTN/BTL/Code/Code/sample_project/build/CMakeFiles/git-data/head-ref" COPYONLY)
=======
		configure_file("${GIT_DIR}/${HEAD_REF}" "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/CMakeFiles/git-data/head-ref" COPYONLY)
	elseif(EXISTS "${GIT_DIR}/logs/${HEAD_REF}")
		configure_file("${GIT_DIR}/logs/${HEAD_REF}" "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/CMakeFiles/git-data/head-ref" COPYONLY)
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/CMakeFiles/git-data/grabRef.cmake
		set(HEAD_HASH "${HEAD_REF}")
	endif()
else()
	# detached HEAD
<<<<<<< HEAD:ESP/build/CMakeFiles/git-data/grabRef.cmake
	configure_file("${GIT_DIR}/HEAD" "D:/HK231/HTN/BTL/Code/Code/sample_project/build/CMakeFiles/git-data/head-ref" COPYONLY)
endif()

if(NOT HEAD_HASH)
	file(READ "D:/HK231/HTN/BTL/Code/Code/sample_project/build/CMakeFiles/git-data/head-ref" HEAD_HASH LIMIT 1024)
=======
	configure_file("${GIT_DIR}/HEAD" "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/CMakeFiles/git-data/head-ref" COPYONLY)
endif()

if(NOT HEAD_HASH)
	file(READ "D:/UniversityProject/embedded_system_subject_assignment/BTL_ES_231/data_reader/build/CMakeFiles/git-data/head-ref" HEAD_HASH LIMIT 1024)
>>>>>>> 2561197efd2b775a1f31193203379d7ec7822d8f:data_reader/build/CMakeFiles/git-data/grabRef.cmake
	string(STRIP "${HEAD_HASH}" HEAD_HASH)
endif()
