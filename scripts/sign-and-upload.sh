#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  echo "This is a pull request. No deployment will be done."
  exit 0
fi
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
  echo "Testing on a branch other than master. No deployment will be done."
  exit 0
fi

# Thanks @djacobs https://gist.github.com/djacobs/2411095
# Thanks @johanneswuerbach https://gist.github.com/johanneswuerbach/5559514

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_NAME.mobileprovision"
OUTPUTDIR="$PWD/build/Release-iphoneos"

echo "***************************"
echo "*        Signing          *"
echo "***************************"
xcrun -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APP_NAME.app" -o "$OUTPUTDIR/$APP_NAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

# zip -r -9 "$OUTPUTDIR/$APP_NAME.app.dSYM.zip" "$OUTPUTDIR/$APP_NAME.app.dSYM"
#
# RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
# RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

# if [ ! -z "$TESTFLIGHT_TEAM_TOKEN" ] && [ ! -z "$TESTFLIGHT_API_TOKEN" ]; then
#   echo ""
#   echo "***************************"
#   echo "* Uploading to Testflight *"
#   echo "***************************"
#   curl http://testflightapp.com/api/builds.json \
#     -F file="@$OUTPUTDIR/$APP_NAME.ipa" \
#     -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
#     -F api_token="$TESTFLIGHT_API_TOKEN" \
#     -F team_token="$TESTFLIGHT_TEAM_TOKEN" \
#     -F distribution_lists='Internal' \
#     -F notes="$RELEASE_NOTES"
# fi
#
# if [ ! -z "$HOCKEY_APP_ID" ] && [ ! -z "$HOCKEY_APP_TOKEN" ]; then
#   echo ""
#   echo "***************************"
#   echo "* Uploading to Hockeyapp  *"
#   echo "***************************"
#   curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
#     -F status="2" \
#     -F notify="0" \
#     -F notes="$RELEASE_NOTES" \
#     -F notes_type="0" \
#     -F ipa="@$OUTPUTDIR/$APP_NAME.ipa" \
#     -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
#     -H "X-HockeyAppToken: $HOCKEY_APP_TOKEN"
# fi
