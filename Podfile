#!/usr/bin/ruby
#ruby
require 'json'
require 'pp'
require 'xcodeproj'



str="tang zhi biao"
puts "str: #{str}"
time2 = Time.now
puts "当前时间 : " + time2.inspect

json = File.read("Config.json")
obj = JSON.parse(json)
#pp obj

currentEnv = obj["current_env"]
currentBranch = obj["current_branch"]
puts "currentEnv:#{currentEnv} currentBranch:#{currentBranch}"
netEnv = obj[currentEnv]["APP_NET_ENV"]
userEnv = obj[currentEnv]["APP_USER_ENV"]
buildBranch = obj[currentEnv]["APP_BUILD_BRANCH"]
puts "netEnv:#{netEnv} userEnv:#{userEnv} buildBranch:#{buildBranch}"

if currentBranch.empty?
    puts "currentBranch is empty"
    currentBranch="1115"
else
    puts "currentBranch is not empty"
end

puts "currentBranch:#{currentBranch}"

# 追加字符串
str = "tang"
str << "zhi"
puts "#{str}"

#自定义所有targets的build settings       只能获取Target:Pods-项目名称
#post_install do |installer|
#    installer.pods_project.targets.each do |target|
#        puts "post_install targetName:#{target.name}"    #Pods-AutoPackageTest
#        target.build_configurations.each do |config|
#            config.build_settings['GCC_ENABLE_OBJC_GC'] = 'supported'
#        end
#    end
#end





platform :ios, '9.0'

target 'AutoPackageTest' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for AutoPackageTest
  
  pod 'YYCache'
  pod 'YYModel'

#读取AutoPackageTest.xcodeproj项目
#project_path = '/Users/tangzhibiao/Desktop/测试项目/AutoPackageTest/AutoPackageTest.xcodeproj'
project_path = File.join(File.dirname(__FILE__), "AutoPackageTest.xcodeproj")
project = Xcodeproj::Project.open(project_path)
project.targets.each do |target|
    puts "tang:#{target.name} product_name:#{target.product_name}"
    target.build_configurations.each do |config|
        puts "config.name:#{config.name}"
        
# fpf配置
# ruby操作符
# || ：a||=123 就是 当a存在但是没有赋值时 a＝123
# array - other_array : 返回一个新的数组，新数组是从初始数组中移除了在 other_array 中出现的项的副本
# array | other_array : 通过把 other_array 加入 array 中，移除重复项，返回一个新的数组。

    old_config = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] || ['$(inherited)']
    new_config = old_config - ['APP_DEV','APP_TEST','APP_TEST_OUT','APP_STAGE','APP_PROD'] | ['APP_DEV']
    new_config = new_config - ['APP_USER_ENV_BETA','APP_USER_ENV_TRIAL'] | ['APP_USER_ENV_BETA']
    config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = new_config
    puts "#{target.name} #{config.name} after: #{config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'].inspect}"

# 测试代码
#    if config.name == 'Debug'
#
#    end

    project.save        #保存 必须调用


    end
end

#这是写入Pods.xcodeproj的环境变量
post_install do |installer|
    puts "installer.pods_project:#{installer.pods_project}" #installer.pods_project:#<Pod::Project> path:`/Users/tangzhibiao/Desktop/测试项目/AutoPackageTest/Pods/Pods.xcodeproj` UUID:`000000000000`
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            puts "new config:#{config.name}"
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) UAT_Release=2 COCOAPODS=2'
        end
    end
end


end
