.so ths.tmac
.nr ths.pg 0
.EQ
delim off
.EN
.\" The title page
.ad ce
.<<
.sp |2i
.ps 24
.vs 30
.ft HD
بسته‌ی نیتراف برای نگارش پایان‌نامه
.sp |5i
.ps 12
علی غلامی رودی
.sp |9i
زمستان \*[num 1395]
.bp 1
.nr ths.pg 2
.\" Abstract
.S_ - "چکیده"
.LP
در این مستند، بسته‌ی \*[en ths] برای نوشتن پایان‌نامه‌های
فارسی معرفی می‌گردد.
.bp
.\" Sections
.de ths.s0
\f(FB\\$2   \\$3\fP\h'1n'  \a\>\\$1\<
..
.de ths.s1
\h'2n'\\$2   \\$3\h'1n'  \a\>\\$1\<
..
.de ths.s2
\h'4n'\\$2   \\$3\h'1n'  \a\>\\$1\<
..
.S_ - "فهرست مطالب"
.nf
.ta \n(.luR
.so .ths.tr
.rm ths.s0
.rm ths.s1
.rm ths.s2
.bp
.\" Figures
.de ths.f1
\\$2 \\$3  \a\>\\$1\<
..
.S_ - "فهرست شکل‌ها"
.nf
.ta \n(.luR
.so .ths.tr
.rm ths.f1
.bp
.\" Tables
.S_ - "فهرست جدول‌ها"
.nf
.ta \n(.luR
.de ths.t1
\\$2 \\$3  \a\>\\$1\<
..
.so .ths.tr
.rm ths.t1
