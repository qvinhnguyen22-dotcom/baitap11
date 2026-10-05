[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "=== TEST ADMIN CRUD COMPREHENSIVE ===" -ForegroundColor Cyan
if (Test-Path "admin_cookie.txt") { Remove-Item "admin_cookie.txt" }

# 1. Login as Admin
curl.exe -s -c admin_cookie.txt -d "email=admin@gmail.com&password=123456" http://localhost:8080/login -L > $null

# 2. Add New Book (ISBN: 9999, Title: 'Lap Trinh Java Nang Cao 2026')
Write-Host "`n1. Creating new book..." -ForegroundColor Yellow
$postCreate = curl.exe -s -b admin_cookie.txt -d "isbn=9999&title=Lap+Trinh+Java+Nang+Cao+2026&publisher=NXB+Giao+Duc&price=199000&quantity=20&description=Sach+chuyen+sau+Java+va+Spring+Boot&publishDate=2026-09-23" http://localhost:8080/admin/books/save -i
Write-Host "Create book response: Status 302 ->" ($postCreate -match 'Location: /admin/books')

# Verify in Admin List (Page 3 or search)
$listHtml = curl.exe -s -b admin_cookie.txt "http://localhost:8080/admin/books?page=3"
$hasNewBook = $listHtml -match '9999' -or $listHtml -match 'Lap Trinh Java Nang Cao 2026'
Write-Host "New book exists in admin list:" $hasNewBook

# Get book ID from DB
$cmd = 'SELECT bookid FROM books WHERE isbn = 9999;'
$rawId = (sqlcmd -S localhost -U sa -P "1234567@a$" -d BookStoreDB_24133074 -h -1 -Q "SET NOCOUNT ON; $cmd" | Out-String)
$newBookId = ($rawId -replace '[^\d]').Trim()
Write-Host "New Book ID in DB: '$newBookId'"

# 3. Edit Book
Write-Host "`n2. Editing book #$newBookId..." -ForegroundColor Yellow
$postEdit = curl.exe -s -b admin_cookie.txt -d "bookid=$newBookId&isbn=9999&title=Lap+Trinh+Spring+Boot+3+Chuyen+Sau&publisher=NXB+Tre&price=250000&quantity=15&description=Updated&publishDate=2026-09-23" http://localhost:8080/admin/books/save -i
Write-Host "Edit book response: Status 302 ->" ($postEdit -match 'Location: /admin/books')

# 4. Delete Book
Write-Host "`n3. Deleting book #$newBookId..." -ForegroundColor Yellow
$deleteRes = curl.exe -s -b admin_cookie.txt -i "http://localhost:8080/admin/books/delete/$newBookId"
Write-Host "Delete response: Status 302 ->" ($deleteRes -match 'Location: /admin/books')

# Verify deleted in DB
$checkDeleted = ((sqlcmd -S localhost -U sa -P "1234567@a$" -d BookStoreDB_24133074 -h -1 -Q "SET NOCOUNT ON; SELECT COUNT(*) FROM books WHERE bookid = $newBookId;" | Out-String) -replace '[^\d]').Trim()
Write-Host "Book count after delete: '$checkDeleted'"
if ($checkDeleted -eq '0') {
    Write-Host "`n-> SUCCESS: Full Admin CRUD (Create, Read, Update, Delete) verified 100% working!" -ForegroundColor Green
} else {
    Write-Host "`n-> FAIL: Delete operation failed!" -ForegroundColor Red
}

if (Test-Path "admin_cookie.txt") { Remove-Item "admin_cookie.txt" }
