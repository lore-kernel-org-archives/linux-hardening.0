Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199E21D00D;
	Mon,  7 Apr 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053953; cv=none; b=kAeH77UsQKoUOdnsVUlGPHuhDhHOKFZ6+OXwvJkCp4NQq+P+ISHhSow863tutSe18uYxQ3looEKPy46RNhqLbmS0HuDAnqfsAI0G0GiDjkPIEs/103PgWmacBKhCfX/Wun/+VSZipVfCwa3vTwAEFOsymXwNHtH8L+gPO9OLzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053953; c=relaxed/simple;
	bh=lCrDHc8UyV2gK3U9FDLItNUPzr/DmcFHZkzvakgFphw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw+jgu4U3s+5czKCra6XS9i7Ex7+9/or5AA80SCLHfIJaTtAsqtftuLS7g0irJZt5Qt1yYTdEifbrwZA+FdezzbSoaaF0zgnp/u4jtK2YdEQZM0x6LyqbPcECYelxch67yuK4TgMrQJoZ5tdCdDQT7xx2RuPE2y+NyEERmcEzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB8CWYxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB8CWYxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CDDC4CEDD;
	Mon,  7 Apr 2025 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053953;
	bh=lCrDHc8UyV2gK3U9FDLItNUPzr/DmcFHZkzvakgFphw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB8CWYxQrmtcIVB/CFdNFSaBdScqNnjYgWr3xTAjDEdRcfNAIP+ThOl/ObYpo3G8c
	 zjc669wPFW2B3eW2s42QUijDjGBUpZzGGEVMtcfqetJvG1ywHBkYc7h/RlBsF6l8bQ
	 kvNkaXliBrfMxRUhR63rQzc7SexCwcd4ANfR0jDmCERSpP+N5LWzfhKUyP1cZzAz64
	 QMHojQbzkS244JlyBi7OfQAm7TWSrf2DlJOu72oETaWII8eLoYgoCs/sAZ7bBjoZVz
	 ryhdljLx0iHReMb550o2HmXzN26wKl6GZwt5KwDIusJFWnFMDYd9mxzEk9iftr5wPY
	 z8SSRuGl9GaJQ==
Date: Mon, 7 Apr 2025 12:25:50 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: svm: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <202504071225.6AB490E7@keescook>
References: <Z-2uezeHt1aaHH6x@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-2uezeHt1aaHH6x@kspp>

On Wed, Apr 02, 2025 at 03:39:07PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/gpu/drm/nouveau/nouveau_svm.c:724:44: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 39 +++++++++++++--------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index e12e2596ed84..6fa387da0637 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -720,10 +720,7 @@ nouveau_svm_fault(struct work_struct *work)
>  	struct nouveau_svm *svm = container_of(buffer, typeof(*svm), buffer[buffer->id]);
>  	struct nvif_object *device = &svm->drm->client.device.object;
>  	struct nouveau_svmm *svmm;
> -	struct {
> -		struct nouveau_pfnmap_args i;
> -		u64 phys[1];
> -	} args;
> +	DEFINE_RAW_FLEX(struct nouveau_pfnmap_args, args, p.phys, 1);
>  	unsigned long hmm_flags;
>  	u64 inst, start, limit;
>  	int fi, fn;
> @@ -772,11 +769,11 @@ nouveau_svm_fault(struct work_struct *work)
>  	mutex_unlock(&svm->mutex);
>  
>  	/* Process list of faults. */
> -	args.i.i.version = 0;
> -	args.i.i.type = NVIF_IOCTL_V0_MTHD;
> -	args.i.m.version = 0;
> -	args.i.m.method = NVIF_VMM_V0_PFNMAP;
> -	args.i.p.version = 0;
> +	args->i.version = 0;
> +	args->i.type = NVIF_IOCTL_V0_MTHD;
> +	args->m.version = 0;
> +	args->m.method = NVIF_VMM_V0_PFNMAP;
> +	args->p.version = 0;
>  
>  	for (fi = 0; fn = fi + 1, fi < buffer->fault_nr; fi = fn) {
>  		struct svm_notifier notifier;
> @@ -802,9 +799,9 @@ nouveau_svm_fault(struct work_struct *work)
>  		 * fault window, determining required pages and access
>  		 * permissions based on pending faults.
>  		 */
> -		args.i.p.addr = start;
> -		args.i.p.page = PAGE_SHIFT;
> -		args.i.p.size = PAGE_SIZE;
> +		args->p.addr = start;
> +		args->p.page = PAGE_SHIFT;
> +		args->p.size = PAGE_SIZE;
>  		/*
>  		 * Determine required permissions based on GPU fault
>  		 * access flags.
> @@ -832,16 +829,16 @@ nouveau_svm_fault(struct work_struct *work)
>  
>  		notifier.svmm = svmm;
>  		if (atomic)
> -			ret = nouveau_atomic_range_fault(svmm, svm->drm,
> -							 &args.i, sizeof(args),
> +			ret = nouveau_atomic_range_fault(svmm, svm->drm, args,
> +							 __struct_size(args),
>  							 &notifier);
>  		else
> -			ret = nouveau_range_fault(svmm, svm->drm, &args.i,
> -						  sizeof(args), hmm_flags,
> -						  &notifier);
> +			ret = nouveau_range_fault(svmm, svm->drm, args,
> +						  __struct_size(args),
> +						  hmm_flags, &notifier);
>  		mmput(mm);
>  
> -		limit = args.i.p.addr + args.i.p.size;
> +		limit = args->p.addr + args->p.size;
>  		for (fn = fi; ++fn < buffer->fault_nr; ) {
>  			/* It's okay to skip over duplicate addresses from the
>  			 * same SVMM as faults are ordered by access type such
> @@ -855,14 +852,14 @@ nouveau_svm_fault(struct work_struct *work)
>  			if (buffer->fault[fn]->svmm != svmm ||
>  			    buffer->fault[fn]->addr >= limit ||
>  			    (buffer->fault[fi]->access == FAULT_ACCESS_READ &&
> -			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_V)) ||
> +			     !(args->p.phys[0] & NVIF_VMM_PFNMAP_V0_V)) ||
>  			    (buffer->fault[fi]->access != FAULT_ACCESS_READ &&
>  			     buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH &&
> -			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_W)) ||
> +			     !(args->p.phys[0] & NVIF_VMM_PFNMAP_V0_W)) ||
>  			    (buffer->fault[fi]->access != FAULT_ACCESS_READ &&
>  			     buffer->fault[fi]->access != FAULT_ACCESS_WRITE &&
>  			     buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH &&
> -			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_A)))
> +			     !(args->p.phys[0] & NVIF_VMM_PFNMAP_V0_A)))
>  				break;
>  		}
>  

LGTM, including the __struct_size() usage.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
