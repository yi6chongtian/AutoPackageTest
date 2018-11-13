#!/bin/sh
target_name="AutoPackageTest"
scheme_name=${target_name}
workspace_name="${target_name}.xcworkspace"
archive_path="archive/${target_name}.xcarchive"
ipa_path="archive/${target_name}.ipa"
configuration_type="Release"
exportPlist_path="exportOptions.plist"

mProjectPath=${cd `dirname $0`; pwd}
echo "mProjectPath:${mProjectPath}"

#删除旧文件
rm -rf ${archive_path}
rm -rf ${ipa_path}

# #归档
 xcodebuild archive \
 -workspace ${workspace_name} \
 -scheme ${scheme_name} \
 -configuration ${configuration_type} \
 -archivePath ${archive_path}

# #ipa打包
 xcodebuild -exportArchive \
 -archivePath ${archive_path} \
 -exportPath ${ipa_path} \
 -configuration ${configuration_type} \
 -exportOptionsPlist ${exportPlist_path}

# 测试jq
testjq(){
   current_env="beta_dev_1115"
   net_env=`jq .${current_env}.APP_NET_ENV Config.json`
   user_env=`jq .${current_env}.APP_USER_ENV Config.json`
   branch=`jq .${current_env}.APP_BUILD_BRANCH Config.json`
   echo "net_env:${net_env},user_env:${user_env},branch:${branch}"

   #修改值
   `touch temp_json_1.json`
   tempJson=temp_json_1.json
   echo ${tempJson}

}

testjq

#git
git add .
git commit -m "tang zhi biao tijiao"
git push

