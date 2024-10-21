Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CE1E47B4
	for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505072; cv=none; b=jB07Uaqw8Blkbg9BXhXxHd3yFH1ktU/Ek5wEjxbMxK7Nz09YlH14kyVjsGM0LL0/5WYQrtWFvYvQSVyPHzwcv3yx8mwVRsGFvsGq605vWoeeE8QQxKeU2lLYqbaUU+Nw5SLVaD2jHGyJ4XNkEdQmg3PgGA/1WYVyJ7xejHA0tEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505072; c=relaxed/simple;
	bh=zBwwiICl41FAygMh+FLshXJ/tGa7gogHxJLxu7b+uJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLEplw/a03LO5WVDD4XLfurtH/H2NYcuspBYaOKtRZrNu/vc5Yw2vjEohPOC25m3fObUCBoMpE8fuo8JqkspWWxaxSwe8LS7lu/QEfLp9lkq1iQnJzpzoYn62mKrca4D8j1W4fPQg91Qo6IlkKLdzYZ5/m59ga15AC0hcsF40vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X3XfLI/C; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X3XfLI/C"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3948751f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729505068; x=1730109868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXr9D+QiqUrfHWA03bUKiVKqnoPxUJl2IUDHzBbrn2o=;
        b=X3XfLI/CMGx/8NgdO7PgLwUXleN4BzbYhvXFgZdq1vCbDfufG4Qlue4pwftP+AMcAx
         foEmNjdYjoHMUEzdu568GpMCcjINJtL/G4R59Vn0dj/Eypqb/lmO9t5wLoI+kE2/Za2s
         /tr82SPvJPHEbw/+68ckEa/WtPsle1NSHvnyQwBoXdIUrxUAn8mOygcDiMMp7E9wKoxG
         kmPnd62WfrFVTa/IQ+SWgo+TEZELWDIaHOKSNUEs2sO7MoEadkzc4dH7z1C608GNWPVq
         8gdW21GZC1EcrRbTGT03qux6NTXlqh1JTFXpgzs1P2LRAeXbimtixQQowvChQ6IGNLTu
         6oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505068; x=1730109868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXr9D+QiqUrfHWA03bUKiVKqnoPxUJl2IUDHzBbrn2o=;
        b=H0WR4ubqODq3C+oIoqDOneJOk8gp17aDVOSmAFrhGsSf252G/5SAXxXen2WcaLnnPj
         gFjyKFItiE4duL07PBIX4TbaYRFyH/iFH6RWwr3xxVIWwg7ObTBTUFgNViut39j9BScN
         2Faqk7UFhTWF6Rg92ce7Eiq74I8fA92E8tXE1uunKH/l9KVXeQH23emgYKJS8wlEVCIG
         wBzCA1kP1WLc8s3fv0uB1s45WM0SmofxGcCa/VwA19vC2nYkqe4GDjGkEHZplqwUsVxw
         Gfi0T8IGbYyte2RkeV3crn/xPeOKYHxroW1SrWi0cKTutRfYlnoBhTHYw5myL/w8FTIK
         n/AQ==
X-Gm-Message-State: AOJu0YyuKC29rfLkfXYMp04/s3qs77yRzRh5B4mlTxFFJcu8quCmCUUl
	P+UeSXTATHhK4fs7QYI6SAlTo1+wqj47+2iiAf8Bhh7zyHdLHoI2ruuz9Rr7OYpjNxH7AAgL+0C
	F
X-Google-Smtp-Source: AGHT+IGW4z70tBtJjYVEC25NjW4Zh4Gpf7rFYYWBzMKvqYBqjTj3bmz732iSxhNJelTfx86Iie8/xQ==
X-Received: by 2002:a05:6000:124a:b0:37d:9508:1947 with SMTP id ffacd0b85a97d-37eb476876amr8204119f8f.51.1729505068250;
        Mon, 21 Oct 2024 03:04:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a64dc1sm3918652f8f.65.2024.10.21.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:04:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
Date: Mon, 21 Oct 2024 12:04:21 +0200
Message-ID: <20241021100421.41734-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The output of ".%03u" with the unsigned int in range [0, 4294966295] may
get truncated if the target buffer is not 12 bytes.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 lib/string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f887aa62fa0..91fa37b5c510 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -57,7 +57,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	static const unsigned int rounding[] = { 500, 50, 5 };
 	int i = 0, j;
 	u32 remainder = 0, sf_cap;
-	char tmp[8];
+	char tmp[12];
 	const char *unit;
 
 	tmp[0] = '\0';
-- 
2.43.0

