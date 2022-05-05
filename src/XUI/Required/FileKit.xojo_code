#tag Module
Protected Module FileKit
	#tag Method, Flags = &h1, Description = 436F706965732060736F757263656020746F206064657374696E6174696F6E602E
		Protected Function CopyTo(Extends source As FolderItem, destination As FolderItem, overwrite As Boolean = False) As FileKit.Errors
		  /// Copies `source` to `destination`.
		  ///
		  /// `source` is the file or folder to copy.
		  /// `destination` must be a folder and must exist. 
		  
		  Return CopyTo(source, destination, overwrite)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F706965732060736F757263656020746F206064657374696E6174696F6E602E
		Protected Function CopyTo(source As FolderItem, destination As FolderItem, overwrite As Boolean = False) As FileKit.Errors
		  /// Copies `source` to `destination`.
		  ///
		  /// `source` is the file or folder to copy.
		  /// `destination` must be a folder and must exist. 
		  
		  // Nil object checks.
		  If source = Nil Then
		    Return Errors.SourceIsNil
		  ElseIf destination = Nil Then
		    Return Errors.DestinationIsNil
		  End If
		  
		  // Do `source` and `destination` exist?
		  If Not source.Exists Then Return Errors.SourceDoesNotExist
		  If Not destination.Exists Then Return Errors.DestinationDoesNotExist
		  
		  Var item As FolderItem
		  
		  // Copy a file
		  If source.IsFolder = False Then
		    // Does destination contain a file with the same name as `source`?
		    Var iMax As Integer = destination.Count - 1
		    For i As Integer = 0 To iMax
		      item = destination.ChildAt(i)
		      If Not item.IsFolder And item.Name = source.Name Then
		        // Destination contains an identically named file. Should we overwrite?
		        If overwrite Then // Yes.
		          Try
		            If Not item.ReallyDelete(safeMode) Then Return Errors.UnableToDeleteFile
		            Exit
		          Catch err
		            If safeMode Then
		              Return Errors.AttemptToDeleteProtectedFolderItem
		            Else
		              Return Errors.UnableToDeleteFile
		            End If
		          End Try
		        Else // Do not overwrite the existing file - abort.
		          Return Errors.Aborted
		        End If
		      End If
		    Next i
		    
		    // At this point, we are copying a file to a valid destination folder and we are sure there is 
		    // not a file at this destination with the same name. All that's left is to do the file copy.
		    #If TargetWindows
		      Return WindowsCopyFile(source, destination)
		    #Else
		      Return UnixCopyFile(source, destination)
		    #EndIf
		    
		  End If
		  
		  // Copy a folder.
		  If source.IsFolder Then
		    // Does destination contain a folder with the same name as `source`?
		    Var iMax As Integer = destination.Count - 1
		    For i As Integer = 0 To iMax
		      item = destination.ChildAt(i)
		      If item.IsFolder And item.Name = source.Name Then
		        // Destination contains an identically named folder. Should we overwrite?
		        If overwrite Then // Yes.
		          Try
		            If Not item.ReallyDelete(safeMode) Then Return Errors.UnableToDeleteFolder
		            Exit
		          Catch err
		            If safeMode Then
		              Return Errors.AttemptToDeleteProtectedFolderItem
		            Else
		              Return Errors.UnableToDeleteFolder
		            End If
		          End Try
		        Else // Do not overwrite the existing folder - abort.
		          Return Errors.Aborted
		        End If
		      End If
		    Next i
		    
		    // At this point, we are copying a folder to a valid destination folder and we are sure there is 
		    // not a folder at this destination with the same name. All that's left is to do the folder copy.
		    #If TargetWindows
		      Return WindowsCopyFolder(source, destination)
		    #Else
		      Return UnixCopyFolder(source, destination)
		    #EndIf
		    
		  End If
		  
		  // If we've got here something went wrong.
		  Return Errors.Unknown
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 496E697469616C6973657320746865206D6F64756C652E
		Protected Sub Initialise()
		  /// Initialises the module.
		  
		  SetupProtectedFiles
		  
		  mInitialised = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6D6F7665732060736F757263656020746F206064657374696E6174696F6E602E
		Protected Function MoveTo(Extends source As FolderItem, destination As FolderItem, overwrite As Boolean = False) As FileKit.Errors
		  /// Mmoves `source` to `destination`.
		  ///
		  /// `source` is the file or folder to move.
		  /// `destination` must be a folder.
		  
		  Return MoveTo(source, destination, overwrite)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6D6F7665732060736F757263656020746F206064657374696E6174696F6E602E
		Protected Function MoveTo(source As FolderItem, destination As FolderItem, overwrite As Boolean = False) As FileKit.Errors
		  /// Mmoves `source` to `destination`.
		  ///
		  /// `source` is the file or folder to move.
		  /// `destination` must be a folder.
		  
		  // Nil object checks.
		  If source = Nil Then
		    Return Errors.SourceIsNil
		  ElseIf destination = Nil Then
		    Return Errors.DestinationIsNil
		  End If
		  
		  // Do `source` and `destination` exist?
		  If Not source.Exists Then Return Errors.SourceDoesNotExist
		  If Not destination.Exists Then Return Errors.DestinationDoesNotExist
		  
		  Var item As FolderItem
		  
		  // Move a file.
		  If source.IsFolder= False Then
		    // Does destination contain a file with the same name as `source`?
		    Var iMax As Integer = destination.Count - 1
		    For i As Integer = 0 To iMax
		      item = destination.ChildAt(i)
		      If Not item.IsFolder And item.Name = source.Name Then
		        // Destination contains an identically named file. Should we overwrite?
		        If overwrite Then // Yes.
		          Try
		            If Not item.ReallyDelete(safeMode) Then Return Errors.UnableToDeleteFile
		            Exit
		          Catch err
		            If safeMode Then
		              Return Errors.AttemptToDeleteProtectedFolderItem
		            Else
		              Return Errors.UnableToDeleteFile
		            End If
		          End Try
		        Else // Do not overwrite the existing file - abort.
		          Return Errors.Aborted
		        End If
		      End If
		    Next i
		    
		    // At this point, we are moving a file to a valid destination folder and we are sure there is 
		    // not a file at this destination with the same name. All that's left to do is move the file.
		    #If TargetWindows
		      Return WindowsMoveFile(source, destination)
		    #Else
		      Return UnixMoveFile(source, destination)
		    #EndIf
		    
		  End If
		  
		  // Move a folder.
		  If source.IsFolder Then
		    // Does destination contain a folder with the same name as `source`?
		    Var iMax As Integer = destination.Count - 1
		    For i As Integer = 0 To iMax
		      item = destination.ChildAt(i)
		      If item.IsFolder And item.Name = source.Name Then
		        // Destination contains an identically named folder. Should we overwrite?
		        If overwrite Then // Yes.
		          Try
		            If Not item.ReallyDelete(safeMode) Then Return Errors.UnableToDeleteFolder
		            Exit
		          Catch err
		            If safeMode Then
		              Return Errors.AttemptToDeleteProtectedFolderItem
		            Else
		              Return Errors.UnableToDeleteFolder
		            End If
		          End Try
		        Else // Do not overwrite the existing folder - abort.
		          Return Errors.Aborted
		        End If
		      End If
		    Next i
		    
		    // At this point, we are moving a folder to a valid destination folder and we are sure there is 
		    // not a folder at this destination with the same name. All that's left to do is move the folder.
		    #If TargetWindows
		      Return WindowsMoveFolder(source, destination)
		    #Else
		      Return UnixMoveFolder(source, destination)
		    #EndIf
		    
		  End If
		  
		  // If we've got here something went wrong.
		  Return Errors.Unknown
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F6D706C6574656C792064656C6574657320607768617460206576656E206966206974206973206120666F6C646572207769746820636F6E74656E74732E2052657475726E732054727565206966207375636365737366756C2E
		Protected Function ReallyDelete(Extends what As FolderItem, safeMode As Boolean = True) As Boolean
		  /// Completely deletes `what` even if it is a folder with contents. Returns True if successful.
		  
		  Return ReallyDelete(what, safeMode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F6D706C6574656C792064656C6574657320607768617460206576656E206966206974206973206120666F6C646572207769746820636F6E74656E74732E2052657475726E732054727565206966207375636365737366756C2E
		Protected Function ReallyDelete(what As FolderItem, safeMode As Boolean = True) As Boolean
		  /// Completely deletes `what` even if it is a folder with contents. Returns True if successful.
		  
		  If Not mInitialised Then Initialise
		  
		  // Do NOT permit the deletion of important special folders if in safe mode.
		  If safeMode And protectedFolderItems.HasKey(what.NativePath) Then
		    Var err As New RuntimeException
		    err.Message = "An attempt to delete the protected FolderItem `" + _
		    what.NativePath + "` was made. Deletion aborted."
		    Raise err
		  End If
		  
		  Var files(), dirs() As FolderItem
		  
		  If what = Nil Or Not what.Exists() Then Return True
		  
		  // Is this a file?
		  If Not what.IsFolder Then
		    Try
		      what.Remove
		    Catch e
		      Return False
		    End Try
		  End If
		  
		  // Collect the folder‘s contents first.
		  // This is faster than collecting them in reverse order and deleting them right away.
		  Var iMax As Integer = what.Count - 1
		  For i As Integer = 0 To iMax
		    Var f As FolderItem
		    f = what.ChildAt(i)
		    If f <> Nil Then
		      If f.IsFolder Then
		        dirs.Add(f)
		      Else
		        files.Add(f)
		      End If
		    End If
		  Next
		  
		  // Now delete the files.
		  For Each f As FolderItem In files
		    Try
		      f.Remove
		    Catch e As IOException
		      Return False
		    End Try
		  Next f
		  
		  // Free the memory used by the files array before we enter recursion.
		  files.RemoveAll
		  
		  // Now delete the directories.
		  For Each f As FolderItem In dirs
		    Try
		      If Not f.ReallyDelete(safeMode) Then
		        Return False
		      End If
		    Catch e As IOException
		      Return False
		    End Try
		  Next f
		  
		  // We're done without error, so the folder should be empty and we can delete it.
		  what.Remove
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C69736573207468652044696374696F6E61727920746861742073746F7265732074686520466F6C6465724974656D732074686174206D757374206E657665722062652064656C6574656420627920605265616C6C7944656C657465282960
		Private Sub SetupProtectedFiles()
		  /// Initialises the Dictionary that stores the FolderItems that must never be deleted by `ReallyDelete()`
		  ///
		  /// Which locations are protected depends upon the platform that the app is currently running on.
		  ///
		  /// The following locations are protected on:
		  /// **Windows:**
		  /// ApplicationData, Applications, Desktop, Documents, Extensions, Favourites, Fonts, 
		  /// Movies, Music, Pictures, Printers, SharedApplicationData, SharedDocuments, System, UserHome, Windows
		  ///
		  /// **macOS:**
		  /// ApplicationData, Applications, Bin, Desktop, Documents, Etc, Favourites, Fonts, Home, 
		  /// Library, Mount, Movies, Music, Pictures, Preferences, Printers, SBin, SharedApplicationData, 
		  /// SharedDocuments, SharedPreferences, System, UserBin, UserHome, UserLibrary, UsersBin
		  ///
		  /// **Linux:**
		  /// ApplicationData, Bin, Desktop, Documents, Etc, Home, Library, Mount, Movies, Music, Pictures, 
		  /// SBin, UserBin, UserHome, UserLibrary, UsersBin
		  
		  protectedFolderItems = New Dictionary
		  
		  #If TargetWindows
		    protectedFolderItems.Value(SpecialFolder.ApplicationData.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Applications.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Desktop.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Documents.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Extensions.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Favorites.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Fonts.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Movies.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Music.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Pictures.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Printers.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SharedApplicationData.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SharedDocuments.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.System.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserHome.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Windows.NativePath) = True
		  #ElseIf TargetMacOS
		    protectedFolderItems.Value(SpecialFolder.ApplicationData.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Applications.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Bin.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Desktop.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Documents.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Etc.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Favorites.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Fonts.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Home.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Library.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Mount.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Movies.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Music.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Pictures.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Preferences.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Printers.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SBin.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SharedApplicationData.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SharedDocuments.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SharedPreferences.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.System.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserBin.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserHome.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserLibrary.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserSBin.NativePath) = True
		  #Else
		    protectedFolderItems.Value(SpecialFolder.ApplicationData.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Bin.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Desktop.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Documents.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Etc.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Home.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Library.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Mount.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Movies.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Music.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.Pictures.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.SBin.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserBin.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserHome.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserLibrary.NativePath) = True
		    protectedFolderItems.Value(SpecialFolder.UserSBin.NativePath) = True
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206572726F72206065602E
		Protected Function ToString(Extends e As FileKit.Errors) As String
		  /// Returns a string representation of error `e`.
		  
		  Select Case e
		  Case Errors.Aborted
		    Return "Aborted"
		    
		  Case Errors.AttemptToDeleteProtectedFolderItem
		    Return "Attempt to delete protected FolderItem"
		    
		  Case Errors.CpError
		    Return "cp command error"
		    
		  Case Errors.DestinationDoesNotExist
		    Return "Destination does not exist"
		    
		  Case Errors.DestinationIsNil
		    Return "Destination is Nil"
		    
		  Case Errors.MoveError
		    Return "move command error"
		    
		  Case Errors.None
		    Return "None"
		    
		  Case Errors.SourceDoesNotExist
		    Return "Source does not exist"
		    
		  Case Errors.SourceIsNil
		    Return "Source is Nil"
		    
		  Case Errors.UnableToCreateDestinationFolder
		    Return "Unable to create destination folder"
		    
		  Case Errors.UnableToDeleteFile
		    Return "Unable to delete file"
		    
		  Case Errors.UnableToDeleteFolder
		    Return "Unable to delete folder"
		    
		  Case Errors.Unknown
		    Return "Unknown"
		    
		  Case Errors.XcopyDiskWriteError
		    Return "xcopy disk write error"
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F706965732060736F757263656020746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E6420746865206063706020636F6D6D616E642E
		Private Function UnixCopyFile(file As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Copies `source` to `destination` using the shell and the `cp` command.
		  ///
		  /// `source` is the file to copy.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` does NOT contain an identically 
		  /// named file as `source`.
		  /// macOS and Linux only.
		  
		  // Use cp to do the copy.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "cp " + QUOTE + file.NativePath + QUOTE + " " + _
		  QUOTE + destination.NativePath + QUOTE
		  s.Execute(command)
		  
		  // Return cp's error code (if any).
		  If s.ExitCode = 0 Then
		    Return Errors.None
		  Else
		    Return Errors.CpError
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F706965732060736F757263656020746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E6420746865206063706020636F6D6D616E642E
		Private Function UnixCopyFolder(folder As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Copies `source` to `destination` using the shell and the `cp` command.
		  ///
		  /// `source` is the folder to copy.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` is a folder and 
		  /// `destination` does NOT contain an identically named folder as `source`.
		  /// macOS and Linux only.
		  
		  // Make sure there is NO trailing slash after the source path.
		  Var sourcePath As String = folder.NativePath
		  If sourcePath.Right(1) = "/" Then sourcePath = sourcePath.Left(sourcePath.Length - 1)
		  
		  // Make sure there IS a trailing slash at the end of the destination path.
		  Var destinationPath As String = destination.NativePath
		  If destinationPath.Right(1) <> "/" Then destinationPath = destinationPath + "/"
		  
		  // Use cp to do the copy.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "cp -R " + QUOTE + sourcePath + QUOTE + " " + QUOTE + destinationPath + QUOTE
		  s.Execute(command)
		  
		  // Return cp's error code (if any).
		  If s.ExitCode = 0 Then
		    Return Errors.None
		  Else
		    Return Errors.CpError
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732060736F75726365602066696C6520746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E642074686520606D766020636F6D6D616E642E
		Private Function UnixMoveFile(file As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Moves `source` file to `destination` using the shell and the `mv` command.
		  ///
		  /// `source` is the file to move.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` does NOT contain an identically 
		  /// named file as `source`.
		  /// macOS and Linux only.
		  
		  // To determine the destination path, we need to append the file's name to it.
		  Var destinationPath As String = destination.NativePath
		  If destinationPath.Right(1) <> "/" Then destinationPath = destinationPath + "/"
		  destinationPath = destinationPath + file.Name
		  
		  // Use `mv` to do the moving.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "mv -f " + QUOTE + file.NativePath + QUOTE + " " + _
		  QUOTE + destinationPath + QUOTE
		  s.Execute(command)
		  
		  // Return mv's error code (if any).
		  If s.ExitCode = 0 Then
		    Return Errors.None
		  Else
		    Return Errors.MoveError
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732060736F757263656020666F6C64657220746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E642074686520606D766020636F6D6D616E642E
		Private Function UnixMoveFolder(folder As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Moves `source` folder to `destination` using the shell and the `mv` command.
		  ///
		  /// `source` is the folder to move.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` is a folder and 
		  /// `destination` does NOT contain an identically named folder as `source`.
		  /// macOS and Linux only.
		  
		  // Use `mv` to do the moving.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "mv -f " + QUOTE + folder.NativePath + QUOTE + " " + _
		  QUOTE + destination.NativePath + QUOTE
		  s.Execute(command)
		  
		  // Return mv's error code (if any).
		  If s.ExitCode = 0 Then
		    Return Errors.None
		  Else
		    Return Errors.MoveError
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F706965732060736F757263656020746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E6420746865206078636F70796020636F6D6D616E642E
		Private Function WindowsCopyFile(file As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Copies `source` to `destination` using the shell and the `xcopy` command.
		  ///
		  /// `source` is the file to copy.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` does NOT contain an identically 
		  /// named file as `source`.
		  /// Windows-only.
		  
		  // Use xcopy to do the copy.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "xcopy " + QUOTE + file.NativePath + QUOTE + " " + _
		  QUOTE + destination.NativePath + QUOTE + " /i /y"
		  s.Execute(command)
		  
		  // Return xcopy's error code (if any).
		  Select Case s.ExitCode
		  Case 5
		    Return Errors.XcopyDiskWriteError
		  Else
		    Return Errors.None
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F706965732060736F757263656020746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E6420746865206078636F70796020636F6D6D616E642E
		Private Function WindowsCopyFolder(folder As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Copies `source` to `destination` using the shell and the `xcopy` command.
		  ///
		  /// `source` is the folder to copy.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` is a folder and 
		  /// `destination` does NOT contain an identically named folder as `source`.
		  /// Windows-only.
		  
		  // We need to create a folder at the destination with the same name as the source folder.
		  Var d As FolderItem = destination.Child(folder.Name)
		  Try
		    d.CreateFolder
		  Catch err
		    Return Errors.UnableToCreateDestinationFolder
		  End Try
		  
		  // Ensure that there is no trailing slash in the source folder's path.
		  Var sourcePath As String = folder.NativePath
		  If sourcePath.Right(1) = "\" Then sourcePath = sourcePath.Left(sourcePath.Length - 1)
		  
		  // Use xcopy to do the copy.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "xcopy " + QUOTE + sourcePath + QUOTE + " " + _
		  QUOTE + d.NativePath + QUOTE + " /i /e /s /y"
		  s.Execute(command)
		  
		  // Return xcopy's error code (if any).
		  Select Case s.ExitCode
		  Case 5
		    Return Errors.XcopyDiskWriteError
		  Else
		    Return Errors.None
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732060736F757263656020746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E642074686520606D6F76656020636F6D6D616E642E
		Private Function WindowsMoveFile(file As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Moves `source` to `destination` using the shell and the `move` command.
		  ///
		  /// `source` is the file to move.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` does NOT contain an identically 
		  /// named file as `source`.
		  /// Windows-only.
		  
		  // Use the `move` command to actually move the file.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "move /Y " + QUOTE + file.NativePath + QUOTE + " " + _
		  QUOTE + destination.NativePath + QUOTE
		  s.Execute(command)
		  
		  // Return move's error code (if any).
		  If s.ExitCode = 0 Then
		    Return Errors.None
		  Else
		    Return Errors.MoveError
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732060736F757263656020746F206064657374696E6174696F6E60207573696E6720746865207368656C6C20616E642074686520606D6F76656020636F6D6D616E642E
		Private Function WindowsMoveFolder(folder As FolderItem, destination As FolderItem) As FileKit.Errors
		  /// Moves `source` to `destination` using the shell and the `move` command.
		  ///
		  /// `source` is the folder to move.
		  /// `destination` specifies the folder that will become the parent of `source`.
		  ///
		  /// The method assumes that checks have already been made for the following conditions:
		  /// `source` <> Nil and `source` exists
		  /// `destination` <> Nil and `destination` exists and `destination` is a folder and 
		  /// `destination` does NOT contain an identically named folder as `source`.
		  /// Windows-only.
		  
		  // Make sure that the source folder path does NOT have a trailing slash.
		  Var sourcePath As String = folder.NativePath
		  If sourcePath.Right(1) = "\" Then sourcePath = sourcePath.Left(sourcePath.Length - 1)
		  
		  // Use the `move` command to actually move the folder.
		  Var s As New Shell
		  s.ExecuteMode = Shell.ExecuteModes.Synchronous
		  Var command As String = "move /Y " + QUOTE + sourcePath + QUOTE + " " + _
		  QUOTE + destination.NativePath + QUOTE
		  s.Execute(command)
		  
		  // Return move's error code (if any).
		  If s.ExitCode = 0 Then
		    Return Errors.None
		  Else
		    Return Errors.MoveError
		  End
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mInitialised As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected protectedFolderItems As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected safeMode As Boolean = True
	#tag EndProperty


	#tag Constant, Name = kVersionBug, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kVersionMajor, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kVersionMinor, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QUOTE, Type = String, Dynamic = False, Default = \"\"", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Errors, Type = Integer, Flags = &h1
		Aborted
		  AttemptToDeleteProtectedFolderItem
		  CpError
		  DestinationDoesNotExist
		  DestinationIsNil
		  MoveError
		  None
		  SourceDoesNotExist
		  SourceIsNil
		  UnableToCreateDestinationFolder
		  UnableToDeleteFile
		  UnableToDeleteFolder
		  Unknown
		XcopyDiskWriteError
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
