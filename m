Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1761D31A6;
	Wed,  2 Oct 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879494; cv=none; b=moa5XNc7pptnagylcpQVoJr75bzRl4EX55n70BtRkLteupo7qStkHZY7pA51K9JCYBVxeTvOxbeYvXWbudU7TdQWHpwp3aMvKThkf1zbcnwlD1xxQDebiBRKydLIhaYdl2iM594oV1HTpLBME/7XNrI7vgokU+wcPhgHNrUK160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879494; c=relaxed/simple;
	bh=AOwsI8ttEsWUZNDXWx350NUjxQIot7Zr9BS5naNczWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUsXRhVEX6cujt0cX77C+GdgIImutIjFb043KIB2Apl8WE/gnrH27aXrDXM2nFsfwf32K+m1j4kZXMlv+QZcX6Qke/w72uY19Xx3R4BMv0yMprksIXMrPCTM2IhJ2USeWHQRA1WN/l3oFXx8V6JwX9WmcC4LZNSIMc4+OIFCbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DG8SOTvK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DG8SOTvK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Vce3FC/WapHyfNwrSw1Wg2Ra7Z/9KxMLRPXhDw+rUG4=; b=DG8SOTvKEiFaZerm
	jNw5I3PFlOqBkhLugXAidg5skmgqVd4ERu9wEOLJ4iWFNFBm0ti9RUyMdxW00bowEgYUJzpQJdTOk
	OmokkirLFXoqqgUdFlCuetB+bOUM47tiTNQ1Lbf5Jf4plCY5XWIsORiU65Gu1ovENQR0sM0DGoRRV
	iUj9GrHPLKHNMa6/ke8h6HS7NhJWgMbgDxmFPXoffls+SC62YKC2NJkpfm/RgckoFCg83lQcEskvh
	Uj1Hg3sI0t14OiSntSaJuhU7JgJysQDfgIX5Iv+WrFY3Pcxv+4+Uw8BQ0jF1kR2/2vnBNapZuwj2G
	Q3yySwllhLC6KsaLDg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sw0Nr-008T2f-27;
	Wed, 02 Oct 2024 14:31:19 +0000
Date: Wed, 2 Oct 2024 14:31:19 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, pmladek@suse.com,
	rostedt@goodmis.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printf: Remove unused 'bprintf'
Message-ID: <Zv1ZN8XZmSZTD-78@gallifrey>
References: <20241002012125.405368-1-linux@treblig.org>
 <Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:24:32 up 147 days,  1:38,  1 user,  load average: 0.03, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Andy Shevchenko (andy@kernel.org) wrote:
> On Wed, Oct 02, 2024 at 02:21:25AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > bprintf is unused.  Remove it.
> 
> bprintf()

OK.

> > It was added in
> > commit 4370aa4aa753 ("vsprintf: add binary printf")
> > 
> > but as far as I can see was never used, unlike the other
> > two functions in that patch.
> 
> Please, rewrap these lines to use more room on each line.

Something like this? :

bprintf() is unused.  Remove it.  It was added in

commit 4370aa4aa753 ("vsprintf: add binary printf")

but as far as I can see was never used, unlike the other two functions in
that patch.


> ...
> 
> I am not familiar with tricks in BPF or ftrace code where this actually might
> be implicitly called via a macro, but brief grep gives nothing that might point
> to that.

I've got an all-yes build (well, most after I took out broken stuff) booting
with it, and it has CONFIG_BINARY_PRINTF=y and CONFIG_FTRACE=y .

trace_seq.c uses seq_buf_bprintf which uses bstr_printf rather than the plain
bprintf() that I've deleted.
Not sure where to dig in BPF, but I've had a fairly good grep around.

> Hence, with the amended commit message
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks!

> P.S. I hope we may rely in CIs to report issues soon, if any.

Sure

Dave

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
