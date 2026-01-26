Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490133A9C1
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444631; cv=none; b=tXpj61Y/pMJe6/Gockjr6n1yDk1QFjwGLjUHEQ9UvgAkjP6l4HobnFSlqzDVogSIxOuaCmUKbBlTQTFYDDJhTxbzXdQavNepZQnsuVEdQoSVwVUmWlRC2Xfw/ioLcZFvNvQfnDJLQKetM7li1Xq8Qs708Y6NoP6P+8LXTG+fsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444631; c=relaxed/simple;
	bh=a1ZLacA1O4sqCM9K8m+UETAL+Z9LVFjWKKCIavSkaqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ba0laN6oqyqdTvWVe6MU8G5hyBD1XsxBiuQx5oTpiUs9AcMH2M6V4e3OTNk9mAhJtUXp8SUnjjMY35CW6knIX71YE186jM52aVpCu8CwvEHwiz4xKc/7USo+n7xdFUQbTXIvN0XlZb/pZpOTRwSPXzE/pbZeSHQ2on4h2gt4zaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nsSYFxhT; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nsSYFxhT"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 783D7C0040;
	Mon, 26 Jan 2026 19:23:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aNjffe0G2uQ0-FqVjocgR;
	Mon, 26 Jan 2026 19:23:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769444619; bh=gdZM1isW/FpUtIl68uXvWfwQOLl2nChZepCdBBYmD24=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nsSYFxhTk9o8RmaJd1GMQ5JmeW2RWSP+ikb1oB2YQlPCcFqajvy1hpfzjfQnfG+rY
	 up4Gmzgly2Z0ngAHzCeAIEy7jh6NOsqBtDayZl6kDllm3+TsgcctwLQmpM8XEndiDg
	 DNKVLqA5bXrNq1+frcBzMWDhuTC9mZ3ka+5pyYu8=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 0/3] lib and lib/cmdline enhancements
Date: Mon, 26 Jan 2026 19:20:56 +0300
Message-ID: <20260126162059.357467-1-dmantipov@yandex.ru>
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
 lib/kstrtox.c             | 42 ++++++++++++++++++++++---------
 lib/tests/cmdline_kunit.c | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.52.0

