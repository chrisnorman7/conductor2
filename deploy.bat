@echo off
flutter build web --base-href /conductor2/ --release & scp -Cr build\web\* root@backstreets.site:/var/www/html/conductor2
