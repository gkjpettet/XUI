#tag BuildAutomation
			Begin BuildStepList Linux
				Begin CopyFilesBuildStep CopyBurntSushiTestsLinux
					AppliesTo = 0
					Architecture = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vdGVzdHMvVE9NTEtpdC9CdXJudFN1c2hpVGVzdHMv
				End
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyBurntSushiTestsMac
					AppliesTo = 0
					Architecture = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vdGVzdHMvVE9NTEtpdC9CdXJudFN1c2hpVGVzdHMv
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyBurntSushiTestsWindows
					AppliesTo = 0
					Architecture = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vdGVzdHMvVE9NTEtpdC9CdXJudFN1c2hpVGVzdHMv
				End
			End
#tag EndBuildAutomation
