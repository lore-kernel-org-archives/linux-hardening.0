Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DCA37DE97
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802875; cv=none; b=j0OtHBPEQcedlDjmibvygZEtmRjSqFTFEQZLeaxpsCQFVGl8ghANaD8KvF/RmXcZsBgLYlzoPi8C60qWnDC5gFx0uOELXlxkaRTWnlR/YCsQNT0Q+x2ZOWzVHnZVLjDCzfEdejUXzuE/eMQJHVX7zJ+dmDEVENRVkP1sjpRBrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802875; c=relaxed/simple;
	bh=FrzKb4y7YlHGJ2vtwJTQmyz/+8z4+4LU13jOEu0AUzY=;
	h=From:Date:Message-ID:Subject:To:Cc; b=p5+fWz9pm8nfEGAxp6Ps/0ioLCruoQahF0bKlkwu9R0WA+HT567lvuZAUPSsvK0p9oEsp4RJHhMq5g+XXufTeot8F7EKex2EBHn34xAtHQ/sojNPLToaxZZFLmS2MG2Ls7IboyIJufDcAP3qe+pMK044Wr3RTYQVddyzPgu8ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuIKlA6T; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuIKlA6T"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab232cc803so22558095ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776802874; x=1777407674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnNcXGDfADai12uq75QgwEjPYzbA2COi4ToRCDNpa2g=;
        b=IuIKlA6TZqi/5DrpucisWcQAejwsgzb+v/k3UT1qd41D+3rxu73W/ivC65iW7Lpomn
         X5Hqst2nulgZw+fC77k7MHD5bj+Khub+YxsMYsN5GI3h2lUgJbJaUt4uba3+Hu4+PRZm
         sUNw6Coi22KPymNLCdOcmzrdm8ur7Lhty1me5MZnJHF6GnMJ23JhugdTBAA3kRMZOUZB
         NdyxhGuA943BhuUJ5kZd8j6IpDCAk7ZT3PQ9PEl31zNssgG1azQI8EJfhKcCtIJFgSTe
         JZjz7dvFrW2mhXo6Gg88qsts2zj4gKhRklK8GHBnIGiD+5opjkUAP7p9zyjaEIxqRpYg
         JfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802874; x=1777407674;
        h=cc:to:subject:message-id:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnNcXGDfADai12uq75QgwEjPYzbA2COi4ToRCDNpa2g=;
        b=ClBlVMPYQLb0e4ScRLitzbziuCQriJLbecoQnUBoJZoL0+7YA5JACZsoAW6Q6UwjQD
         H7uPsv/PifbP+1K+5bfS8lhNXBran+8Fk7mEDKxxl8wDX3gluAkhHbNfWMWLbmZzW2UU
         RUmlUR+h82Nggsla52BeOkMw9H/1NjwRYfqVPpIvPG4ZAs44CEFAzB/LIyxYERqOujZx
         +lGfciQhTkvM/iV8Vu7VBoC/bAHun/KonSl20iyLbZI0txEvZj/MUgXwU8hzRA5g5DsY
         x35zxJxE64twTR8QjQM9bOvv3yfgSPABj/VBG9H9ld40ACTf6rDCJZwPMVigB0NVckyV
         D7eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xC3Wukukl8te3rY/sK1IjDDfc7cWAUr3G5nIPukRXijF+A6JmLYat4dWBVEtbV7f/VsprQY9Iq9hNvKRs1VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvda9KawXGxnBDKCHD2UZ7ZHBQW6r/lcge8HpMCF3hbqGeQdQY
	XC9xjuLeFZzgib8btzWqmJjIRsBYLyDNDAOEuGElucQasux/Nu9zUQhjROMzg3Ypko8=
X-Gm-Gg: AeBDies+swxtxleM9TGZkFlrstzJwP/tUZotmmp0P9//N/gI96xq4Iww8BBkFwFMlcq
	iDoXwH5LWyNBggC4sZq4pnH2dPQzGLGY0wvHUyVFWxzL2UNgedZcjc1z9cfh8ig7ay4C0tgflgN
	6OZDDilAuU3bMHtw0wTBXYYdXudjkHy6ndbKbXHteKTX0K6ZKJxkMVX3N0dB8Rr9HShIenrgRIq
	OleoaD5f+JOgU3uq3O8m+7/NmNvXqboDLyIV3JBLulXT9p7QMtF0Ax5kVEsOxdn1DYWrXrzevG+
	NNCX54+b4JNReXQPVQEdI26S3UZ0SUGFD7ssY4pDvv1POF+jvegAXfEcbJ6n8/f1a2aG7X5yOZg
	SMWAt3i0msYsiqyiqSNy5u7vVBuLhpPgNqwfDxPawJ+gdnR1Zw169mvNo2/8GRgq8ZniccNhReI
	/Gn0hFEcv5FeFHrWpC1R2CcupfDeWK89phYVJIvNyWM6TH1XDr5qaEpyjGzvI6WebdErUjrXd4L
	YqORi8PcfM0zQMRfRZoBIwrXVbo9YNG+7xCHdgIU+KMALWNmfj5VccyR9H6+A6CZI8YdiPyk6Ni
	nap9PVqppih5KEpL6dE=
X-Received: by 2002:a17:902:8e85:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2b5fa030fa5mr128011345ad.37.1776802873498;
        Tue, 21 Apr 2026 13:21:13 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([103.129.135.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cddfsm206356875ad.49.2026.04.21.13.21.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2026 13:21:13 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Wed, 22 Apr 2026 02:04:06 +0545
Message-ID: <177680283372.84187.11707577520741615468@gmail.com>
Subject: [PATCH] lib/tests: add string_get_size() boundary tests
To: Kees Cook <kees@kernel.org>,
    Andy Shevchenko <andy@kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    linux-hardening@vger.kernel.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

string_get_size() has several non-obvious outputs around decimal and
binary unit boundaries because the unit is chosen before the final
rounding step. Decimal values just below 1 MB can print as "1000 kB";
binary values below 1 KiB stay in bytes; and rounded binary values can
print as "1000 KiB" or "1024 KiB" before the input reaches the next
binary unit.

Add KUnit coverage for these current outputs and nearby threshold values
so the existing behavior is explicit.

Link: https://lore.kernel.org/r/CAHp75VfB0Y7K=chk5wpKtZcgVfCN5X7zhNEq6QSrirdgHs5_bQ@mail.gmail.com
Link: https://lore.kernel.org/r/696d25567aadbb8ba324d4a980c15eb5cf4ccef6.camel@HansenPartnership.com
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 lib/tests/string_helpers_kunit.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_kunit.c
index c853046183d24..92454837f3ddd 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -558,6 +558,39 @@ static void test_get_size(struct kunit *test)
 	/* weird block sizes */
 	test_string_get_size_one(3000, 1900, "5.70 MB", "5.44 MiB");
 
+	/* decimal boundary around 1 MB */
+	test_string_get_size_one(999499, 1, "999 kB", "976 KiB");
+	test_string_get_size_one(999500, 1, "1000 kB", "976 KiB");
+	test_string_get_size_one(999999, 1, "1000 kB", "977 KiB");
+	test_string_get_size_one(1000000, 1, "1.00 MB", "977 KiB");
+	test_string_get_size_one(1000001, 1, "1.00 MB", "977 KiB");
+
+	/* binary values stay in bytes until the 1 KiB boundary */
+	test_string_get_size_one(1000, 1, "1.00 kB", "1000 B");
+	test_string_get_size_one(1018, 1, "1.02 kB", "1018 B");
+	test_string_get_size_one(1023, 1, "1.02 kB", "1023 B");
+	test_string_get_size_one(1024, 1, "1.02 kB", "1.00 KiB");
+	test_string_get_size_one(1025, 1, "1.03 kB", "1.00 KiB");
+
+	/* binary rounding around 1000 KiB */
+	test_string_get_size_one(1023487, 1, "1.02 MB", "999 KiB");
+	test_string_get_size_one(1023488, 1, "1.02 MB", "1000 KiB");
+	test_string_get_size_one(1024000, 1, "1.02 MB", "1000 KiB");
+	test_string_get_size_one(1024511, 1, "1.02 MB", "1000 KiB");
+	test_string_get_size_one(1024512, 1, "1.02 MB", "1001 KiB");
+
+	/* binary boundary around 1 MiB */
+	test_string_get_size_one(1048063, 1, "1.05 MB", "1023 KiB");
+	test_string_get_size_one(1048064, 1, "1.05 MB", "1024 KiB");
+	test_string_get_size_one(1048575, 1, "1.05 MB", "1024 KiB");
+	test_string_get_size_one(1048576, 1, "1.05 MB", "1.00 MiB");
+	test_string_get_size_one(1048577, 1, "1.05 MB", "1.00 MiB");
+
+	/* binary boundary around 2 MiB */
+	test_string_get_size_one(2097151, 1, "2.10 MB", "2.00 MiB");
+	test_string_get_size_one(2097152, 1, "2.10 MB", "2.00 MiB");
+	test_string_get_size_one(2097153, 1, "2.10 MB", "2.00 MiB");
+
 	/* huge values */
 	test_string_get_size_one(U64_MAX, 4096, "75.6 ZB", "64.0 ZiB");
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
-- 
2.50.1 (Apple Git-155)


