Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33252E8B94
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168887; cv=none; b=H9eoMuSGHh9KeBD0hAzjEOd0Yh88P4EhXJxopxbFAx5pVnhQ3vCxHVSpEfET0mpUDMQ0forWIT0/hHMV187sIUh1eLltSKD2miHsamdcvyc7YiaIEyl8uQS9PJJBbQ7rSnEEEsJJTy99Z3gbVgj/PjkkohrLtoxrDpD4hOgTqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168887; c=relaxed/simple;
	bh=xmXqm3+X0pUYGOJEG6RysVloyQXvCD2HnOg31fEc3Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COQONrxCiMGVmFsTVwUxg3w3bbSC8TladieFIRgoDDHr9rd25zyxEn1ItMa3mRX3XBhbio1RlR4xsuXy48xniXFu81R2iPC7w3rnXJO8msqq/xwU9JbytI7BSwjf0hIoITuJDCeWwanAylwHMivPWuBY29zJ9QFBeoaJxNgjqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LXJuW72Z; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LXJuW72Z"
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id E7812C00D7;
	Fri, 23 Jan 2026 14:47:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rlbvWNAHGiE0-mUHbwjZr;
	Fri, 23 Jan 2026 14:47:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769168875; bh=r7bFrLoVuRvMJu7QoD7E9CGgKqRYweiHYW3AsLvih24=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LXJuW72Zk8Mp7c3LZd0NlyvSOolTtlwMtrZgc0lBSvCr++Q+B3+lCRwQLzzt//PgI
	 c5YuDY5YOmdWuSWW77AGG1qqFi0y/McEHSbzek+VNTEUxoBOE6RkhRw8GOiuzuBA1o
	 xISCS+uWm0ZX2Ume3b6Egsm8Mn4DYwet2XlJBatM=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 0/3] lib and lib/cmdline enhancements
Date: Fri, 23 Jan 2026 14:46:44 +0300
Message-ID: <20260123114647.1606335-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust '_parse_integer_limit()' to not ignore overflows, add KUnit-based
test for 'memparse()' and fix kernel-doc glitches found in lib/cmdline.c.

Dmitry Antipov (3):
  lib: fix _parse_integer_limit() to handle overflow
  lib/cmdline_kunit: add test case for memparse()
  lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings

 lib/cmdline.c             |  7 ++++--
 lib/kstrtox.c             | 32 +++++++++++++++---------
 lib/tests/cmdline_kunit.c | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 14 deletions(-)

-- 
2.52.0

