Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BA34B1A3;
	Tue, 16 Jun 2026 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593788; cv=none; b=uc0S6/3BLx9HCMVwyAon0uzv9qKnkwirXiCyLVyFGSB+fHz/bbJl2kX4MKZdW6TfpqkwrbNgYlm2M3lowYPwTOC9of2Aa+i7P2JxZk9ZCdt1E20esk032cGr78DJyXaQJ+HUupk1OzJY3DDewBe3EjHh1kartNoT7LJZ7G4Xxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593788; c=relaxed/simple;
	bh=ultoLLjmUkQztBNzH2dBjoS6Eym1jmW9Ik8DQCM1z8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nArisfg9QYxgz3+HuQBBJ9drREzFZwLLLIm6bsRHbw3r3nLLm7IzmJQ7DARs5upaTE0qmF7qPhjw3mxRJWjPasiSd9JsBSPES/eVUYuvpojeyfUAJbtse2tfTgGmC9jV6uh7Q7hE6WL6T2yFJMazlfHV+fXzbYiWHPwjTCZaXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkqcYEA1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkqcYEA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781593785; x=1813129785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ultoLLjmUkQztBNzH2dBjoS6Eym1jmW9Ik8DQCM1z8o=;
  b=nkqcYEA1DvGnCjAF40GS8zlW5rb+EVvh+isYCxB6kOkAykYHupwgyd4E
   38+RvzjMIh9AdAjD6dioUa70oUbK42KuWQlnX8dLOG2BNATiTCdaMOYC7
   CG+71Le14PrMvlz439LWkgmMNKfsOx9myyJBA28TPtTeBlJKgC583Z6dK
   XyK5E7Ux31AkO/WS4od7xY45YI8rvcFpGmefXyGrILP/if42QPBa33p3s
   uYhHx2bmGTMX3GwCVXP2rp0QMdpmP4Q+lntfdV6NrLnxB9z9nYm+PuNZo
   A3sc/hnfhIJk1oYEqzaqpSHsolAdC8a1ACMkgyKg7NC9wOKjghpDf/sj5
   A==;
X-CSE-ConnectionGUID: IgwsPiptR7m6p9uvBntPbw==
X-CSE-MsgGUID: BWEyOx0NSdmTx6GXaD8jrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84913696"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="84913696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:09:44 -0700
X-CSE-ConnectionGUID: YY77ryvqRmOeDU9DrFCQ1w==
X-CSE-MsgGUID: DHlVHzP2S1aasQOHCrq+kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252813771"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:09:41 -0700
Date: Tue, 16 Jun 2026 10:09:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Dan Carpenter <error27@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefano Zacchiroli <zack@upsilon.cc>,
	Steven Rostedt <rostedt@goodmis.org>,
	Laura Abbott <labbott@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Wenwen Wang <wenwen@cs.uga.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, Dawei Feng <dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v3] Documentation/process: Add Researcher Guidelines
Message-ID: <ajD2s5Q0sP679Mbh@ashevche-desk.local>
References: <20220304181418.1692016-1-keescook@chromium.org>
 <ahgaOigklcDCYvRp@stanley.mountain>
 <ajACprp9UJp2JSJM@black.igk.intel.com>
 <202606151547.DB4095584@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606151547.DB4095584@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 03:48:02PM -0700, Kees Cook wrote:
> On Mon, Jun 15, 2026 at 03:48:22PM +0200, Andy Shevchenko wrote:
> > On Thu, May 28, 2026 at 01:34:34PM +0300, Dan Carpenter wrote:
> > > On Fri, Mar 04, 2022 at 10:14:18AM -0800, Kees Cook wrote:

...

> > > > +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
> > > > +  11.2 show no new warnings, and LeakMagic no longer warns about this
> > > > +  code path. As we don't have a FooBar device to test with, no runtime
> > > > +  testing was able to be performed.
> > > 
> > > People have started sending commit messages in this exact template and
> > > normally I would ask them resend with the meta commentary from this
> > > paragraph below the --- cut off line.
> > > 
> > > Do we really want this "Compile tested only" stuff in the permanent git
> > > log?
> > 
> > +1 here, can we rather avoid flooding commit messages with the meta, that
> > anyways is available in lore.kernel.org archives?
> 
> Hm, I have gotten a lot of push-back from maintainers (reasonablly)
> wanting to know the specific level of testing patches get. In the case
> of lacking hardware, this seems like useful information still.

I am *not* against providing this information (actually I on the same page),
I'm just against putting it into the commit message! We have a comment block
put it there, please.

-- 
With Best Regards,
Andy Shevchenko


