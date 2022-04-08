#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyTOMLKitTestsLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vdGVzdHMvVE9NTEtpdC9CdXJudFN1c2hpVGVzdHMv
				End
				Begin CopyFilesBuildStep CopyDemoResourcesLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vZGVtbyUyMHJlc291cmNlcy9YVUlDb2RlRWRpdG9yL05vdmEudG9tbA==
					FolderItem = Li4vLi4vWFVJJTIwRVVMQS5tZA==
					FolderItem = Li4vLi4vWFVJJTIwU2ltcGxlJTIwRVVMQS5tZA==
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyTOMLKitTestsMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vdGVzdHMvVE9NTEtpdC9CdXJudFN1c2hpVGVzdHMv
				End
				Begin CopyFilesBuildStep CopyDemoResourcesMac
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vZGVtbyUyMHJlc291cmNlcy9YVUlDb2RlRWRpdG9yL05vdmEudG9tbA==
					FolderItem = Li4vLi4vWFVJJTIwRVVMQS5tZA==
					FolderItem = Li4vLi4vWFVJJTIwU2ltcGxlJTIwRVVMQS5tZA==
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyTOMLKitTestsWindows
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vdGVzdHMvVE9NTEtpdC9CdXJudFN1c2hpVGVzdHMv
				End
				Begin CopyFilesBuildStep CopyDemoResourcesWindows
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vLi4vZGVtbyUyMHJlc291cmNlcy9YVUlDb2RlRWRpdG9yL05vdmEudG9tbA==
					FolderItem = Li4vLi4vWFVJJTIwRVVMQS5tZA==
					FolderItem = Li4vLi4vWFVJJTIwU2ltcGxlJTIwRVVMQS5tZA==
				End
			End
#tag EndBuildAutomation
