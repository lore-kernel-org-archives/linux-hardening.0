Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B9284662
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168887; cv=none; b=iJHOaaAID56y55Ksgvm2yXBZbGBKH2wOwFopasCVCh7aX4VVYjO6sIyqBPf8PIUltd5gnRXTeK3tuScv3CKWjW0paYwQx6+aedkScMVrFRI7nYstFAu/IoIvT9Y3iI4UKej3/bvT4KspN5XnvNJS48/IAW3PX/QS6hHTiFEeIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168887; c=relaxed/simple;
	bh=Feef3qYcIkrxYsZ32ddrG0AHGnZKsavwS+ecFL2lU4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUFp/nRAqNuTBXkWuArzAwaZ+5eGY8MCE1MvmE+HCxfkq9ttmKaQrhs++XsIxXxiW+Ce41vWhSiHXXcXOBBhdGm+oPhqYRHIkd4mV3LnN5EaHiNF0L7gfC0ZWvxdffTYEiRt8U7VzQC+CNiSIn43P/+hEyDvmKNKmIBekxaA7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=P2Y3itzI; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="P2Y3itzI"
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id B631580C97;
	Fri, 23 Jan 2026 14:47:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rlbvWNAHGiE0-mfxXO72s;
	Fri, 23 Jan 2026 14:47:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769168876; bh=5fnRAXxxrq8dO6cBKof2PfeoSYRkGBRTWntfWaK6J8U=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=P2Y3itzISQsD2JHglCDYHWf47nRAQxUgxHxf6ZQqnmtiKRbi++rlVqa92xJmOA73/
	 hKP1eUJNMSJJF3/9foU7OmRF2iCT2RQ6PgTVAzAazqeHvVF28niQq7lM6gY3v2QK1B
	 F5G666snoRyzDh1JxSF6zbD3YH8BN5JwCwqqz53I=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 1/3] lib: fix _parse_integer_limit() to handle overflow
Date: Fri, 23 Jan 2026 14:46:45 +0300
Message-ID: <20260123114647.1606335-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123114647.1606335-1-dmantipov@yandex.ru>
References: <20260123114647.1606335-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In '_parse_integer_limit()', replace native integer arithmetic with
'check_mul_overflow()' and 'check_add_overflow()' to check whether
an intermediate result goes out of range, and denote such a case
with ULLONG_MAX. Adjust comment to kernel-doc style as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: initial version to join the series
---
 lib/kstrtox.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..a416cdafee37 100644
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
+ * This function is the workhorse of other string conversion functions and
+ * you do not expect to use it explicitly. Consider kstrto*() famlily instead.
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
@@ -72,14 +78,16 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
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
+		if (res != ULLONG_MAX) {
+			if (check_mul_overflow(res, base, &tmp) ||
+			    check_add_overflow(tmp, val, &res)) {
+				res = ULLONG_MAX;
 				rv |= KSTRTOX_OVERFLOW;
+			}
 		}
-		res = res * base + val;
 		rv++;
 		s++;
 	}
-- 
2.52.0

