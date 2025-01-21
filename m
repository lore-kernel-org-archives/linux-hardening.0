Received: from mail45.out.titan.email (mail45.out.titan.email [3.69.218.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32451DED4F
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jan 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.69.218.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453454; cv=none; b=LV0e5BFHgQzwqWeZhq3VIeTgtfLbhlqAfc8LJn3uTCNA9JWFmEKot+PWrQU6UGaHBJVUxmZbWy4bUVweRp3vTPOsYD663QRacrSPHD6W72iggygSEVLqqE3t1mYrexcDFkYTt/NxMp5gP1XUsUqQQ425RL9icPil8/QnXCXILtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453454; c=relaxed/simple;
	bh=VvVzoYk2sHiu8/SDVYls1msvCpp+47JqUFgK1SwOz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR2NrFN8SfEVJakyCy9/x77R5hv2fMjkLzqUzYmvszZr3HLbNdxhy9tpYRp9KuXThRT6xKxbqJ0TaabE1oPCJCV6QC3VPoB5d6+1BSQOmWU1bToHVms/0bTwuJn09dmSzNWEzb5R3mMy24YM7wIkQqg3YQyVKRGYFfVhrnejXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=D/OGKmo1; arc=none smtp.client-ip=3.69.218.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="D/OGKmo1"
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 175C1100020;
	Tue, 21 Jan 2025 09:21:57 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=sccipapXhNbeC6uMs53zEH29wrubYoMOansmEhlytZg=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=mime-version:date:to:references:subject:in-reply-to:from:cc:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1737451317; v=1;
	b=D/OGKmo11NTXhpjiHFg2gvpbuodwxD95PU8tgG/H+1BYvREWDDFLxxWulaXNLK8GynvA+IF0
	6jeC6WFktmX/Lip7uGNOFFpTXLTYGLii4vAwgPTEDHgKNnH4t732GLWl/KmzGgH7sEqENP2mUOv
	WCMcy0+Tdx6K29tCNUclR5XI=
Received: from mail.blacknight.com (ip-84-203-196-66.broadband.digiweb.ie [84.203.196.66])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id A34F71000CD;
	Tue, 21 Jan 2025 09:21:56 +0000 (UTC)
Date: Tue, 21 Jan 2025 09:21:55 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Kees Cook <kees@kernel.org>
Cc: Daniel Micay <danielmicay@gmail.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: security: Move hardened usercopy under 'Kernel
 hardening options'
Message-ID: <aapczkb5toqvhe7cdtiyh5yl3etuptr3t6ceuhx2gp44byr5me@z3oar4quneda>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
 <20250117130337.4716-2-mgorman@techsingularity.net>
 <202501201309.73DA8439B@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <202501201309.73DA8439B@keescook>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1737451316962360000.2117.1171205118477614334@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TIZDSUla c=1 sm=1 tr=0 ts=678f6734
	a=jU4EnjUUC1PH4wSjvv7Pww==:117 a=jU4EnjUUC1PH4wSjvv7Pww==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8
	a=ZnWMjbixoiQcK7vDt3wA:9 a=PUjeQqilurYA:10 a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Jan 20, 2025 at 01:10:44PM -0800, Kees Cook wrote:
> On Fri, Jan 17, 2025 at 01:03:35PM +0000, Mel Gorman wrote:
> > There is a submenu for 'Kernel hardening options' under "Security".
> > Move HARDENED_USERCOPY under the hardening options as it is clearly
> > related.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  security/Kconfig           | 12 ------------
> >  security/Kconfig.hardening | 16 ++++++++++++++++
> >  2 files changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 28e685f53bd1..fe7346dc4bc3 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -159,18 +159,6 @@ config LSM_MMAP_MIN_ADDR
> >  	  this low address space will need the permission specific to the
> >  	  systems running LSM.
> >  
> > -config HARDENED_USERCOPY
> > -	bool "Harden memory copies between kernel and userspace"
> > -	imply STRICT_DEVMEM
> > -	help
> > -	  This option checks for obviously wrong memory regions when
> > -	  copying memory to/from the kernel (via copy_to_user() and
> > -	  copy_from_user() functions) by rejecting memory ranges that
> > -	  are larger than the specified heap object, span multiple
> > -	  separately allocated pages, are not on the process stack,
> > -	  or are part of the kernel text. This prevents entire classes
> > -	  of heap overflow exploits and similar kernel memory exposures.
> > -
> >  config FORTIFY_SOURCE
> >  	bool "Harden common str/mem functions against buffer overflows"
> >  	depends on ARCH_HAS_FORTIFY_SOURCE
> > diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> > index c9d5ca3d8d08..00e6e2ed0c43 100644
> > --- a/security/Kconfig.hardening
> > +++ b/security/Kconfig.hardening
> > @@ -279,6 +279,22 @@ config ZERO_CALL_USED_REGS
> >  
> >  endmenu
> >  
> > +menu "String manipulation"
> 
> I think "string" means different things to different people. I'd prefer
> "Bounds checking" or "Spatial safety" if it's going to be a separate
> menu section.
> 

I will change it to "Bounds checking" in v2.

Thanks.

-- 
Mel Gorman
SUSE Labs
