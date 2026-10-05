using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Drawing.Text;

public class CoverGenerator
{
    public static void CreateCover(
        string outputPath,
        string title,
        string author,
        string publisher,
        string category,
        int r1, int g1, int b1,
        int r2, int g2, int b2,
        int ar, int ag, int ab)
    {
        int width = 450;
        int height = 600;

        Color bgTop = Color.FromArgb(r1, g1, b1);
        Color bgBottom = Color.FromArgb(r2, g2, b2);
        Color accentColor = Color.FromArgb(ar, ag, ab);

        using (Bitmap bmp = new Bitmap(width, height))
        using (Graphics g = Graphics.FromImage(bmp))
        {
            g.SmoothingMode = SmoothingMode.AntiAlias;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            g.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;

            // 1. Background gradient
            Rectangle rect = new Rectangle(0, 0, width, height);
            using (LinearGradientBrush bgBrush = new LinearGradientBrush(rect, bgTop, bgBottom, 50f))
            {
                g.FillRectangle(bgBrush, rect);
            }

            // 2. Subtle diagonal line texture
            using (Pen texturePen = new Pen(Color.FromArgb(14, 255, 255, 255), 1))
            {
                for (int i = -600; i < 1100; i += 36)
                {
                    g.DrawLine(texturePen, i, 0, i + 600, 600);
                }
            }

            // 3. Borders
            using (Pen borderPen = new Pen(accentColor, 3))
            {
                g.DrawRectangle(borderPen, 18, 18, width - 36, height - 36);
            }
            using (Pen innerPen = new Pen(Color.FromArgb(100, accentColor), 1))
            {
                g.DrawRectangle(innerPen, 24, 24, width - 48, height - 48);
            }

            // 4. Corner Ornaments
            using (SolidBrush accentBrush = new SolidBrush(accentColor))
            {
                g.FillEllipse(accentBrush, 14, 14, 8, 8);
                g.FillEllipse(accentBrush, width - 22, 14, 8, 8);
                g.FillEllipse(accentBrush, 14, height - 22, 8, 8);
                g.FillEllipse(accentBrush, width - 22, height - 22, 8, 8);
            }

            StringFormat sf = new StringFormat
            {
                Alignment = StringAlignment.Center,
                LineAlignment = StringAlignment.Center
            };

            // 5. Category
            using (Font catFont = new Font("Segoe UI", 11, FontStyle.Bold))
            using (SolidBrush catBrush = new SolidBrush(accentColor))
            {
                g.DrawString(category.ToUpper(), catFont, catBrush, new RectangleF(35, 50, width - 70, 30), sf);
            }

            // Line under Category
            using (Pen sepPen = new Pen(Color.FromArgb(160, accentColor), 1.5f))
            {
                g.DrawLine(sepPen, 130, 88, width - 130, 88);
            }

            // 6. Title
            float titleSize = title.Length > 28 ? 20f : (title.Length > 18 ? 24f : 28f);
            using (Font titleFont = new Font("Segoe UI", titleSize, FontStyle.Bold))
            using (SolidBrush titleBrush = new SolidBrush(Color.White))
            {
                g.DrawString(title, titleFont, titleBrush, new RectangleF(35, 130, width - 70, 160), sf);
            }

            // 7. Middle Ornament
            using (Font starFont = new Font("Segoe UI", 18, FontStyle.Regular))
            using (SolidBrush starBrush = new SolidBrush(accentColor))
            {
                g.DrawString("◆  ◆  ◆", starFont, starBrush, new RectangleF(35, 300, width - 70, 35), sf);
            }

            // 8. Author
            using (Font authorFont = new Font("Segoe UI", 15, FontStyle.Bold))
            using (SolidBrush authorBrush = new SolidBrush(accentColor))
            {
                g.DrawString(author.ToUpper(), authorFont, authorBrush, new RectangleF(35, 365, width - 70, 50), sf);
            }

            // Line above Publisher
            using (Pen sepPen = new Pen(Color.FromArgb(120, accentColor), 1f))
            {
                g.DrawLine(sepPen, 90, 500, width - 90, 500);
            }

            // 9. Publisher
            using (Font pubFont = new Font("Segoe UI", 11, FontStyle.Regular))
            using (SolidBrush pubBrush = new SolidBrush(Color.FromArgb(220, 240, 240, 240)))
            {
                g.DrawString(publisher, pubFont, pubBrush, new RectangleF(35, 515, width - 70, 35), sf);
            }

            // Save JPEG
            ImageCodecInfo jpegCodec = null;
            foreach (ImageCodecInfo codec in ImageCodecInfo.GetImageEncoders())
            {
                if (codec.MimeType == "image/jpeg")
                {
                    jpegCodec = codec;
                    break;
                }
            }

            EncoderParameters encoderParams = new EncoderParameters(1);
            encoderParams.Param[0] = new EncoderParameter(Encoder.Quality, 95L);

            bmp.Save(outputPath, jpegCodec, encoderParams);
        }
    }
}
