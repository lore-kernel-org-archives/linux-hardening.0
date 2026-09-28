Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA5348C76;
	Mon, 28 Sep 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583437; cv=none; b=S3Pr13oolKzuaU//XjKD7nGaKJIbsUkGXuUbYzF0fgPDVzOvHy9Uhck0KbkSaixZx7Kk6m9xAEhGcviS2wSVzZyqGp5li9hcw5zmb6KjLoJkT/5lj/W8EEnnC99mr2PL6WH/ivr6mIN6Mxfl1vvob2eTJaaF6seion8Dh7O+TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583437; c=relaxed/simple;
	bh=RMwnknzyporCh2N44aQGjZo/9Mdx15w0HVQJ5oSd1wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGKknk82HZ3Pm5FYtuB02mletw1yS6qqSaEP2lJw7Id5eB/p3Bky83rYpCBRaogwPNSZRqJIdQxrx6xepnI19emw2yqk7G0pCU5X1exnSS2FvOvMqDY0BUAPxK2YemFhaKSNwbVp83hbcNgCElJ8Exf3b40sjyTgvOcpgPNvq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdEbYCu+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdEbYCu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790583437; x=1822119437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RMwnknzyporCh2N44aQGjZo/9Mdx15w0HVQJ5oSd1wI=;
  b=YdEbYCu+frE/NukK8CVwYgxPJnEvJhY9MtZb50A5vofQOGv/Km7LNkP/
   +vcJWZRZg+SU1XJfMa7c+ZJJ61emMi5G3DIlRjdb6MFZD6pdcYCWRuUBz
   2kBkFjWXPaPF+/U1K1SX7D2BXPnEguqeybsmeHfEJz2xfrtz1NfkLZMpd
   pPJwCcxPJQrMwDyYR/D3gC+1K8J2Ck1HSZikQRi/KiDuPuCYJZZo+8ON/
   lPWTINPCXCcRu0IIECWRFlpJvy7r+bFP83I+/lT7jPhFyNZ7wbVlrxzii
   3VNCwD9npK6YnXr4yUbHRfKXqqNwwfZgssBw4FjDbZeXAKU5K3PeT7UAB
   A==;
X-CSE-ConnectionGUID: HL0LTN1uR02jRDZrzHczXQ==
X-CSE-MsgGUID: T/GYgMgsT9uYyGRLIJzcdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90319296"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90319296"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:17:16 -0700
X-CSE-ConnectionGUID: hF/y2tFsTZmnScPlRpoEtQ==
X-CSE-MsgGUID: ZmQYASSmQLin5E05x0bwMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="302934554"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 01:17:13 -0700
Date: Mon, 28 Sep 2026 11:17:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: add ESCAPE_BACKSLASH flag to
 string_escape_mem()
Message-ID: <aroih4_AQYlsNctC@ashevche-desk.local>
References: <20260926205708.384308-1-meatuni001@gmail.com>
 <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 11:11:53AM +0300, Andy Shevchenko wrote:
> On Sat, Sep 26, 2026 at 11:57 PM Muhammad Bilal <meatuni001@gmail.com> wrote:
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
> 
> But why? I believe it can be done in the current implementation using
> the last argument @only (id est use the list of the characters you
> want to escape).
> 
> > This only adds a new opt-in flag; no existing caller changes
> > behavior.
> 
> No test cases --> automatically NAK.

...

> Also you missed printk() update and respective documentation.

And on top of that, I have neither cover letter, nor patch 2/2 in my mailbox.
If you think that it's not important to me as lib/string* reviewer/contributor,
you are mistaken (yes, I can retrieve from lore, but this doesn't change
the fact).

-- 
With Best Regards,
Andy Shevchenko


