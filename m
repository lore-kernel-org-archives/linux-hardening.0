Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC014EC73
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118913; cv=none; b=V6SGT1ktlJ5W2P/9P4mAnjJle7aD0uEjRs1c9cpE4rLy+7uCY6QhoREbEidti4Cw+waWWg87NcXvMiLDp74A+pG03Bma87H5pv2l631zRzlSx/3oHe3CeTCO+f4R7nhNgwUtsNRou/14vcc8gNXaa0U0GzZONx9cDnsVUYKlEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118913; c=relaxed/simple;
	bh=R3jMW8ZmkBtM32pcjgP9kGqpFKjlYsyUvI6+VjdQ3I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwgLdyRD4vs8rvJYMWn+hOBl94pFMSDgiQa6U3sSRTe+uhkviZMf8q/73FRo2V/5b5s6yG/EivF/c/TTX7lxIe4hbfhwl9fyox9rJT1ZpeQ8e97FzwzO/ZbYcBVEL0lyi3Zi2reJJcX7kN336E2U2DFuC1dpHIKJgReMZRuvWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxUDu1K1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxUDu1K1"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so3814294a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773118911; x=1773723711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbT9TM6XMNn8MYcYe10K1UH44o/w1pSutn1XPvv9QwQ=;
        b=IxUDu1K10UrHhmTxmVyKYdjfKnfw8UOzh+O255D5f0ws9UQGsWTOw4wVGJ6LVIJad9
         0NwNPjEtFs7r3ZVDNK6NEIPUTJkX7EF985wGrm6jRY7IfrjLMypVBxdkK55YjIJx/Kpz
         bt8RZMYeY3ROXPWi0h3fgirbQRpqNdwtLqqZizZaTCdZLx/BjG3Jf4OHqNo4AwCCsCJQ
         pEwGwnBsGMFMPXOWs/LwWl2KHsDfnnkkf+DvkmbH8s2YlitsXMxvY4LquI4CoomiFSCz
         6p+cx/iKYmT1vYVVp5SRMWC0SnXOoFn+1L+VwVpEbJbeQmVZzniDzWld1ipDMv6jS7Rw
         N4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773118911; x=1773723711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbT9TM6XMNn8MYcYe10K1UH44o/w1pSutn1XPvv9QwQ=;
        b=iFAm7IG2U79GedPIt22GZ7iF672rEzICfyNcB4eKMiADnvJ5XTWyeMuLjB6ldZgfNY
         AJB8Zg4iu87/CE5KGYS1kY2BVLqUcdb/Sf2ZNb16MvIB15lRZVBPfwnleFPuQK7DeJQE
         aOvuSQ4hBBCG60ofECL4bIajEipp5HZTyc7EEiS+ccqr3ztWJdUYZ7Vo7gdrdB/iEO8d
         gh4I6omRCCrGYFg95Tm4/wZeE7EsW87g9OwWwEUoewCLJJUGHlv0qezDF7QLLJUhu55a
         1tacAo6ptTfoAts60kn+rtZ8yK6xH2s2orcVFvENIwO9r1zc56c+VRNsGU3RoG5/NoRK
         DjDw==
X-Forwarded-Encrypted: i=1; AJvYcCXCvOs8KXeNEpYNXnQ/kHoLVLtw0hMqppAGm+L8R9rpsJJlqV/Y2j7MdjjoLZB3yAxLZqjpQP9kJ7Yv9vMl9/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZC2KmaCNlGscEt+pF1MeXdOMXLCeVwawDAiAWXEtveohVs74
	zEBONGlgf1uKUSygBKtK2fQrlg9/SgKWLHSCKgzPGLArhqS3bqbefTXlIlv1K8ZGYJU=
X-Gm-Gg: ATEYQzxjhbnYwHR7tmq6j8Lj1fCgKy6GCM97DstpwBLJp2ZMkqbS0aOGHq62IagigXf
	RcVqlpKp/eDa/GlPQpOB18ZmBOzH+aJEU346IoqfDkf6qexlY8Xo7P89wK783i3ygBvjxqv62fj
	3TgCGA/SG6VNYzRYzzlH7Q8ZowIiDhOiFkQYzGUSLzMglBxM7MoHfne/WhvhjrJ23i0a3naJMwN
	2jvlbnry4JZ8rrG6sju1yu3fRJFuVXomCLTf/6JjvFral2b/pjgBi2hKgnQzn7aAXFIQ6ed4pQX
	qbE4IgdvDCziqmYRwR4WKVSJeGRC3ifwDDSanBgkUkBTaUd+PNQXrTJdOaB+MGKFJ99/gyMiaCd
	m4bYMwuRXWgiqm5x6HyeBAq3pGczA9rArh4dZZBQxNG3eqvy0Yg3pq3XcFUeG3zl4+2O8Aq0Rxr
	kk6Hi78SjUALiP5Wrd/wfeLDJE
X-Received: by 2002:a17:902:f68a:b0:2ae:7f24:27ec with SMTP id d9443c01a7336-2ae82512971mr142991985ad.47.1773118911306;
        Mon, 09 Mar 2026 22:01:51 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aea3d26565sm11358025ad.2.2026.03.09.22.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 22:01:50 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:31:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, "open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: virtio: remove one kcalloc
Message-ID: <sdcvb4g2d5optcout5f2qvvdvnb2g6o76tlc2dkf5zl7p2mc6j@52ejlit6fnoj>
References: <20260310020057.340550-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310020057.340550-1-rosenp@gmail.com>

On 09-03-26, 19:00, Rosen Penev wrote:
> A flexible array member can be used to combine allocations.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpio/gpio-virtio.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8a..876a34ed739d 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -52,7 +52,6 @@ struct virtio_gpio {
>  	struct virtio_device *vdev;
>  	struct mutex lock; /* Protects virtqueue operation */
>  	struct gpio_chip gc;
> -	struct virtio_gpio_line *lines;
>  	struct virtqueue *request_vq;
>  
>  	/* irq support */
> @@ -60,6 +59,7 @@ struct virtio_gpio {
>  	struct mutex irq_lock; /* Protects irq operation */
>  	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
>  	struct vgpio_irq_line *irq_lines;
> +	struct virtio_gpio_line lines[];

Add a blank line before this to separate this out from irq-support
entries.

>  };
>  
>  static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
> @@ -541,10 +541,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  	u16 ngpio;
>  	int ret, i;
>  
> -	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
> -	if (!vgpio)
> -		return -ENOMEM;
> -
>  	/* Read configuration */
>  	gpio_names_size =
>  		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
> @@ -556,8 +552,8 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  		return -EINVAL;
>  	}
>  
> -	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
> -	if (!vgpio->lines)
> +	vgpio = devm_kzalloc(dev, struct_size(vgpio, lines, ngpio), GFP_KERNEL);
> +	if (!vgpio)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < ngpio; i++) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
