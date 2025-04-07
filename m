Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3127DA73;
	Mon,  7 Apr 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056580; cv=none; b=QZCx3sD4nvam0IsmP5k/dDtPKkshKJMDudZYRZet6rHfm2ri0V3rVAl/5wnpmAapAzpPLq/NY4FOcOTlpYfwsCrzSDTIHlfxWr6KSvnVKxOGKlveLUyYwwLWvqgsWu+dI9OsLxupIV3Hi8NmT7+ZtHkA9DsStpiZklXZSUrjVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056580; c=relaxed/simple;
	bh=fVvN0JHskLdp155gnQ9XeJXY0J+bjgy7+CYP5LtCPwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbu3F3OV4diu6Gh2zTAT/JvcYmLlYPkMDneA1+YbWKc3yozpFFCTkg67mjBpjc9/gSRpgUCOuL9kY8fA4cL9E6vyJfc4WFWxL1cFGj6Q9ILaRc3zYhhLborpLs4gCLX6NYPi57V5F07D7e4yG+ktQiYWyGgSq8HzTsIt2l6pjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzCbJXjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzCbJXjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4AFC4CEDD;
	Mon,  7 Apr 2025 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056579;
	bh=fVvN0JHskLdp155gnQ9XeJXY0J+bjgy7+CYP5LtCPwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzCbJXjEYt1+ZT0h1q9IFlmvBR75GDcWcFoWPZxAoiAJvV7U9GKORrAS6GpcYTw+X
	 HzLeFqGKf5M1fTXn3jH6eBZTt6NfYZA6FbDp5zIuQQTk5w1iEWDoVMKMmtjWSe5igB
	 fGAktUn3XRv2z05aEe2904GwVmUI8OPt6WqYobsOsL7GlzFSuRErJrfQnQ7P9f+S/0
	 9GbowM2YaaBln358C1/vorgVGpxfxZ2HA6bt3hOScvGjRf/fh3jLha0gIl3mEz7Awc
	 cTOj2A5u6Vu8kSyXpLemGt2VMMy+iT7oXrRQmDhrQGnJhOzAv0BtRVvfoo4E80ScLJ
	 zNTHjyALd+OjQ==
Date: Mon, 7 Apr 2025 13:09:36 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <202504071303.BF0B5846@keescook>
References: <Z_ABiwj7hoXR0fJ5@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ABiwj7hoXR0fJ5@kspp>

On Fri, Apr 04, 2025 at 09:58:03AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Adjust heap allocation to account for the flex-array-in-the-middle
> issue, and refactor the rest of the code accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Adjust heap allocation instead of using the DEFINE_RAW_FLEX() helper.
>  - Link: https://lore.kernel.org/lkml/202504041254.6e26LBdj-lkp@intel.com/
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z-7IQcWNePAMQEM0@kspp/
> 
>  drivers/gpu/drm/nouveau/nvif/fifo.c | 35 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
> index a463289962b2..2c887dffa45d 100644
> --- a/drivers/gpu/drm/nouveau/nvif/fifo.c
> +++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
> @@ -25,33 +25,34 @@ static int
>  nvif_fifo_runlists(struct nvif_device *device)
>  {
>  	struct nvif_object *object = &device->object;
> -	struct {
> -		struct nv_device_info_v1 m;
> -		struct {
> -			struct nv_device_info_v1_data runlists;
> -			struct nv_device_info_v1_data runlist[64];
> -		} v;
> -	} *a;
> +	struct nv_device_info_v1_data *runlists;
> +	struct nv_device_info_v1_data *runlist;
> +	struct nv_device_info_v1 *a;
> +	const u8 runlist_cnt = 64;
>  	int ret, i;
>  
>  	if (device->runlist)
>  		return 0;
>  
> -	if (!(a = kmalloc(sizeof(*a), GFP_KERNEL)))
> +	a = kmalloc(struct_size(a, data, runlist_cnt + 1), GFP_KERNEL);

Hrm, a pre-existing issue, but this is dumping quite a few uninitialized
bytes into this allocation, as struct nv_device_info_v1::pad is never
initialized and runlists->data is never initialized. It looks like these
bytes are being written out to the video card? Or some kind of ioctl?

This should really be using kzalloc() or making sure stuff isn't
uninitialized.

> +	if (!a)
>  		return -ENOMEM;
> -	a->m.version = 1;
> -	a->m.count = sizeof(a->v) / sizeof(a->v.runlists);
> -	a->v.runlists.mthd = NV_DEVICE_HOST_RUNLISTS;
> -	for (i = 0; i < ARRAY_SIZE(a->v.runlist); i++) {
> -		a->v.runlist[i].mthd = NV_DEVICE_HOST_RUNLIST_ENGINES;
> -		a->v.runlist[i].data = i;
> +
> +	runlists = &a->data[0];
> +	runlist = &a->data[1];
> +	a->version = 1;
> +	a->count = runlist_cnt + 1;

Seems struct nv_device_info_v1::count is the counted_by for struct
nv_device_info_v1::data?

> +	runlists->mthd = NV_DEVICE_HOST_RUNLISTS;
> +	for (i = 0; i < runlist_cnt; i++) {
> +		runlist[i].mthd = NV_DEVICE_HOST_RUNLIST_ENGINES;
> +		runlist[i].data = i;
>  	}
>  
>  	ret = nvif_object_mthd(object, NV_DEVICE_V0_INFO, a, sizeof(*a));
>  	if (ret)
>  		goto done;
>  
> -	device->runlists = fls64(a->v.runlists.data);
> +	device->runlists = fls64(runlists->data);

I assume nvif_object_mthd() writes runlists->data?

>  	device->runlist = kcalloc(device->runlists, sizeof(*device->runlist),
>  				  GFP_KERNEL);
>  	if (!device->runlist) {
> @@ -60,8 +61,8 @@ nvif_fifo_runlists(struct nvif_device *device)
>  	}
>  
>  	for (i = 0; i < device->runlists; i++) {
> -		if (a->v.runlist[i].mthd != NV_DEVICE_INFO_INVALID)
> -			device->runlist[i].engines = a->v.runlist[i].data;
> +		if (runlist[i].mthd != NV_DEVICE_INFO_INVALID)
> +			device->runlist[i].engines = runlist[i].data;
>  	}
>  
>  done:
> -- 
> 2.43.0
> 

-- 
Kees Cook
