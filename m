Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280027F01E
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560008; cv=none; b=ResMKDZe5dIV7laYd+Mn89LhpIldYCAgI2JcdPKLTMr3d8TlvN3qKdpd5iZLpU2FqSs8+YFUnj1pZMVjT0qmtMityfV4j9ptrgXQSEPTOzhlW0llSuUU4Td4VMJ0XLiexRVFqgnX5hvgTn1ab8JnEW854FMbcZFpG8SqM9NC+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560008; c=relaxed/simple;
	bh=xOdYb11ulJDRcwqJWSqmRQeKE6/HWn8vnQo6ghUt3sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNmMeT7lmZOVyNCkuw7VOchoqkPCOIRN9c3KyEgTvocu4cbpQd2Z920/BR/6mqWh3A/Z+fvCLJ0FrQk/325w0fKGWoCi3GwkmyDzF6avIG5v+UOaDYZLuiU2bGzb/zagCteWkLgiPuy3NauRSuG7ACKVQp0Hvn0EboPYBEk+L8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USmCWECp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USmCWECp"
Date: Thu, 30 Apr 2026 16:39:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777560003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfA3Wc3uU30w4z/3AVtqP0eG6oLr6uoNilY2n35U9+k=;
	b=USmCWECpWqnBOzi/A+9DhFPCfLj/YZ0uNjzetTQXA00CtKHfiXduSWPKqCsQs7ceruFXxQ
	87dMHEJ1gZSE3L6tcV91UaTGJYhx+flhrgtp8ZviEwlTzRCUzkbDOJ86ZmYJ9dj7/kldMx
	tsxkZBnzkoYZlnYxkzP8l5HPYIicw9A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in
 kasprintf_strarray
Message-ID: <afNps6X5Hii2jcSQ@linux.dev>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
 <ad-j4eGpltrb-WQj@ashevche-desk.local>
 <ad-vKhbh4KNV87gu@linux.dev>
 <aeCUY_BH3s9b8qKG@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeCUY_BH3s9b8qKG@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

Hi Kees and Andrew,

On Thu, Apr 16, 2026 at 10:48:51AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 15, 2026 at 05:30:50PM +0200, Thorsten Blum wrote:
> > On Wed, Apr 15, 2026 at 05:42:41PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 15, 2026 at 02:25:43PM +0200, Thorsten Blum wrote:
> > > > kasprintf_strarray() returns an array of N strings and kfree_strarray()
> > > > also frees N entries.  However, kasprintf_strarray() currently allocates
> > > > N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> > > > 
> > > > Also update the kernel-doc for @n.
> > > 
> > > Have you checked all current users that they do not rely on the NULL terminated
> > > array?
> > 
> > Yes, I've checked all call sites, and none of them rely on the NULL
> > terminator. Specifically, I checked:
> > 
> >   drivers/gpio/gpio-mockup.c
> > 
> > which uses PROPERTY_ENTRY_STRING_ARRAY_LEN(), and
> > 
> >   drivers/pinctrl/bcm/pinctrl-bcm4908.c
> >   drivers/pinctrl/intel/pinctrl-intel-platform.c
> >   drivers/pinctrl/meson/pinctrl-amlogic-a4.c
> >   drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> >   drivers/pinctrl/pinctrl-at91.c
> >   drivers/pinctrl/pinctrl-rockchip.c
> >   drivers/pinctrl/pinctrl-st.c
> > 
> > all of which use the size N to iterate over the returned array.
> 
> Thanks for confirming.
> 
> > Also, kfree_strarray() explicitly takes the number of entries N,
> > indicating that callers are expected to keep track of it.
> 
> Still we might have an API that requires a NULL terminated arrays (when it
> doesn't take size), which a caller wants to use.
> 
> > > Note, that was done on purpose that once allocated it can allow user
> > > to drop the track of the number of strings and rely on NULL terminator.
> > > I.o.w.  the number of strings may be just a local variable somewhere
> > > where kasprintf_strarray() is called.
> > > 
> > > I tend to NAK this change, rather you can update kernel-doc to explain
> > > why it's done this way (see above).
> 
> Given pros and cons, and what David said I'm still not sure that this is
> going to be a beneficial patch. I leave it Kees and Andrew to decide.

What's your take on this and the __counted_by_ptr() annotation from
patch 2/2?

Thanks,
Thorsten
