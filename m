Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C619D07E
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jul 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538889; cv=none; b=okAFQYrFOuFrSq5nn6LSjXjBNZ0cZxEZfm9hc38hnIGfnvAOjLsn0OZxiyrBQ8KSoP9JvXPYsrtQMFC6ir9qj8okYMcGhinAPckHcvBwceZwlmhTW7RkqOl15RNhunmhJVe7S8LrmvBiogxNf9kM26qyb9YMbhjC3cLXorxHu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538889; c=relaxed/simple;
	bh=bmzpuGZtae1sxfRhz5O/nUTK5nTCIQFyLTiHDi+hhK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWLLahwR+6Q+fJS8+m2NjFOtSuFiNgBMv/qyJLPe7j1Y6Lb5/FSZlGcv72TFOt+PmEyrRrY6PSrpaI8HvgwoZ6XQxL5w2BuxebLpE+wQkbIxXNWlBovL+4TjvOo5frYDgX4Cs/KoSfGK8fS6dzjqqkIfyk9oyYtY7lU5xJWPgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yih3vlU/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yih3vlU/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so14437a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jul 2024 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720538886; x=1721143686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oz7iFbPy9x6jKPSlipqwYKyt0mKn37mM+Pcl7G9Qsw=;
        b=yih3vlU/Gjl5BMZbd5bvbxl+dp5h5UpKq2Fp1GHvo5CJiVwGqxuN2rZ4knD81oejbo
         wwpIbRFtV3/8BqN+a5/MZkJ/lZ6hrsJvqbIDJKsnNfZjuLCvPlNSg3aGi3x8lMMgrEbi
         r+deVKEuyuNRNef/6B+fhU/bWXsjFWckcWq26wL5SFqgjEU/u7bsPhaCziE7t5esMN93
         p33wi5QK17oRAOsbiyQfBCb8kMgOZNKt9lKQDehzcJyTjGIbJwc66UA9zPSp+MuCmydS
         Wo/e+lxnZqR1yE6zK3Oop7Urxrpv9BJKbDBeEy3tBenQUQpNM4UUSDOYuv/ppYJVu6aK
         UUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538886; x=1721143686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oz7iFbPy9x6jKPSlipqwYKyt0mKn37mM+Pcl7G9Qsw=;
        b=KIFJ8GKHAvRPnGvKz4BGmNwAIMGKkqjHfNoMWL0ErIgt2r1CVBytyvc1VeGsVBNTlc
         +rVUweFm/MJd1raSxifGM5RBoKmH9VWKwEk1yKLHsHxFLTIBoQEOXylMK278P7CUoFF4
         p46ZzgTFJrcOPn7/obwdtFWDIgQNk1uBpZEnIMdTDqSJzf2QoG0hcH7FZtLtRBzlnKZO
         NS36tMO2sRgNatkO4mguXGGHfKw69G4Xkz2Hreexg3LnPF/PB77QU7MhBSJR7+YPl1og
         uu9e2JHdYWf9+LnhfNOCJQc73/BbHpBbwlabTcryT2+vHsPP4gG35A2+gpTV9kAVuqTM
         TZUA==
X-Forwarded-Encrypted: i=1; AJvYcCXQnZzfklvewtgvGQ0YYzUpL19htjYlCZ/Gf+zz4sVKuoQy+DPdVUG+hTvkvS1xCYwOTgXxI5asyhERkhu69cvM5wGwWUP2O90fdrT1CLoE
X-Gm-Message-State: AOJu0Yz298l2S39Sed6ucE90ORabvuSVsNgRxEhUIpU6+ONqmeMW9hnf
	7048VgZ4dJjFbZvF+9Xj2ZyVrLekg6tn4GLs2HZZ5UCXlHDG8ZTZkNS4pyDhw6x8CwUSbU0YiPS
	wtrBK1UgeNFFNidg2MZhdcNVkvqRmVf6lSwxT
X-Google-Smtp-Source: AGHT+IF8CSkJvGGed5ndBA8XHwTEBAtbw5PQvIIvxORIqaGScYuzTZyQcKM6+zPcofzAMZGxN+ajQBZQkcxwNirf8P8=
X-Received: by 2002:a50:9fc1:0:b0:58b:21f2:74e6 with SMTP id
 4fb4d7f45d1cf-594cf64511dmr259393a12.0.1720538881433; Tue, 09 Jul 2024
 08:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org>
In-Reply-To: <20240709125433.4026177-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jul 2024 08:27:45 -0700
Message-ID: <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:54=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
>
> bloat-o-meter for vmlinux:
>
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
>
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> Changelog:
>
> v2:
>  * Rebased Alexander's patch on top of f750dfe825b90 ("ethtool: provide
>    customized dim profile management").
>  * Removed the ALIGN() of SMP_CACHE_BYTES for sizeof_priv.
>
> v1:
>  * https://lore.kernel.org/netdev/90fd7cd7-72dc-4df6-88ec-fbc8b64735ad@in=
tel.com
>
>  include/linux/netdevice.h | 12 +++++++-----
>  net/core/dev.c            | 30 ++++++------------------------
>  net/core/net-sysfs.c      |  2 +-
>  3 files changed, 14 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 93558645c6d0..f0dd499244d4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2199,10 +2199,10 @@ struct net_device {
>         unsigned short          neigh_priv_len;
>         unsigned short          dev_id;
>         unsigned short          dev_port;
> -       unsigned short          padded;
> +       int                     irq;
> +       u32                     priv_len;
>
>         spinlock_t              addr_list_lock;
> -       int                     irq;
>
>         struct netdev_hw_addr_list      uc;
>         struct netdev_hw_addr_list      mc;
> @@ -2406,7 +2406,10 @@ struct net_device {
>
>         /** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB).=
 */
>         struct dim_irq_moder    *irq_moder;
> -};
> +
> +       u8                      priv[] ____cacheline_aligned
> +                                      __counted_by(priv_len);
> +} ____cacheline_aligned;
>  #define to_net_dev(d) container_of(d, struct net_device, dev)
>
>  /*
> @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct net=
 *net)
>   */
>  static inline void *netdev_priv(const struct net_device *dev)
>  {
> -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIG=
N);
> +       return (void *)dev->priv;

Minor remark : the cast is not needed, but this is fine.

Reviewed-by: Eric Dumazet <edumazet@google.com>

It would be great to get rid of NETDEV_ALIGN eventually.

Thanks.
