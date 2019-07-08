from cpt.packager import ConanMultiPackager
import os 

if __name__ == "__main__":
    dockerEntryScript = None

    if "INSTALL_CONAN_PACKAGES" in os.environ:
        rawPackages = os.environ["INSTALL_CONAN_PACKAGES"].split(",")
        dockerEntryScript = "conan install "
        for package in rawPackages:
            dockerEntryScript += package + " " 
        dockerEntryScript += "--build missing"
    builder = ConanMultiPackager(docker_entry_script=dockerEntryScript)

    builder.add_common_builds(pure_c=False, build_policy="missing")
    builder.run()
