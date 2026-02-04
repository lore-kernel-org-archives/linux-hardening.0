Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A132571B;
	Wed,  4 Feb 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214035; cv=none; b=cTy/L51tZhLaVVDAjrejyBdatkTiXfkCKn9LCH/2Rh0+FbtKJjrCnkv5TS7fMcCvCbTB5P3hzcrt4BaJQyxfEwdBy8hdhX7Bv5sd6FQ8N0WyMAdO8jenGqwUgQoymH8uF+wrYZlPl8mCY86OcU7LSnkHBaFrbe8+wuN49RbjQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214035; c=relaxed/simple;
	bh=0HlBZQsfQqCnVJ+Cj9jTFVxH6hjqTnQaD1skX60UBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfEhjxHMNNkcsl2UOfCJ/Qc62SS0HjylhqxGiSd2reMBmfV+leFavc/hIt0GIU5/Nff4qGKERVMePR+d+fffvhQNTBwIKXJbl2VbBJrNjxP4HPTBlyMAaBR0S+42fI0TuvK+86yF967QzeocdaWsZiaZPz7uLH8F7bAUn4erWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LE8BuIZe; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LE8BuIZe"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id C222B88A9A;
	Wed, 04 Feb 2026 16:59:55 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 12B12C0104;
	Wed, 04 Feb 2026 16:59:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ixp7xlOGqOs0-fnDqrqmw;
	Wed, 04 Feb 2026 16:59:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770213587; bh=Ph9nlSIHnFc8uYBX8avqimT9s/mmxhrA1L+zGGONLyI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=LE8BuIZeqS7tyHiQ8MTXhfPRvP9e1fGkjYbge/x4i2viaxLx4heR0+vfW3SysWsIh
	 hxrWZtJg3fBm9iBZiLsWpVvwZGv4/LOrwV8Ogj7n59t0FWHD1gOazrccfCVQre+qA9
	 u62u76pPut0u56NIFKKpckbTTLIiLd4KFE4pP0Dw=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 2/5] lib: fix memparse() to handle overflow
Date: Wed,  4 Feb 2026 16:57:14 +0300
Message-ID: <20260204135717.941256-3-dmantipov@yandex.ru>
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

Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
capable to handle overflow, adjust 'memparse()' to handle overflow
(denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
use 'check_shl_overflow()' to catch an overflow possibly caused
by processing size suffix and denote it with ULLONG_MAX as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: initial version to join the series
---
 lib/cmdline.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 90ed997d9570..e18fdfb80ba5 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -151,38 +151,48 @@ unsigned long long memparse(const char *ptr, char **retptr)
 {
 	char *endptr;	/* local pointer to end of parsed string */
 
+	unsigned int shl = 0;
 	unsigned long long ret = simple_strtoull(ptr, &endptr, 0);
 
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
+		shl += 10;
 		endptr++;
 		fallthrough;
 	default:
 		break;
 	}
 
+	/* If no overflow, apply suffix if any. */
+	if (likely(ret != ULLONG_MAX) && shl) {
+		unsigned long long val;
+
+		ret = (unlikely(check_shl_overflow(ret, shl, &val))
+		       ? ULLONG_MAX : val);
+	}
+
 	if (retptr)
 		*retptr = endptr;
 
-- 
2.52.0

