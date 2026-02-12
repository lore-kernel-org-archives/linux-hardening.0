Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C735BDB2;
	Thu, 12 Feb 2026 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901001; cv=none; b=M5jL5Rt/TUD8dDqZMChaNSvU1mFRHNdqf7cWgCo41mx/h28jnboZGEZ+9reHpJWuxy7y7dsKzRX9jExgxj+1s4KvkgcKsbCtdYjLf81b1KNv6d5rz12Hfjo1Lmv+0vt647fN5TPTYZlGMS3t6WD9Ub7fxtOvZDSdicNZZ+D0A8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901001; c=relaxed/simple;
	bh=3yabApihiYJ68XRFacLC8Yylt3n+P7wvNETpIrfho8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbMx42R8lO1hzovcrPWBaMYYfBH4ojXtGeHApPoRXrKLbiXS/oTvOr3oyK5mY8VB6Y572Y1PP0dS/Z9gsi8O+m3DQIqK8Lc5S8XLajZWrRLxXoJTi0DALYufqPqCYcfcoh4pmCgjjAHbr9C1ei3ndfHBg+QkhioRJIdeW0/23LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RT2A+E/R; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RT2A+E/R"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 4678FC0082;
	Thu, 12 Feb 2026 15:56:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VuTjuXAGI4Y0-wTpp4CyV;
	Thu, 12 Feb 2026 15:56:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770900995; bh=lQkD1HjdqbKWVKea36s5LLC68RWQLUMntkSSahrra38=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=RT2A+E/R0b7seaIGh3uW3lF4n6gFfNeZJPI1SDdPFiQAh7wKgvZfkUgX2MfSGDGGo
	 jIHC+qkqkq7ZD7lRIZYkN62/6OIZQ9NSlT9WPfHIzQh1Ia9qIq6C8OvsW86Z3gVOk0
	 GNL5kRdlkDeEOw8mbY5jM6B82Ut9KsPsIxiYKaZg=
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
Subject: [PATCH v7 5/5] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Thu, 12 Feb 2026 15:56:28 +0300
Message-ID: <20260212125628.739276-6-dmantipov@yandex.ru>
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

Fix 'get_option()', 'memparse()' and 'parse_option_str()' comments
to match the commonly used style as suggested by kernel-doc -Wreturn.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2 and upwards: bump version to match the series
---
 lib/cmdline.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 32da6f5a9cdb..357798b79682 100644
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
@@ -209,7 +212,7 @@ EXPORT_SYMBOL(memparse);
  *	This function parses a string containing a comma-separated list of
  *	strings like a=b,c.
  *
- *	Return true if there's such option in the string, or return false.
+ *	Return: True if there's such option in the string or false otherwise.
  */
 bool parse_option_str(const char *str, const char *option)
 {
-- 
2.53.0

