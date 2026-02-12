Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAEA358D3D;
	Thu, 12 Feb 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900997; cv=none; b=rkzNOfwrekhHO+lPkBhLfTZ7qtEvkGsKyB+ZUGpCjAVei4Tbrl1yWqui7MUtB+Qyfh7UOlj/JRe5yWlAWLbKL1xYcZgrVutwyoQoILuJ2not9RKK2YjPMV0J0uBkAvoGd2oND6crYg6SWycRQmElCq4OQf9GjPpnwGnaUOPuvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900997; c=relaxed/simple;
	bh=i/YL/mVWy5lRqFCtJyTP3sW4sKYd/0MXpGazdSmbaiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQASFb9FS1ht4uPC663Y/LLnqoreMBJbH4FX65bxMQEsftQ3EBzrKEB15dbMWTgAf3qWUM9jBwDMP3NXTL1pNQAoG21s1Reocae4S4aCSABBpPNPu/GFEK8SWLUysbJLyxPSbVeGDI3+a7GUU50A0Ps7JBbMS4D545ex9+yTEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ECUY/HPy; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ECUY/HPy"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 56E5CC00EB;
	Thu, 12 Feb 2026 15:56:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VuTjuXAGI4Y0-kvDfMToo;
	Thu, 12 Feb 2026 15:56:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770900992; bh=0fKN4Y+k4d+LxcuJxWobJuwlWBYAEFn705l1ytjnVDA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ECUY/HPyZDDz8wkqKe0K0rGac6h/3ejHX8cMbj7zFn5tnxxI+H8QMjaTIyBzeAR2I
	 s3dCmCutdh4DXMGYzuoEsyjp0EdeA2Oc9SG+vzUHh6jckpaV2ppeq2XNWJan4sm6RI
	 RXge1dE5InoKJep3fm6KFfhudemK8V1nACpPidnQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v7 1/5] lib: fix _parse_integer_limit() to handle overflow
Date: Thu, 12 Feb 2026 15:56:24 +0300
Message-ID: <20260212125628.739276-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212125628.739276-1-dmantipov@yandex.ru>
References: <20260212125628.739276-1-dmantipov@yandex.ru>
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
v7: drop redundant check against ULLONG_MAX and restore
    original comment
v6: more compact for-loop and minor style adjustments again
v5: minor brace style adjustment
v4: restore plain integer arithmetic and use check_xxx_overflow()
    on near-to-overflow branch only
v3: adjust commit message and comments as suggested by Andy
v2: initial version to join the series
---
 lib/kstrtox.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..ffcf0219b1f1 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,14 +39,20 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
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
@@ -56,8 +62,7 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 	unsigned int rv;
 
 	res = 0;
-	rv = 0;
-	while (max_chars--) {
+	for (rv = 0; max_chars--; rv++, s++) {
 		unsigned int c = *s;
 		unsigned int lc = _tolower(c);
 		unsigned int val;
@@ -76,12 +81,16 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 		 * it in the max base we support (16)
 		 */
 		if (unlikely(res & (~0ull << 60))) {
-			if (res > div_u64(ULLONG_MAX - val, base))
+			unsigned long long tmp;
+
+			if (check_mul_overflow(res, base, &tmp) ||
+			    check_add_overflow(tmp, val, &res)) {
+				res = ULLONG_MAX;
 				rv |= KSTRTOX_OVERFLOW;
+			}
+		} else {
+			res = res * base + val;
 		}
-		res = res * base + val;
-		rv++;
-		s++;
 	}
 	*p = res;
 	return rv;
-- 
2.53.0

