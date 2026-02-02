Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D00364EAB
	for <linux-hardening@vger.kernel.org>; Mon,  2 Feb 2026 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033621; cv=none; b=N1HbTyuGcyo+BU3qZevKoYOZCGi56RZ0/6Myxons8WL+96xR0XoEtCk1XgaiAaw5VyHr+dxLw6/XmSo1RR0z5ujSaiPzGiVeXTpDjpPllczOSDN+maCwN7o/6YFdZ0U1eSsVGwttM/MWpnZIZvfvVtNZPVtoRU1Z/35Cr8GndOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033621; c=relaxed/simple;
	bh=dyGBFKUnClzCel0oAo87uDZh1UBKlgh4meHRzE/FCaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXwqIyXEM2hVzbEkqsS59PyWwMCMIbu/yJwPsKd7oH8HHh/N9Oq2giSqb2f8feMVnzgEdqSmJdiqIK+2R1p2qrStGHLKzKw31L5FOtsrZp5wFu/iWCso8Fovl83DVpoYpDOcx594Go6cpKj+GEWgCVxbcovgbTM+/shqVUICOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=rxc/8My9; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="rxc/8My9"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id 403788988C
	for <linux-hardening@vger.kernel.org>; Mon, 02 Feb 2026 14:55:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a9f:0:640:207a:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 02CB580DF7;
	Mon, 02 Feb 2026 14:54:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tslFK8gGKCg0-gVKuOWsz;
	Mon, 02 Feb 2026 14:54:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770033296; bh=yY9+ISNLOXMSBW0XrA2OYcEGtc5okbCvCdONMziR/AI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=rxc/8My9loMvxDvRhPVEoip8I+sfrQ3Sz8BBVVOui6SgHggFRLnCB5rGw+yxpepcM
	 1B9nVfVeif8TA5pFkOPINmFwxwVnfPWSO5JtfW0Yl18Gp7/zTN//exbt6pM6L+5cia
	 DOYuq5HScRLzTmnMhm807/T9jx92NxT1OVNvtwdA=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v4 0/4] lib and lib/cmdline enhancements
Date: Mon,  2 Feb 2026 14:54:47 +0300
Message-ID: <20260202115451.290173-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust '_parse_integer_limit()' to not ignore overflows, extend
string to 64-bit integer conversion tests, add KUnit-based test for
'memparse()' and fix kernel-doc glitches found in lib/cmdline.c.

Dmitry Antipov (4):
  lib: fix _parse_integer_limit() to handle overflow
  lib: add more string to 64-bit integer conversion overflow tests
  lib/cmdline_kunit: add test case for memparse()
  lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings

 lib/cmdline.c             |  7 ++++--
 lib/kstrtox.c             | 38 +++++++++++++++++++----------
 lib/test-kstrtox.c        |  6 +++++
 lib/tests/cmdline_kunit.c | 50 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 15 deletions(-)

-- 
2.52.0

