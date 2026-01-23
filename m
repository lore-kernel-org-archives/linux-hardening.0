Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED143242D6
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168888; cv=none; b=ATwVlpAgBNacDee9b6lRpjF4R3YdEZQuPBhxMFEPIUXJXfybHH50tTEnoC6VJpnj6BklLIRXC2g18wBsZWDJiaWl19yEgypiH09l8uZBQSHF7V7mHUHKMpIZwHAUCaXmZaCn+pG6hodesep/+mMwRaFWgZ6DyEWYMXyXWaFEAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168888; c=relaxed/simple;
	bh=FzzhKiT+H3QbzpS+oqCPw/+baHOluF6b8Eoi42jZfe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og8tlwYXDsMaybohL4e410Ht3ayAW6nVDOh4OW1hDN9C98Twho9wTR4gFQx/K+Rj6gX4JkhhR8gFa8wMBHzx7o99+h8xjdz7ERnSxnKKDIJjsPV2hle42VDYFEYUyn/XTJYTo5N0ufGNsIf60xnCKSttuA+0RnerS0aSDKTPtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Y1BQx/XS; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Y1BQx/XS"
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 278EEC00BF;
	Fri, 23 Jan 2026 14:47:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rlbvWNAHGiE0-CCYGsMO4;
	Fri, 23 Jan 2026 14:47:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769168878; bh=rWKWbxOmailznWvjL9csdnllxIGZFyWuYxRNvAHRUoU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Y1BQx/XSu2+cxOf9O5gfEenhl+17GEpzHO0tJLEROGaOANHMyN/tnq9CKsU4t9VDn
	 G4QILWbnARBn8HcljWBMHP+EJP6H+S4ZLRH5r9QW6+WcR6a8I/8P2a3GQn9ZMuOj60
	 mV/zW0aY7YY2CjW6cK2vHbqtHS5JHmBqf48BuehQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 3/3] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Fri, 23 Jan 2026 14:46:47 +0300
Message-ID: <20260123114647.1606335-4-dmantipov@yandex.ru>
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

Fix 'get_option()', 'memparse()' and 'parse_option_str()' comments
to match the commonly used style as suggested by kernel-doc -Wreturn.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: just bump version to match the series
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

