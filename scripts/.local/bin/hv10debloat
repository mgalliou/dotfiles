#!/usr/bin/env sh

main() {
	PACKAGES="
	#com.huawei.HwMultiScreenShot
	com.huawei.android.launcher #Huawei Launcher
	#com.huawei.android.tips
	#com.huawei.appmarket #AppGalery
	#com.huawei.bd #HwUE
	#com.huawei.camera
	#com.huawei.compass
	#com.huawei.contactscancard #Scan Business Card
	#com.huawei.gameassistant
	#com.huawei.hicare
	com.huawei.hidisk #Files
	com.huawei.hifolder #AppAdvisor
	com.huawei.himovie.overseas #Huawei Video
	#com.huawei.hitouch #HiTouch
	#com.huawei.hiview #HiView
	#com.huawei.hivoice #HiVoice
	#com.huawei.hwdetectrepair #Smart Diagnosis
	com.huawei.livewallpaper.honor
	com.huawei.livewallpaper.simple
	com.huawei.livewallpaper.geometry
	#com.huawei.parentcontrol #Digital Balence
	#com.huawei.phoneservice #HiCare
	#com.huawei.scanner #HiVision
	#com.huawei.screenrecorder
	#com.huawei.search #HiSearch
	#com.huawei.systemmanager #System Manager
	#com.huawei.tips
	#com.huawei.android.wfdft #Wi-Fi Direct
	#com.huawei.mirrorshare #Wireless projection
	com.huawei.videoeditor
	#com.ironsource.appcloud.oobe.huawei #Essential Apps
	com.android.calculator2
	com.android.calendar
	#com.android.deskclock
	com.android.bookmarkprovider
	com.android.email
	com.android.gallery3d
	com.android.mediacenter #Music
	com.android.mms
	com.android.providers.calendar
	com.android.providers.partnerbookmarks
	com.android.wallpaper.livepicker #Live Wallpaper Picker
	com.ebay.carrier
	com.example.android.notepad
	com.facebook.appmanager
	com.facebook.services
	com.facebook.system
	com.google.android.music
	com.google.android.videos
	com.google.android.apps.tachyon #Google Duo
	com.google.android.chrome
	"
	
	for PACKAGE in $PACKAGES
	do
		printf "Uninstalling: %s\n" "$PACKAGE"
		adb shell "pm uninstall -k --user 0 $PACKAGE"
	done
}

main
