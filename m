Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BC3839A3;
	Mon, 28 Sep 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600399; cv=none; b=fvlT3BlvIZo6TCxyODEINK7ZWVQEVRPR4VBIeFuaITJUNekD3LCAtbdXmnCVYt1+Nra3r2KlHq/mS/p09n2ErD0JPvN98VJPwDycJkRpcjIPttsJF2/QnTbP2/hfZNmaFIRTh2Q7eQtLaCztIjoCEjT8eb5HzBql7vgqLop90xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600399; c=relaxed/simple;
	bh=ZZqnXXy1+FwVGUghP1bNR9O8KWl+oZKLZs1e+0rpo+Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V5ODnfYXqveFO6AhjrfgjJuMHnBgTXdvzS6owJxgJ8FnMksPnWKQB9byfjNIOZNh/v11E7YNFXOTl9LiZ90C2sTchFfLz6oNizlBUDIFn+cOvsFO/5M4s8HIJed4OrYkSOPinpSd2LAS1Gk3lsfvJou3GYNEZaBlKWw0EcH7yNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFi9IQuT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFi9IQuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790600398; x=1822136398;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZZqnXXy1+FwVGUghP1bNR9O8KWl+oZKLZs1e+0rpo+Y=;
  b=EFi9IQuTF8VUPSFuJ0g9NUPRcOqVuzV/a+5ppnSfmDb82e9thpc62QrY
   IWgOaG1Ay/y211M9sMrACVDPCGZWNmq3Ts8xBIQsMpYCJn1zAn/A+HMJs
   tKwcC7eu2jAZR8yYHV7WIvVscH2t9MLP0MeAyYLIJytWP5rw42YKueGM+
   HrXfng7PnE3SgKT03pabpUCHNwQJrymp5ZhTc7WaJ23ZIGGG5r5YBpLlU
   K87nK17XfslycKBvBU50Obfi4+Pl4giMHkYw+fAE4px8P8rpgLTjNaQnd
   FprWysI/NwkMIXNVpKTTWMPZlaBkN3U8Zu34PxHZkiYeuFVjFRrR+t7Ea
   g==;
X-CSE-ConnectionGUID: TKue2eRZQ7CcHITxOxDUKw==
X-CSE-MsgGUID: twplA6Q6TQScXvBBFVuOVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90349873"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90349873"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:59:57 -0700
X-CSE-ConnectionGUID: KI+8cUNnR1+54rg4z/kupQ==
X-CSE-MsgGUID: pcmIGNDDSRKIpHfhWBMAHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275170226"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 05:59:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Sep 2026 15:59:51 +0300 (EEST)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Muhammad Bilal <meatuni001@gmail.com>, Kees Cook <kees@kernel.org>, 
    Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] lib/string_helpers: add ESCAPE_BACKSLASH flag to
 string_escape_mem()
In-Reply-To: <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
Message-ID: <a2687bd9-8cf7-1d08-41fc-9d6e69b5ca17@linux.intel.com>
References: <20260926205708.384308-1-meatuni001@gmail.com> <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1885734108-1790600391=:1168"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1885734108-1790600391=:1168
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Sep 2026, Andy Shevchenko wrote:

> On Sat, Sep 26, 2026 at 11:57=E2=80=AFPM Muhammad Bilal <meatuni001@gmail=
=2Ecom> wrote:
> >
> > ESCAPE_SPECIAL escapes '\\', '\a', '\e' and '"' as one group. A caller
> > that wants '\\' escaped but needs '"' left untouched, because it has
> > its own handling for quotes or because quoting is not meaningful in
> > its output, currently has no way to pull just the backslash case out
> > of that set.
> >
> > Add ESCAPE_BACKSLASH, which escapes only '\\'. It can be combined with
> > ESCAPE_SPACE, or used on its own, without pulling in ESCAPE_SPECIAL's
> > quote and control-character handling.
>=20
> But why? I believe it can be done in the current implementation using
> the last argument @only (id est use the list of the characters you
> want to escape).

Ah, that's my fault for suggesting this and not noticing there was way to=
=20
negatively filter them.

> > This only adds a new opt-in flag; no existing caller changes
> > behavior.
>=20
> No test cases --> automatically NAK.
>=20
> ...
>=20
> Also you missed printk() update and respective documentation.
>=20
>=20

--=20
 i.

--8323328-1885734108-1790600391=:1168--
