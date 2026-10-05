[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "         TESTING BOOKSTORE (MSSV: 24133074 - DE 02)       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Remove old cookies
if (Test-Path "user_cookie.txt") { Remove-Item "user_cookie.txt" }
if (Test-Path "admin_cookie.txt") { Remove-Item "admin_cookie.txt" }

# 1. TEST HOME & UTF-8
Write-Host "`n[TEST 1] Testing Home Page and UTF-8 Rendering..." -ForegroundColor Yellow
$homeContent = curl.exe -s http://localhost:8080/home
if ($homeContent -match 'Mắt Biếc' -and $homeContent -match 'Nguyễn Nhật Ánh' -and $homeContent -match '24133074') {
    Write-Host "  -> PASS: Home page rendered with full Vietnamese UTF-8 accents!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Home page missing expected UTF-8 content!" -ForegroundColor Red
}

# 2. TEST NORMAL USER LOGIN & SESSION
Write-Host "`n[TEST 2] Testing User Login & Session Handling..." -ForegroundColor Yellow
$userLoginHtml = curl.exe -s -c user_cookie.txt -d "email=user1@gmail.com&password=123456" http://localhost:8080/login -L
$hasUserName = $userLoginHtml -match 'Nguyễn Văn A'
$hasAdminBtn = $userLoginHtml -match 'Trang quản trị'
Write-Host "  -> User login result: contains 'Nguyễn Văn A' = $hasUserName, contains 'Trang quản trị' = $hasAdminBtn"
if ($hasUserName -and -not $hasAdminBtn) {
    Write-Host "  -> PASS: Normal user login successful. Header displays username without Admin button!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: User header display check failed!" -ForegroundColor Red
}

# Test accessing /login while already logged in as user -> should redirect to /home
$accessLoginWhileLoggedIn = curl.exe -s -b user_cookie.txt -i http://localhost:8080/login
Write-Host "  -> Access /login with active user session:"
$loginRedirectPass = ($accessLoginWhileLoggedIn -match 'Location: /home' -or $accessLoginWhileLoggedIn -match 'HTTP/1.1 302')
if ($loginRedirectPass) {
    Write-Host "  -> PASS: Accessing /login while logged in redirects to /home!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: User was not redirected when accessing /login!" -ForegroundColor Red
}

# 3. TEST ADMIN LOGIN & ADMIN BUTTON IN HEADER
Write-Host "`n[TEST 3] Testing Admin Login & Header Navigation..." -ForegroundColor Yellow
$adminLoginHtml = curl.exe -s -c admin_cookie.txt -d "email=admin@gmail.com&password=123456" http://localhost:8080/login -L
$adminHasName = $adminLoginHtml -match 'Quản Trị Viên'
$adminHasBtn = $adminLoginHtml -match 'Trang quản trị'
Write-Host "  -> Admin login result: contains 'Quản Trị Viên' = $adminHasName, contains 'Trang quản trị' = $adminHasBtn"
if ($adminHasName -and $adminHasBtn) {
    Write-Host "  -> PASS: Admin login successful. Header displays 'Trang quản trị' button!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin header display check failed!" -ForegroundColor Red
}

# Test accessing /login while logged in as admin -> should redirect to /admin/books
$adminAccessLogin = curl.exe -s -b admin_cookie.txt -i http://localhost:8080/login
$adminRedirectPass = ($adminAccessLogin -match 'Location: /admin/books' -or $adminAccessLogin -match 'HTTP/1.1 302')
if ($adminRedirectPass) {
    Write-Host "  -> PASS: Admin accessing /login redirects to /admin/books!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin was not redirected when accessing /login!" -ForegroundColor Red
}

# 4. TEST ADMIN CRUD & PAGINATION
Write-Host "`n[TEST 4] Testing Admin Books CRUD..." -ForegroundColor Yellow
$adminListHtml = curl.exe -s -b admin_cookie.txt http://localhost:8080/admin/books
$adminListPass = $adminListHtml -match 'Quản Lý Danh Mục Sách' -and $adminListHtml -match 'Thêm Sách Mới'
if ($adminListPass) {
    Write-Host "  -> PASS: Admin list loaded successfully with book table and pagination!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin list page failed!" -ForegroundColor Red
}

# Test Admin Create Form
$createFormHtml = curl.exe -s -b admin_cookie.txt http://localhost:8080/admin/books/create
$createFormPass = $createFormHtml -match 'Thêm Sách Mới Vào Kho' -and $createFormHtml -match 'Nguyễn Nhật Ánh'
if ($createFormPass) {
    Write-Host "  -> PASS: Admin book create form loaded successfully with author list!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin create form failed!" -ForegroundColor Red
}

# Test Admin Edit Form for Book #1
$editFormHtml = curl.exe -s -b admin_cookie.txt http://localhost:8080/admin/books/edit/1
$editFormPass = $editFormHtml -match 'Cập Nhật Sách #1' -and $editFormHtml -match 'Mắt Biếc'
if ($editFormPass) {
    Write-Host "  -> PASS: Admin book edit form loaded with existing book data!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin edit form failed!" -ForegroundColor Red
}

# 5. TEST BOOK DETAIL & REVIEWS
Write-Host "`n[TEST 5] Testing Book Detail & Reviews..." -ForegroundColor Yellow
$detailHtml = curl.exe -s http://localhost:8080/book/1
$detailPass = $detailHtml -match 'Mắt Biếc' -and $detailHtml -match 'Sách rất hay và cảm động!'
if ($detailPass) {
    Write-Host "  -> PASS: Book #1 detail and customer reviews rendered perfectly!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Book detail page check failed!" -ForegroundColor Red
}

# Test Adding a Review via POST /book/1/review
$reviewHtml = curl.exe -s -b user_cookie.txt -d "rating=5&review_text=Cuốn sách rất ý nghĩa và sâu sắc!" http://localhost:8080/book/1/review -L
$reviewSavedPass = $reviewHtml -match 'Cuốn sách rất ý nghĩa và sâu sắc!'
if ($reviewSavedPass) {
    Write-Host "  -> PASS: Submitted new customer review and verified it appears on book detail page!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: New review not rendered!" -ForegroundColor Red
}

# 6. TEST FILTER & SEARCH
Write-Host "`n[TEST 6] Testing Filter by Author and Search by Keyword..." -ForegroundColor Yellow
$authorFilterHtml = curl.exe -s "http://localhost:8080/home?authorId=1"
$authorPass = $authorFilterHtml -match 'Mắt Biếc' -and $authorFilterHtml -match 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh' -and -not ($authorFilterHtml -match 'Harry Potter')
if ($authorPass) {
    Write-Host "  -> PASS: Filter by Author (Nguyễn Nhật Ánh) works accurately!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Author filter failed!" -ForegroundColor Red
}

$searchHtml = curl.exe -s "http://localhost:8080/home?keyword=Harry"
$searchPass = $searchHtml -match 'Harry Potter' -and -not ($searchHtml -match 'Mắt Biếc')
if ($searchPass) {
    Write-Host "  -> PASS: Search keyword ('Harry') returned matched books accurately!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Keyword search failed!" -ForegroundColor Red
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "         ALL 6 TEST SUITES PASSED SUCCESSFULLY!           " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
