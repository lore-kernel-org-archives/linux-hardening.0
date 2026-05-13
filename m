Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7F349CE6;
	Wed, 13 May 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694820; cv=none; b=dhjegXgdI046hvFiCP1gsy5NSJNTosAD9rdT4oWAXiVP7F+3CRy4TThcU8eV3DJq54ypCq5Fcwb3FJg87fwTBw7yLR3EXyne+eGgeebTIRfBv/QYWlGCNvpn+DZSxO+Q6CMw6P9YU62b2ohkHCN5r4QEnN6U0Ag1H83+vRnGLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694820; c=relaxed/simple;
	bh=f/sQ/XwW3xgI0gwxK2WNUbLTcyCgZM5TzfnMLvNcOSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfsR1rYwPDWxHmXG/JVdrlwHAuYy2q5ATPOfrCI6Rt/j0Mmh1Nwz5km2RkXXVnaxvbPBAEIsEdzQd0eMUlooppI7/rx+ucLfRQ+9rqTlyYqZj5uoUBox357Pm/uZu0Vi+/KB7ceqbUoziWaBZJoJ0DMl8FFlyV65r9IBGTBxDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ2HH3y/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ2HH3y/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB9AC19425;
	Wed, 13 May 2026 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694820;
	bh=f/sQ/XwW3xgI0gwxK2WNUbLTcyCgZM5TzfnMLvNcOSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ2HH3y/yoOP5H2oRUhLbi7DkLCLA5aDh1OzTvPY7p/nqIWs1fzP5tMCoJRTgmCPB
	 vTGnUYDOVlyToElVCGA5So2VM41dIbw5GAGjM/C06VqqX5RdmyE4rXnyJjIIhiPnDw
	 H+CK2a2Q63+vpHLJyeNc0ufBq46qpN0VVX2qtrRrhmyxjjTcDW3Eh8AOtP7n+gPd17
	 RBJebzU6TKp7MxLLw0jUkZCsKj1CQPdOD2zJAMh+tl93UKJS3CXTG+BgHT0rp51zSP
	 VBh5IFE+OuQJ8J/HcMXU95Q3kyCB78cp4n1Jw/K6CB3BdMHHunQn3+N3kj1qUFf00z
	 Y3IxkZ8f482eA==
Date: Wed, 13 May 2026 10:53:39 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in
 kasprintf_strarray
Message-ID: <202605131047.BD31D2130@keescook>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
 <ad-j4eGpltrb-WQj@ashevche-desk.local>
 <ad-vKhbh4KNV87gu@linux.dev>
 <aeCUY_BH3s9b8qKG@ashevche-desk.local>
 <afNps6X5Hii2jcSQ@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afNps6X5Hii2jcSQ@linux.dev>

On Thu, Apr 30, 2026 at 04:39:47PM +0200, Thorsten Blum wrote:
> Hi Kees and Andrew,
> 
> On Thu, Apr 16, 2026 at 10:48:51AM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 15, 2026 at 05:30:50PM +0200, Thorsten Blum wrote:
> > > On Wed, Apr 15, 2026 at 05:42:41PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 15, 2026 at 02:25:43PM +0200, Thorsten Blum wrote:
> > > > > kasprintf_strarray() returns an array of N strings and kfree_strarray()
> > > > > also frees N entries.  However, kasprintf_strarray() currently allocates
> > > > > N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> > > > > 
> > > > > Also update the kernel-doc for @n.
> > > > 
> > > > Have you checked all current users that they do not rely on the NULL terminated
> > > > array?
> > > 
> > > Yes, I've checked all call sites, and none of them rely on the NULL
> > > terminator. Specifically, I checked:
> > > 
> > >   drivers/gpio/gpio-mockup.c
> > > 
> > > which uses PROPERTY_ENTRY_STRING_ARRAY_LEN(), and
> > > 
> > >   drivers/pinctrl/bcm/pinctrl-bcm4908.c
> > >   drivers/pinctrl/intel/pinctrl-intel-platform.c
> > >   drivers/pinctrl/meson/pinctrl-amlogic-a4.c
> > >   drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> > >   drivers/pinctrl/pinctrl-at91.c
> > >   drivers/pinctrl/pinctrl-rockchip.c
> > >   drivers/pinctrl/pinctrl-st.c
> > > 
> > > all of which use the size N to iterate over the returned array.
> > 
> > Thanks for confirming.
> > 
> > > Also, kfree_strarray() explicitly takes the number of entries N,
> > > indicating that callers are expected to keep track of it.
> > 
> > Still we might have an API that requires a NULL terminated arrays (when it
> > doesn't take size), which a caller wants to use.

What I find problematic here is that we allocate N+1 and free N. And
this is repeated in wrappers too, like devm_kasprintf_strarray(), which
explicitly tracks N for the later devm free. How has kmemleak missed
this?

> > > > Note, that was done on purpose that once allocated it can allow user
> > > > to drop the track of the number of strings and rely on NULL terminator.
> > > > I.o.w.  the number of strings may be just a local variable somewhere
> > > > where kasprintf_strarray() is called.
> > > > 
> > > > I tend to NAK this change, rather you can update kernel-doc to explain
> > > > why it's done this way (see above).
> > 
> > Given pros and cons, and what David said I'm still not sure that this is
> > going to be a beneficial patch. I leave it Kees and Andrew to decide.
> 
> What's your take on this and the __counted_by_ptr() annotation from
> patch 2/2?

I think both patches look good.

-- 
Kees Cook
