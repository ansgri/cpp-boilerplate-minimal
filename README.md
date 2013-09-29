Documentation
=============

Intro
-----

cpp-boilerplate-minimal is a skeleton for writing image processing C++. It contains a solid working CMakeLists structure,
some fundamental thirdparty libraries built from source, and an adapted OpenCV sample to get you up to speed quickly.

_Why 'minimal'?_ Because there's a not-so-minimal version with useful infrastructure frameworks not _yet_ open-sourced.

How to use
----------

1. Copy (probably not clone unless you know better) the contents of this repository
2. Replace "CPPBP" and "cppbp" in the root CMakeLists.txt and files within cmake/ folder to some short codename of your project
3. Set up prerequisite libraries Boost and OpenCV (see below)
4. Build the sample
5. build new stuff based on the sample

Building sample
---------------

Assuming Visual Studio 9 2008 as your sole installed compiler. Then from the root of the copied & customized cpp-boilerplate, run this:

    * mkdir build.vc9 && cd build.vc9
    * cmake ..
    * start <your-project-codename>.sln
    * Build Solution (F7)

To run the sample, OpenCV dlls must be in the system path.

Setting up Boost
----------------

If you already have Boost installed or built, just set the `BOOST_ROOT` environment variable, like this:
    
    set BOOST_ROOT=c:\Users\ansgri\thirdparty-src\boost_1_54_0

Otherwise, build it first following this approximate procedure:

    * you must have Visual Studio (or other compiler of choice) installed (obviously)
    * download and unpack the source archive
    * from the unpacked source dir execute `bootstrap.bat`
    * review the build options: `b2 --help`
    * build like this: `b2 link=shared variant=release threading=multi runtime-link=shared`

Setting up OpenCV
-----------------

TODO: instructions for the case when OpenCV is installed via binary installer

Building from source on Windows:

    * `git clone git://github.com/Itseez/opencv.git`
    * `git checkout 2.4.6` (or other stable tag; to see all, execute `git tag`)
    * `mkdir build.user && cd build.user
    * `cmake .. && start OpenCV.sln`
    * build solution (F7) in both Release and Debug configurations
    * build 'INSTALL' target in both Release and Debug configurations (in Solution Explorer, right-click and Build, it's in CMake Targets folder)
    * you'll have `install` folder under `build.user`. Its full path must be set to `OpenCV_DIR` environment variable.

