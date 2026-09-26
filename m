Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615C30CD81
	for <linux-hardening@vger.kernel.org>; Sat, 26 Sep 2026 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456254; cv=none; b=AylirCBGgwswwyKL5o9uqAX/P2oSv8ORDKMA7QklwJpamiYAt73sQzW5hXCS+G151+LKSkVph3lAUlUbcGL7BAzOBMkwWJWLYgKxett5skE/Hhr0wbmcDx2sQ+DnPJBF0ee4uUN/rOi5PUirD6k6ckq9Sc4OwdTW4iUXySBvDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456254; c=relaxed/simple;
	bh=bfRXeeWZCnYxMWiaETcHuPeeQ99w6tkf/jqYYZ9kEUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ro4Vln+mW6q7ZzRvnVrVVUeQi9pfjjLlM0CaJVkB6iYo7TScm/6xrsf8NndXgKvS3UBQTFb0E+TzxJ3qXKJAeQDrx6FEkq9OCmCqtOaG5xQV+G/THl9Rqwf+M8s4c+OGLh2qyCoNlI6z1a5pYEH4TrpbUbYv1hKK+/zAPHs0N2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oylus4sd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oylus4sd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so2862065e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 26 Sep 2026 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456250; x=1791061050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csF2i/18qFumLJd4aqdPk0G5uoJk8kwCVpfjDMQwFsM=;
        b=oylus4sdo/ESnPyc2rmZ622v6zmkJhM2wQQzIMRIGQSKzZy4zQc75Qx/i6j8mnpAfx
         GbKCwE05VWUhtPBD7psp+YTmzgX72017k0BWTK2/YxZST3djtB0qneUYkL2q7AgDOH+J
         05pgx+m4am40scIvTvBsqOfXwKrWECzRWmOKb54VjlIhwh1Q/O+QtJqGYL0mUsI4F98i
         v1bbwX0bYpTb2aE1dNDhw1ceLIdWLgQQKFDezPVfiYgyFr9bItE/hMmC6Y8lhtgcOjLD
         4y+Q5rXVjO0Awm2ml2XwOqEnCOUj4f+djyEMHOcMh5pdwal8PLIXnF14mUlR883hTpgO
         +7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456250; x=1791061050;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csF2i/18qFumLJd4aqdPk0G5uoJk8kwCVpfjDMQwFsM=;
        b=0ZAm2DyvXb49sYib8qJJCiOJfyhv9XFiOwP8bWqCmttThvR/dlhRbGXYhUiCR+BDdk
         MZMdg1HE2oRiS7F0L7+5uanM0d1AXTfAXfAZeh3J3e011SoP4cE1RmiN9QxX6En+N0lq
         EBdiw/Ms9opC6sjS38sw5jzOrxnHfBHKQyfMbv2RTs9glM55hFOdPJqCdgIICBpiqdgK
         Dm1zmL3nvtI1MsGcDKGGQQLwI9aYMgnSJ4bKaBdG74akGckfIdpIIlzAaBt0ycvmC8CM
         INngbUCd1C2I9ceXuKGY4sNbZrM98qMHjyfjK6WtGx7AhTutgqnz8kAwgiQPsfRymw16
         wpsA==
X-Forwarded-Encrypted: i=1; AKwUvBy9RFl/YwMVk4rrWaf0QNSK2KkGhuGybvbOu/Gaui+Yy8O2Z2kT7BO0iVAz7xKeGOnnUFgw8le5YMi6XBpEs50=@vger.kernel.org
X-Gm-Message-State: AFuF++ntoME9nvsTrZKFlutiRr9iMqQHaLznKgaxvsLAP2XKuJjez3xc
	C1e95LgqdeTy+Cnl+hPwTBjNx6tkXmCsA18eyQ3/iS/4h0h6m1pmTXfz
X-Gm-Gg: AYBFou3ijk1NW5usAVDGx61imYJT7avYGxWibhIVilsgC94ScKjMfxEUJTOOXPd5zat
	6L6uh/71CQ55EmLGw43sYgnMKug/5/OMOQY0yF1hs7wQU+/RRBpVX34MimBaKtj/lWcJmwrg6K9
	WStHHMqxFaMDNkrURr1gnjJ/OEx+x+LpkA5T/p99R5cxSc3iNd6Zibd4QouQbYdAP35AhHzhcRa
	JKxqwEFmGp5y0in+qNPKcBiNv6gsIZ6+BLIyJEmf0WDql5Y+L31CoZDDphzoQ0Lbm2phSpjwJtS
	Ql96GXyEeTwO+B78ZpusijKCKHA9Kwac/UyjsnMV8zn1cbzdpYxwMQsv+pjx7UpCAjE+btWcU6r
	IqjOhl/9gELnuUYE2Mx5pylKDU13zvKaTFwF+eWa4qh8UxwtxT9fV+SLfbpUzOfKNJKNc4wBvqN
	UprdBVAXJGcmRY2XZEMzNST8oTa8MI3uZ/0yxUVLliLOD4jI1hRxjr2jm2gq951UVoKuAVyf4Rk
	QscrWYJ3bRaP7byZeSjbS0GsiUlDq94ZhI1eqljH8qTBLMkFpiB
X-Received: by 2002:a05:600c:348e:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49ff06b2ef6mr105847065e9.5.1790456250016;
        Sat, 26 Sep 2026 13:57:30 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018e6dcbsm1734845e9.6.2026.09.26.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:57:29 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Muhammad Bilal <meatuni001@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/string_helpers: add ESCAPE_BACKSLASH flag to string_escape_mem()
Date: Sun, 27 Sep 2026 01:56:54 +0500
Message-ID: <20260926205708.384308-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ESCAPE_SPECIAL escapes '\\', '\a', '\e' and '"' as one group. A caller
that wants '\\' escaped but needs '"' left untouched, because it has
its own handling for quotes or because quoting is not meaningful in
its output, currently has no way to pull just the backslash case out
of that set.

Add ESCAPE_BACKSLASH, which escapes only '\\'. It can be combined with
ESCAPE_SPACE, or used on its own, without pulling in ESCAPE_SPECIAL's
quote and control-character handling.

This only adds a new opt-in flag; no existing caller changes
behavior.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 include/linux/string_helpers.h |  3 ++-
 lib/string_helpers.c           | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 3fb88a1..111114d 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -72,8 +72,9 @@ static inline int string_unescape_any_inplace(char *buf)
 #define ESCAPE_NA		BIT(6)
 #define ESCAPE_NAP		BIT(7)
 #define ESCAPE_APPEND		BIT(8)
+#define ESCAPE_BACKSLASH	BIT(9)
 
-#define ESCAPE_ALL_MASK		GENMASK(8, 0)
+#define ESCAPE_ALL_MASK		GENMASK(9, 0)
 
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 98d6ed0..f35234a 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -438,6 +438,24 @@ static bool escape_special(unsigned char c, char **dst, char *end)
 	return true;
 }
 
+static bool escape_backslash(unsigned char c, char **dst, char *end)
+{
+	char *out = *dst;
+
+	if (c != '\\')
+		return false;
+
+	if (out < end)
+		*out = '\\';
+	++out;
+	if (out < end)
+		*out = '\\';
+	++out;
+
+	*dst = out;
+	return true;
+}
+
 static bool escape_null(unsigned char c, char **dst, char *end)
 {
 	char *out = *dst;
@@ -558,6 +576,8 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *		escape only non-printable or non-ascii characters
  *	%ESCAPE_APPEND:
  *		append characters from @only to be escaped by the given classes
+ *	%ESCAPE_BACKSLASH:
+ *		'\\' - backslash, without the rest of %ESCAPE_SPECIAL
  *
  * %ESCAPE_APPEND would help to pass additional characters to the escaped, when
  * one of %ESCAPE_NP, %ESCAPE_NA, or %ESCAPE_NAP is provided.
@@ -628,6 +648,9 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
 			continue;
 
+		if (flags & ESCAPE_BACKSLASH && escape_backslash(c, &p, end))
+			continue;
+
 		if (flags & ESCAPE_NULL && escape_null(c, &p, end))
 			continue;
 
-- 
2.43.0

