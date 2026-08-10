Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB52EEE6E;
	Mon, 10 Aug 2026 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396607; cv=none; b=PVg7u+6clsBRu9iEA2S9dh8EBnsa8fk4e5+/MRu7SMUK5t3F4Jd8uVpmosNshwcP8qaO306HhcKkooxQM/VTiLI5S7idWaEUXvFhOmdOyal+91H5CavBdoQX/Wp3g0S9paGkEf6RyL43EwqtrxrxEMlF0OLqCslLrcYQkLKjzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396607; c=relaxed/simple;
	bh=TBFlUH2DAWRdO5ZEbfVsPuzo0HQ+oE1ROviFaDWyp8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7F8HFmMUfURE29lW5p9ghP7MpzF3h08FrdHGoQ9J66ZwKou3tlhxDqWnZLPlATjl1DAzNXZrDQa0xrPy/oq0qF1a4Cs5SOhwdW/u3ocUZUdqEcpXOy55gg0xYOSX4C9P94LN0iIPYfuB1Rv1vn97/SfDsCHbCCqWhvY4vqAIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f97RwX0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f97RwX0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96FA1F000E9;
	Mon, 10 Aug 2026 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786396606;
	bh=pcJn5EzShExLFseVfhgfYB2fGGsg+eUvJiSevSzZ3vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f97RwX0BOLEgNdLIB5HepcIfFsVOL1MolVy+VG3IhHfgnD33JykCHMkHx++PboA8L
	 +f0/Mqw8NbZwT9/jHVrQxx9MYfFopMv08rnTlSqYmIjqyD+ZPuXGTj9yW3gwBP6LtW
	 MYseaaHKS5yo5i5N6NatkodNZSv5M+1RnCh5nKq/yNy5f1WStSqU84UfphR6B1Jm/U
	 AeDPIR9m8lCAqsfpdaoa+4CK8GHpf7AO/PZQ14zYjHG7rngsHF2E04PjP9YR2fce47
	 bJJaHKTAXGdKwewczyqzFGeUwAWmdG5Edft1y0wpSpvM7ZOeaf5mRn7CvGi5fjuHf0
	 jOI+XySNJmIYg==
Date: Mon, 10 Aug 2026 23:16:41 +0200
From: Robert Richter <rric@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ian Bridges <icb@fastmail.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <ano_uQtMIjcoFcs9@rric.localdomain>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
 <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
 <annRsN6UBDPsFLr2@rric.localdomain>
 <20260810134506.GAannV4uJN0I1UXh0q@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810134506.GAannV4uJN0I1UXh0q@fat_crate.local>

On 10.08.26 06:45:06, Borislav Petkov wrote:
> On Mon, Aug 10, 2026 at 03:27:12PM +0200, Robert Richter wrote:
> > However, the driver has several issues. I asked Marvell a while ago to
> > take over maintainership, but never got a response. I don't have
> > hardware to test changes. If you mean to mark the driver obsolete, I
> > am good with it. On the other hand, the issues found may not actually
> > trigger and only affect a single system. If we can live with it, we
> > could leave it as is.
> 
> I am sorting out stuff which needs maintaining from obsolete gunk, which is not
> used anymore and which doesn't need any maintenance effort or no one cares for
> it anymore and there's no point to waste precious resources for.
> 
> So I'm going to do this but we can always revert it if someone shows interest.
> 
> ---
> Author: Borislav Petkov (AMD) <bp@alien8.de>
> Date:   Mon Aug 10 06:40:13 2026 -0700
> 
>     EDAC/thunderx: Orphan it
>     
>     Robert doesn't have hardware to test patches anymore and no one else has
>     shown interest in maintaining this driver, so orphan it, for now at
>     least.
>     
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Acked-by: Robert Richter <rric@kernel.org>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d413dac5c8b3..671515d21bfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9308,9 +9308,8 @@ S:	Maintained
>  F:	drivers/edac/octeon_edac*
>  
>  EDAC-CAVIUM THUNDERX
> -M:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
> -S:	Odd Fixes
> +S:	Orphan
>  F:	drivers/edac/thunderx_edac*
>  
>  EDAC-CORE
> 
> ---
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
