Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0DD21E0AD;
	Thu, 12 Feb 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914661; cv=none; b=nHpAjV0wOz7g75BRsZDcijMq3TKvOA3DXUU5dObhixwI6MZws1kHEfBocucwqWm6YMw2ukDCK01le2etyjUrz9G43GCsRR43YGWaYud+MIaQbhq5nfzl2F+aaDx/9kR43tOYxibGfWvNnkPEReRvYIbKIXzitLnzWIfOxZWYlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914661; c=relaxed/simple;
	bh=YbaYBt5wymcfE8LewVf5ekMotq+LDY7DQpbKBXZ6uKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTXZf8JAkfIZjpfyjSJ6Sw5Qs2j7H+3oYzi8PP3mmnXgpnMv/HjM7JxZXLcixk03mjI8OlMSTiTYe83KZffXBsYJcK1Y8cxeWjoB0biukbOWsA37gzgVjHhvDwdN+XbZd0I23dlZt8J7X2W2ig7qDCD9dSBcEV5IjhvOU97ifXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=eTmqtncd; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eTmqtncd"
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:3990:0:640:454b:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 44367C005E;
	Thu, 12 Feb 2026 19:44:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id EiXcAWCGxeA0-5NXQQlI4;
	Thu, 12 Feb 2026 19:44:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770914655; bh=3V07dujldyfd8+VLUbZqe5xXRGtEZD6+Cp1Nv6yYR9s=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=eTmqtncdWpThOtMdnAR5ow/+4i8fj6/xGz5S1Vhz4RyyhJ3HsD4D+ocrvHlkuI6sP
	 Fp7UGUX1rfNLKFDLpYHMwxpwa6psZk2NhHFI5rEochUxuMArIIhLn1PAlzaXlzgSt1
	 mjAx9hyrth06bzrVkfOiV4m2ciyEPMLeSXN97zcQ=
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
Subject: [PATCH v8 0/5] lib and lib/cmdline enhancements
Date: Thu, 12 Feb 2026 19:44:08 +0300
Message-ID: <20260212164413.889625-1-dmantipov@yandex.ru>
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

 lib/cmdline.c             | 30 ++++++++++++++-------
 lib/kstrtox.c             | 37 +++++++++++++++-----------
 lib/test-kstrtox.c        |  6 +++++
 lib/tests/cmdline_kunit.c | 56 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 25 deletions(-)

-- 
2.53.0

