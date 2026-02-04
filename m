Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0540B6FF;
	Wed,  4 Feb 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213598; cv=none; b=UkGu3SyLqWM2RZCiEfaQjSMFuBx4ymIYxnppk72oyHaUwryPQcw/Z/EaCA+4g9Uin22naU//FNkpv0+bxqE9o+ncpkOYFMcFq6UisDWBtV38rw3OwytPpSVIjPO5xMIdj9vRPcLdIsuOoxWX64KHcvEvjnMKm5G2XhNcbfcDeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213598; c=relaxed/simple;
	bh=ZfWJf7USGOi2ZmL8BmbBAxr5xtcenMPKFDN8d3rC2SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9aySKLvQk8qH8+XuW9az6F7uDGWm0mMzbJP/msDhsqNwSu919U7I8fQOROPDmI2a3cFGOTMAC2fCXo9XyMjSNGS29PGv/NqiI6MeEPDcpVsNOsrEn401/tWzLycU+UwWKRYX3Hv38lmlBmI7wXnri8S++65+mKG85E7o6oUC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Z1FP2NRW; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Z1FP2NRW"
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4f41:0:640:844:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 00731C0079;
	Wed, 04 Feb 2026 16:59:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ixp7xlOGqOs0-UqzEJAMF;
	Wed, 04 Feb 2026 16:59:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770213586; bh=dcQy4LkY6TTrzFvJ7wADX5Axp7+J/0ZI1FSU2KmYChY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Z1FP2NRWe0a9ZCDzBdRKqbTAvH6Qc+1PbfW2QWi7FGdo3CjfBz8OafL+Ced32722n
	 lC6M/s6cMrAogAyPJ1uXwF6lk3QQbgAyIix5Bcjq8XLeHxxVEBBioSXxi+L9L+U7rj
	 L3lV360+2X8dnqhJmUkKRqH3bDASpa/ZmwqQj3DM=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 0/5] lib and lib/cmdline enhancements
Date: Wed,  4 Feb 2026 16:57:12 +0300
Message-ID: <20260204135717.941256-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.52.0
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

 lib/cmdline.c             | 29 +++++++++++++++------
 lib/kstrtox.c             | 38 ++++++++++++++++++----------
 lib/test-kstrtox.c        |  6 +++++
 lib/tests/cmdline_kunit.c | 53 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 21 deletions(-)

-- 
2.52.0

