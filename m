Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335967;
	b=p8vyWVAmFXPrTLvwMS9CIUjqiew/Vv8iu2ghpmwa3z8V+M6dOga8eaA5VagBfSa2MGST
	 YNQtIXclnm6KPKUYNakD9vUwhcvYHb+PZl8GI/rmFNa+T0+axN0CMb/p2Ldkg3ZAXEJPP
	 tpSoqRSZDaZS2CFhKPfy3mFDtkMpSbsqxt9v7U0jbiwC5zhUkoZdhSHDwQPZmdIxokysr
	 0h2O4i6EMBRt+rlW/YYw/TjJ2NKSRUm4MLuYQGt62E9B4uDzU87X+zRIqFaVEdtQK6tn0
	 sWlWLR4orCBRJUwwuojmta+Xgg/XtoYleZt1B/IxgesbHFd+kWjML2yJrcHKF0WMiPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335967;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=ni0dTEFkOEdqX3aB5/r5AsPbCHUNITe03X/RTMKqB9s=;
	b=44aG4KZ24CvVBbRP8DiTgnDqGW3Tzrgdo7tZP+Ry98QqZNElmzRbxNjGUwaUqkj2X2MY
	 nXE6zXEQtYtFDeUI0TN9ybqMydgYa8c0AhziTeucCXVt4bFTj0SJPhovUAwjuoSoVkBrI
	 VPhnbiOI3QvWUxB9pVMIIXh19VBd2sCpQzMav29xAHCdpoVwwQUZzZ4LqixW3ddFYbJNL
	 SY8T5rJX/o2cYEZmysaB/q8+QYm0TG/7Lbj5B4dP1qSuXokymb0RSwK6KeWcYfPUHOmy9
	 xtsMX+Gx1W9eKWlVcn9+KtGvLeFrwkhuf8CGCiPNDc4I33YsIbpyKcJ/XlfZFKYVE+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZj7yuLJ;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E8606A32D;
	Tue, 10 Nov 2026 18:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564E8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hZj7yuLJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794335966; x=1825871966;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5IIWJTjMiWzzw1rqGkI1LkFpGuY5WUpCBfbX01vYXnc=;
  b=hZj7yuLJymPao9f2N9WVsdwKSZsLEfgTNIUiItWxV5uMDlFu7ST4kaRD
   1JjcNcYpTdn7ni8wMEuOaFCf1xkv6Y51+lxqJNMe1v2Xx5TU4jEcHGc5o
   d+TX+Ly7eRRCSthR4Km5lqpFhdDKoiCBhzbpJc5+O2cu1s/PRgDi/v1PG
   0WCY+W+hHT/Awiye1LBVycFP4xhkMnDBAfZkgVzYAjae1oWLpEuvXiid/
   Ry/ayLT4NjTZ/RrkoPtGzTEcqmy5i1FQT37FxtM7zw18vuD67trFQ788i
   O8/2iW0arsROhV2VbYUTpdg1XC39FV6949C5+L8iXJH3s8Wses5l02hTJ
   A==;
X-CSE-ConnectionGUID: lSh6Tr/8R0esO48f/1r3+Q==
X-CSE-MsgGUID: AFHltO6lTyCCL2PQCYipVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3000743"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3000743"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 10:39:25 -0800
X-CSE-ConnectionGUID: pGYfelFnRri63STqEVTRcA==
X-CSE-MsgGUID: C853midoRQ+w5QvwW93Qaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8045289"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 10:39:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Nov 2026 20:39:17 +0200 (EET)
To: Yury Norov <ynorov@nvidia.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-hardening@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Yury Norov <yury.norov@gmail.com>, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, Muhammad Bilal <meatuni001@gmail.com>, 
    platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
In-Reply-To: <avNb_7QmpPkxa8xq@yury>
Message-ID: <df77dcec-08ea-b307-53bc-d52078fce7a2@linux.intel.com>
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com> <avNb_7QmpPkxa8xq@yury>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Nov 2026, Yury Norov wrote:

> On Tue, Nov 10, 2026 at 05:41:50PM +0100, Andy Shevchenko wrote:
> > Export strnchrnul() for users that may be compiled as modules.
> > 
> > Reported-by: Armin Wolf <W_Armin@gmx.de>
> > Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de
> > Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
> 
> Not sure that exporting a symbol is actually a fix. It rather looks
> like a normal development. Also, I'd like to have this patch attached
> to the PDx86 or whatever series that uses it.

I did put it now before the change that broke because of the missing 
export.

I dropped Closes and Fixes tags as the issue should be non-problem after 
the history rewrite.

-- 
 i.

> Their implementation may change, so this would become the exported
> symbols space bloat.
> 
> Thanks,
> Yury
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Assumed to go via PDx86 where the first (wow!) module user wants to use it.
> > 
> >  lib/string.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/string.c b/lib/string.c
> > index a3778d5aab4a..cc8982a93afc 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -352,6 +352,7 @@ char *strnchrnul(const char *s, size_t count, int c)
> >  		s++;
> >  	return (char *)s;
> >  }
> > +EXPORT_SYMBOL(strnchrnul);
> >  
> >  #ifndef __HAVE_ARCH_STRRCHR
> >  /**
> > -- 
> > 2.50.1
> > 
> 

-- 
 i.

