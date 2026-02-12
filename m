Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0235D5FC;
	Thu, 12 Feb 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914663; cv=none; b=utVbJ9QPpv/nZjfeOwu5Ky1/EyJwVhb7JKFY73zDw05o2/q40ggZwdym/oS+0uWeQ7dw7jUaGtXQkD/5M+PNutRIiwjAUffZrToeLDR4C4M38Sq5u0EaGLA5Ja3UgaSS41nF8nzLjs3LEuU0XeY1NgVqBn5aOZVnDvveBDYfASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914663; c=relaxed/simple;
	bh=x7zQCTK9E9zvarWdz56OYkmXuR+sj+nJBAl9IBPWsk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4pD4UAkLr4/uEDob5br+K9B/XjxK7fbV+Tnk2umpTRjqkbgi6RGIqJYsaLDkHm/XOyqEtCBxggit4KO8CL2qN++FlSi+SCox5BAYMQLgiVbV74pTCLaV4aPHxWCj5cKiq/hHXSMMLRhSVh1+y8jaUQ65knx23BR4sm6Gv6UfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DN95QyO9; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DN95QyO9"
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:3990:0:640:454b:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 80786C0081;
	Thu, 12 Feb 2026 19:44:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiXcAWCGxeA0-n2xGa5QO;
	Thu, 12 Feb 2026 19:44:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770914659; bh=gA72Ls5eRaGrKkWfOZiySyHNm4v/PKnrrPEn/q+BU34=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=DN95QyO9YHAQTuBg4/0+TCm+fJiJPLwvQE93B2WchC7cLqk+jCl3g8tmq1bOeR/AP
	 2pEBYMPKMF7/IXQsgeLLKk3oN9cH3/7mhtDd2Voq8l+qpsCi8xB4J6dnaTnuP2tVAC
	 tj3Qr/b+kXnE7KdqAQ4aqhIkJNLaG13RYicWzQUA=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 5/5] lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings
Date: Thu, 12 Feb 2026 19:44:13 +0300
Message-ID: <20260212164413.889625-6-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212164413.889625-1-dmantipov@yandex.ru>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
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
index f6e4b113ca9f..16cce6621cec 100644
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
@@ -205,7 +208,7 @@ EXPORT_SYMBOL(memparse);
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

