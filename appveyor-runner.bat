for /f "delims=" %%a in ('git name-rev --name-only HEAD') do @set branch=%%a
echo "On branch %branch%"

echo %branch%|find "release/" >nul
if errorlevel 1 (goto test) else (goto release)

:test

echo "Running test build..."

conan create . LunarWatcher/testing --build missing 

goto end

:release

conan create . LunarWatcher/release --build missing 
if errorlevel 1 (goto end)

echo "Package built! On branch %branch% - attempting upload."

conan remote add origin %CONAN_UPLOAD%

conan user -p %CONAN_PASSWORD% -r origin %CONAN_REFERENCE%
if errorlevel 1 (goto userfail)

conan upload -r origin --all --confirm "IXWebSocket/*"
if errorlevel 1 (goto uploadfail)

goto end

:userfail 

echo "Failed to add the user. Halting upload.

goto end

:uploadfail

echo "Failed to upload!"

:end

