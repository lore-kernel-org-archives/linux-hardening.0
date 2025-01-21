Received: from mail37.out.titan.email (mail37.out.titan.email [3.65.141.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8971F191A
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.141.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462959; cv=none; b=puVrwEHzRGGpTE5TTwJjD+NeHHPQmAdBQZqn9PX6mQSRymFnzz0pqIc5VZshmtnQaWwtZDPFbVDBJ6UPxUJpNPY0yomKHPnbGBXE/LhP6Xo4wbrI+PCyRuUAuiDEkkGXOiakF7C3DPgMFuvZHrTtw0hjNbNksPMrbELRIkKVlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462959; c=relaxed/simple;
	bh=iPN4iMNlCreEtWDv8pwwpSuUYWSCMO9mPht3pgJ+Uew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKgH3onZsaZ2I9fJWNpYOPfhx8s0+YyPMrEw94AahK/JZQQUdTh6UFxpOAR4ZGy6dWxgwIrkOZSizfW6gVG3j+8uQhlwlFlU3n/SJdp6JE6DbqNjV+SV672eEHc3K2kQR47j8Ru/lb42QFDYnlt1EebUO/APIpAIG9dXrGmiBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=VWb3dwA5; arc=none smtp.client-ip=3.65.141.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="VWb3dwA5"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 40C24100314;
	Tue, 21 Jan 2025 12:35:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=hW7NrVXkxUQhbBM9CKOUAXuTqSHWPfMwEfBYmm9DTl8=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=date:message-id:in-reply-to:to:subject:references:from:cc:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737462955; v=1;
	b=VWb3dwA5dhlRU2rrneLLsXD4ejTxKhQqfI+prZ5ctw4bslZjmFcDsJHQv0xoICAxgQ9PDTbN
	DeKO8EVzGWLSp2k1aGrKelILeDQAiYDI2r4mgxumyXiHgvmngLjDRu20AvmiLVeKbU1VEGaF50g
	3VA4xAMFRDiuR3tUP/622mNM=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id CBB4B10031B;
	Tue, 21 Jan 2025 12:35:54 +0000 (UTC)
Date: Tue, 21 Jan 2025 12:35:53 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: security: Allow default HARDENED_USERCOPY to be
 set at compile time
Message-ID: <s2uigraqtmh3rs72hbsxcv2mnl3fa7dlqtq6erl2glkeizzdn7@wi6fop5p4usx>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
 <20250117130337.4716-3-mgorman@techsingularity.net>
 <202501201311.C67EEFBD7F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202501201311.C67EEFBD7F@keescook>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737462955129931656.2117.4168520547574402111@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TIZDSUla c=1 sm=1 tr=0 ts=678f94ab
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=VwQbUJbxAAAA:8
	a=HkYVKR1uqoi5OQ_vu8cA:9 a=PUjeQqilurYA:10 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Jan 20, 2025 at 01:21:54PM -0800, Kees Cook wrote:
> On Fri, Jan 17, 2025 at 01:03:36PM +0000, Mel Gorman wrote:
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
> 
> With the addition of the compile-time default, we can also provide
> better hot-path hinting for the static branches (likely as a separate
> patch), that would rename "bypass_usercopy_checks" to
> "perform_usercopy_checks" to avoid confusing negatives, and then:
> 

I decided to go with the more explicit name "validate_usercopy_range"
but I'm not overly pushed about the name

> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -293,6 +293,14 @@ config HARDENED_USERCOPY
> >       or are part of the kernel text. This prevents entire classes
> >       of heap overflow exploits and similar kernel memory exposures.
> >
> > +config HARDENED_USERCOPY_DEFAULT_ON
> > +   bool "Harden memory copies by default"
> > +   depends on HARDENED_USERCOPY
> > +   default n
>
> To avoid regressions for people moving their configs forward (and IMO
> get the right setting by default), I think this should instead be
> "default HARDENED_USERCOPY".

This I'm less keen on. The intent is that all the hardening options would
default to all opt-in or all opt-out by default to be consistent. I lean
towards default opt-in because those requiring a hardened environment should
know what options to enable and why. A distribution providing a hardened
kernel would explicitly enable them by default. A distribution that wanted
to provided a general kernel for users could provide the hardening options
but leave them disabled to avoid spurious performance regression reports
after a kernel upgrade.

Micro-optimisation currently is this;

--<--
mm: security: Check early if HARDENED_USERCOPY is enabled

HARDENED_USERCOPY is checked within a function so even if disabled, the
function overhead stillexists. Move the static check inline.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index cf2446c9c30d..832f6a97e64c 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -221,9 +221,17 @@ static inline int arch_within_stack_frames(const void * const stack,
 extern void __check_object_size(const void *ptr, unsigned long n,
 					bool to_user);
 
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+			   validate_usercopy_range);
+
 static __always_inline void check_object_size(const void *ptr, unsigned long n,
 					      bool to_user)
 {
+	if (static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+				&validate_usercopy_range)) {
+		return;
+	}
+
 	if (!__builtin_constant_p(n))
 		__check_object_size(ptr, n, to_user);
 }
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 4cf33305347a..2e86413ed244 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -201,7 +201,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	}
 }
 
-static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
+DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
+			   validate_usercopy_range);
+EXPORT_SYMBOL(validate_usercopy_range);
 
 /*
  * Validates that the given object is:
@@ -212,9 +214,6 @@ static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
  */
 void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 {
-	if (static_branch_unlikely(&bypass_usercopy_checks))
-		return;
-
 	/* Skip all tests if size is zero. */
 	if (!n)
 		return;
@@ -271,7 +270,9 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
 static int __init set_hardened_usercopy(void)
 {
 	if (enable_checks == false)
-		static_branch_enable(&bypass_usercopy_checks);
+		static_branch_enable(&validate_usercopy_range);
+	else
+		static_branch_disable(&validate_usercopy_range);
 	return 1;
 }
 
