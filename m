Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA758528E;
	Mon,  7 Apr 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053839; cv=none; b=lMVzZ+t16O845ATq/DEEIP4jCBsZACOshCKooIo4QZQkfOrvyTCd9gRU2x0UoZaf5NN05GRmpFULQizJQtH1/vZDCjTtp5tNbsteUhbhtrSVtRLKZTmLMR0eJFHt85LW5ANzS2sstP/SG6/D7eXFoPU8p6DHaTQ682GNIl9UFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053839; c=relaxed/simple;
	bh=YbNPsZN6HL6dUYMl9sFPgAsEQwv6L2hq+AKPCvpenEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYMfPJ2oysDjbf/XBZd6w8mPkKsST2mgO4c7dfDVDgC7zv8ldvMyoIIvVVFlfToR0WQk3+7SMciFs8W4zQax6J5yQOoIZaCRs1Kjj8R6goNDccWmJBJFY3zeXWvPHHodFp5malZMtqnM34pWh+GBAqN8dh4QsBvWKzFnu9rIL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ2XPV99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ2XPV99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE11C4CEE7;
	Mon,  7 Apr 2025 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053838;
	bh=YbNPsZN6HL6dUYMl9sFPgAsEQwv6L2hq+AKPCvpenEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQ2XPV99IOL/Y10mTh4QHyHn0o/vzpByTSaB3ziQXI0TTrQh764O50bGN+6irqR1o
	 +issO4W7mJYgBoNgWuUYmne37ynvTT5t2ma0xESdEfZn2ACZzx7GE3csBLYlPPZS8l
	 5EzsXfvZJEtrs2N+Dnc9HTibCjMAfP4d3r1WnDqaqwkYT2OfN358IfwuJS9GtEG5cd
	 nq2H18GPcgu9Fdj2tGAj58wKbsm1ECFNa7bcy3bF6ahcuBZ+WumQQIewmoobD5h83L
	 0dkZLmbAx25zdoDTvLRg/OmjflKXnVBozXlefwUIT9M/kISo5qk7e716b1/NvU63Cy
	 XhdWL1RyyYMqA==
Date: Mon, 7 Apr 2025 12:23:55 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: fence: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <202504071223.EDBF8A080@keescook>
References: <Z-2r6v-Cji7vwOsz@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-2r6v-Cji7vwOsz@kspp>

On Wed, Apr 02, 2025 at 03:28:10PM -0600, Gustavo A. R. Silva wrote:
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
> drivers/gpu/drm/nouveau/nouveau_fence.c:188:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_fence.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index 7cc84472cece..7622587f149e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -184,10 +184,10 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
>  	struct nouveau_cli *cli = chan->cli;
>  	struct nouveau_drm *drm = cli->drm;
>  	struct nouveau_fence_priv *priv = (void*)drm->fence;
> -	struct {
> -		struct nvif_event_v0 base;
> -		struct nvif_chan_event_v0 host;
> -	} args;
> +	DEFINE_RAW_FLEX(struct nvif_event_v0, args, data,
> +			sizeof(struct nvif_chan_event_v0));
> +	struct nvif_chan_event_v0 *host =
> +				(struct nvif_chan_event_v0 *)args->data;
>  	int ret;
>  
>  	INIT_WORK(&fctx->uevent_work, nouveau_fence_uevent_work);
> @@ -207,12 +207,12 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
>  	if (!priv->uevent)
>  		return;
>  
> -	args.host.version = 0;
> -	args.host.type = NVIF_CHAN_EVENT_V0_NON_STALL_INTR;
> +	host->version = 0;
> +	host->type = NVIF_CHAN_EVENT_V0_NON_STALL_INTR;
>  
>  	ret = nvif_event_ctor(&chan->user, "fenceNonStallIntr", (chan->runlist << 16) | chan->chid,
>  			      nouveau_fence_wait_uevent_handler, false,
> -			      &args.base, sizeof(args), &fctx->event);
> +			      args, __struct_size(args), &fctx->event);
>  
>  	WARN_ON(ret);
>  }

Looks good to me. Good replacement, including the __struct_size() use.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
