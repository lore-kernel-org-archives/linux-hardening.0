Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15D2E8DE5;
	Thu, 12 Feb 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914662; cv=none; b=SJ67gGY2mpJsSotbFkMRzDMw4l0NDpR7VgAHl4gQyJmMs/6ubfiQwNtFkedfcPLDhZ4oc2V9ucgrKD7kVK8ljjPWES71wHwCB366OFzn+6tkNDWPXCAczVJGyGAaNBiTrMyt7KnwAEBUqdsX96hYMciNwjNn7oS/pU8FkS8jfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914662; c=relaxed/simple;
	bh=pxhCE1IopNkcK9Ec3eMFvUr5dcrXFpjQJaInJqtRiLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBZsV6/Bl4hE6riLmiwe1dLI5OA8yJfdR2cPBmnvBvFTHudhtBhZGHFlwXKKTHZyDPzrfCQ9ZlDs+Uh29YehzNCjfFM2murZ7vKJyTAiUVws2CLeUgD/ktVTuC/HzsDyPCU5qZ7R7Y5xvb4xcVxuqd7hWe+xYMTLPvzbwowHZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nJPwIkPp; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nJPwIkPp"
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:3990:0:640:454b:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id F4024C0063;
	Thu, 12 Feb 2026 19:44:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiXcAWCGxeA0-sXx3qsF6;
	Thu, 12 Feb 2026 19:44:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770914656; bh=qOxwQMQR/hRQV0CpfELaF6n/K7loZVqmdu8PH7RWFS4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=nJPwIkPpVtYDmPbhFR4T5OjJYOA9AAL2IzmSmBedABc7k/oBlQTUAn8eV8U/BJCgQ
	 ad7cu8W005GUMnGet2JskF9AzmU8TB1giH4uGPhgWltz7TEqieJ4bsqd2HsIlLBv2D
	 NPfRzGEaqoRTIm0E3GL7A6j5PMbHJ452+6lZ9tQY=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 1/5] lib: fix _parse_integer_limit() to handle overflow
Date: Thu, 12 Feb 2026 19:44:09 +0300
Message-ID: <20260212164413.889625-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212164413.889625-1-dmantipov@yandex.ru>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In '_parse_integer_limit()', adjust native integer arithmetic
with near-to-overflow branch where 'check_mul_overflow()' and
'check_add_overflow()' are used to check whether an intermediate
result goes out of range, and denote such a case with ULLONG_MAX,
thus making the function more similar to standard C library's
'strtoull()'. Adjust comment to kernel-doc style as well.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v8: do not use explicit temporary in check_xxx_overflow()
    calls and handle overflow flag using separate variable
v7: drop redundant check against ULLONG_MAX and restore
    original comment
v6: more compact for-loop and minor style adjustments again
v5: minor brace style adjustment
v4: restore plain integer arithmetic and use check_xxx_overflow()
    on near-to-overflow branch only
v3: adjust commit message and comments as suggested by Andy
v2: initial version to join the series
---
 lib/kstrtox.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..cd67f494c3bd 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,25 +39,30 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 	return s;
 }
 
-/*
- * Convert non-negative integer string representation in explicitly given radix
- * to an integer. A maximum of max_chars characters will be converted.
+/**
+ * _parse_integer_limit - Convert integer string representation to an integer
+ * @s: Integer string representation
+ * @base: Radix
+ * @p: Where to store result
+ * @max_chars: Maximum amount of characters to convert
+ *
+ * Convert non-negative integer string representation in explicitly given
+ * radix to an integer. If overflow occurs, value at @p is set to ULLONG_MAX.
  *
- * Return number of characters consumed maybe or-ed with overflow bit.
- * If overflow occurs, result integer (incorrect) is still returned.
+ * This function is the workhorse of other string conversion functions and it
+ * is discouraged to use it explicitly. Consider kstrto*() family instead.
  *
- * Don't you dare use this function.
+ * Return: Number of characters consumed, maybe ORed with overflow bit
  */
 noinline
 unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
 				  size_t max_chars)
 {
+	unsigned int rv, overflow = 0;
 	unsigned long long res;
-	unsigned int rv;
 
 	res = 0;
-	rv = 0;
-	while (max_chars--) {
+	for (rv = 0; rv < max_chars; rv++, s++) {
 		unsigned int c = *s;
 		unsigned int lc = _tolower(c);
 		unsigned int val;
@@ -76,15 +81,17 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 		 * it in the max base we support (16)
 		 */
 		if (unlikely(res & (~0ull << 60))) {
-			if (res > div_u64(ULLONG_MAX - val, base))
-				rv |= KSTRTOX_OVERFLOW;
+			if (check_mul_overflow(res, base, &res) ||
+			    check_add_overflow(res, val, &res)) {
+				res = ULLONG_MAX;
+				overflow = KSTRTOX_OVERFLOW;
+			}
+		} else {
+			res = res * base + val;
 		}
-		res = res * base + val;
-		rv++;
-		s++;
 	}
 	*p = res;
-	return rv;
+	return rv | overflow;
 }
 
 noinline
-- 
2.53.0

