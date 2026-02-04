Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D940F8C2;
	Wed,  4 Feb 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213598; cv=none; b=KlrCZNeCngU958TmXaA+ZXscceWGuGPdowZdOOVaqjJ5l8r6/y5eVHRMIJ/woDhMpWrSO3DoX6tVZM4zCMRxZ6aoqmnrId4Q5BElxWzoEC4aZVOEf2f/JpfVSbk6Q6N77VY1ObUV3iJuHGcS0duOI3i4E0yUQ4NssScqdVQ3YQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213598; c=relaxed/simple;
	bh=qeYCwCyPFsOM3FUtsZBFHWHlf9wMKyvS2v+X7GWuWJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/LucQRn2iYK7UZZL3PYvJD3MWYIHXOEGFyILncZbYYtFeWEy5zWRfhbTq2Lx9felOmrtKaSqbg9JlHnyUGCcQv7Og3itwlRC2Bl9kQ+btuVkG1msdnVFQKbt6uZ0lNB8UPixJJKkUfIOBe32Xt+zlQdVJh7+N8tcln0ErSv8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lsQtjLD2; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lsQtjLD2"
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id C64B3C0086;
	Wed, 04 Feb 2026 16:59:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ixp7xlOGqOs0-gnLf22ma;
	Wed, 04 Feb 2026 16:59:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770213589; bh=BbpoEEQEsYGNHUUR7D/TJUYhcvpQHUq5n7L8TA6k0Ck=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=lsQtjLD27eqiQMboPaRlvZQWs6bzbfk8d3O/83opFDh/KnZzd9Bz7jAMt4yPCfd9J
	 yi01sGXhmMc7H8KCK+/jLTHTSxPc0r2ugd5DlOzJssShiYJLO/ibLrmaKXHTVLs1qJ
	 cMZ0j2FGaTQoDvEKkUQeZtcGOu9euAcc5pQl9J7k=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 5/5] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Wed,  4 Feb 2026 16:57:17 +0300
Message-ID: <20260204135717.941256-6-dmantipov@yandex.ru>
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

Fix 'get_option()', 'memparse()' and 'parse_option_str()' comments
to match the commonly used style as suggested by kernel-doc -Wreturn.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: likewise
v4: likewise
v3: likewise
v2: bump version to match the series
---
 lib/cmdline.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index e18fdfb80ba5..c6f7aa5abe77 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -43,7 +43,7 @@ static int get_range(char **str, int *pint, int n)
  *	When @pint is NULL the function can be used as a validator of
  *	the current option in the string.
  *
- *	Return values:
+ *	Return:
  *	0 - no int in string
  *	1 - int found, no subsequent comma
  *	2 - int found including a subsequent comma
@@ -145,6 +145,9 @@ EXPORT_SYMBOL(get_options);
  *
  *	Parses a string into a number.  The number stored at @ptr is
  *	potentially suffixed with K, M, G, T, P, E.
+ *
+ *	Return: The value as recognized by simple_strtoull() multiplied
+ *	by the value as specified by suffix, if any.
  */
 
 unsigned long long memparse(const char *ptr, char **retptr)
@@ -208,7 +211,7 @@ EXPORT_SYMBOL(memparse);
  *	This function parses a string containing a comma-separated list of
  *	strings like a=b,c.
  *
- *	Return true if there's such option in the string, or return false.
+ *	Return: True if there's such option in the string or false otherwise.
  */
 bool parse_option_str(const char *str, const char *option)
 {
-- 
2.52.0

