Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF640F8CB;
	Wed,  4 Feb 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213999; cv=none; b=HAnFfS2QDmjAMErCU2qSZZCYnGu9ph1Qo0z0y4ZWAoh902DpDwKXSB5d1TKrWQdnhXwkuHTz5A7dnXUInwdAlXPmV2pXe8Jj5XiM5dJgbOUEsOqEQf6mYrzTHkDllYaCTFrQRLbcHXTEgvl007Fbl1iucKFqr8x9jOX8/7Yezew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213999; c=relaxed/simple;
	bh=R6zs33WQ84en5tjPbrzZIwDWnySjLcVt8dD8Qw8zUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j10WhmCWQUtwmyVcitvmlv7roud/yCFFuT3MyndbnYtraFRwWKTwyBM1VGXZ7udXUNlARnJPj6amUxeim3QVysmz+rtPzVGKaYEFHwqbkKXEjrk99igt4yY2TBi2gWW9IL/5cXf7R81Zmo/bpks0u5UO0GrPXPtBj8NHEZCCRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lCKgjJkV; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lCKgjJkV"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id C195D89519;
	Wed, 04 Feb 2026 16:59:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 9959CC011C;
	Wed, 04 Feb 2026 16:59:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ixp7xlOGqOs0-v5X2gJ0i;
	Wed, 04 Feb 2026 16:59:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770213587; bh=j6IFUnJfkIk8paM3WA6aApufvLav+nbFsQN6ZWDlQt4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=lCKgjJkV2EMzWF0saEaLaDFYzs0Xpn5uDMn5rXjQILCyzWccI9ezNzJ0ySOG4X0SH
	 is3ce3Epc2qlQ2IeHwPLYccaVsh9d/8tnoB+S07amL1O/BPd8Izrs/KtPg92wXXFOt
	 5e62pX78nKTjPAhH4zg9fSePnRPYb401G3kyzY04=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle overflow
Date: Wed,  4 Feb 2026 16:57:13 +0300
Message-ID: <20260204135717.941256-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204135717.941256-1-dmantipov@yandex.ru>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
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
v5: minor brace style adjustment
v4: restore plain integer arithmetic and use check_xxx_overflow()
    on near-to-overflow branch only
v3: adjust commit message and comments as suggested by Andy
v2: initial version to join the series
---
 lib/kstrtox.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..8691f85cf2ce 100644
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
@@ -72,14 +78,21 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
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
+			} else {
+				res = res * base + val;
+			}
 		}
-		res = res * base + val;
 		rv++;
 		s++;
 	}
-- 
2.52.0

