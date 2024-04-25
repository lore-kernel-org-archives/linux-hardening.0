Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621015382C
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081562; cv=none; b=sXlaKSv1GvlcCrwMMh7WRFMsCk27FmAhsPdVA9CSrmZi7MpRTbaqRHTcm0pdlxQZ//zEti9y307zIbBsud6FllN4O4L/jhC/5kAspToiLXVPdIRE0wWRkOOq/aVtO+AaNqC6dRq9VXfzxQ1Ui4fDskb8bI2qIvr5ffUAtH8hzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081562; c=relaxed/simple;
	bh=KBAqfCc9aXWXjn3ofK+oFYsop4IYofS4yltpNOFRV+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw1p08y3xDVJ3Xl454rei9ociHz6KVH5GDs6t9RqA3HfWCEGbSi3IjUVtmu+X7Evtpd3bv+t5Zwbi1RUL49O2y340sAYHTsjsCvrZeYgnCvi+wLErRIByKH+Qll91POEBvK7Rs+6YrIFPFz86+1QoB1/UPuJyNir54bHjG4aFko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PavWTYF/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PavWTYF/"
Date: Thu, 25 Apr 2024 17:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714081558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gojPkHBBYhfHH8Nts+6nokM2SWbYB22brKZh/DHHIWE=;
	b=PavWTYF/BaxN61KWH2/AES+ibnfiGZEFab/vTL8xZJh4inSYbsdS4D8BIpDB4y1NRB/TQ2
	qbc6t3H9XE3U6iQpkk2BMJBapBCZhS5AKlUXHIV2FNN149deSIr+RKOR3CphAyoKnBU919
	Qv4iJoYjMF7lsOdNXYtabCbRyEgx/vA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <lu7r7gbk6q75sdohh7sqlcfftbmuskluedpi2a7tzqwdywhj3b@vpwqhsy4o4ca>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
 <20240425143842.fe54147e4073c7d5e8b48d7b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425143842.fe54147e4073c7d5e8b48d7b@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 02:38:42PM -0700, Andrew Morton wrote:
> On Thu, 25 Apr 2024 14:21:39 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > > > > The side effect of locking down more and more reporting interfaces is
> > > > > that programs that consume those interfaces now have to run as root.
> > > >
> > > > sudo cat /proc/allocinfo | analyse-that-fie
> > >
> > > Even that is still an annoyance, but I'm thinking more about a future
> > > daemon to collect this every n seconds - that really shouldn't need to
> > > be root.
> > 
> > Yeah, that would preclude some nice usecases. Could we maybe use
> > CAP_SYS_ADMIN checks instead? That way we can still use it from a
> > non-root process?
> 
> I'm inclined to keep Kees's 0400.  Yes it's a hassle but security is
> always a hassle.  Let's not make Linux less secure, especially for
> people who aren't even using /proc/allocinfo.

That's a bit too trite; we've seen often enough that putting security
above all other concerns leads to worse outcomes in the long run; impair
usability too much and you're just causing more problems than you solve.

We need to take a balanced approach, like with everything else we do.

I'd really like to hear from Kees why pre-sorting the output so we aren't
leaking kernel image details wouldn't be sufficient.
