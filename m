Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DC42B738
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080419; cv=none; b=NublIkLu/92DEzTCZ6VPjfS+NAAZ4s5hITH07SXWaoxh86eQko4oKn+B9bw5ciokFCfnj5FP37zGm4NVpTmC4mI5Q5Vy6oag/CFBNRqYblg9t5hUdVDlTEyr9NWwJMzmbJJnICybwaLDBx+MMg+teB0mXjH+RZ0r+/ibNyt3Wq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080419; c=relaxed/simple;
	bh=5PMCsE8iGgrRGfYLROICIFZPe+LYQ7NyqHxprlQBlzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8xnnyOMUNf4aR92u9WggP17uP4NFGI+rrtxKtQBX1LKEESoIVR+P5gHTmVIyJJ/OuOMIMRzTzVaICZNnE5TlsmB+Ag5ou8+7W8T3hjwsdyBuFpMaw2vRIw46WcZIHw7uwIxw+Q/0RF0kZ614Sgoy3pH0Yhv0xvJJGuEQBWSGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=rVPMK39n; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="rVPMK39n"
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4702:0:640:9195:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id ABFC0C011B;
	Thu, 22 Jan 2026 14:13:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ODaD4vJG4a60-3Sd7tikf;
	Thu, 22 Jan 2026 14:13:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769080408; bh=HJhwbPATE52Rir+9MuHdBfsAYVcpn9a0ieLHpgxgAlw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=rVPMK39n/HqReZUjJ9x6M7twK3Boj1JfnPvPVlOja2diKdDSA5693dfnJ4fD/idnA
	 NToO13tlDRx9G20lbpud2dXH6GIIMkwO6jGhwVR+ms1DY1BlWPJyYSVASb7DQMEwfp
	 T0j+NcVTr3VZ6Wo06dnnLC1cuga21hzfMMFGHd7E=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Thu, 22 Jan 2026 14:12:54 +0300
Message-ID: <20260122111254.1111811-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111254.1111811-1-dmantipov@yandex.ru>
References: <20260122111254.1111811-1-dmantipov@yandex.ru>
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
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 lib/cmdline.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 90ed997d9570..9ac23a0aecf7 100644
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
@@ -198,7 +201,7 @@ EXPORT_SYMBOL(memparse);
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

