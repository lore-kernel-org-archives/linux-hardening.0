Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105F344DA6;
	Thu, 12 Feb 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895285; cv=none; b=i8LPuipVEKf2t14qxCalribUPuYur5ud2Hj9H6Uod44ZL4qPc2M3vq1iIWMpH5mi74tySaL9tfsgEWmaACHDcH7x/qDlvHJAw74Ak6LeOTz75PcRssrOnf+kXIbTFTZBCWMBe5SiwaUFblowMHblA3nef3pfwJ1IRF0NBjYOkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895285; c=relaxed/simple;
	bh=wKoUdnQQJGmM2GJm0Z9DUTrsvBzCmgWGAwiLzGc7OuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGazvTvVhBTQWlZ4/hLPpmWCakI3hRPtjv+eisP2sXHflxphNEWWH6V9asgAYs1eqPoU430x5bfvI6iFALYnPbhZjv3G7DUFe+Ff44j0UIX4rMEuLM0nGRZYPOHpI8A9CO0UQT5wgWM+SmhpovtkI/UC7FJOBS5MVLeaUqoYNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CKbdVsYo; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CKbdVsYo"
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:494f:0:640:ed81:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id DF88680746;
	Thu, 12 Feb 2026 14:21:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CLSNPv9GsuQ0-bxRr2TML;
	Thu, 12 Feb 2026 14:21:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770895274; bh=wKoUdnQQJGmM2GJm0Z9DUTrsvBzCmgWGAwiLzGc7OuE=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=CKbdVsYo7G3uWTEJ4TkOdjCbQskkr1LMEF2ajj3OJgGdFaiEowxbbbCBj3brCOg/i
	 aW7NMRwA5xUkRGoiB7f1yEcMJAcFc5xkXtbNm53wcnzb2bdwmdvUwFBD8XVYpyZApd
	 zN6A89lEyD1i0zzyZc6Qc8nxCz9p4gSdupnHHaUc=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <64fe0370ed23d00fc891901414811ad06d7b5d9b.camel@yandex.ru>
Subject: Re: [PATCH v6 2/5] lib: fix memparse() to handle overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Darrick J . Wong"
	 <djwong@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Feb 2026 14:21:12 +0300
In-Reply-To: <aYrjiNg8hag9KK5i@smile.fi.intel.com>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
	 <20260209164757.433932-3-dmantipov@yandex.ru>
	 <aYrjiNg8hag9KK5i@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-10 at 09:51 +0200, Andy Shevchenko wrote:

> Strictly speaking this is an ABI breakage. I dunno how many (broken) stri=
ngs
> will stop working after this check.

Yes, but this is for the corner case only (where ULLONG_MAX is used instead=
 of
ignoring an overflow). And finding more bugs is better than silently hiding=
 them.

Dmitry
