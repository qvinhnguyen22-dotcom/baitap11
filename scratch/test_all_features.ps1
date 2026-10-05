$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "         TESTING BOOKSTORE (MSSV: 24133074 - DE 02)       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. TEST HOME & UTF-8
Write-Host "`n[TEST 1] Testing Home Page and UTF-8 Rendering..." -ForegroundColor Yellow
$homeRes = Invoke-WebRequest -Uri "http://localhost:8080/home" -UseBasicParsing
if ($homeRes.StatusCode -eq 200 -and $homeRes.Content.Contains("Mắt Biếc") -and $homeRes.Content.Contains("Nguyễn Nhật Ánh")) {
    Write-Host "  -> PASS: Home page rendered 200 OK with correct Vietnamese characters!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Home page missing expected UTF-8 content!" -ForegroundColor Red
}

# 2. TEST AUTH & SESSION REDIRECT (USER)
Write-Host "`n[TEST 2] Testing User Login & Session Handling..." -ForegroundColor Yellow
$userSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Login as normal user
$loginBody = @{
    email = "user1@gmail.com"
    password = "123456"
}
$loginRes = Invoke-WebRequest -Uri "http://localhost:8080/login" -Method Post -Body $loginBody -WebSession $userSession -MaximumRedirection 0 -ErrorAction SilentlyContinue

# Should redirect (302) to /home
Write-Host "  -> User login response status:" $loginRes.StatusCode "(Redirect to: $($loginRes.Headers['Location']))" -ForegroundColor Gray

# Now access /home with user session
$userHome = Invoke-WebRequest -Uri "http://localhost:8080/home" -WebSession $userSession -UseBasicParsing
$hasUserTag = $userHome.Content.Contains("Nguyễn Văn A")
$hasAdminBtn = $userHome.Content.Contains("Trang quản trị")
Write-Host "  -> User session has user name: $hasUserTag, has Admin button: $hasAdminBtn"
if ($hasUserTag -and -not $hasAdminBtn) {
    Write-Host "  -> PASS: Normal user sees their name and does NOT see Admin button!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: User header display check failed!" -ForegroundColor Red
}

# Try accessing /login while logged in as user
$loginRedirect = Invoke-WebRequest -Uri "http://localhost:8080/login" -WebSession $userSession -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Access /login while logged in: Status $($loginRedirect.StatusCode), Location $($loginRedirect.Headers['Location'])"
if ($loginRedirect.StatusCode -eq 302 -and $loginRedirect.Headers['Location'] -eq "/home") {
    Write-Host "  -> PASS: Accessing /login while logged in automatically redirects to /home!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: /login did not redirect logged in user!" -ForegroundColor Red
}

# 3. TEST AUTH & SESSION REDIRECT (ADMIN)
Write-Host "`n[TEST 3] Testing Admin Login & Navigation..." -ForegroundColor Yellow
$adminSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Login as admin
$adminLoginBody = @{
    email = "admin@gmail.com"
    password = "123456"
}
$adminLoginRes = Invoke-WebRequest -Uri "http://localhost:8080/login" -Method Post -Body $adminLoginBody -WebSession $adminSession -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Admin login response status:" $adminLoginRes.StatusCode "(Redirect to: $($adminLoginRes.Headers['Location']))" -ForegroundColor Gray

# Check Admin access to /home - header MUST contain "Trang quản trị"
$adminHome = Invoke-WebRequest -Uri "http://localhost:8080/home" -WebSession $adminSession -UseBasicParsing
$adminHasBtn = $adminHome.Content.Contains("Trang quản trị")
Write-Host "  -> Admin session on /home has 'Trang quản trị' button: $adminHasBtn"
if ($adminHasBtn) {
    Write-Host "  -> PASS: Header correctly displays 'Trang quản trị' for Admin!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin button missing from Header!" -ForegroundColor Red
}

# Try accessing /login while logged in as admin
$adminLoginRedirect = Invoke-WebRequest -Uri "http://localhost:8080/login" -WebSession $adminSession -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Admin accessing /login: Status $($adminLoginRedirect.StatusCode), Location $($adminLoginRedirect.Headers['Location'])"
if ($adminLoginRedirect.StatusCode -eq 302 -and $adminLoginRedirect.Headers['Location'] -eq "/admin/books") {
    Write-Host "  -> PASS: Admin accessing /login automatically redirects to /admin/books!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Admin /login redirect check failed!" -ForegroundColor Red
}

# 4. TEST ADMIN CRUD & PAGINATION
Write-Host "`n[TEST 4] Testing Admin Books CRUD..." -ForegroundColor Yellow
$adminBooks = Invoke-WebRequest -Uri "http://localhost:8080/admin/books" -WebSession $adminSession -UseBasicParsing
Write-Host "  -> Admin books list status:" $adminBooks.StatusCode "Contains 'Quản Lý Danh Mục Sách':" ($adminBooks.Content.Contains("Quản Lý Danh Mục Sách"))

# Test Create Form
$createForm = Invoke-WebRequest -Uri "http://localhost:8080/admin/books/create" -WebSession $adminSession -UseBasicParsing
Write-Host "  -> Admin create form status:" $createForm.StatusCode "Contains author select:" ($createForm.Content.Contains("Nguyễn Nhật Ánh"))

# 5. TEST BOOK DETAIL & REVIEW
Write-Host "`n[TEST 5] Testing Book Detail & Reviews..." -ForegroundColor Yellow
$bookDetail = Invoke-WebRequest -Uri "http://localhost:8080/book/1" -WebSession $adminSession -UseBasicParsing
$hasTitle = $bookDetail.Content.Contains("Mắt Biếc")
$hasReviews = $bookDetail.Content.Contains("Sách rất hay và cảm động!")
Write-Host "  -> Book #1 Detail has title: $hasTitle, has initial review: $hasReviews"
if ($hasTitle -and $hasReviews) {
    Write-Host "  -> PASS: Book detail and reviews displayed with full UTF-8!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Book detail display check failed!" -ForegroundColor Red
}

# Test Posting a new Review
$reviewBody = @{
    rating = "5"
    review_text = "Đánh giá kiểm thử tự động - chất lượng sách tuyệt vời!"
}
$postReview = Invoke-WebRequest -Uri "http://localhost:8080/book/1/review" -Method Post -Body $reviewBody -WebSession $userSession -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Submit review status:" $postReview.StatusCode

$bookDetailAfter = Invoke-WebRequest -Uri "http://localhost:8080/book/1" -WebSession $userSession -UseBasicParsing
$hasNewReview = $bookDetailAfter.Content.Contains("Đánh giá kiểm thử tự động - chất lượng sách tuyệt vời!")
Write-Host "  -> Book #1 has new review:" $hasNewReview
if ($hasNewReview) {
    Write-Host "  -> PASS: New review saved and displayed correctly!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: New review not found!" -ForegroundColor Red
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "                 ALL TESTS COMPLETED                      " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
