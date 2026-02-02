Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35E364E9A
	for <linux-hardening@vger.kernel.org>; Mon,  2 Feb 2026 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033786; cv=none; b=M4rWg5LhognVmNGbNV7I6vuXVvAafuRhozUdkMgJfd0EQADyg9pXefWCbcorDNv2Cq1cdXTfytRAi2j3Jo8IhyvGpzaTHKRwKhzbaM/G/VTzKJyJYxIN3irWGEQJO4amjXxgLMUmAdL/GH7Xd3Qfix10RnTamnrqeFd/2qF7nFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033786; c=relaxed/simple;
	bh=O7tidpFK+ugE1Ls/AbwlJoGQa9NkJgPhdeeKFJzQIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5lg9VxNnCVcJ9JaEjo1D/FX4aLr+p5iR18P9soTpdRDINx0FKO4qRERyw2SNFlcxDo8ury24AcqsAaF30P3wJhSlzFs//rOypyy8EkzCp3zyX6zHBg8Iv00oCoqOX+1yfJyEiA8RsrjQITZbSLZHIO9pAsDzGzAXbQHxsTFdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=WKK6n+6M; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="WKK6n+6M"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id AF1B3852AE
	for <linux-hardening@vger.kernel.org>; Mon, 02 Feb 2026 14:55:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a9f:0:640:207a:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 1D906C0051;
	Mon, 02 Feb 2026 14:55:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tslFK8gGKCg0-V0vhX6LE;
	Mon, 02 Feb 2026 14:54:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770033299; bh=Ljte7UY/J7OmT4etotlp/R+Xr3gmeIMMeunVnTOqzbo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=WKK6n+6MV1ljW5c4n5IagX3rJVlvkl6rC0NjLpaVpjYuLsFz7cBa4qfU3hm6cZo1U
	 c6FsU4c+LXvhdicMjV4C74o7bmGhGQEEXabUFWrg4KQvjOLVCKp4ZwQIbHuRrzOXWH
	 tei7emttKutSFzYGTXUtbrxjHAiL6GaVY8BD3Qb4=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 4/4] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Mon,  2 Feb 2026 14:54:51 +0300
Message-ID: <20260202115451.290173-5-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202115451.290173-1-dmantipov@yandex.ru>
References: <20260202115451.290173-1-dmantipov@yandex.ru>
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
v4: likewise
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

