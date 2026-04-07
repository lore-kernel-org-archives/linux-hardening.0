Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17217A31E
	for <linux-hardening@vger.kernel.org>; Tue,  7 Apr 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572395; cv=none; b=stVMCSwpR9oQj2m0ZPzMsfo/5zy/NQoJWQn6T/IYsWHfCOLJQejCcBKf4VWAweB8oOU0b0QJkuuCCaxk2ES5YAZRVPID1/pUfQcSqpu9nnfJz3JG9XOBypoJq0dVR8BoARza7BZtO3ArIS/2uGIa5Skp8A4lhiPOSxGNBviddDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572395; c=relaxed/simple;
	bh=y2ryRWTMom41Ry8K7iEMHsKVi693F6fn5CC+z8ttHYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6xz+gqkoQpXF8REuQnQRKJTVQRX102E3E4c86yBM8Fso6/lkW1QLg4dMiUQhltEGrvLYStEanb6Py7zYIKNzY/FDwg7BFcgoTYvg5AfkRwyCZvQiCoZYaV6xzq7e6BObDcgmWkMDXjlg4uu2YtFccbYRs6crFFcKPwzhi2Sps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBwgUyJL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBwgUyJL"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so1726020a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 07 Apr 2026 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572392; x=1776177192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S06L4O8V2fqzeDXiPwpWBh6KNFIVpJ0g//Xhqb4k9Lw=;
        b=eBwgUyJLv5Zl6MPFArvWfUKRzax8VW3IPkezzwSF2BQulMeVb5ratrjpeAmh7wRWxc
         ikNGnuySHTflqDWquqKjnRkCdgxymxV9DTqSGLbUEZrCZktac2vh3LKJ4qxJHwYGslyI
         yP6OLIZd38ixtmt9ixSJwId1BTv84eJVlAGeGD+kdOV72EcYlxJqH4GfPxTUjAR19VwF
         sLwl086wFLWoOR0a/E6/OLlDreNJMHdFGSZ58pg0tFFHoihXaelcFnlTZ9ot6PdkOj/X
         tcTKFS98gr19i1YRj4xIK2jeKe4ifI0F5OXVwCZIYBJPrKlcS4TaT+kLBxOMg9QjC5Go
         H/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572392; x=1776177192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S06L4O8V2fqzeDXiPwpWBh6KNFIVpJ0g//Xhqb4k9Lw=;
        b=Z9+0V+pCt3x3SqWAK0l9+GqOyIiMBmC7v8lUohr/Q0pKI/qpueIytzp/KMu5gj45Rv
         gUSBUhPBbCkr/586Mhxhlw/hL8DL7sA1h5cQ/Its+2VB/1S2DaAU5LoOf8EeFJc9QrbS
         gHHbfsApeLNyV5hqfHHk7TGSKip+WJ250pS8OcNRo22JC/v78UEtbBh1HGiTPyyvhbw0
         PDJHWv0QhwtFnfRgaCxuWBR6ztWDe3eiwD7iu85I/3REPBlJY9sosWt/Mm8rL4hmDok5
         4/k1NAfJo8w495wL4Oc7ONbBI0iLuhfqSPlfK1Mh02h1Z0soHD3O5N6+2Xbw4FWfGbnA
         aKAA==
X-Forwarded-Encrypted: i=1; AJvYcCWLcnIzc3qntcnhM3hjP6HI/unQyS7EUZKZw5Xs5xXs3GAJIxIvPh7HqwOUCEaQR6V7R/V1E1DQVV9iQ8G8/aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwq1j5bBrSBzhTs5S5ZucCnT1hrgHVei8T6S3c50KtalE1WH01
	6aWG8MeSU4DPjvsQp8hHj9+FzFJQAFYSuM7GLxoqiPNp2k2tfhFilI1THGUdhLZ+
X-Gm-Gg: AeBDietP8XomUWxi0ixj4mLzutG1SjZstx/dKqhDwO8XUfoHnNt6xYuemKNBL3wALwu
	6ENgwZf7JlKX7qdrLZMOXmYi64SJh6ydpiaIWZL3+kMIwFPoNX4lznr/j/WFOnyOGb6DelZauEb
	vv4T/9EvdhYFQTVQ/EHiU4i1n3caTl82KDyFN5E0XQfEmoJGQOtcMieaCOhLbWb9M8CrzWDaHus
	MgqCR+4IN1nxpmT0zTmm3zY/4IIby53XZSAS2g+tWYCb3GHWmilndwhUqPlvTLdIN0Cr8xutxk6
	rTZdQbOGJQFdIBEmNfW2VW6IUmSnJGzK/jlKz/FPnp+lW/4eq00daOs79UV9FcD81m3xDmA3nkn
	srxBcojViVD/fdoDMnjm+71HJxZ1FP19cGpf0FwXyv94Agyt5zGqBrbm/NqZa1d4yvHOxrDF3NE
	TCTHla1RZDUNYhJ27GzEzZC+F46uOaCva0gVuPSSHnkOyi3iDbVr8VptXgXbE4hKBFGbfRL8wtV
	7vQqefASD+G8qL8m+M=
X-Received: by 2002:a05:6a00:848:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-82d0db71c03mr19798857b3a.30.1775572392342;
        Tue, 07 Apr 2026 07:33:12 -0700 (PDT)
Received: from localhost.localdomain ([103.10.31.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca75dfsm17611419b3a.60.2026.04.07.07.33.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:33:11 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] lib/string_helpers: fix string_get_size() unit promotion after rounding
Date: Tue,  7 Apr 2026 20:18:06 +0545
Message-ID: <20260407143306.78809-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

string_get_size() rounds the fractional part before formatting the
result. If that carry pushes the integer part to the unit divisor, the
value is still printed in the old unit.

This yields outputs like "1000 kB" for 999500 bytes and "1024 KiB" for
1048064 bytes instead of promoting them to the next unit.

Renormalize the value after the carry so it is promoted before
formatting. Add KUnit coverage for the decimal and binary boundary
cases.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 lib/string_helpers.c             | 7 +++++++
 lib/tests/string_helpers_kunit.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 169eaf583494..aa1ba47e28bd 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -121,6 +121,13 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 		size += 1;
 	}
 
+	if (size >= divisor[units_base]) {
+		size = 1;
+		remainder = 0;
+		i++;
+		j = 2;
+	}
+
 	if (j) {
 		snprintf(tmp, sizeof(tmp), ".%03u", remainder);
 		tmp[j+1] = '\0';
diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index c853046183d2..16118fb16c9a 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -558,6 +558,10 @@ static void test_get_size(struct kunit *test)
 	/* weird block sizes */
 	test_string_get_size_one(3000, 1900, "5.70 MB", "5.44 MiB");
 
+	/* rounding carry into the next unit */
+	test_string_get_size_one(999500, 1, "1.00 MB", "976 KiB");
+	test_string_get_size_one(1048064, 1, "1.05 MB", "1.00 MiB");
+
 	/* huge values */
 	test_string_get_size_one(U64_MAX, 4096, "75.6 ZB", "64.0 ZiB");
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
-- 
2.50.0

