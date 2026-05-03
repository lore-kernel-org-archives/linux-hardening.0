Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56A2236F0
	for <linux-hardening@vger.kernel.org>; Sun,  3 May 2026 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777816101; cv=none; b=mJpiZiaYSNH/dtEmF7krihpZcctt/vGpKQbtYwVZ5/Mw6yP932MYhi3J0yr6SVDp2QbbtkGu+lE3N1ckdMun6zqUph4jfB7FFx87O2qUKHQxH725lB81CKZy8jxNAkGCn2QUaYKoK7wRv2zBW01x4Pud8A/DRdQ0AzDIbHVCQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777816101; c=relaxed/simple;
	bh=bxAUnTRq0sB2VolIw0ZaRvOMxjDa5sYMVtkeV9mxjS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Who0C9rcS9PBS8sUxEOkQ/NqZ9mK2mo7fth4+eoCEh9tQVHx4SmT/cXRVi0spIto8OHZGKoM0d+64syFjd0nlX6ATOr88jqVMKP8PY3IoXgynafV8MaUn+2+OvIUiBA/Adx6sWF8PjvNK3XKmfi6B+YCBBcCvwVN9G3KX+cdxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7zT75+2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7zT75+2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-356337f058aso2057004a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 03 May 2026 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777816099; x=1778420899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0/ioyAogd00i5zqylTa1SMj5VmF41JDzr3zBahFXHU=;
        b=k7zT75+2+F1TDoDzrA4zSPDDck/2SKqkCQd+2XPaCF+prH+Rzx0Hl1r1eL6EQRs2oe
         SBckGgOIYWuA2OTrxL8DJCKAefeLiA1kQRHCLdBSQsAalDmiYnfSCUDqMb3XYPdwsyrg
         O9DQCahnxx0D0sKFFJCaFCWB7CPKeoOvPjRRtkzP3yqOIKdZx35PEFS1VPj6tViNlhKA
         WbXImlD6PGolNc6kbgGLWT4ZRx813qkyXiYIuTdWMvWB0zFVz4gouF7XqyEc6fjW7LJW
         HXe8+4B392XfNy2dHN8wEmO+4k1ncJ6DHCS9akcyNTRkx2Y7dPz9G2+4jkwZY0CVCDtQ
         VwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777816099; x=1778420899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0/ioyAogd00i5zqylTa1SMj5VmF41JDzr3zBahFXHU=;
        b=Oa7Tlvg5dmmUpv3blpHJjllCJ6lxb18qjAEa2MvMP8/XLbDIIBkOsmm9MucEUKH9uO
         GOf266jN3smtnnxXxx1fYUl7VlmAQckPGxUAsOZmi0KKX1o5CZog1JLw+bTyuNEHy1h4
         mUUhO2akRfSlUn+H0bw6SYoKCwZKanlPDF5V1b7AZEgUaDHzGBL70FVW6oWQY6q7FDJo
         W4c9IXHqotEsK30Xcgd5bGMZYrSJPPkTykv0R/hfaKm47RksePp/x4Yw0XK7ajdgBV3+
         x55qshDmnSR7kW5lUC/cBmW1RuuHLEpAQeQvEMS7w1mtAAey9+z3B0/sNMMsQ7M0XpAn
         6GTw==
X-Gm-Message-State: AOJu0YyW7NKW3Quuoftx/6jSoyAYmaKE6Pgz903a+IF4Yt4kbEq68Rvy
	NubrdthEXLZTa9/ME6OyAhsWh+s8JM+9ng6lx5Iy4apWy8egfxxQuHnH
X-Gm-Gg: AeBDiesW0kup2w2YJT31sNU3Wkr+3OO86TQysea9nDErzEU53hQNTwrO+MIAiw5IS2T
	mRC4Pp5Y+j14KVd1bm0+IOMuEVE+b03SeqHMgjNlOzj8R2Z1y6w+Mjp7pwCW9Wh/HUWbOuvPUQc
	wUvNAyj1lxZiz8zlYEHjEnJN0THZChVXLr+zjeGPXcQ7xQqwhoYS/NKXZmOux046yat/laEZXm2
	7NTHRBYhmRlPUE5n22N3xohbYb0FdlHlHlYSInct2rTYi4u/6eD19uGgf8qjjLbc3I2zwE2kmvo
	T0hzPvwMfKIfu5lgLjyXhkDdahoL5qxOhyrcHsAFjzSwOYdia3tggj2r76mLB8T/kdRFrZ+JEh3
	0MTf8ClbjQibypv6u4a4RiImpekYdVIAbHnITaU7yZNNvHbhjbQOoF68egjvMzXjyL8m4LjzDH1
	ZXWuLGBZd8AJwCrY0MeNF8g36THcnk
X-Received: by 2002:a17:90b:2b45:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-3650ced3be5mr6449812a91.22.1777816098951;
        Sun, 03 May 2026 06:48:18 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec03c944sm7976384a91.15.2026.05.03.06.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 06:48:18 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-hardening@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] overflow: Fix kernel-doc typos in overflows_type and __set_flex_counter
Date: Sun,  3 May 2026 22:48:14 +0900
Message-ID: <20260503134814.473307-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace stale @x reference with @n in overflows_type() kernel-doc,
and fix "annoated" -> "annotated" in __set_flex_counter() kernel-doc.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Hello,

I found these minor typos while reading the code. The change is trivial,
but I hope it helps reduce a bit of confusion for future readers.

Best Regards,
Sang-Heon Jeon
---
 include/linux/overflow.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index a8cb6319b4fb..ec279c8c637b 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -218,11 +218,11 @@ static __always_inline bool __must_check __must_check_overflow(bool overflow)
  *		    or data type
  *
  * @n: source constant value or variable to be checked
- * @T: destination variable or data type proposed to store @x
+ * @T: destination variable or data type proposed to store @n
  *
- * Compares the @x expression for whether or not it can safely fit in
- * the storage of the type in @T. @x and @T can have different types.
- * If @x is a constant expression, this will also resolve to a constant
+ * Compares the @n expression for whether or not it can safely fit in
+ * the storage of the type in @T. @n and @T can have different types.
+ * If @n is a constant expression, this will also resolve to a constant
  * expression.
  *
  * Returns: true if overflow can occur, false otherwise.
@@ -574,7 +574,7 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
 
 /**
  * __set_flex_counter() - Set the counter associated with the given flexible
- *                        array member that has been annoated by __counted_by().
+ *                        array member that has been annotated by __counted_by().
  * @FAM: Instance of flexible array member within a given struct.
  * @COUNT: Value to store to the __counted_by annotated @FAM_PTR's counter.
  *
-- 
2.43.0

