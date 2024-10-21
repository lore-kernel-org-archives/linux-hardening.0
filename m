Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0861E2856
	for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502067; cv=none; b=l/WP5u9AOxKtv0EFXAZadng/xg4lrYwYGDLueIQ03siGYKz5RJ+fzefr5k0k3nPp2LzGENJ+DAOEXM25wVfNFYlAI7R72EH94E4skBfxKsWo/mAU8DBj5XKQENS9a10ZxxR55V6QdimnTyjkTNH/+adwDPe6fI1mpiHCUdt9owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502067; c=relaxed/simple;
	bh=ASWrvXnuLMsHbkqZnMajEVLcesZQBnkmFo5lh1TiMiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L081LnKyYo20Lu2EYUQ/2rEia4ZkKfG0EB45r0sczqtCCP6ZjdOVtRr0Dyl7cgWJ0LJqNRQ7473FSnHGKuhei+JDcpDYR7OoQBkZ87KCrRxoOxci6OrqSUejanHMyofe3pVL8545f0pg57xJ2iTBHMkwpKm0OusLtPrct8Du4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HHlRO/MV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HHlRO/MV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43169902057so17564295e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729502064; x=1730106864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5raYV5vPxawZNarPbF7rVysyaAZqhzjtOUPOejyw3qk=;
        b=HHlRO/MVX1dtUD+mxEsabbrRTsOQDjotwpVkIm4L4dD2R2TD2ocxYY/yTwNpjhluVo
         LFSGyP6HylQp8Ziaf/SlLAJCCH3Cf97AqrQ9BpALpSxd8SO6O+rTYJB6XDmX4mNISlzB
         d3m/Fa6iTxUUBvq+nNc95Dhvep/E6pZtFctRcRce0IlQpxlQcnL1PuLZx4XS1iRfVpX8
         5yIAOJzU4pFh1MoCTEND2MstqW7DYuDcgwI4sRKl/nTwVEKZSC9eaMpBkopaUuRngK1m
         H5wsz0KYlok0kqd41SEeU9mzW5hdHzSo9qd1dE0vz44THZX2/AQ95mJzjyUPOtxGofAd
         wX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502064; x=1730106864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5raYV5vPxawZNarPbF7rVysyaAZqhzjtOUPOejyw3qk=;
        b=vV1VVt2pW6O6k4lo9lE+oV7AcMbegvFtugBlgKpoIfulxvhKMT2jMNp3mrvNf6V7bk
         S9crjfdMJb+OosRx9kiHQ6DA0IWr+ukETVRTW1nYcbK//Fuq2gbIepZpPDJTWv0v2GDd
         hb5UvyrZtPXPZcsjeIDnZlx89MnGBHh0kVzibJkRsnfGYHZ7i5+X+LpkQflNdWy0Enre
         /Dqo1b0SZNcyAxXg5VV0wI06DRzEUZuRID+G5rXWvj535OOkOrJ1RWGRL9WUuGtfHRx6
         7U4n1BWB0QLfQeOxGFPpnBKH1JcDb9dRV6TeSqOERPhMy9H2XrlDiytzbswe2zMYshYz
         FdFw==
X-Gm-Message-State: AOJu0YwImzTRFtbU53Mt70+fYwEXFjBo6oGTZtZq5XZN8Jm8HHk5RkeN
	rf/MKCh7Kz0kfTZ9Xh5bkah5A6MwKdoI/V4vCbcf9Je0TuI9kYwrJQtcCFUK6xM=
X-Google-Smtp-Source: AGHT+IEYuZyLwzQfurWjEnYG8ZF9u47IIP/NoCY4w93Z6L4JxTaxu47mXeeN94UlMxTSaSPKDiwZYg==
X-Received: by 2002:a05:600c:45d2:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-4316168ee39mr77674285e9.22.1729502063773;
        Mon, 21 Oct 2024 02:14:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f571201sm51099145e9.5.2024.10.21.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:14:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
Date: Mon, 21 Oct 2024 11:14:17 +0200
Message-ID: <20241021091417.37796-1-brgl@bgdev.pl>
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

