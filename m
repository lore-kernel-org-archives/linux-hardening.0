Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803F3019A9
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444631; cv=none; b=eNNBL4s5nSsRFEifjlGJ8uEEsYKhXvM/Fu/x4IZ/UJfU4r8fLk9kx7OiV1RemESmHFSY9Q+iZJiLAGcSJcFyvATbq0QrO65U8OkqsK6OWHp2N3rI5rXt3k1KsTRRf6o1FkEYYdCgwXFlxrpKTe3yj3lUMQv/0LZ827dlk7emlPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444631; c=relaxed/simple;
	bh=Xyjmw5cutGi2qcdpifWnTngBCAFUPMbIZwVZD2gn71s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olG+96Lb/uJYK+0wNinPnCtCnZWf9WCiNVQcAtb/TE2W5HiG8xOLEzgRtST+ayLgWZTCzHQpE+mqZkIquP4izZiSUKBOqVHdVDRP7kyn1MhcxNCsEF4HVz49ZYKEhv8XDEaccMYVAbcNDeih4rZZ6V1wXNnsVgZq6lZ8Rdglhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Yb4LlPDb; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Yb4LlPDb"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 0A08BC00F9;
	Mon, 26 Jan 2026 19:23:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aNjffe0G2uQ0-1NVT5QPB;
	Mon, 26 Jan 2026 19:23:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769444619; bh=F9iCeMal4F4tSsfUWLzBFFqFEM0cRxJhltHabU79RG4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Yb4LlPDbtm3DYAHNPWtskOzev1MlolC7jw6CnsYg87gzV9E+BbbYlXGjuc9masThq
	 nY4x7gjsA0o3wfzbXJbo8p1tWbJgC7Yx56NO54ya6deT44siHjIyKtmgBtdpqqARaP
	 yevSFDFvCZfuOpnSOqOYPcpim/l3Pzio5H4HSkyA=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 1/3] lib: fix _parse_integer_limit() to handle overflow
Date: Mon, 26 Jan 2026 19:20:57 +0300
Message-ID: <20260126162059.357467-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126162059.357467-1-dmantipov@yandex.ru>
References: <20260126162059.357467-1-dmantipov@yandex.ru>
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
with ULLONG_MAX, thus making the function more similar to standard
C library's 'strtoull()'. Adjust comment to kernel-doc style as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: adjust commit message and comments as suggested by Andy
v2: initial version to join the series
---
 lib/kstrtox.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..443f89e92fa6 100644
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
@@ -72,14 +78,26 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
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
+			/*
+			 * tmp = res * base;
+			 * if (overflow)
+			 *	res = ULLONG_MAX;
+			 * else {
+			 *	res = tmp + val;
+			 *	if (overflow)
+			 *		res = ULLONG_MAX;
+			 * }
+			 */
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

