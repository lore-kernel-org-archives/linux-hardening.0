Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0945086353;
	Fri,  6 Feb 2026 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371996; cv=none; b=qyqATbfpi4jmiI8YiWX3E6kdkQKXaNstx6Ns8NntKIrpUDbkeLoze7YgjMPH7f/g9Zj+NWrHzFClbvCu0yl1tEZlUOZ+UKtVnVudnUanC/dz5DclEx3o1sOXPsXUoxMdF0O9o74+PrgZq+ludeBFvZvTyUmEE0Soalpaqy/03Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371996; c=relaxed/simple;
	bh=ZLvgkmzV+6Yonp4h53w+QGiOEaQEnjI7GaQxSjC7RuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ff9oFr8Z7CMwEBSBH3s1+IX+wYpo+bGlpZvVkTwqd2/FGVNS+q3afKV/nHZ+ZO0ZXj81bzICI+WsaB6dc5x+hrdrW+Wu+kuLo9yl8wvhzOS/uVVH3eZQ1XfAO6sYaY3zk2RYzOv9OCGzpv6OMnJRhO5Cf5jUA0Ag6KAeazGeDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Z5UXOTl5; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Z5UXOTl5"
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:251b:0:640:cb7f:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 3C995816EC;
	Fri, 06 Feb 2026 12:53:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id prKlhR1GCeA0-qTvNoQmb;
	Fri, 06 Feb 2026 12:53:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770371632; bh=ZLvgkmzV+6Yonp4h53w+QGiOEaQEnjI7GaQxSjC7RuQ=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=Z5UXOTl5OhpPQZdfi6OfPZH0r2HhC/4uYAypchTfG42eQ2Htn/RCcCNKtHVyK5F51
	 jjnejCgWVCdXFpIPaWgvjv9zI/oTUf7CHRLn6uAXb5w2UQP8z2mJwGXJmumJBF6kqB
	 TexjLGDzGE9ydR0HfyojA8TIwxoh80BKKIElZF98=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8bd4317ef717016ca5d921a96b15808b6c77845a.camel@yandex.ru>
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle
 overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, David Laight
	 <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Darrick J . Wong"
	 <djwong@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 06 Feb 2026 12:53:50 +0300
In-Reply-To: <aYWbcFb73qO16tEC@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
	 <20260204135717.941256-2-dmantipov@yandex.ru>
	 <20260205221537.34778ff0@pumpkin> <aYWbcFb73qO16tEC@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-06 at 09:42 +0200, Andy Shevchenko wrote:

> > Code looking at the terminating character wont be expecting a digit
> > and will treat it as a syntax error - which is what you are trying to d=
o.
> >=20
> > That is a much easier API to use, and a 'drop-in' for existing code.
>=20
> Maybe, but problematic from the usage point of view as I described above.

Note that was an idea behihd memvalue(), see https://lists.openwall.net/lin=
ux-hardening/2026/01/07/23.
IOW since "mem=3D64K" is expected to be used more often than, say, "mem=3D6=
4K@0xaaaaa" or "mem=3D64K,sync",
it may be useful to have a wrapper which is enough to parse "64K" but treat=
 everything else as error.

Dmitry
