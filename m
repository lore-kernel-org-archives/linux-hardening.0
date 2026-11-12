Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505324;
	b=a8Xu0/l4bzIHkaa/oQ+yRWSNRjkicel72rI1imPVpcrrejiB3gjZqGkr27t9Kr2i/6Ul
	 t3SdU4bwfu3CtfVbrIe+1ab0Axg2pVbtDuxWPuPB6SKPmju0px9fvmz4J4szkCAI6MkwO
	 rS51grJU733dwFb8m+MILMwugrztvKIzekxBiHK+sO4rGMjEEwfNM4PLLesC41jI0Hoxq
	 wsgbJdw1dVq00TH14bKmBseec9ARVfXJdMKVHcU8+M7WCqdyXM6R2Q/d3tFNrLkrcdpH4
	 mGi2WY3nO+rSv3AZglddxIU4OyVIDAbDdHmDOZvPJN0ta2ChUyQSReTiAaD8D4fhcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505324;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J59odrFLjjANLwNFolGOP3Zia626TnXoqhdFI5QxRqY=;
	b=En7KPmIbWa9gvYy2IEo8tI+2mncakUx5gEQlGlKxSd7NmM93mw8Fcl97m3RmWdyjSAtA
	 jYoheZ29+ib6Gvx5s8a4YypF5m3al+sklrt1Yxm4YDanE4w0A5n2fwosZv0iFPL2Yv9Da
	 porCuSPlWsxLzEZXg3e6AC5q4Ckj6O9sxIpgS5DdQMm3y12Eb0yNeJob9XV/LliCxZx1y
	 Zb5sX3XMp1+0c+MACRNRmAsNLMqxjIKHoolfVQsLhtMnQY0/+jAagy40VkaYqZ8Leofxk
	 3hPvmVeXsPDnuCxZxI+ctcnO2a6vLVpstoon9NuHT7usY02KvnxIoghRzpxeM8sm6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mjj/CXab";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBC606CFD3;
	Thu, 12 Nov 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mjj/CXab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED2A1F000C5;
	Thu, 12 Nov 2026 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505324;
	bh=J59odrFLjjANLwNFolGOP3Zia626TnXoqhdFI5QxRqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mjj/CXabPYjuvMnmr9l3z/qKw+asC7/DPMmIIb4xBArs+BJuJBVg2Ne86h9OFXpEo
	 T+ZDF0ac5EWu3tLKl/nD3cSX+NpBAKeCZaSTrO+1b3iA46E6ubrgikBEFXy6Shm4r1
	 z5NbnBKQ3MYuJUo5ArVhG5UKajsWYaPsvVuI+JPGtVE4LWzqRf7VhUJq2kdTwrGRTp
	 7PNOB/EX+Tf1/krteAcmzHXRw6u4/RKyewwUhTngPhfFYKmQZkfLQEtNysJUe8pJ8T
	 4HAqINaHARWIWQ4OEVrjixRRxnIabFiWiVhCaQALhACgs58xLLsAAp9exNsW9ey0aL
	 noFVZCAe/kGkA==
Date: Thu, 12 Nov 2026 09:42:03 -0800
From: Kees Cook <kees@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: nicolas.dufresne@collabora.com, benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de, mchehab@kernel.org,
	hverkuil+cisco@kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, justinstitt@google.com,
	morbo@google.com, david.laight.linux@gmail.com
Subject: Re: [PATCH v2] media: verisilicon: Replace strlcat() with scnprintf()
Message-ID: <202611120937.C289DA9C4D@keescook>
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
 <20261111032446.29803-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111032446.29803-1-nikitash.mariiaw@gmail.com>

On Tue, Nov 10, 2026 at 07:24:46PM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API [1], replace the
> strscpy() and strlcat() calls in hantro_add_func() with a single
> scnprintf() call.
> 
> This preserves the resulting string, including NUL termination
> and truncation behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
> Changes in v2:
> - Replace seq_buf with a single scnprintf() call, as suggested
>   by Hans Verkuil.

Reviewed-by: Kees Cook <kees@kernel.org>

I think the Subject prefix is fine, it matches the prior poking of this
area:

b66215e7b780 ("media: verisilicon: replace snprintf with strscpy+strlcat")

For vfd->name,

	struct video_device {
		...
		        char name[64];

Does this need to be raised?

Because match->compatible is quite large:

struct of_device_id {
...
        char    compatible[128];

The real question remains: how should truncation of vfd->name (by
anything that constructs it) be handled?

-Kees

> 
>  drivers/media/platform/verisilicon/hantro_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 26e5d5547466..d8854ceb4fed 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -902,9 +902,8 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>  	vfd->vfl_dir = VFL_DIR_M2M;
>  	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
>  	vfd->ioctl_ops = &hantro_ioctl_ops;
> -	strscpy(vfd->name, match->compatible, sizeof(vfd->name));
> -	strlcat(vfd->name, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
> -		"-enc" : "-dec", sizeof(vfd->name));
> +	scnprintf(vfd->name, sizeof(vfd->name), "%s%s", match->compatible,
> +		  funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "-enc" : "-dec");
>  
>  	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>  		vpu->encoder = func;
> -- 
> 2.43.0
> 

-- 
Kees Cook
