Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270011CB33A;
	Thu, 22 Aug 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347659; cv=none; b=H70dyTpwZ0CAGgP/y0cmTrrMw9SZ2eYvtkQkACr/pLJK0YU6WLHBKfiU1Bi4GIjL5IpZFv2Gy0Jey00NJ5qxkdwwwLtZEnJHApxnesgsfz8lsnyl/pZdct3JAgVGZyA5mnciWhKjOa4vAn3KZFyT1EdV5WV53JzJlrGIZswTBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347659; c=relaxed/simple;
	bh=TWiJ93HyAJ88G0js0Qu5sBOlvCmAqny+80HmOjGUBgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDcVXLGqnWxL5v2d0+07V7JCI1nFA8rrq44jw+srzBQK1UV74T1RvNWA4q9DqNgpH2kawmwofajRbWxO9JvI/ZyiLqSkZIzOd1aS/JFuGAdfgMGzh371iXXi1+6mmvrfSHRnEzOFV/ooxsVP86uIJu2hM5tKojQZlZ4H2L5Trlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7ZbSPhX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7ZbSPhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9D1C32782;
	Thu, 22 Aug 2024 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724347658;
	bh=TWiJ93HyAJ88G0js0Qu5sBOlvCmAqny+80HmOjGUBgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7ZbSPhXCKuat5wa5m3ssacTGsb9R32fPXdGVtGmibM4WFj96ciyCVM5fbxhjKaNA
	 mcOR8rp2o3bBdepLAV9HlpAo4rJrTWGSNuSYW25mKjEZzhKkdjNUGMFvcTTzx+2kSj
	 UovTM8gRRX0ZqrB5cFi430wanYTzkgqHIKHyvExTgLR61IiQvfDFBiF7HcUXcerDqq
	 6SatQL0hhLTWfpX+uQRHkZ5obtIXtitWc5nIJIEJMGs5otVrcY4v+lpnhowNMR30/i
	 nQtG/vqqUkPecvMe+p4hS8qODiaoyAorTIhMRBCeOgdcLxnRuDnB+kNdkiPVv5DWPE
	 TZohJE5eH3FKQ==
Date: Thu, 22 Aug 2024 10:27:38 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <202408221011.82876DA0C4@keescook>
References: <ZsZLFS1CsHkKjw+C@elsanto>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZLFS1CsHkKjw+C@elsanto>

On Wed, Aug 21, 2024 at 02:16:21PM -0600, Gustavo A. R. Silva wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with this, fix the following warning:
> 
> drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index eed579a6c858..ddddc69640be 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -774,11 +774,9 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
>  	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
>  	union hdmi_infoframe infoframe = { 0 };
>  	const u8 rekey = 56; /* binary driver, and tegra, constant */
> +	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
> +	const u8 data_len = 17; /* same length as in DEFINE_RAW_FLEX above. */

To avoid repeating the open-coded "17", this could either be a define:

nv50_hdmi_enable(...)
{
...
#define data_len	17
	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, data_len);
...rest of function...
#undef data_len
}

or an ungainly but compile-time calculated value that exposes some
DEFINE_FLEX internals:

	const u8 data_len = (sizeof(args_u) - sizeof(*args)) / sizeof(*args->data);

(Maybe a helper is needed for that?)

#define STACK_FLEX_COUNT(name, member)	\
	((sizeof(name##_u) = sizeof(*(name))) / sizeof(*(name)->member))

> @@ -815,29 +813,29 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
>  		return;
>  
>  	/* AVI InfoFrame. */
> -	args.infoframe.version = 0;
> -	args.infoframe.head = nv_crtc->index;
> +	args->version = 0;
> +	args->head = nv_crtc->index;

The stack variable (was before and is again) already zero-initialized,
so the "= 0" line shouldn't be needed.

But neither of these comments are show-stoppers, IMO.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
