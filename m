Received: from mail31.out.titan.email (mail31.out.titan.email [3.66.49.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213B20CCC3
	for <linux-hardening@vger.kernel.org>; Thu, 23 Jan 2025 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.66.49.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632257; cv=none; b=OxGCTkuK1vM/QBNjYuUi97mKwiPvzCt9M31+qtg/tLmxrAQooLXVFIB+XNbr3AiEV0eRbQ1FkcFd842wYtRNYohJMRyj4mk5NJiS2aLXdUJI0dp4xUBgiNOLuUEKhJoie2xrVLnXvs5TM5Zk1izrXncIg2z+ayRCziyRuTqMOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632257; c=relaxed/simple;
	bh=9XDvLCp9IVXCNgwBV7Pq4aqXxXSvhGqbBINcYppjCL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2lLKr7oAZ37Op/teN+YvXDy5beyig8iYCHxwfy+QdDa5+J+OFD5BJcwbLopNbpvsydRcXQuu9DabDkQrVw/QAvoe9tYU7dKg1JH+zIGOl5+Mhg/mv3mLbTNFcCZ1wy18ajZK4hbEPAqz2WX08I2zCLG36Mr99VDwAWU5slP5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=VicYzkGm; arc=none smtp.client-ip=3.66.49.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="VicYzkGm"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id BD4E11000A7;
	Thu, 23 Jan 2025 11:37:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=+IlzZHyCEJh/xltUPPsa1hQ8E6BqvoLQPao3GlXCDJE=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=to:cc:subject:from:mime-version:message-id:in-reply-to:references:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737632245; v=1;
	b=VicYzkGmwrJriyKk/u3FrnqNlz+D7VsP5sWz0vaYWodMgkhtQJPmvEvWGGrlrGba9hNIGTJ0
	FlEh5z2/ThDnKe3NbVuUzHVVJrBlwPNF/5m+xPmawXR8q+xkUMtTqLGeprtCs2GrP2aXacO+yc9
	Km3g+ThYlMdkPeKoWLlB4Id4=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 5F08410006B;
	Thu, 23 Jan 2025 11:37:25 +0000 (UTC)
Date: Thu, 23 Jan 2025 11:37:24 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: security: Allow default HARDENED_USERCOPY to be
 set at compile time
Message-ID: <jgyz66gu5ormzmr2jrgyyksbm5q2mduvb7w7zxefoamlwe7l6a@o3j77ebpjwyx>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
 <20250122171925.25472-3-mgorman@techsingularity.net>
 <202501221651.3F5A6ACD@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202501221651.3F5A6ACD@keescook>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737632245640493528.2117.2181088510976086906@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UdNXSrSN c=1 sm=1 tr=0 ts=679229f5
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8
	a=BE4pPNmKF6ZOhpLNiO0A:9 a=PUjeQqilurYA:10 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Jan 22, 2025 at 04:57:37PM -0800, Kees Cook wrote:
> On Wed, Jan 22, 2025 at 05:19:23PM +0000, Mel Gorman wrote:
> > HARDENED_USERCOPY defaults to on if enabled at compile time. Allow
> > hardened_usercopy= default to be set at compile time similar to
> > init_on_alloc= and init_on_free=. The intent is that hardening
> > options that can be disabled at runtime can set their default at
> > build time.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 4 +++-
> >  mm/usercopy.c                                   | 3 ++-
> >  security/Kconfig.hardening                      | 8 ++++++++
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3872bc6ec49d..5d759b20540a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1773,7 +1773,9 @@
> >  			allocation boundaries as a proactive defense
> >  			against bounds-checking flaws in the kernel's
> >  			copy_to_user()/copy_from_user() interface.
> > -		on	Perform hardened usercopy checks (default).
> > +			The default is determined by
> > +			CONFIG_HARDENED_USERCOPY_DEFAULT_ON.
> > +		on	Perform hardened usercopy checks.
> >  		off	Disable hardened usercopy checks.
> >  
> >  	hardlockup_all_cpu_backtrace=
> > diff --git a/mm/usercopy.c b/mm/usercopy.c
> > index 83c164aba6e0..4cf33305347a 100644
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -255,7 +255,8 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
> >  }
> >  EXPORT_SYMBOL(__check_object_size);
> >  
> > -static bool enable_checks __initdata = true;
> > +static bool enable_checks __initdata =
> > +		IS_ENABLED(CONFIG_HARDENED_USERCOPY_DEFAULT_ON);
> >  
> >  static int __init parse_hardened_usercopy(char *str)
> >  {
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index 9088d613d519..adcc260839c7 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -293,6 +293,14 @@ config HARDENED_USERCOPY
> >  	  or are part of the kernel text. This prevents entire classes
> >  	  of heap overflow exploits and similar kernel memory exposures.
> >  
> > +config HARDENED_USERCOPY_DEFAULT_ON
> > +	bool "Harden memory copies by default"
> > +	depends on HARDENED_USERCOPY
> > +	default n
> 
> This must be "default HARDENED_USERCOPY" or existing distro builds will
> break. All major distros enable this by default, and I don't want to
> risk HARDENED_USERCOPY_DEFAULT_ON getting missed and getting globally
> disabled.
> 

Ok. I dislike that HARDENED_USERCOPY will be inconsistent with INIT_ON*
but it's not a hill I'm willing to die on. Will be in v3

-- 
Mel Gorman
SUSE Labs
