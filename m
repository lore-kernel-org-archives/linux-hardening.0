Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11C243387;
	Mon,  9 Feb 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656343; cv=none; b=RFa52Slahy6lZKlIsmcGDaDmk5i/3JGqutgeLAW+ZVC1jxWvafgy7TpASptXgZ6hIv6OPxBuACs8xUtlJqbxwLnY+upNavh+LJgwPml6DQwpNA5pIYnFcwWrvef28y2AvrlZ8mTRugPq6LUzhhk47On3jTpbBrTcNE/TIWxfNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656343; c=relaxed/simple;
	bh=eO5tke+KhgXh2513zEmf5TEKgDgK3D90rv/LsDRg6s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWxU6Mpd64j3ZNkomF+hD+5taBx/I5rGZ99py7qmwI9+ki3vKI43C3DFn5nqBPqO+OFkxE47DC/dCvyhVVwMuBQDmq22kRl9a1fwrae+GDGgHQEVLNFt83ZXFUXVNaL5BXDhXdu2BdGtkVyYJnyD4iOj2taLkDwrUrobgd7qILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Q2tV9Cx5; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Q2tV9Cx5"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id 32DEE828AF;
	Mon, 09 Feb 2026 19:53:11 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:405:0:640:8814:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 5181CC007C;
	Mon, 09 Feb 2026 19:53:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0rUtjO1G1mI0-Du3YAbWs;
	Mon, 09 Feb 2026 19:53:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770655983; bh=6wKqFxInnLDgQDtAb5C+Fe26hbEaSYc85Ba2o1NJxoQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Q2tV9Cx5bVC/9Ouk6h+F8d8Xv84CJDH+C6uxXh11+ePuPRbDqF+yFc5LkY29XS2ya
	 gon+DrfsNoOsBTyKJ3USSrdSwmapj0yX9dmhaRNTnnmBntKLJLnU9E62tT1HH520k1
	 sGcNOqd5aGR9ycNnmPIh2KkhdAxsC9+SokN4xEQA=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v6 2/5] lib: fix memparse() to handle overflow
Date: Mon,  9 Feb 2026 19:47:54 +0300
Message-ID: <20260209164757.433932-3-dmantipov@yandex.ru>
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

Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
capable to handle overflow, adjust 'memparse()' to handle overflow
(denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
use 'check_shl_overflow()' to catch an overflow possibly caused
by processing size suffix and denote it with ULLONG_MAX as well.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v6: handle valid-suffix-only string like "k"
    as unrecognized, minor style adjustments
v5: initial version to join the series
---
 lib/cmdline.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 90ed997d9570..0d8770a0fb67 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -150,39 +150,57 @@ EXPORT_SYMBOL(get_options);
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
+		shl += 10;
 		endptr++;
 		fallthrough;
 	default:
 		break;
 	}
 
+	if (shl) {
+		/* Valid suffix without preceding number. */
+		if (unlikely(ptr == endptr - 1)) {
+			endptr--;
+			ret = 0;
+		}
+		/* Apply suffix if no overflow. */
+		else if (likely(ret != ULLONG_MAX)) {
+			unsigned long long val;
+
+			if (unlikely(check_shl_overflow(ret, shl, &val)))
+				ret = ULLONG_MAX;
+			else
+				ret = val;
+		}
+	}
+
 	if (retptr)
 		*retptr = endptr;
 
-- 
2.53.0

