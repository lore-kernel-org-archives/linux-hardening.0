Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D035C1AD;
	Thu, 12 Feb 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901004; cv=none; b=uwOBmjEl0+/STPk7Xp7lK+Ni/eEPfGj7HrLj+I+07VN6dPULSB0AAWVGCgDeRBZHrrHYefllUMO6syjD7jeg613D0f2LZ3vvZI32bXD0linUSkk7UwqSTrKUZ9NScjeWK8VJmkWFJmWBOqG6OcrS7xOu6t7iVlsBZfCakHYmbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901004; c=relaxed/simple;
	bh=mnKuLEH8BfjkEMBC9cWgyEAo0Be6SXc3cyw+vkboY2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7UMkzr4BQ4xR6GM5CbSjJ27i1zusA/HUbQqavBds1pGyxheq+EQqXAdY4zXrf0IIA2afBe6iYrYOOuJk+c8DFdtqwE4+e070q0RalHbvqZyLrLfnG3JKwz/l5hSBtLwrn0NFxzGueQJK/QeJnmcEkaMuXmhuG8TNJtha3abAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Nqi6viXC; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Nqi6viXC"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 2FFF2C0102;
	Thu, 12 Feb 2026 15:56:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VuTjuXAGI4Y0-yXnszrB9;
	Thu, 12 Feb 2026 15:56:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770900993; bh=bUSYSYWj4dObYpG0McIjHrOKuumKhZrreSa3eiSsy1k=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Nqi6viXC11Fa2rMq15n8chAksHUfXjGoSFL0T3C2NBu+Wpn0RzHmQAiFqikWz2ojm
	 8KkmqPXPY/1qOedErE5KL6rR9OT6YlyJwZULQq4zjSt/AiedNTRovSOE87KjXGkjhm
	 +XsW9wlnoFeT9NJeyOaKyjRvIwiMUlBz+fim906g=
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
Subject: [PATCH v7 2/5] lib: fix memparse() to handle overflow
Date: Thu, 12 Feb 2026 15:56:25 +0300
Message-ID: <20260212125628.739276-3-dmantipov@yandex.ru>
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

Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
capable to handle overflow, adjust 'memparse()' to handle overflow
(denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
use 'check_shl_overflow()' to catch an overflow possibly caused
by processing size suffix and denote it with ULLONG_MAX as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v7: do not double-adjust endptr and drop
    redundant check against ULLONG_MAX
v6: handle valid-suffix-only string like "k"
    as unrecognized, minor style adjustments
v5: initial version to join the series
---
 lib/cmdline.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 90ed997d9570..32da6f5a9cdb 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -150,39 +150,50 @@ EXPORT_SYMBOL(get_options);
 unsigned long long memparse(const char *ptr, char **retptr)
 {
 	char *endptr;	/* local pointer to end of parsed string */
-
 	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);
+	unsigned int shl = 0;
 
+	/* Consume valid suffix even in case of overflow. */
 	switch (*endptr) {
 	case 'E':
 	case 'e':
-		ret <<= 10;
+		shl += 10;
 		fallthrough;
 	case 'P':
 	case 'p':
-		ret <<= 10;
+		shl += 10;
 		fallthrough;
 	case 'T':
 	case 't':
-		ret <<= 10;
+		shl += 10;
 		fallthrough;
 	case 'G':
 	case 'g':
-		ret <<= 10;
+		shl += 10;
 		fallthrough;
 	case 'M':
 	case 'm':
-		ret <<= 10;
+		shl += 10;
 		fallthrough;
 	case 'K':
 	case 'k':
-		ret <<= 10;
-		endptr++;
+		shl += 10;
 		fallthrough;
 	default:
 		break;
 	}
 
+	if (shl && likely(ptr != endptr)) {
+		/* Have valid suffix with preceding number. */
+		unsigned long long val;
+
+		if (unlikely(check_shl_overflow(ret, shl, &val)))
+			ret = ULLONG_MAX;
+		else
+			ret = val;
+		endptr++;
+	}
+
 	if (retptr)
 		*retptr = endptr;
 
-- 
2.53.0

