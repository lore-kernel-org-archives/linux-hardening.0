Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBE3859E7;
	Mon,  9 Feb 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656414; cv=none; b=DJNE55bzWIgA3jNSbD3H5rcSxkSbaybuBvtOvemK8l1v+nIvrQPzMZnch2g+xujhqb1fxJ8OMRNSWENW2faq0nXBJxDPCV4Zwbf6yMQ3Nm2lFa/TNr2lAk7JFp4V/qLQacVnbGamZemQqqtDg4sflr4Zu+zol6sa9IJhbQIUxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656414; c=relaxed/simple;
	bh=ez8OxnOMyn6+oq5DnEf9j9mCEYuyWDAxsH3OlMmFoLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSIBunEjmPKww9q1YgRi+FswVP2hfFVMHA11wOG+i4GriF7/FXUjuRZyF4pty2yfd9/QzfxplPpmu+VhaPQCWowhYAjBNZ4K8Ee8QeBMlzjEiZkqy0lwUUM2Sunug7OIRGDqozwQtPuHNgijuGSLuj8K4Sb/kXR/1hqiA34yl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=G0hk/Jgv; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="G0hk/Jgv"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 5F451C339D;
	Mon, 09 Feb 2026 19:53:11 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:405:0:640:8814:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id BAB13C00AD;
	Mon, 09 Feb 2026 19:53:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0rUtjO1G1mI0-jC9Gndc8;
	Mon, 09 Feb 2026 19:53:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770655982; bh=Szwt/gMTXkjv3UveWfT7NKTQ3VUWAsWHEOulJ/VjYZw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=G0hk/JgvJoffUpN2nj3/a4NEwy2KFyN38oX7zK/RtNbyjrT9GslNNG+pID9TZvIoA
	 07CwQvpEtKDWMPscz5T/P7a3hXjdGb9i5Wm/rXUNd7uMoPz41dCjYd7B37+JG/LH9q
	 xBR1E7wkPB+LpNhuBoaJMPprqWRsKop24gh9yp/c=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v6 1/5] lib: fix _parse_integer_limit() to handle overflow
Date: Mon,  9 Feb 2026 19:47:53 +0300
Message-ID: <20260209164757.433932-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209164757.433932-1-dmantipov@yandex.ru>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
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
v6: more compact for-loop and minor style adjustments again
v5: minor brace style adjustment
v4: restore plain integer arithmetic and use check_xxx_overflow()
    on near-to-overflow branch only
v3: adjust commit message and comments as suggested by Andy
v2: initial version to join the series
---
 lib/kstrtox.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..ab7ce72e36e2 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,25 +39,29 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
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
  *
- * Return number of characters consumed maybe or-ed with overflow bit.
- * If overflow occurs, result integer (incorrect) is still returned.
+ * Convert non-negative integer string representation in explicitly given
+ * radix to an integer. If overflow occurs, value at @p is set to ULLONG_MAX.
  *
- * Don't you dare use this function.
+ * This function is the workhorse of other string conversion functions and it
+ * is discouraged to use it explicitly. Consider kstrto*() family instead.
+ *
+ * Return: Number of characters consumed, maybe ORed with overflow bit
  */
 noinline
 unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
 				  size_t max_chars)
 {
-	unsigned long long res;
+	unsigned long long res = 0;
 	unsigned int rv;
 
-	res = 0;
-	rv = 0;
-	while (max_chars--) {
+	for (rv = 0; max_chars--; rv++, s++) {
 		unsigned int c = *s;
 		unsigned int lc = _tolower(c);
 		unsigned int val;
@@ -72,16 +76,23 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 		if (val >= base)
 			break;
 		/*
-		 * Check for overflow only if we are within range of
-		 * it in the max base we support (16)
+		 * Accumulate result if no overflow detected.
+		 * Otherwise just consume valid characters.
 		 */
-		if (unlikely(res & (~0ull << 60))) {
-			if (res > div_u64(ULLONG_MAX - val, base))
-				rv |= KSTRTOX_OVERFLOW;
+		if (likely(res != ULLONG_MAX)) {
+			if (unlikely(res & (~0ull << 60))) {
+				/* We're close to possible overflow. */
+				unsigned long long tmp;
+
+				if (check_mul_overflow(res, base, &tmp) ||
+				    check_add_overflow(tmp, val, &res)) {
+					res = ULLONG_MAX;
+					rv |= KSTRTOX_OVERFLOW;
+				}
+			} else {
+				res = res * base + val;
+			}
 		}
-		res = res * base + val;
-		rv++;
-		s++;
 	}
 	*p = res;
 	return rv;
-- 
2.53.0

