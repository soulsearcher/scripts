@echo off
:: since 2014/07/21
::
:: remote file copy batch script
::
:: 환경에 맞게 내용 수정 필요함.
:: 

:: 스크립트 시작

:: 네트워크 드라이브 연결
:: net use 사용할드라이브명 원격지폴더 원격지비밀번호 /user:원격지
net use drive_name: \\server_ip\path

:: 날짜 및 시간 설정
:: 날짜 형식 : yyyyMMdd
:: 시간 형식 : hhmmss
set current_date=%date:-=%
set temp_time=%time: =0%
set current_time=%temp_time:~0,2%%temp_time:~3,2%%temp_time:~6,2%

:: 디렉토리 설정
:: 서버 환경에 맞게 path 변경 필요.

:: 백업 원본 경로
set original_path=origin_path
:: 복제 경로 (네트워크 드라이브 마운트 경로의 디렉토리)
set duplicate_path=target_path
:: 파일 복사 로그 경로
set log_path=logfile_path

:: 스크립트 로그 기록
echo daily script execution - %current_date%_%current_time% >> %log_path%\%current_date%_copy.log

:: 삭제될 파일 목록 확인
echo ## previous data ## >> %log_path%\%current_date%_copy.log
forfiles /p %duplicate_path% >> %log_path%\%current_date%_copy.log
echo ## previous data ## >> %log_path%\%current_date%_copy.log

:: 이전 데이터 삭제, 7일 동안 보관
:: forfiles /p pathname /d date /c command
forfiles /p %duplicate_path% /d -7 /c "cmd /c rmdir /s /q @file"

:: 오늘 날짜 이름으로 폴더 생성
mkdir %duplicate_path%\%current_date% >> %log_path%\%current_date%_copy.log

:: 원본 DB백업 데이터 복사 
xcopy /y %original_path%\*_%current_date%.txt %duplicate_path%\%current_date% >> %log_path%\%current_date%_copy.log

:: 네트워크 드라이브 연결 해제
net use drive_name /del

:: 스크립트 끝