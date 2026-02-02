Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9635DD19
	for <linux-hardening@vger.kernel.org>; Mon,  2 Feb 2026 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033773; cv=none; b=IU8Ofy1N847zJkUuoW8uZ3dJTMp4oTJn+Om02E/nDGwdRA56losGhFoo0cKia2Eg8nB4C95iuA7dsGHayUGIw8A0WoDFhTvJDlLFtCucbkMVSqmkHT5k9laAGUKeD2VOE6b9nCGXcJ1aFW6mhEXvPvaikqRxseyrtbpzYFJTEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033773; c=relaxed/simple;
	bh=jrBOSXQh6gTo57/apq+pZHUDo5QYgyGFNWVl7p7Op2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG9HPfZOy5VuLTmy7RtSPeEaytQ9p+DYk+maHtSdS65eKbqrsQIEzkDTOZ5pSV4/cQKeSNJjU7ojf5I7MedbSC6QFwBDicksX6D8/W/9USMUsi+lJFq/fKJj9F770YcxUiDUc1WC/U+i09dca25vJqsEUt9XaR93T7Dv6LLGr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RABObacO; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RABObacO"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 8EAC382FDB
	for <linux-hardening@vger.kernel.org>; Mon, 02 Feb 2026 14:55:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a9f:0:640:207a:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id A376580CD2;
	Mon, 02 Feb 2026 14:54:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tslFK8gGKCg0-sm74w5qI;
	Mon, 02 Feb 2026 14:54:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770033297; bh=nliBDhyARHG0HKrNYpdkx/PWjcymNmOgqQOKAuYYeJE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=RABObacOfY3mzMt3BASMEEtrhyz0nRUtvx7tDAf/UFE8kRmpIOusaJtqKePjto2Yr
	 CDQAQ9+haX2g76cQn0QfAMUYnAYupfF9Ap86eLcahdNQQhA4SzBBIOPLlke/FmKPeI
	 9SvpmOPmfNsbITpmpQyzzgiZnv8yWRxp5A/K5ETM=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 1/4] lib: fix _parse_integer_limit() to handle overflow
Date: Mon,  2 Feb 2026 14:54:48 +0300
Message-ID: <20260202115451.290173-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202115451.290173-1-dmantipov@yandex.ru>
References: <20260202115451.290173-1-dmantipov@yandex.ru>
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

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: restore plain integer arithmetic and use check_xxx_overflow()
    on near-to-overflow branch only
v3: adjust commit message and comments as suggested by Andy
v2: initial version to join the series
---
 lib/kstrtox.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..137132e1a207 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,20 +39,26 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
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
-	unsigned long long res;
+	unsigned long long tmp, res;
 	unsigned int rv;
 
 	res = 0;
@@ -72,14 +78,20 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
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
+				if (check_mul_overflow(res, base, &tmp) ||
+				    check_add_overflow(tmp, val, &res)) {
+					res = ULLONG_MAX;
+					rv |= KSTRTOX_OVERFLOW;
+				}
+			} else
+				res = res * base + val;
 		}
-		res = res * base + val;
 		rv++;
 		s++;
 	}
-- 
2.52.0

