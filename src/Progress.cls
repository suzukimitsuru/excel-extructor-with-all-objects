VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Progress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

''' �o�ߌ^
Private Type Progressing
    Current As Long
    Count As Long
End Type

Private mFileNumber As Integer
Private mFileIsOpend As Boolean
Private mView As Range
Private mSheets As Progressing
Private mCells As Progressing
Private mShapes As Progressing

''' �N���X����
Private Sub Class_Initialize()
    mFileNumber = FreeFile()
    mFileIsOpend = False
End Sub

''' �N���X�j��
Private Sub Class_Terminate()
    Set mView = Nothing
End Sub

''' �\���Z���̐ݒ�
Public Sub SetView(ocell As Range)
    Set mView = ocell
End Sub

''' �G���[�\��
Public Sub ErrorView(smessage As String)
    mView.Font.Color = RGB(255, 0, 0)
    mView.Value = smessage
End Sub

''' �t�@�C�����J��
Public Function FileOpen(filename As String)
    FileOpen = ""
    On Error GoTo ErrorHandler

    Open filename For Output As #mFileNumber
    mFileIsOpend = True

    On Error GoTo 0
    Exit Function
ErrorHandler:
    FileOpen = Err.Number & ":" & Err.Description
    Resume Next
End Function

''' �t�@�C�������
Public Function FileClose()
    FileClose = ""
    On Error GoTo ErrorHandler

    Close #mFileNumber
    mFileIsOpend = False

    On Error GoTo 0
    Exit Function
ErrorHandler:
    FileClose = Err.Number & ":" & Err.Description
    Resume Next
End Function

''' �t�@�C�����J���Ă��邩�Ԃ�
Public Property Get FileIsOpend() As Boolean
    FileIsOpend = mFileIsOpend
End Property

''' �t�@�C����1�s�o�͂���
Public Sub FilePrint(sline As String)
    Print #mFileNumber, sline
End Sub

''' �o�߂̐����W�v����
Public Sub ProgressSumCount(ncells As Integer, nsharps As Integer)
    mSheets.Count = mSheets.Count + 1
    mCells.Count = mCells.Count + ncells
    mShapes.Count = mShapes.Count + nsharps
End Sub

''' �Z�����J�E���g����
Public Sub ProgressCountupSheets()
    mSheets.Current = mSheets.Current +1
End Sub

''' �Z�����J�E���g����
Public Sub ProgressCountupCells()
    mCells.Current = mCells.Current +1
End Sub

''' �Z�����J�E���g����
Public Sub ProgressCountupShapes()
    mShapes.Current = mShapes.Current +1
End Sub

''' �G���[�\��
Public Sub ProgressView()
    mView.Font.Color = RGB(0, 0, 0)
    mView.Value = mSheets.Current & "/" & mSheets.Count & "�V�[�g " & _
        mCells.Current & "/" & mCells.Count & "�Z�� " & _
        mShapes.Current & "/" & mShapes.Count & "�}�`"
End Sub