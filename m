Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113A13D503
	for <linux-hardening@vger.kernel.org>; Sun, 19 Apr 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776612680; cv=none; b=C1KMR6xx0v7B7FnMIYfK5+OMzxuzB5tEtuiGshubiAN4YEXDQfuoBGlvGWOunUHWhwwivjO6omwROJaZfoxnYo5JYPN5F0dfv0bpT5bwUKr0UoCqyU5nRZgfOHRHWTK4Sx+/BmZ7Et8Vo+OX6B9mQw2sNDKo6k5u3leIaJaa/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776612680; c=relaxed/simple;
	bh=c+7Hh6YAYHR57ZfV7dF+lbU+IgX8gHDuA3Iwr95bSWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VttuDuYrp22bpPv/LjjMDRjw2s67C63eX6Z+PRnoP0e5SGyaTkiPyMg+nRJLiTui6onMuCC9WBs8Rhhb2ObNU/XfA0tEF17ZdWrowMRveIkJekjIoPxTkRitRnzI9KozBbvs/Jd+9kKsn0i8trinbSyr6H/3kE1UUXhvgyXigJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2eTIpjB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2eTIpjB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c741692db4cso516435a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 19 Apr 2026 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776612678; x=1777217478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htAQUVsc8t4gkTnrakwopY54QdwU9K7VfH7XV9JXjro=;
        b=E2eTIpjBOfkjXn7CVHODObw9d/q/boLUPPDiOE4gqQ003IW/LD0wUXdXJdcWfxjZiY
         S5rA5ViOzfkIfYFFa7c3uOLm2eCvncQt43Pdc/v2b27vhUubak78iT4bTCPv78dTeRZw
         /8RfXkxn8RaWojMZ9RjhEJzAEGsbPYPPbM2WkcPrcRaRmUjv/tpFgDHh7hMruhnZG7oJ
         F+72pP5+QVVfnj6An/oGYp2XqS5GRcSwzaoUxLZ+TvrEyu4LiL7gRW7EoWPLWPBKAwPE
         EmKtLrI0kNA8OqRsg9twC5NlwuQudwtfFrBAYz4PoPfuVfVOe96MPVB7bq1JWGsfFopY
         +N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776612678; x=1777217478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htAQUVsc8t4gkTnrakwopY54QdwU9K7VfH7XV9JXjro=;
        b=fys0sKcb0o7Y+agbaquBi+GKElqZuUGQYaDXL78Rpwg2lm7YAqLlcJX0mY+7XRz+WA
         /YdzSlEJtjPa9DNkGWw2gXg0vd79KDSzyuMivo8K5XwDyZ8A0v2UOjsAn8oWpt6oaao1
         8p8cl4Cgn396+yAlMNYaOc/ear1zUZ3hlXalKvFRdQ8WVLg0nFkJUq5CdDBeyQ9Y2eRE
         YBH7Ue0/uI8omkS1QCNrCEH1wQwtqfc5ZPjskVitwf+aOM4yzoPyEO5XtUHWMqh/LJ+o
         k9sTnA5VjQboMj4Tev4TADmKftT+v7NBqMtEYtow7SoC5hXuX01qt4jLgpm8IXx//Y97
         nToA==
X-Forwarded-Encrypted: i=1; AFNElJ9Y4UxJrXtm8x6mBDArb1nrh0Du83l9E6coTLl3Of1sB1zEh52JStLoVEkHpXqVf2Qzt39TwREqjPxhT3HKwkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpSrHHCxEoNRbqy2Mkr9IhsmVZNm7fmJUv3wQaqu/os+s6SGJj
	PZXwwo2BaDm9us514bPlgM9dmaZxujDt7s381gtGPGyXarXgF3tdkYp8
X-Gm-Gg: AeBDietUDSJT2qMrwmMMxz4dpUiHF/OchCPKl9H0pJKXJnZvNMC6unbsJtO5LWTLO3j
	PzPGdKuV5vPN7MTyKUBVb+YoMCsEPRR7H3Twy9xHM6P1PLRg/AeeI1vFk1A15bkSeXKGAaF2wTE
	B4lZwQRBU6zo4w4xC4f2NL2/fxgj7qMBMnO97xm91EXXwkS+zrE+I+pMJElWEcU3ricuTuVBxwN
	/On7UWLDGZ9Mdw83DZkOkkYVPL9/M3OM3vatskL2WuH5gQnMXiRp11z1zoCWZ2yEsKpLy9Kvibu
	Zmb16SjGq+EWieRINXWD+A54tnbzdpRx384VGEdfablGbMgrTCifrPdECXkEXV8heCaQupLxh7b
	YrwFMp4x0hPdWaUvcNlDBoLyJfrKYXNe9f1qGuksLYYryJzw2+i/X4sN4TNgKk/Ddo+yL6C259q
	lBlf7DIqJdGhsFKHmdRxY51s8oW+X53Yvo0Jo6mDD4Oq0bjEhQEt51MYo54YWdoJ9Yfn9COXfPt
	gyM2wNLAC7enwXsA934XjQAM00=
X-Received: by 2002:a05:6a20:9389:b0:398:7daf:6d7e with SMTP id adf61e73a8af0-3a08ca74edbmr8943223637.17.1776612678098;
        Sun, 19 Apr 2026 08:31:18 -0700 (PDT)
Received: from localhost.localdomain ([110.44.115.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f932daa68sm7435228b3a.49.2026.04.19.08.31.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 08:31:17 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuvam Pandey <shuvampandey1@gmail.com>
Subject: [PATCH v2] lib/string_helpers: renormalize string_get_size() after rounding carry
Date: Sun, 19 Apr 2026 21:16:11 +0545
Message-ID: <20260419153111.90635-1-shuvampandey1@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407143306.78809-1-shuvampandey1@gmail.com>
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

string_get_size() rounds the fractional part before formatting the
result. If that carry pushes the integer part to the unit divisor, the
helper still prints the old unit and produces strings like "1000 kB"
and "1024 KiB".

That misformatted carry case comes from the arithmetic rounding added by
commit 564b026fbd0d ("string_helpers: fix precision loss for some
inputs"). The helper already rounds those values up numerically; it
just fails to renormalize them into the next unit before formatting.

Renormalize the carried result into the next named unit so those cases
print as "1.00 MB" and "1.00 MiB" instead. Only do that when another
named unit exists, so the existing "UNK" fallback is preserved at the
top end. Extend the KUnit coverage around the first decimal and binary
boundaries, including adjacent values and non-byte block sizes that hit
the same carry path.

Fixes: 564b026fbd0d ("string_helpers: fix precision loss for some inputs")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
Changes in v2:
- correct the Fixes tag to 564b026fbd0d
- renormalize only when another named unit exists
- preserve the top-end UNK fallback
- add decimal and binary boundary/neighbor KUnit coverage
- add non-byte block-size cases that hit the same carry path

 lib/string_helpers.c             | 12 ++++++++++++
 lib/tests/string_helpers_kunit.c | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 169eaf5834949..bcabb24fe0dbf 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -121,6 +121,18 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 		size += 1;
 	}
 
+	/*
+	 * Renormalize into the next named unit, but preserve the top-end
+	 * UNK fallback. After promotion the value is exactly 1 of the next
+	 * unit, so keep two fractional digits for the usual 1.00 formatting.
+	 */
+	if (size >= divisor[units_base] && i + 1 < ARRAY_SIZE(units_2)) {
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
index c853046183d24..67822cb48fd15 100644
--- a/lib/tests/string_helpers_kunit.c
+++ b/lib/tests/string_helpers_kunit.c
@@ -558,6 +558,31 @@ static void test_get_size(struct kunit *test)
 	/* weird block sizes */
 	test_string_get_size_one(3000, 1900, "5.70 MB", "5.44 MiB");
 
+	/* rounding carry into the next unit at the first decimal boundary */
+	test_string_get_size_one(999499, 1, "999 kB", "976 KiB");
+	test_string_get_size_one(999500, 1, "1.00 MB", "976 KiB");
+	test_string_get_size_one(999999, 1, "1.00 MB", "977 KiB");
+	test_string_get_size_one(1000000, 1, "1.00 MB", "977 KiB");
+	test_string_get_size_one(1000001, 1, "1.00 MB", "977 KiB");
+
+	/* rounding carry into the next unit at the first binary boundary */
+	test_string_get_size_one(1048063, 1, "1.05 MB", "1023 KiB");
+	test_string_get_size_one(1048064, 1, "1.05 MB", "1.00 MiB");
+	test_string_get_size_one(1048575, 1, "1.05 MB", "1.00 MiB");
+	test_string_get_size_one(1048576, 1, "1.05 MB", "1.00 MiB");
+	test_string_get_size_one(1048577, 1, "1.05 MB", "1.00 MiB");
+
+	/* values already in the next binary unit stay unchanged */
+	test_string_get_size_one(2097151, 1, "2.10 MB", "2.00 MiB");
+	test_string_get_size_one(2097152, 1, "2.10 MB", "2.00 MiB");
+	test_string_get_size_one(2097153, 1, "2.10 MB", "2.00 MiB");
+
+	/* non-byte block sizes hit the same carry path */
+	test_string_get_size_one(4997, 200, "999 kB", "976 KiB");
+	test_string_get_size_one(4998, 200, "1.00 MB", "976 KiB");
+	test_string_get_size_one(9981, 105, "1.05 MB", "1023 KiB");
+	test_string_get_size_one(9982, 105, "1.05 MB", "1.00 MiB");
+
 	/* huge values */
 	test_string_get_size_one(U64_MAX, 4096, "75.6 ZB", "64.0 ZiB");
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
-- 
2.50.1 (Apple Git-155)

