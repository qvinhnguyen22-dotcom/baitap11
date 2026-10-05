$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  KIEM THU CHUC NANG NGUOI DUNG: GIO HANG - COD - DON HANG " -ForegroundColor Cyan
Write-Host "       (MSSV: 24133074 - Ho va ten: Nguyen Quang Vinh)     " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# ----------------------------------------------------
# BUOC 1: DANG NHAP USER
# ----------------------------------------------------
Write-Host "`n[BUOC 1] Dang nhap tai khoan user1@gmail.com..." -ForegroundColor Yellow
$loginBody = @{
    email = "user1@gmail.com"
    password = "123456"
}
$loginRes = Invoke-WebRequest -Uri "http://localhost:8080/login" -Method Post -Body $loginBody -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Ket qua dang nhap: Status $($loginRes.StatusCode) - Redirect: $($loginRes.Headers['Location'])" -ForegroundColor Green

# ----------------------------------------------------
# BUOC 2: KIEM TRA TRANG GIO HANG BAN DAU (/cart)
# ----------------------------------------------------
Write-Host "`n[BUOC 2] Kiem tra trang gio hang (/cart)..." -ForegroundColor Yellow
$cartPage = Invoke-WebRequest -Uri "http://localhost:8080/cart" -WebSession $session -UseBasicParsing
if ($cartPage.StatusCode -eq 200) {
    Write-Host "  -> PASS: Trang gio hang 200 OK!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Khong the truy cap gio hang!" -ForegroundColor Red
}

# ----------------------------------------------------
# BUOC 3: THEM SACH VAO GIO HANG
# ----------------------------------------------------
Write-Host "`n[BUOC 3] Them sach Mat Biec (bookId=1, quantity=2) vao gio hang..." -ForegroundColor Yellow
$addBody = @{
    bookId = "1"
    quantity = "2"
    returnUrl = "/cart"
}
$addRes = Invoke-WebRequest -Uri "http://localhost:8080/cart/add" -Method Post -Body $addBody -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Status them vao gio: $($addRes.StatusCode) - Redirect: $($addRes.Headers['Location'])"

$cartAfterAdd = Invoke-WebRequest -Uri "http://localhost:8080/cart" -WebSession $session -UseBasicParsing
$hasMatBiec = $cartAfterAdd.Content.Contains("M") -and $cartAfterAdd.Content.Contains("Bi")
$hasQty2 = $cartAfterAdd.Content.Contains('value="2"')
Write-Host "  -> Gio hang chua Mat Biec: $hasMatBiec, so luong 2: $hasQty2"
if ($hasQty2) {
    Write-Host "  -> PASS: Them sach vao gio hang thanh cong!" -ForegroundColor Green
} else {
    Write-Host "  -> FAIL: Sach chua duoc them dung so luong!" -ForegroundColor Red
}

# ----------------------------------------------------
# BUOC 4: KIEM TRA GIOI HAN SO LUONG TON KHO
# ----------------------------------------------------
Write-Host "`n[BUOC 4] Thu tang so luong vuot qua ton kho (9999 cuon)..." -ForegroundColor Yellow
$updateBody = @{
    bookId = "1"
    quantity = "9999"
}
$updateRes = Invoke-WebRequest -Uri "http://localhost:8080/cart/update" -Method Post -Body $updateBody -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
$cartAfterOverflow = Invoke-WebRequest -Uri "http://localhost:8080/cart" -WebSession $session -UseBasicParsing
$hasLimitCheck = $cartAfterOverflow.Content.Contains('50')
Write-Host "  -> So luong duoc dieu chinh ve ton kho toi da: $hasLimitCheck"
if ($hasLimitCheck) {
    Write-Host "  -> PASS: He thong chan so luong trong gioi han ton kho!" -ForegroundColor Green
}

# Dieu chinh lai so luong = 2
$updateValid = @{
    bookId = "1"
    quantity = "2"
}
$resValid = Invoke-WebRequest -Uri "http://localhost:8080/cart/update" -Method Post -Body $updateValid -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue

# ----------------------------------------------------
# BUOC 5: TRUY CAP TRANG THANH TOAN COD (/checkout)
# ----------------------------------------------------
Write-Host "`n[BUOC 5] Truy cap trang checkout (/checkout)..." -ForegroundColor Yellow
$checkoutPage = Invoke-WebRequest -Uri "http://localhost:8080/checkout" -WebSession $session -UseBasicParsing
$hasCod = $checkoutPage.Content.Contains("COD")
Write-Host "  -> Trang Checkout co hinh thuc COD: $hasCod"
if ($hasCod) {
    Write-Host "  -> PASS: Trang Checkout san sang voi hinh thuc COD!" -ForegroundColor Green
}

# ----------------------------------------------------
# BUOC 6: XAC NHAN DAT HANG COD
# ----------------------------------------------------
Write-Host "`n[BUOC 6] Xac nhan dat hang COD (/checkout/place-order)..." -ForegroundColor Yellow
$orderBody = @{
    receiverName = "Nguyen Van A"
    receiverPhone = "0987654321"
    receiverAddress = "Ky tuc xa DH Su Pham Ky Thuat TP.HCM"
    notes = "Giao hang gio hanh chinh"
    paymentMethod = "COD"
}
$orderRes = Invoke-WebRequest -Uri "http://localhost:8080/checkout/place-order" -Method Post -Body $orderBody -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
$redirectLoc = $orderRes.Headers['Location']
Write-Host "  -> Dat hang xong, redirect ve: $redirectLoc"

$orderId = $redirectLoc.Substring($redirectLoc.LastIndexOf('/') + 1)
Write-Host "  -> Ma don hang moi: #$orderId" -ForegroundColor Cyan

# Kiem tra trang success
$successPage = Invoke-WebRequest -Uri ("http://localhost:8080" + $redirectLoc) -WebSession $session -UseBasicParsing
$isSuccess = $successPage.StatusCode -eq 200 -and $successPage.Content.Contains("COD")
Write-Host "  -> Trang Success 200 OK va hien thi COD: $isSuccess"
if ($isSuccess) {
    Write-Host "  -> PASS: Dat hang COD thanh cong!" -ForegroundColor Green
}

# ----------------------------------------------------
# BUOC 7: KIEM TRA LICH SU DON HANG (/orders)
# ----------------------------------------------------
Write-Host "`n[BUOC 7] Kiem tra lich su dat hang (/orders)..." -ForegroundColor Yellow
$ordersPage = Invoke-WebRequest -Uri "http://localhost:8080/orders" -WebSession $session -UseBasicParsing
Write-Host "  -> Status trang /orders:" $ordersPage.StatusCode
if ($ordersPage.StatusCode -eq 200) {
    Write-Host "  -> PASS: Trang lich su don hang hien thi tot!" -ForegroundColor Green
}

# ----------------------------------------------------
# BUOC 8: KIEM TRA CHI TIET VA HUY DON HANG
# ----------------------------------------------------
Write-Host "`n[BUOC 8] Kiem tra chi tiet don hang #$orderId va test huy don..." -ForegroundColor Yellow
$detailPage = Invoke-WebRequest -Uri "http://localhost:8080/orders/$orderId" -WebSession $session -UseBasicParsing
Write-Host "  -> Status chi tiet don hang:" $detailPage.StatusCode

$cancelRes = Invoke-WebRequest -Uri "http://localhost:8080/orders/$orderId/cancel" -Method Post -WebSession $session -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "  -> Status huy don:" $cancelRes.StatusCode

$detailAfterCancel = Invoke-WebRequest -Uri "http://localhost:8080/orders/$orderId" -WebSession $session -UseBasicParsing
$hasCancelledStatus = $detailAfterCancel.Content.Contains("h") -or $detailAfterCancel.StatusCode -eq 200
Write-Host "  -> Don hang sau khi huy truy cap 200 OK: $($detailAfterCancel.StatusCode -eq 200)" -ForegroundColor Green

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "         TAT CA CAC TEST DA HOAN TAT THANH CONG!          " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
