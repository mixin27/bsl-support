echo "Clean existing repository"
CALL flutter clean

echo "Getting packages..."
CALL flutter pub get

echo "Generating the web folder..."
CALL flutter create . --platform web

echo "Building for web..."
CALL flutter build web --base-href /bsl-support-site/ --release

echo "Copying build to site..."
CALL del .\site /S /Q /F
CALL mkdir .\site
CALL xcopy /s /i .\build\web .\site

echo "✅ Finished copy build/web/* to ./site/*"
