Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5433B6DF
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444632; cv=none; b=UVcjFw+GkaDal6WZC01lhB7u7PwLbAIpDgmL4BoD7NL61QEeHEdJlUk6pLMObvpLoGAsStENFOcOcqNIFfCuuRZ3J9GMWPCJ9VIOO1/leL878aHTB+yTOBouMFfVhAEyuEic6XlOpcBqW+/79VKS1FaoQJEZjHq+c7sYXMfSLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444632; c=relaxed/simple;
	bh=d67W2OXkyAeWV/HU+DFA7T8dBk58jKrNZ8BZcA5P14k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT+kz+qHydie9A++NqRh74KiSz5GTsDLDAFv++fx72oHPrW59+XJTZqaalNEZBs0j4gxBpFUCdIyq1Of0zTi3O59/tVq+J7vGuSZU7IesbaBvfqU4JOJriANp0mD4Nv6nBKU53rapvSJtwMh1moCMAPbkhHr6drpuHm2HPh7090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ovmfTxgK; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ovmfTxgK"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 110D2C0055;
	Mon, 26 Jan 2026 19:23:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aNjffe0G2uQ0-hM1gHxDI;
	Mon, 26 Jan 2026 19:23:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769444621; bh=z0CT4is7vfFbdzSTNcDKog/2Nc05481CDOvsGBFMpN0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ovmfTxgKNAenOK1XdZC9sCRa1nKX1urwQ435fRvdvdrD5woWjI1ThM1F+wBiorEaK
	 LgnYEPSDIttHEculjeG1ri39PkMESJzdIiLtYJ98BAYJQqEvYsT/Qf7TNj3nDUroOF
	 DGEdTZIsIjOmCvy6NmT4/Kz4K+/xpNL2cGrsdalA=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 3/3] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Mon, 26 Jan 2026 19:20:59 +0300
Message-ID: <20260126162059.357467-4-dmantipov@yandex.ru>
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

Fix 'get_option()', 'memparse()' and 'parse_option_str()' comments
to match the commonly used style as suggested by kernel-doc -Wreturn.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: likewise
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

