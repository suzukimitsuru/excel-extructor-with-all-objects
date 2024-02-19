-- ディレクトリの作成
on MakeDirectory(directory)
	try
		do shell script "mkdir -p '" & directory & "'"
		return ""
	on error number n
		return n
	end try
end MakeDirectory

-- クリップボードを画像ファイルに抽出する
on ClipboardToImageFile(filename)
	try
		set png_data to the clipboard as «class PNGf»
		set the_file to open for access POSIX path of (POSIX file filename) with write permission
		write png_data to the_file
		-- close access the_file
		return ""
	on error number n
		return n
	end try
end ClipboardToImageFile
