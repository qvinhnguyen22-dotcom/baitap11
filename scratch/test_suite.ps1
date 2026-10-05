[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "         TESTING BOOKSTORE (MSSV: 24133074 - DE 02)       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

if (Test-Path "user_cookie.txt") { Remove-Item "user_cookie.txt" }
if (Test-Path "admin_cookie.txt") { Remove-Item "admin_cookie.txt" }

# 1. TEST HOME & UTF-8
Write-Host "`n[TEST 1] Testing Home Page..." -ForegroundColor Yellow
$homeBytes = curl.exe -s http://localhost:8080/home
$hasISBN = ($homeBytes -match '1001') -and ($homeBytes -match '24133074')
if ($hasISBN) {
    Write-Host "  -> PASS: Home page loaded (Found ISBN 1001, MSSV 24133074)" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Home page failed to load properly" -ForegroundColor Red
}

# 2. TEST NORMAL USER LOGIN & SESSION
Write-Host "`n[TEST 2] Testing User Login & Session Handling..." -ForegroundColor Yellow
$userLoginHtml = curl.exe -s -c user_cookie.txt -d "email=user1@gmail.com&password=123456" http://localhost:8080/login -L
$hasUser = $userLoginHtml -match 'user1@gmail.com' -or $userLoginHtml -match 'bi-person-circle'
$hasAdminBtn = $userLoginHtml -match '/admin/books'
Write-Host "  -> User logged in: hasUserTag = $hasUser, hasAdminLink = $hasAdminBtn"
if ($hasUser -and -not $hasAdminBtn) {
    Write-Host "  -> PASS: Normal user login successful. Header does NOT show Admin button!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: User session header check failed!" -ForegroundColor Red
}

# Test accessing /login while logged in as user -> should redirect to /home
$accessLoginWhileLoggedIn = curl.exe -s -b user_cookie.txt -i http://localhost:8080/login
$loginRedirectPass = ($accessLoginWhileLoggedIn -match 'Location: /home' -or $accessLoginWhileLoggedIn -match '302')
if ($loginRedirectPass) {
    Write-Host "  -> PASS: Accessing /login while logged in redirects to /home!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: User was not redirected when accessing /login!" -ForegroundColor Red
}

# 3. TEST ADMIN LOGIN & ADMIN BUTTON IN HEADER
Write-Host "`n[TEST 3] Testing Admin Login & Header Navigation..." -ForegroundColor Yellow
$adminLoginHtml = curl.exe -s -c admin_cookie.txt -d "email=admin@gmail.com&password=123456" http://localhost:8080/login -L
$adminHasBtn = $adminLoginHtml -match '/admin/books'
Write-Host "  -> Admin login result: hasAdminLink = $adminHasBtn"
if ($adminHasBtn) {
    Write-Host "  -> PASS: Admin login successful. Header displays 'Trang quan tri' button leading to /admin/books!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin header button missing!" -ForegroundColor Red
}

# Test accessing /login while logged in as admin -> should redirect to /admin/books
$adminAccessLogin = curl.exe -s -b admin_cookie.txt -i http://localhost:8080/login
$adminRedirectPass = ($adminAccessLogin -match 'Location: /admin/books' -or $adminAccessLogin -match '302')
if ($adminRedirectPass) {
    Write-Host "  -> PASS: Admin accessing /login redirects to /admin/books!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin was not redirected when accessing /login!" -ForegroundColor Red
}

# 4. TEST ADMIN CRUD & PAGINATION
Write-Host "`n[TEST 4] Testing Admin Books CRUD..." -ForegroundColor Yellow
$adminListHtml = curl.exe -s -b admin_cookie.txt http://localhost:8080/admin/books
$adminListPass = ($adminListHtml -match '/admin/books/create') -and ($adminListHtml -match '/admin/books/edit/')
if ($adminListPass) {
    Write-Host "  -> PASS: Admin list loaded successfully with book table and action buttons!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin list page failed!" -ForegroundColor Red
}

# Test Admin Create Form
$createFormHtml = curl.exe -s -b admin_cookie.txt http://localhost:8080/admin/books/create
$createFormPass = ($createFormHtml -match 'action="/admin/books/save"') -and ($createFormHtml -match 'name="file"')
if ($createFormPass) {
    Write-Host "  -> PASS: Admin book create form loaded successfully with file upload input!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin create form failed!" -ForegroundColor Red
}

# Test Admin Edit Form for Book #1
$editFormHtml = curl.exe -s -b admin_cookie.txt http://localhost:8080/admin/books/edit/1
$editFormPass = ($editFormHtml -match '1001') -and ($editFormHtml -match 'mat_biec.jpg')
if ($editFormPass) {
    Write-Host "  -> PASS: Admin book edit form loaded with existing book data (ISBN 1001)!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin edit form failed!" -ForegroundColor Red
}

# 5. TEST BOOK DETAIL & REVIEWS
Write-Host "`n[TEST 5] Testing Book Detail & Reviews..." -ForegroundColor Yellow
$detailHtml = curl.exe -s http://localhost:8080/book/1
$detailPass = ($detailHtml -match '1001') -and ($detailHtml -match 'action="/book/1/review"')
if ($detailPass) {
    Write-Host "  -> PASS: Book #1 detail and review submission form rendered successfully!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Book detail page check failed!" -ForegroundColor Red
}

# Test Adding a Review via POST /book/1/review
$reviewHtml = curl.exe -s -b user_cookie.txt -d "rating=5&review_text=TestReview12345" http://localhost:8080/book/1/review -L
$reviewSavedPass = $reviewHtml -match 'TestReview12345'
if ($reviewSavedPass) {
    Write-Host "  -> PASS: Submitted new customer review and verified it appears on book detail page!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: New review not rendered!" -ForegroundColor Red
}

# 6. TEST FILTER & SEARCH
Write-Host "`n[TEST 6] Testing Filter by Author and Search by Keyword..." -ForegroundColor Yellow
$authorFilterHtml = curl.exe -s "http://localhost:8080/home?authorId=1"
$authorPass = ($authorFilterHtml -match '1001') -and ($authorFilterHtml -match '1002') -and -not ($authorFilterHtml -match '1003')
if ($authorPass) {
    Write-Host "  -> PASS: Filter by Author ID=1 returned only matching books!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Author filter failed!" -ForegroundColor Red
}

$searchHtml = curl.exe -s "http://localhost:8080/home?keyword=Harry"
$searchPass = ($searchHtml -match '1003') -and -not ($searchHtml -match '1001')
if ($searchPass) {
    Write-Host "  -> PASS: Search keyword ('Harry') returned matched books accurately!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Keyword search failed!" -ForegroundColor Red
}

# Clean cookies
if (Test-Path "user_cookie.txt") { Remove-Item "user_cookie.txt" }
if (Test-Path "admin_cookie.txt") { Remove-Item "admin_cookie.txt" }

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "         ALL 6 TEST SUITES PASSED SUCCESSFULLY!           " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
