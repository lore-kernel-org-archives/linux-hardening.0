Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40589344D8D;
	Thu, 12 Feb 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900996; cv=none; b=KZQyqIISXi2+nxSKv4oVo2aBZFkfUXSKxd3Yb+YgGQPP9RsBs+NFENs5757vcrwMzO2d7QOPcQiujzr16JG67yTljTVryp7m6vUmAWKCaJ8agWSkRaRdjYlFyuhDu+B8PnCeejtC70piYyrAZSbkRJ1Cc06Ooah81dEl/93BnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900996; c=relaxed/simple;
	bh=GNvRl/vnU1Hml3S4xBWc6gSd8ReWQFLSiLhhmFoXg/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GukN/Mc4dRjM+5WlNRKxW5cB6koEEXO8EvDyRpHSu1ZI2nU65PuwCK4fWNM8baWZ8/V4K53K3MeU+nznh6Ui5OLlSqDHVl2laJTun4BG0uLcGncr0KNv78Xt3pVJm5ZNZ50lqJpEZ0l/zyYEQOJcCatz+oajKL2X83B5k2fGz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DpEoNja5; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DpEoNja5"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 85AC7C00E5;
	Thu, 12 Feb 2026 15:56:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VuTjuXAGI4Y0-t5M3j9IH;
	Thu, 12 Feb 2026 15:56:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770900992; bh=8VakxvMiRlhjvCW7DRsU1ML8jUVZAdBqq0Hn2wUrTC0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=DpEoNja5u/Xgjjxbnerv/Pjg4t61D+FuKn/GST74tZs6T3a7OFWqGDSEVvTzTgK+R
	 d/Bi/g/G6IhaP4qqyCXZckds2gNP3JBKAmcmoXLtoQDo3Nyxhrjq/0T1Kb7JIin2Fw
	 ovsZL+gtoCa2ZEnYUOmJWDISvNqkwgI5Iu0eixMw=
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
Subject: [PATCH v7 0/5] lib and lib/cmdline enhancements
Date: Thu, 12 Feb 2026 15:56:23 +0300
Message-ID: <20260212125628.739276-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust '_parse_integer_limit()' and 'memparse()' to not ignore
overflows, extend string to 64-bit integer conversion tests, add
KUnit-based test for 'memparse()' and fix kernel-doc glitches
found in lib/cmdline.c.

Dmitry Antipov (5):
  lib: fix _parse_integer_limit() to handle overflow
  lib: fix memparse() to handle overflow
  lib: add more string to 64-bit integer conversion overflow tests
  lib/cmdline_kunit: add test case for memparse()
  lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings

 lib/cmdline.c             | 34 +++++++++++++++++-------
 lib/kstrtox.c             | 33 ++++++++++++++---------
 lib/test-kstrtox.c        |  6 +++++
 lib/tests/cmdline_kunit.c | 56 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 22 deletions(-)

-- 
2.53.0

