Add-Type -AssemblyName System.Drawing

$covers = @(
    @{
        File = "cho_toi_xin_mot_ve.jpg"
        Title = "CHO TÔI XIN MỘT VÉ ĐI TUỔI THƠ"
        Author = "NGUYỄN NHẬT ÁNH"
        Publisher = "NXB TRẺ"
        Category = "VĂN HỌC THIẾU NHI"
        Color1 = [System.Drawing.Color]::FromArgb(230, 126, 34)
        Color2 = [System.Drawing.Color]::FromArgb(186, 74, 0)
        Accent = [System.Drawing.Color]::FromArgb(254, 249, 231)
    },
    @{
        File = "harry_potter_2.jpg"
        Title = "HARRY POTTER VÀ PHÒNG CHỨA BÍ MẬT"
        Author = "J.K. ROWLING"
        Publisher = "NXB TRẺ"
        Category = "VĂN HỌC HUYỀN ẢO"
        Color1 = [System.Drawing.Color]::FromArgb(44, 62, 80)
        Color2 = [System.Drawing.Color]::FromArgb(20, 90, 50)
        Accent = [System.Drawing.Color]::FromArgb(244, 208, 63)
    },
    @{
        File = "chi_pheo.jpg"
        Title = "CHÍ PHÈO"
        Author = "NAM CAO"
        Publisher = "NXB VĂN HỌC"
        Category = "VĂN HỌC HIỆN THỰC"
        Color1 = [System.Drawing.Color]::FromArgb(120, 40, 31)
        Color2 = [System.Drawing.Color]::FromArgb(64, 21, 16)
        Accent = [System.Drawing.Color]::FromArgb(245, 238, 248)
    },
    @{
        File = "lao_hac.jpg"
        Title = "LÃO HẠC"
        Author = "NAM CAO"
        Publisher = "NXB KIM ĐỒNG"
        Category = "VĂN HỌC KINH ĐIỂN"
        Color1 = [System.Drawing.Color]::FromArgb(110, 44, 0)
        Color2 = [System.Drawing.Color]::FromArgb(62, 34, 18)
        Accent = [System.Drawing.Color]::FromArgb(250, 229, 211)
    },
    @{
        File = "dac_nhan_tam.jpg"
        Title = "ĐẮC NHÂN TÂM"
        Author = "DALE CARNEGIE"
        Publisher = "NXB TỔNG HỢP TP.HCM"
        Category = "NGHỆ THUẬT SỐNG"
        Color1 = [System.Drawing.Color]::FromArgb(192, 57, 43)
        Color2 = [System.Drawing.Color]::FromArgb(100, 30, 22)
        Accent = [System.Drawing.Color]::FromArgb(255, 241, 118)
    },
    @{
        File = "quang_ganh_lo.jpg"
        Title = "QUẲNG GÁNH LO ĐI VÀ VUI SỐNG"
        Author = "DALE CARNEGIE"
        Publisher = "NXB TỔNG HỢP TP.HCM"
        Category = "KỸ NĂNG SỐNG"
        Color1 = [System.Drawing.Color]::FromArgb(22, 160, 133)
        Color2 = [System.Drawing.Color]::FromArgb(14, 98, 81)
        Accent = [System.Drawing.Color]::FromArgb(232, 248, 245)
    },
    @{
        File = "rung_na_uy.jpg"
        Title = "RỪNG NA UY"
        Author = "HARUKI MURAKAMI"
        Publisher = "NXB HỘI NHÀ VĂN"
        Category = "TIỂU THUYẾT KINH ĐIỂN"
        Color1 = [System.Drawing.Color]::FromArgb(142, 68, 173)
        Color2 = [System.Drawing.Color]::FromArgb(74, 35, 90)
        Accent = [System.Drawing.Color]::FromArgb(245, 238, 248)
    },
    @{
        File = "kafka_ben_bo_bien.jpg"
        Title = "KAFKA BÊN BỜ BIỂN"
        Author = "HARUKI MURAKAMI"
        Publisher = "NXB HỘI NHÀ VĂN"
        Category = "VĂN HỌC HIỆN ĐẠI"
        Color1 = [System.Drawing.Color]::FromArgb(41, 128, 185)
        Color2 = [System.Drawing.Color]::FromArgb(21, 67, 96)
        Accent = [System.Drawing.Color]::FromArgb(235, 245, 251)
    },
    @{
        File = "nha_gia_kim.jpg"
        Title = "NHÀ GIẢ KIM"
        Author = "PAULO COELHO"
        Publisher = "NXB HÀ NỘI"
        Category = "TIỂU THUYẾT TRIẾT LÝ"
        Color1 = [System.Drawing.Color]::FromArgb(212, 172, 13)
        Color2 = [System.Drawing.Color]::FromArgb(125, 102, 8)
        Accent = [System.Drawing.Color]::FromArgb(254, 249, 231)
    },
    @{
        File = "1984.jpg"
        Title = "MỘT CHÍN TÁM TƯ (1984)"
        Author = "GEORGE ORWELL"
        Publisher = "NXB VĂN HỌC"
        Category = "VĂN HỌC THẾ GIỚI"
        Color1 = [System.Drawing.Color]::FromArgb(52, 73, 94)
        Color2 = [System.Drawing.Color]::FromArgb(23, 32, 42)
        Accent = [System.Drawing.Color]::FromArgb(236, 112, 99)
    },
    @{
        File = "chuyen_o_nong_trai.jpg"
        Title = "CHUYỆN Ở NÔNG TRẠI"
        Author = "GEORGE ORWELL"
        Publisher = "NXB HỘI NHÀ VĂN"
        Category = "NGỤ NGÔN KINH ĐIỂN"
        Color1 = [System.Drawing.Color]::FromArgb(39, 174, 96)
        Color2 = [System.Drawing.Color]::FromArgb(20, 90, 50)
        Accent = [System.Drawing.Color]::FromArgb(244, 208, 63)
    },
    @{
        File = "sherlock_holmes.jpg"
        Title = "SHERLOCK HOLMES TOÀN TẬP"
        Author = "ARTHUR CONAN DOYLE"
        Publisher = "NXB VĂN HỌC"
        Category = "TRINH THÁM KINH ĐIỂN"
        Color1 = [System.Drawing.Color]::FromArgb(33, 47, 61)
        Color2 = [System.Drawing.Color]::FromArgb(18, 26, 34)
        Accent = [System.Drawing.Color]::FromArgb(245, 176, 65)
    }
)

$targetDir = "uploads/covers"
if (!(Test-Path $targetDir)) {
    New-Item -ItemType Directory -Force -Path $targetDir
}

$width = 450
$height = 600

foreach ($c in $covers) {
    $outPath = Join-Path $targetDir $c.File
    Write-Host "Creating cover: $outPath..."

    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

    # 1. Background gradient
    $rect = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
    $brushBg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $c.Color1, $c.Color2, 55.0)
    $g.FillRectangle($brushBg, $rect)

    # 2. Texture lines (subtle diagonal pattern)
    $penPattern = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(15, 255, 255, 255), 1)
    for ($i = -600; $i -lt 1000; $i += 40) {
        $g.DrawLine($penPattern, $i, 0, $i + 600, 600)
    }

    # 3. Outer Border
    $penBorder = New-Object System.Drawing.Pen($c.Accent, 3)
    $g.DrawRectangle($penBorder, 20, 20, $width - 40, $height - 40)

    # 4. Inner Border
    $penInner = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(120, $c.Accent.R, $c.Accent.G, $c.Accent.B), 1)
    $g.DrawRectangle($penInner, 26, 26, $width - 52, $height - 52)

    # 5. Corner Ornaments
    $cornerBrush = New-Object System.Drawing.SolidBrush($c.Accent)
    $g.FillEllipse($cornerBrush, 17, 17, 8, 8)
    $g.FillEllipse($cornerBrush, $width - 25, 17, 8, 8)
    $g.FillEllipse($cornerBrush, 17, $height - 25, 8, 8)
    $g.FillEllipse($cornerBrush, $width - 25, $height - 25, 8, 8)

    # Formatters
    $sfCenter = New-Object System.Drawing.StringFormat
    $sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
    $sfCenter.LineAlignment = [System.Drawing.StringAlignment]::Center

    # Category Badge
    $fontCat = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $rectCat = New-Object System.Drawing.RectangleF(40, 50, $width - 80, 30)
    $g.DrawString($c.Category, $fontCat, $cornerBrush, $rectCat, $sfCenter)

    # Decorative Line Under Category
    $penSep = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, $c.Accent.R, $c.Accent.G, $c.Accent.B), 1.5)
    $g.DrawLine($penSep, 120, 85, $width - 120, 85)

    # Title Box
    $titleLen = $c.Title.Length
    $fontSize = if ($titleLen -gt 25) { 20 } elseif ($titleLen -gt 15) { 24 } else { 28 }
    $fontTitle = New-Object System.Drawing.Font("Segoe UI", $fontSize, [System.Drawing.FontStyle]::Bold)
    $brushTitle = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $rectTitle = New-Object System.Drawing.RectangleF(40, 130, $width - 80, 160)
    $g.DrawString($c.Title, $fontTitle, $brushTitle, $rectTitle, $sfCenter)

    # Star / Diamond Ornament in Center
    $fontStar = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Regular)
    $rectStar = New-Object System.Drawing.RectangleF(40, 310, $width - 80, 40)
    $g.DrawString("★ ★ ★", $fontStar, $cornerBrush, $rectStar, $sfCenter)

    # Author Name Box
    $fontAuthor = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $brushAuthor = New-Object System.Drawing.SolidBrush($c.Accent)
    $rectAuthor = New-Object System.Drawing.RectangleF(40, 380, $width - 80, 50)
    $g.DrawString($c.Author, $fontAuthor, $brushAuthor, $rectAuthor, $sfCenter)

    # Decorative Line Above Publisher
    $g.DrawLine($penSep, 80, 500, $width - 80, 500)

    # Publisher
    $fontPub = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Regular)
    $brushPub = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(210, 255, 255, 255))
    $rectPub = New-Object System.Drawing.RectangleF(40, 515, $width - 80, 35)
    $g.DrawString($c.Publisher, $fontPub, $brushPub, $rectPub, $sfCenter)

    # Save as high-quality JPEG
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]95)
    $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }

    $bmp.Save($outPath, $jpegCodec, $encoderParams)

    $g.Dispose()
    $bmp.Dispose()
}

Write-Host "Completed generating all covers!"
