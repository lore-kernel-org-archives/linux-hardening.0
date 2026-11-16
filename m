Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849377;
	b=u5ws+t0HYfah59nTOAsvOjUeYBcfUsddnnL6qCWeDWKNvLs048JoLYZT2mPtSmk5LH0f
	 qWlxuVsXc64mkgbDqSQhsBR86X/unGugoApos/Q9ZpuWetJFAdExntHprYagpt3qWf2Ru
	 jb+Kg6agm5fmP3MB5oSLsF+2jAV1aFcGCH27jhdAloGXWvdcUWDRA6kP6kYk17BDw1YmQ
	 59FtkDH5KLQLX1MOrpK/F6l1ws+xKPli/KbL1H3t3yB22uZAAk2A/VRbZX3t4qUl7vWcG
	 eoH0QtcmE0nCUhKIWEtXqJIHJPcvTHDmWl++ZZlq7SiKzVzjk4BS8vEUkPCFUdKrD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Bd5KkZtIi9hEU9aTOnohsJP4GtQbznYQgq/LOm2c1XM=;
	b=dNzrSwnDH33q0GeyvmJnNgwOZixUnN4J/pa6/RWd+CfzAoQgvyRSgWevZU8X1eSZemS7
	 Y4X6yQABmdi0SO+/TtisTndASlaJgH98EfRFtzqvnIts/eBGJLAKDlelPRzDCdIkBxjvH
	 /HWTYoJCIKxLHOt73pKz98F1Cmr+A8MKJfQdAtP+qA3n6Dv3B2KDkCgf58rRT1RTNPKu4
	 lxzEXq2ir6XcRdvCG0oFYBNu+mGqygCfaAI3+453LHC5RWKoe58XIsATTceheL6OkeDs5
	 BSphADNj5/yt3P3UFmQEHUewjXcbEBpTO6MBGKU464eIZs3zcWib1TqJu6zJu23m0vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HkMSiR+d;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF85606A31C
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 17:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF85606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HkMSiR+d
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc147d86bebso53678a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794849376; x=1795454176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bd5KkZtIi9hEU9aTOnohsJP4GtQbznYQgq/LOm2c1XM=;
        b=HkMSiR+dksGlcwGZWXhn8RdtxqBYdJQtbxVMvbLI96Ikx2BxI3kJdM8SEHvcYMuweq
         Mg3EHEZsItCRb824lZUmdTkkxwc2OpLow4+0NsHeKkxKzP6xOXIY59In7u3SCoBtPfqY
         BJZM4/S1UARezX28Zhx/rN944CAeFFzwvXAXf0YdLsW6fmthJG+3kSv7zhsrNw6xnVr7
         IJsBWKe+bcNa1RisuddA3+9M9p14aEOUNjmYrYHbT3epecNIi+eb132pbV75ve6d780Q
         PSoRo+KCZDtD9ZU+3rUiMM71agE0dNDUtfWgY4kZCgotc3BWLs8iYy3Abq959FUkwprJ
         9vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849376; x=1795454176;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bd5KkZtIi9hEU9aTOnohsJP4GtQbznYQgq/LOm2c1XM=;
        b=qL2PaYvAebW/TFNPoLJYbUqSXK01N09Qk2/GY/gAF5dcZDtU6OXHwA16/zlsKEpmp9
         9on5Uj4J2URv07PtlNkI2FhI02q3rJ70aLbklo2+Hd6/qaFBNZvRoFV+EG1IvtSneh0F
         hVBiHN7RECZNygKN3uwxl4oukVWLey08fuOdylmY+N6x38I/39t7/ca6POx/NRP7+dVU
         lWHU03I7aXc9ZB6m8VoHagEd8pHo1LzIyscTVu/5xRDRiNNaU11zwPmCR26lk8cYmN+K
         TgpI9a3zySv8mPO4tCH3AmFeNIvQRWrPEyMSSIGL6tRRYRk/di6FN08AB0TFg8nXsliR
         B9GA==
X-Forwarded-Encrypted: i=1; AL+hErGnN7wodVPLNxErYo0EfQhr6oTI9nbhX8YZQB6FGkYlj4ygVKpQ2xuoPmYpJgYVpD33cUBSgn33CwqtgQzbTHc=@vger.kernel.org
X-Gm-Message-State: APuU4Z95YLCy3NhpZYIPoBNOBzSZBtFKF8dhu22Hn1205oTUz5CMj0+l
	rL6q4v3iG3unDm2x/oIxEEjs+A+mfh9759pjNWtuRaIlUjDJ6CvlKKt51m/4dlGoNYM=
X-Gm-Gg: AYBFou3QOAH7UTuTg4GJJ/4vNT26RISwZJWkxbT0nqZ8lhK8ev1CLZaRwVfd12mDh7Y
	9Sc4lKkHO4y142OzPy6DXl/YK2/QPOJmp0zctDbK7P89cwLgfmIsOJfE5hukaciBCZHkpMFqzt3
	5q+tUGjAsiE+ucr2lKuT9A1ihqgQ+GT14nNkAUfjCdifK9kGGd4aJRQQZrkYcwwxIvV3uT72TnE
	jZuqvmQYfRZ0BbWmEwyWPXwaY/AKESNTDUdKUZOe2NOLrAq71UKbe7Z4L6vgJQrXj9eCPkN/zEq
	qchM5B5WoRl677JBdpw70S8z7bS8ATEDACuKk2n+j8gHNDgaRPdf9gk72rcDGI3dIW7ZKNl/Hsh
	A4clBhpRgHGS92VmrNiKwjmDvFBJhVnKotzvGcgDVj3OPNUGwdhrYJJBYZbwu3RxSN79FwTFoJn
	XBDWyK8lSu6dDdPbDLnrXAakisqc2Ym7V9PBF3TPldJSZFt+CX5G06szyKXVooMhkwdpuyJ9Oie
	5N+QMU1knMgY9fDyWhkZ5rkb8blhdoMaQYkagTJ+8rYTaObt3v5EBaDD5RUsDWIOmJxaRo/eyxn
	6XFYmTNkjlc07azcc5Z6a1CfI65EtWlC
X-Received: by 2002:a05:6a21:7a46:b0:3de:71c4:a22b with SMTP id adf61e73a8af0-3fd29c153b2mr84093637.1.1794849376336;
        Mon, 16 Nov 2026 09:16:16 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:ea6f:45e1:c614:f10f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a97f9sm3778408b3a.14.2026.11.16.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:16:15 -0800 (PST)
Date: Mon, 16 Nov 2026 11:16:13 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v2 05/11] remoteproc: virtio: report
 VIRTIO_F_ACCESS_PLATFORM when required
Message-ID: <avs6XQpoQmY_MNYx@p14s>
References: <20261102-remoteproc_virtio_map-v2-0-26b300e01c62@valla.it>
 <20261102-remoteproc_virtio_map-v2-5-26b300e01c62@valla.it>
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
In-Reply-To: <20261102-remoteproc_virtio_map-v2-5-26b300e01c62@valla.it>

On Mon, Nov 02, 2026 at 12:26:42AM +0100, Francesco Valla wrote:
> Depending on the driver originating them, data buffers used for virtio
> communication can either:
> 
>   - already be allocated from the coherent memory area that is
>     accessible by the remote processor; this is the case of
>     remoteproc-specific virtio devices, i.e., rpmsg and rproc-serial;
>   - be allocated from generic kmem, and thus not necessarily accessible
>     directly by the remote processor.
> 
> In the second case, the DMA APIs can be exploited to obtain a
> functional communication, since they will take care of cache maintenance
> and - if required - bounce buffering. The VIRTIO_F_ACCESS_PLATFORM
> feature flag can be used for this purpose: with it set, the virtio
> framework will use the aforementioned DMA APIs to map and unmap buffers.
> 
> Bounce buffering will be transparently used in two cases:
> 
>   - if the buffer address supplied by the virtio driver is not suitable
>     for DMA transfers, or
>   - if the reserved memory associated to the vdev is a
>     restricted-dma-pool; in this case, *all* buffers will be bounced to
>     and from this pool.
> 
> With this support in place, any kind of virtio device can be supported
> through the remoteproc-virtio transport, at least from a data exchange
> standpoint.
> 
> Note that remote processors behind an IOMMU need da == pa for the memory
> region(s) the buffers are allocated from.

I'm not sure to understand the da == pa requirement - can you expand more on
that?

> 
> Existing use cases (e.g., rpmsg and virtio-console) are not impacted as
> they are explicitly excluded.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index f1b362158a9c..1496659ddff9 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -280,9 +280,14 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>  	 * All non-remoteproc-specific virtio devices are assumed to be
>  	 * compliant with virtio specifications 1.x; there is no other method
>  	 * to transmit this capability from the remote processor to the host.
> +	 *
> +	 * Virtio devices that are specific for remoteproc usage take care on
> +	 * their own to allocate memory from the device's coherent pool; use
> +	 * the DMA APIs for the others through VIRTIO_F_ACCESS_PLATFORM.
>  	 */
>  	if (!rproc_virtio_rsc_vdev_rproc_specific(rsc))
> -		features |= (1ULL << VIRTIO_F_VERSION_1);
> +		features |= ((1ULL << VIRTIO_F_VERSION_1) |
> +			     (1ULL << VIRTIO_F_ACCESS_PLATFORM));
>  
>  	return features;
>  }
> @@ -312,7 +317,8 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
>  	features = vdev->features;
>  
>  	if (!rproc_virtio_rsc_vdev_rproc_specific(rsc))
> -		features &= ~(1ULL << VIRTIO_F_VERSION_1);
> +		features &= ~((1ULL << VIRTIO_F_VERSION_1) |
> +			      (1ULL << VIRTIO_F_ACCESS_PLATFORM));
>  
>  	if (WARN_ON((u32)vdev->features != features))
>  		return -EINVAL;
> 
> -- 
> 2.56.0
> 
