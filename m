Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DC1D04B8;
	Wed,  2 Oct 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880750; cv=none; b=RvT8iORABlvDtAyKdx7/cd+53dAyrnsbxhJ2SydSKYWJDSK4v7WbyaD7DYcwhqr21q5rPIEejDxnZg3fEd89Mu7s6L7LIm1FCEStBaC+Hhj1jcd8IntU9rs6njTavh6kRH8YM3hM2ZTqOeeHL7u3Efs+UipQ+8cLlvIlTyOey4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880750; c=relaxed/simple;
	bh=MU9+R9Kvl7CAykXh043qkbjzvCIiYkmaJANF1Yea/O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItqwmtKmUO60JoMFZJyl/sipKdrJGcCxR+IO5eIQQTdviUfCCyRenesyWcsaiUZBRFYxYMKJ+Jm58TVrmeh7ymDUlxPpNM3eRmkVJoiY7IJtF4VrYsQipeh247sHBbG0DofdvHLmU8DmJ2hs67+p96XjfJvFNLKlpv83cghoypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=h5mn6BSj; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="h5mn6BSj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=GI3RiPDGhmzNSN8i/+FL+Bxe+r6gMoOsPDsMSIAkf64=; b=h5mn6BSjY/6e8B96
	kPyAMHyMGCQt5p5sp0qI/Sq+lJwEdJOO7FheXm6KC5O22mdM25IGVGi97hnlO67I9WO+Eaathpnlj
	WeuzfWRs8xSs99fvvzsX6aHM/KIq2hINe6PGanyAORuj8XK+QqBJ09kkA8sjkiKjaaSfzLLtIstr7
	WVM1E2Jcb8mPFbfMhJ/V6C/iO0jPN+ruAGSOKT1bM7hlw28RpuSf1/dYwwcjMdLp4W//obXyOmHPh
	L1jBeaX2iXIDi/2o/n3I6ZPCzXE2qaSxV5cl1CyPsaePfnr8aOsKT75OowyqqB1pZ4peh41edJQWH
	4Vik0yo8XeKeIYD4uw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sw0iF-008TMg-0r;
	Wed, 02 Oct 2024 14:52:23 +0000
Date: Wed, 2 Oct 2024 14:52:23 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, pmladek@suse.com,
	rostedt@goodmis.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printf: Remove unused 'bprintf'
Message-ID: <Zv1eJ-07dY2Drmh_@gallifrey>
References: <20241002012125.405368-1-linux@treblig.org>
 <Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
 <Zv1ZN8XZmSZTD-78@gallifrey>
 <Zv1chIuTlOdu-ved@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zv1chIuTlOdu-ved@smile.fi.intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:51:26 up 147 days,  2:05,  1 user,  load average: 0.07, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Andy Shevchenko (andy@kernel.org) wrote:
> On Wed, Oct 02, 2024 at 02:31:19PM +0000, Dr. David Alan Gilbert wrote:
> > * Andy Shevchenko (andy@kernel.org) wrote:
> > > On Wed, Oct 02, 2024 at 02:21:25AM +0100, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > bprintf is unused.  Remove it.
> > > 
> > > bprintf()
> > 
> > OK.
> > 
> > > > It was added in
> > > > commit 4370aa4aa753 ("vsprintf: add binary printf")
> > > > 
> > > > but as far as I can see was never used, unlike the other
> > > > two functions in that patch.
> > > 
> > > Please, rewrap these lines to use more room on each line.
> > 
> > Something like this? :
> 
> > bprintf() is unused.  Remove it.  It was added in
> > 
> > commit 4370aa4aa753 ("vsprintf: add binary printf")
> > 
> > but as far as I can see was never used, unlike the other two functions in
> > that patch.
> 
> You have two blank lines in the middle, do you really need them?

No, I was just trying to keep the commit reference separate, I'm never
quite sure what checkpatch gets upset by.

> I would put it like this
> 
> bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
> ("vsprintf: add binary printf") but as far as I can see was never used,
> unlike the other two functions in that patch.

Sure, I can send a v2 like that.

Dave

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
