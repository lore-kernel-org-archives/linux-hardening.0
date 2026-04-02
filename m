Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442AE56A;
	Thu,  2 Apr 2026 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113469; cv=none; b=gCJt+DBWtGcAuIcdOJISUYKZDygmTt5qLhxxEPjUNYPxiU2x574Y/NvgnUl8AIKHOoReQvxoUv2Ar/CC2VAKSbhebQOwLZdNGth7gNt+bjIO5Nm7W9W35zMwJB06jGqZf+OrsdrwuAKIt/lSCF0bN82hQvkNB9O0UDvFeBgBSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113469; c=relaxed/simple;
	bh=CKR4wwBcN2YziF+jtw/Xlyb4lf4TovOTs9yKoVZiDSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USz9S4/UdWFsSd5nz+28U1Tl1Ru9VVHUbkDcWKgsfM9Wwheel8V0LcUGH9yOO5d3GWrVRivU4uei3P2BKbQhkMzfOEsnl0hkaMv7KuM1QS8L211XKf1BUF+zd3GK++OoAWHt9f+Vy8ba9MayBOuNvyOEXAiPymB4uuS/qYUU+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RngGHWeC; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RngGHWeC"
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:1791:0:640:6f9:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 9B841826AC;
	Thu, 02 Apr 2026 09:56:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id juVoI39QASw0-uV2XriYf;
	Thu, 02 Apr 2026 09:56:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1775113008; bh=CKR4wwBcN2YziF+jtw/Xlyb4lf4TovOTs9yKoVZiDSg=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=RngGHWeCM143qleGlxAt5lIk/MRTHTzlULV3emnycz3gdG94UFzFUnbRtiDOTtBY4
	 Pd25ASYrr3hY5sFfnmyRBR4fJsgpKvUSAQgHe7ATXUOuYL+8Lt7Nl1BqWmBxBVTC0z
	 wKTW+huEazWlwwWBazpyAtEZCgUgcIb9Ib6rmdcA=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <4ece2ada3067d3668fc380d3dcf807ff73073c21.camel@yandex.ru>
Subject: Re: [PATCH v8 0/5] lib and lib/cmdline enhancements
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Laight	
 <david.laight.linux@gmail.com>, Kees Cook <kees@kernel.org>, "Darrick J .
 Wong"	 <djwong@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 09:56:45 +0300
In-Reply-To: <aZXDSbyH8tWmTPPL@smile.fi.intel.com>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
	 <87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
	 <aZXDSbyH8tWmTPPL@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 15:48 +0200, Andy Shevchenko wrote:

> On Wed, Feb 18, 2026 at 04:40:28PM +0300, Dmitry Antipov wrote:
> > On Thu, 2026-02-12 at 19:44 +0300, Dmitry Antipov wrote:
> >=20
> > > Adjust '_parse_integer_limit()' and 'memparse()' to not ignore
> > > overflows, extend string to 64-bit integer conversion tests, add
> > > KUnit-based test for 'memparse()' and fix kernel-doc glitches
> > > found in lib/cmdline.c.
> > >=20
> > > Dmitry Antipov (5):
> > > =C2=A0 lib: fix _parse_integer_limit() to handle overflow
> > > =C2=A0 lib: fix memparse() to handle overflow
> > > =C2=A0 lib: add more string to 64-bit integer conversion overflow tes=
ts
> > > =C2=A0 lib/cmdline_kunit: add test case for memparse()
> > > =C2=A0 lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn =
warnings
> >=20
> > Any chance to move forward with this?
>=20
> I think it's a grace period due to ongoing merge window.
> Also we need more input on the first patch from others,
> perhaps Kees and Andrew can take a look when they will be
> less busy.

The same question again...

Dmitry
