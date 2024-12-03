echo "Clean existing repository"
CALL flutter clean

echo "Getting packages..."
CALL flutter pub get

echo "Generating the web folder..."
CALL flutter create . --platform web

echo "Building for web..."
CALL flutter build web --base-href /bsl-support/ --release

echo "Copying build to docs..."
CALL del .\docs /S /Q /F
CALL mkdir .\docs
CALL xcopy /s /i .\build\web .\docs

echo "✅ Finished copy build/web/* to ./docs/*"
