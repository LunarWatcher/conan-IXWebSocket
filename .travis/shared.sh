branch="$(git name-rev --name-only HEAD)"
echo "Currently on branch $branch"

if [[ "$branch" == *"release/"* ]]; then
    
    conan create . LunarWatcher/stable --build missing $([ "${IX_OPTIONS}" ] && echo "${IX_OPTIONS}" || echo "")

    result = $?
    # If the build succeeded, and we're on a release branch, upload to Bintray!
    if [ "$result" == 0  ]; then
        conan remote add origin $CONAN_UPLOAD
        # ... assuming the Bintray API key is defined.
        if [ "$CONAN_PASSWORD" ]; then
            conan user -p $CONAN_PASSWORD -r origin $CONAN_REFERENCE
            conan upload -r origin --confirm "IXWebSocket/*"
        fi
    fi
else 
    conan create . LunarWatcher/testing --build missing $([ "${IX_OPTIONS}" ] && echo "${IX_OPTIONS}" || echo "") 
    # Test build - no upload
fi
