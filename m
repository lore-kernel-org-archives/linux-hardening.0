Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933D35958;
	Fri, 28 Mar 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174343; cv=none; b=kuLYb80K9t/O0dO6+ZSqNNRnsypG/uSRnZ2gOLVVYSn6hdVrdKLKsy3iH4cY8z9QRrihaFs2azdalS6Oz41PyjZ5Lx9yT72pfEXP6ldbzsvewg8AdxJkYoOBAcA27edXAsAVP3WgZXN8rryClGBD+SseXhusetDpIVstCSYSHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174343; c=relaxed/simple;
	bh=DFlgmDbfFVNEIC8CuMgkRVk9uaSaT4iLRwL3bDdyVjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbhXU4WjfcVSBUd1SPM4lWBFdrrmNW+BZKAiryUmALZz59c/wTadoAsGGexE91Rim9wRZzw2w5OSobc7M1ttzRAGYGzYQ3N4wGQjt6cg7EepZxeZTBSS1oVIyHl84qVdBsdNBfVuwcWnKWhUI6v5kyZPgQz+UcvwfzDnRGf5sNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6J7IYiL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6J7IYiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010FC4CEE4;
	Fri, 28 Mar 2025 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743174343;
	bh=DFlgmDbfFVNEIC8CuMgkRVk9uaSaT4iLRwL3bDdyVjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6J7IYiLwYEa8HUpwYBGYRDyIuKnXwG2AIg/IQgkucNhPP7TlZ3NVRsWsoA+kw1GR
	 AFGsDW3zqA7Y5WXozoKfKFjNwK0AK9hPJZQTeFbRLuOf721qwquNcEwMHcIl/fBiuX
	 m9eKDJn3BEz7+QM9DG4mft7OcdU7ZhpmWUrhLESEUp7CKwfxTbLkqJ065KFjDIOtdD
	 Rz414Fe68nmJwmIP24fAuRXdstVNpGWk5HKwp7gkRUCYtI5rCn+xu2nVm+8NcN3uE2
	 9JHPX1z7eBO7QQtFfxiSeLnTfAI9Z5fA+iyxT0l0bVaquQGxy4vkQI/1HEPB9Kcg+I
	 P6cDE2SXaOtbQ==
Date: Fri, 28 Mar 2025 16:05:38 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau/outp: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-a6wtoIAkDY2ERx@pollux>
References: <Z-a2DAQmcsHHlyci@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-a2DAQmcsHHlyci@kspp>

On Fri, Mar 28, 2025 at 08:45:32AM -0600, Gustavo A. R. Silva wrote:
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
> drivers/gpu/drm/nouveau/nvif/outp.c:199:45: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nvif/outp.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
> index 6daeb7f0b09b..403cf16d5e84 100644
> --- a/drivers/gpu/drm/nouveau/nvif/outp.c
> +++ b/drivers/gpu/drm/nouveau/nvif/outp.c
> @@ -195,20 +195,18 @@ nvif_outp_dp_aux_pwr(struct nvif_outp *outp, bool enable)
>  int
>  nvif_outp_hda_eld(struct nvif_outp *outp, int head, void *data, u32 size)
>  {
> -	struct {
> -		struct nvif_outp_hda_eld_v0 mthd;
> -		u8 data[128];
> -	} args;
> +	DEFINE_RAW_FLEX(struct nvif_outp_hda_eld_v0, mthd, data, 128);
>  	int ret;
>  
> -	if (WARN_ON(size > ARRAY_SIZE(args.data)))
> +	if (WARN_ON(size > 128))

Seems a bit unfortunate that the size is duplicated here.

Can we have an accessor macro to derive the size for us?

	union {
		u8 bytes[struct_size_t(type, member, count)];
		type obj;
	} name##_u initializer;

Maybe a macro that returns the size difference between bytes and obj?

>  		return -EINVAL;
>  
> -	args.mthd.version = 0;
> -	args.mthd.head = head;
> +	mthd->version = 0;
> +	mthd->head = head;
>  
> -	memcpy(args.data, data, size);
> -	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, &args, sizeof(args.mthd) + size);
> +	memcpy(mthd->data, data, size);
> +	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDA_ELD, mthd,
> +			__struct_size(mthd) + size);
>  	NVIF_ERRON(ret, &outp->object, "[HDA_ELD head:%d size:%d]", head, size);
>  	return ret;
>  }
> -- 
> 2.43.0
> 
