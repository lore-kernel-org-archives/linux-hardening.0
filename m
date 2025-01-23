Received: from mail18.out.titan.email (mail18.out.titan.email [3.64.226.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACC381AF;
	Thu, 23 Jan 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632837; cv=none; b=Hyqi7Cr0D3ptxA5/qOnJU6ROXzFDam9QRmwCfhANdi0NusFvkfKqo0UT+OlQG/GLC3gS0CViYyBl5bSqxiQm8yE4lUctCvI+uSkK+4GT9mQgW5faDeynyfKjvGdN+D1upTeeBCvXR4X8fE7Gw4IeVPSDxDJLvUubXUix/NOod3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632837; c=relaxed/simple;
	bh=p7p+70gODuygFBbNmQZM4P2MMtWXHP4Vxhk4b1xW3/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkdjvbCEthcEV3kO4mC5Gtq1wEz9nVEpB0j9TgQsL0yOWfCXaf1o3mTrSV+onPHdwmOdfLiftnFGhOv4W+qF7XymvEtGOYqr8IFjeYAYWHy4zZOrQVQOaZccXfvKyK3/j1EZ8Vq1SEMQgfiV9TSl39a6wqer/QlLwjihlQGDQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=ZwuWedC/; arc=none smtp.client-ip=3.64.226.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="ZwuWedC/"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id A6E31A014F;
	Thu, 23 Jan 2025 11:47:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=PDlnjIOGLC9huanq0PXLwl0a0rA6MLFYobde6kIUick=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=subject:message-id:mime-version:in-reply-to:date:from:to:cc:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737632827; v=1;
	b=ZwuWedC/o31nI5LaamdZ2Dt4mJk0VqyhHHOgIPvGEPcRG8gYIEckOFKRT2Gg//P8nsQKr8wO
	pHb2tXg5nM3rGoUEX8o4SUcm9+yDdcmQQpt3wkXjbccmB2kbYH8pkOEFYy6hAO0Axetl43xpihc
	CaUmYEMgcP9stGP4uFP2oDk4=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id A9F8FA016B;
	Thu, 23 Jan 2025 11:47:06 +0000 (UTC)
Date: Thu, 23 Jan 2025 11:47:05 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: security: Check early if HARDENED_USERCOPY is
 enabled
Message-ID: <vtpg3zz4vv6drtkdqvqlcquajiw2lgj5h5d5xlhhptopl5r5r7@g5hwiqcrq7xr>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
 <20250122171925.25472-4-mgorman@techsingularity.net>
 <202501221657.E657471E6B@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202501221657.E657471E6B@keescook>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737632827098904498.9138.8096332741043118874@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TIZDSUla c=1 sm=1 tr=0 ts=67922c3b
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=R_Myd5XaAAAA:8
	a=LboAmBLv0ONKXr6YTZkA:9 a=PUjeQqilurYA:10 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Jan 22, 2025 at 05:01:21PM -0800, Kees Cook wrote:
> On Wed, Jan 22, 2025 at 05:19:24PM +0000, Mel Gorman wrote:
> > HARDENED_USERCOPY is checked within a function so even if disabled, the
> > function overhead still exists. Move the static check inline.
> > 
> > This is at best a micro-optimisation and any difference in performance
> > was within noise but it is relatively consistent with the init_on_*
> > implementations.
> > 
> > Suggested-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  include/linux/thread_info.h |  8 ++++++++
> >  mm/usercopy.c               | 11 ++++++-----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> > index cf2446c9c30d..832f6a97e64c 100644
> > --- a/include/linux/thread_info.h
> > +++ b/include/linux/thread_info.h
> > @@ -221,9 +221,17 @@ static inline int arch_within_stack_frames(const void * const stack,
> >  extern void __check_object_size(const void *ptr, unsigned long n,
> >  					bool to_user);
> >  
> > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> > +			   validate_usercopy_range);
> 
> This should be DECLARE_STATIC_KEY_MAYBE_RO()
> 

Doesn't exist. Are you mixing it up with the DEFINE_STATIC_KEY_MAYBE_RO?


> >  static __always_inline void check_object_size(const void *ptr, unsigned long n,
> >  					      bool to_user)
> >  {
> > +	if (static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> > +				&validate_usercopy_range)) {
> > +		return;
> > +	}
> > +
> >  	if (!__builtin_constant_p(n))
> >  		__check_object_size(ptr, n, to_user);
> >  }
> 
> This is accidentally correct ("if validate, skip" matches "if not
> enabled, disable validation" below, but is very confusing. Also, yes,
> this is good to be moved into the inline, but let's wrap it in the
> compile-time __builtin_constant_p() check:
> 
> static __always_inline void check_object_size(const void *ptr, unsigned long n,
> 					      bool to_user)
> {
> 	if (!__builtin_constant_p(n) &&
> 	    static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> 				&validate_usercopy_range))
> 		__check_object_size(ptr, n, to_user);
> }
> 

Ok, should be fine given that it's a compile-time check anyway.

> > diff --git a/mm/usercopy.c b/mm/usercopy.c
> > index 4cf33305347a..2e86413ed244 100644
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -201,7 +201,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
> >  	}
> >  }
> >  
> > -static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
> > +DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> > +			   validate_usercopy_range);
> > +EXPORT_SYMBOL(validate_usercopy_range);
> >  
> >  /*
> >   * Validates that the given object is:
> > @@ -212,9 +214,6 @@ static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
> >   */
> >  void __check_object_size(const void *ptr, unsigned long n, bool to_user)
> >  {
> > -	if (static_branch_unlikely(&bypass_usercopy_checks))
> > -		return;
> > -
> >  	/* Skip all tests if size is zero. */
> >  	if (!n)
> >  		return;
> > @@ -271,7 +270,9 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
> >  static int __init set_hardened_usercopy(void)
> >  {
> >  	if (enable_checks == false)
> > -		static_branch_enable(&bypass_usercopy_checks);
> > +		static_branch_enable(&validate_usercopy_range);
> > +	else
> > +		static_branch_disable(&validate_usercopy_range);
> 
> This should be:
> 
> 	if (enable_checks)
> 		static_branch_enable(&validate_usercopy_range);
> 	else
> 		static_branch_disable(&validate_usercopy_range);
> 

Bah, fixed.

-- 
Mel Gorman
SUSE Labs
