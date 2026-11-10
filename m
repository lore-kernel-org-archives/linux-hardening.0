Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335407;
	b=GK/OGI85xu9RM4llqWdqW4jWKCKM6FwnL2qoboPu9iHZBDNZZLFTVO76+kZ06RNwr444
	 eDrkBGPbcE0RbFBjQpdtyZBXSsvGQl8/8FiQUQa+m190CTZLbTN87VvqP0SdACU9OKygP
	 lhsboRMvM1ad0OmVLqS64ZxaObp5aF1kzlbwBVH+QMaqAFqwqPlE3WOrZ2bGYNa1F1IZF
	 GKSLhof4zPn/ZSikkF+N5IMfJeN1nF/GqUg+J2g0FuzebdoEOspVrcu19REC3y1MHnGL8
	 9a/ch1jJgaXmB+jGXKT4m7JdXaLBt0BPw3AP3BCyc0aPAhEKfoRZrL3Rz5a6xZ5iC4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335407;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=PJIIA10gwRhxx0yWXx8JIAgfxJvcr9pmGGek8WJIWn8=;
	b=qEENTq5x5aR7lAe5498SCp3KehwO1s4PuOHwvbvpL6zYbYT9zDlw0zJCBaj/uZiC/GID
	 zR8aSckC0g0aum7BLGaKZe2EXaaxOY2FmhRd0U5dswMOD4RLLIHNDgnaE8d6GlHu04Fnt
	 EisfEDAzP6zaFnj9nS/pmoBcFG3HtpXM7F0WNz/J7NLy1giKnK6wSKoMSdFGynXJZFFP/
	 gmGlz64I80B6CSam2Hc5BNoeZo3UuDMduhaSUuqnNKGDS5zXjvMrLgSo8yr88h7QrALkt
	 FmijRRjzEzGVGn105XctPaCGohfQ8W4TA40tki47Au3PPNWxFmODRkiegEpkV4nWtuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hTDTLBwF;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA1606A334;
	Tue, 10 Nov 2026 18:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1AA1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hTDTLBwF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794335407; x=1825871407;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lR7NR20MiUrJbWgNmq4dQF+sJRZEbWOcR410rH65ktQ=;
  b=hTDTLBwFAXvT3VG3mk4OgguzgWV0FeLEjlaBQbLpzZwtpnY+nrHy8p1G
   aGWDch5GwAo+0a1ECXJHU9Pw9wA5w6BEDMXHAC5thqbBU3C+23lMnMzh9
   TupFin9NgoB9QZ1nPzvft/8mPauZFHaGq1P+p1p0OxgZ97LE/N3ZyPoXR
   B8sxLfEdm7Z3/oPaq9I3ONoZdidnkgkq9YkMIikbk1M/GkwxGk1W8S1o4
   RqW9rrl+1K0TReUxO5EZoBfdQzfQ037jYJY5S9IxqnY2tW7l3azKIocIR
   qaOvWqG4IZ3Zfr2lAPGz6cgUz3ZusG70ujMzP1tU7g1Yt99BnYz1D9ceO
   A==;
X-CSE-ConnectionGUID: gipJwHutQ0CJ/plrn7uyrA==
X-CSE-MsgGUID: KJHrKLc+SDSLnVMWKgr90g==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2993795"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2993795"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 10:30:06 -0800
X-CSE-ConnectionGUID: NbhgJh2eQ6WwlTgMLgDaaw==
X-CSE-MsgGUID: QI9yerIBSVawsa3mqo0LFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8357111"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 10:30:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Nov 2026 20:29:58 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: linux-hardening@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Yury Norov <yury.norov@gmail.com>, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, Muhammad Bilal <meatuni001@gmail.com>, 
    platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
In-Reply-To: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
Message-ID: <cec3aee0-a075-bec2-b487-2e28991f2d23@linux.intel.com>
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
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

On Tue, 10 Nov 2026, Andy Shevchenko wrote:

> Export strnchrnul() for users that may be compiled as modules.
> 
> Reported-by: Armin Wolf <W_Armin@gmx.de>
> Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de
> Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Assumed to go via PDx86 where the first (wow!) module user wants to use it.

Thanks guys,

I'm so surprised by this, sashiko did warn about this so I even checked 
myself and saw an export after the closing brace so thought sashiko was 
just wrong... Maybe I was looking that the strrchr's export, can't think 
of anything else to explain it.

>  lib/string.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/string.c b/lib/string.c
> index a3778d5aab4a..cc8982a93afc 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -352,6 +352,7 @@ char *strnchrnul(const char *s, size_t count, int c)
>  		s++;
>  	return (char *)s;
>  }
> +EXPORT_SYMBOL(strnchrnul);
>  
>  #ifndef __HAVE_ARCH_STRRCHR
>  /**
> 

-- 
 i.

