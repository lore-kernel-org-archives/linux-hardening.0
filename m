Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456813563C3
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080853; cv=none; b=Bn7Lgi8o4BrfEhINLPfKEwuvUb5R3C6VGaTQZ2I1z3kZ37rk4Y/D4twH9uzVLwaiEP85140AQZ7bKQdlNIeWFF55nyb1N5Xp96V/nRWTBXQSUHeeod1lgai9dZBaUa27MvJOYFuEzaqBPit8PG3brJ1XspqAmiE6CV3gyu/tMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080853; c=relaxed/simple;
	bh=56QRg+pqhzu593jHaurQHVxzvyzYYuMDirJy4o/Sjcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIbjocnk6CTyEPDKSGbyJ8O+tdZpSskCszXA55lnHfhtC9q9dYHZYnIIk9MIyMo15uhQWPXXBmq9QYVrTa10/D5Xg9DaonKmwURCS1TlRT286rfHElUg4xMUe7OeQMfaUNP4uX8jayLIacPIRlFjJjtjfBVjxhTiUI5UsYjuOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VzpLQ0Fy; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VzpLQ0Fy"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id 9C8D7861F8
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 14:13:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4702:0:640:9195:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 4F35CC0096;
	Thu, 22 Jan 2026 14:13:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ODaD4vJG4a60-hNhHqUoj;
	Thu, 22 Jan 2026 14:13:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769080406; bh=LXSqaZmVZfpBGvZXyYxwoznRt09J7ph64Q/7jnpD3tY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=VzpLQ0Fy8I7DRtu7Z9zPHMbZwoFMylYqAaSJNPIrteqYozP1h4opYODGrLsblVXKB
	 f9qyahDk4vqeGq58Dv53xaXoCOYgIgImfP0feGYYrL0KhHMctO15SozgtSDuiJkH7q
	 shLI+QrSRjvA3GewJJYZIT9RX3F/3P9KxUjrv+Uw=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 0/2] minor lib/cmdline enhancements
Date: Thu, 22 Jan 2026 14:12:52 +0300
Message-ID: <20260122111254.1111811-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit-based test for 'memparse()' and fix
kernel-doc glitches found in lib/cmdline.c.

Dmitry Antipov (2):
  lib/cmdline_kunit: add test case for memparse()
  lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warnings

 lib/cmdline.c             |  7 ++++--
 lib/tests/cmdline_kunit.c | 50 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.52.0

