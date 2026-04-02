Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293829B216;
	Thu,  2 Apr 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145632; cv=none; b=BSUdkBeOI1ONHzPsfLdZKGgspPLH7YSoc7NvYllbBxqeVPYe0F/HmK/Q41sHkTVA76IXeC4G2mIO4EZNNN1eSsBJe0lswNiXyj+XLUp1EzFtb73xf02fxJtcAFrqHrUpvC25gLuBn2dJH4l7A8vzXZKFoZXu+YrMADujTUL0mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145632; c=relaxed/simple;
	bh=MQjaSqI0WPBvlxYTZgoLKR4ljuF2kCit3KstTqvQRfw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mZBKBZoAHysDvbKLYBv8FAmLOsam89ASKVheaBtV1x0DIf7BGrRUxRJCGtG0rosUtFhsdzZ3yvg5TNKOC27max4X2i1K+/4OXaaLCVViB8fXcFHqjlJ+Wpth7v3Sbi/L02As3rVneJZs/L7ze0Zokgc0+QYd9zGiNn0OV+ZY3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P+uCij3n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P+uCij3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626B8C19423;
	Thu,  2 Apr 2026 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775145631;
	bh=MQjaSqI0WPBvlxYTZgoLKR4ljuF2kCit3KstTqvQRfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+uCij3nudtJSPBho2X8JCcnjmtrJlcBTRkubS6IhHwo48vcKOtl9+KY55MYNNuHL
	 oDSdiw+JcF30kHpIoxob30ziDomGWkSGozEU5EFd+M6p4UzE1Gxu8h/XS/3Ym4pMdz
	 9Gusf0naIHts0BQmRy8v0LZ/pb2bdWBucb+KalHU=
Date: Thu, 2 Apr 2026 09:00:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, David Laight
 <david.laight.linux@gmail.com>, Kees Cook <kees@kernel.org>,
 "Darrick J . Wong" <djwong@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] lib and lib/cmdline enhancements
Message-Id: <20260402090030.b5a03939994b3b426ea37032@linux-foundation.org>
In-Reply-To: <ac4pM6kHVI8cK1Xb@ashevche-desk.local>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
	<87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
	<aZXDSbyH8tWmTPPL@smile.fi.intel.com>
	<4ece2ada3067d3668fc380d3dcf807ff73073c21.camel@yandex.ru>
	<ac4pM6kHVI8cK1Xb@ashevche-desk.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Apr 2026 11:30:43 +0300 Andy Shevchenko <andriy.shevchenko@intel.=
com> wrote:

> > > > > =A0 lib/cmdline_kunit: add test case for memparse()
> > > > > =A0 lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn=
 warnings
> > > >=20
> > > > Any chance to move forward with this?
> > >=20
> > > I think it's a grace period due to ongoing merge window.
> > > Also we need more input on the first patch from others,
> > > perhaps Kees and Andrew can take a look when they will be
> > > less busy.
> >=20
> > The same question again...
>=20
> I'm not sure why. The patches are in Linux Next for several days already.
> $ git tag --contains b85c7e022e1c # the last one
> next-20260401
>=20
> Yet it needs to be merged into nomm-stable (if I understood the process r=
ight).

Yes, these are on track for the upcoming merge window.

However I believe the riscv32 build breakage remains unresolved?

https://lore.kernel.org/all/202603041925.KLKqpK6N-lkp@intel.com/T/#u
