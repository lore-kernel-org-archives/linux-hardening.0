Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4B3815D0;
	Mon,  9 Feb 2026 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656385; cv=none; b=Nwv667TjZE9XpA5EULrUURALCyLsde8jhPNt+RnqwtorhC0aO5Oqb52uPrWv4gDky93eSTloKy+ZC6Td0EtobiFEJRbfpwjE3imm4+UTF55XHtt+GIsqoX7NGMz56G31ZHwNLDSL8+mIiq9L+Zw6r+ITzrkxF0HH8tVD1Sne/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656385; c=relaxed/simple;
	bh=qOuYLZMxwPfh0WolZG1I4oCGq1smXIu1D+7FZwGEV1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+fM3rjakLtjaS67Yc2acelhwc2wk915SeZvcCtKvyC1XdOoZjP0QM4j6tUt+0Qf40HgG4uBW/aCyCpCSYxA2pNcJSqTzrs+hJOE77o3t3tt1xoa1rYKhK7m8+BgJPklBlupcplbgxFe9OkpJtXLll2CgCBg6HGyybXiftljF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VFLY31Sh; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VFLY31Sh"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 5D9C7848B6;
	Mon, 09 Feb 2026 19:53:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:405:0:640:8814:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id EB6DDC008C;
	Mon, 09 Feb 2026 19:53:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0rUtjO1G1mI0-CqflcE7D;
	Mon, 09 Feb 2026 19:53:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770655981; bh=S1lWgiGmVsAvMZSkg+pIOmyi7+ycUwprxf/PI/HEcu0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=VFLY31Shbp0FuBw1/uvZCtJ44HNMev48EfMptE4pEva8NMTKkGCJvsQHBDW/1iz82
	 yysX3/1tMKSSsz2z63RN3bABlbtf8CkgW2pI8ZaC+uk4AwPQF8tPceCwIp1D5IOqfc
	 8cYXZOnRDelEVhlDyr+Bp/iIJsEpN/JzgAWgUPJg=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v6 0/5] lib and lib/cmdline enhancements
Date: Mon,  9 Feb 2026 19:47:52 +0300
Message-ID: <20260209164757.433932-1-dmantipov@yandex.ru>
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

 lib/cmdline.c             | 39 ++++++++++++++++++++-------
 lib/kstrtox.c             | 47 ++++++++++++++++++++-------------
 lib/test-kstrtox.c        |  6 +++++
 lib/tests/cmdline_kunit.c | 55 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 27 deletions(-)

-- 
2.53.0

