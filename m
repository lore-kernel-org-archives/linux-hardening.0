Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519283DA7E2
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783009; cv=pass; b=Q7DN43br+HBHqno7SpjpIR8RPaJWVWrr3fORI/rzMxYCeQL0YfoRU9kL/i3WMryZBLNekr3iXKbQx9U/DvF2cMquXtvoxNh33Qy3kt9GwvoDsB7+A7lHDQmGgQaZs0S4mx/2APMUu/EOxth1BheqXucOvU9lDm8PXUtM+YYWH9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783009; c=relaxed/simple;
	bh=aiBMmDxUbkczn/Vb9JP5UZM5Zl61RSgtXrA/0C46Sgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skyjwmIebmef5hjpIu7GWKFCbxsRPD9Ylij6tyaKv/y4R4QtU+yQQAhiZNUoeFatcuEnXVXJu+d5dyd4G8GvRLhJg4i4Qb8YK3PtQWG/s7QFXeOv/wrETLVFmSuU6CBQUlFn3/ytYUYbXBb9vh0YrV5Fb1Ohlx0kZqAzKAOQ/CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ownrisk.dk; spf=none smtp.mailfrom=ownrisk.dk; dkim=pass (2048-bit key) header.d=ownrisk-dk.20251104.gappssmtp.com header.i=@ownrisk-dk.20251104.gappssmtp.com header.b=GD6oKj5U; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ownrisk.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ownrisk.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownrisk-dk.20251104.gappssmtp.com header.i=@ownrisk-dk.20251104.gappssmtp.com header.b="GD6oKj5U"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8d18de80b29so9428086d6.1
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 04:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781783006; cv=none;
        d=google.com; s=arc-20240605;
        b=jsvK+PrAYM3a54NRpERS8m2a6xz2TXFiEDam4+lJ/DgdMeytygEd2Em8S8LiK/rwKp
         fLovBxEKDPaepmsSjn/BsMgf1mIGh2CyX7fepi3aOQlEJ5Jr/BaJZM9tmQvDP/D1R7fD
         mdFvoykFF1IDULCCmzV0YQju6eGq8NiKYeAEJCWhUPw/5BpDkAATCMeDQNhzEW/5Jo+8
         3WoElW7zJtlJdjqJNJ8llVRAkM/5pNfTK5g36GGNQcmtrdyS5gFrUpEloQcVSyjeJ1DK
         QL/yioQdlocIbEXnC88b5RuVhBu8hLgTk3jPdfukI5wkvcqSeyGK3rcoLr/HbDVgVIrm
         9b8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fGm6AcqnI1+bNBW3QZHl+Bh51II3lcjM0XYTu8SKeS0=;
        fh=KldsxIrLta+JXN30gjVaBaoaP+SEYhkLRSQ5LiCZCaY=;
        b=T484VJYQ/K4bHvZbKJqFEIt24MrX9noHpfd4h0nDfdvWSqG010sEGSOhjfb6PMhTdH
         DvIR6+DXCw2hOhHamEEIJONCVxZQcrR3JfBjinw1PY3tP5cL14MMVc5Xy6UXhpAlHXny
         3IzCS0NntzN1q2qNvUYzOmCERVu4CyDTzu0GelTL98YaGccADAl1zzypO2MuhCGeFzsn
         9JhTqG3EowCRE2U79/7xxfuCCL1R7qpctJa/G4TIYXRo8+NNtvJicHsL1Rq6mOTjUaKd
         YNczecvblMBD+OgQipyxYO8KQsn/zYy7u9vrt3FvavJdrvqCAyFkrbCySl/HlMj3woIx
         3B7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ownrisk-dk.20251104.gappssmtp.com; s=20251104; t=1781783006; x=1782387806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGm6AcqnI1+bNBW3QZHl+Bh51II3lcjM0XYTu8SKeS0=;
        b=GD6oKj5UGQz0/vISJW4N8ZfulM+f/VNtIgZ04kem/D58fVFCTUAbD2XUG0ffd5ly2O
         +9U7KhtOyXohKD/6zYtmzyeciC/I0B8HXsjxEM0TBzDEIj4cS99M7f6NFeBW7uxdzfSg
         DBo4HLCBwg4KyHWjTgyZ5OrH7/NcMGebHnbUdGC0biu9vxID0Xh9xkWYL/yq/ujyvfkN
         rQIG4MTMt9bk4M3x9AHuRPEmPsJoHqiPhECcVVgc46GW7zayf1o4Q+060Jfb2EagClrh
         tXdVZxQGGjGTQZ0dh51lXWJYkx7e1zlVutNuWT1vLmT14WYKLvVF7g+MEbSISeWB7mdf
         BgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783006; x=1782387806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGm6AcqnI1+bNBW3QZHl+Bh51II3lcjM0XYTu8SKeS0=;
        b=VJDTEVf4EvsBpG28bJ7AY/sSOj9AmILbQaJvKzNdvidFUyjBbC9rhQv5UWiLN3+4Mz
         mZmAGUUP1azFJDa1T3+LS7VmbQf3afszaIrSOl3PpSeh8Nr0Ri19O+zyQJN3rhPqIDFY
         sOSXSEpr3oQ713+Tb5RczmimVzokdZexXI2yiuudpEkid2Ncgy7hmrV4rykg2GJ1xVqJ
         qpOwiPgX14Y4nzXurwhukjiWUZsqcgdtKC2u3epTaz6BJse+DZioABMDN3duGAE6KeVC
         xGl7Q5DMP9EJpXNjtUaxY4zv1SE/I/BbWe9wooQEBjYT42TJyPLCk0GdCb4xydJT8qTu
         GggA==
X-Forwarded-Encrypted: i=1; AFNElJ/zGyuhygy6i4KxZoe6YG7iHDeBIZgYIDON0ZufMCTMYhszGQzMGSqKl8DptYpMNSmgsPxpj/Jxv22+Z2IEJSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaZV8K5w1jFqbTAfL97wrHSUqs2Fh+dNMHCwG/fpYJyJ2U76F
	aTpIu5e7/8WovIgSmmiCrElV/uHUpmtu5DSrVA6hWZKLBvVwk3j0CfwtLtd8fOg/Hk+3CdxFvq9
	SbQWG1PT7BTi21OLPzD87IVhKi6iQb/JeY0iH3hhOSg==
X-Gm-Gg: AfdE7cleMHguqaW+zmY+xyDfYpeVFvwQWscxdoePpwZr0qgDd3CoF8wHqirtl9gM+gE
	ItfN/jMyyfRMwxzTzgjVR9dlS6tKGrhVsjP4OFak/yNLAkkHAWEX2x/UzPDwfd3iX3Mp3U55JQr
	DkqDIzy1WbTqsFe36EjI29ntyPxV7OrK/F/79/RBeSJhiJCvsyKpkhxnjUbENJ7MZzADn57apcU
	n6ivHqbOsp+iGmhOqYXnmliwgbNBqZlnp1W3El4DM9UWBS7q2uQCKSz4ha0edT0oy+01sfcb4cb
	dO0Yyn87XDPK3FxmcUKwLDo8QbxF
X-Received: by 2002:a05:6214:4801:b0:8db:6d7d:b587 with SMTP id
 6a1803df08f44-8dccc14dac9mr52050636d6.11.1781783005874; Thu, 18 Jun 2026
 04:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616100332.1308294-1-i.maximets@ovn.org>
In-Reply-To: <20260616100332.1308294-1-i.maximets@ovn.org>
From: Johan Thomsen <write@ownrisk.dk>
Date: Thu, 18 Jun 2026 13:43:14 +0200
X-Gm-Features: AVVi8Cf3XOkaQmP6GH0ARFvC4rsKf-fMT6mtyJYcQfTm0vSkjjtCI2heDspnweI
Message-ID: <CAKv6aAMTqSo0qSng2Kv4=i6BSvJuUy9KSfeFRYx5JsYuo9=kqQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Johan, if you can test this one in your setup as well, that would
> be great.  Thanks.
>
>  include/net/dst_metadata.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f..f45d1e3163f0 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>         if (!new_md)
>                 return ERR_PTR(-ENOMEM);
>
> -       memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -              sizeof(struct ip_tunnel_info) + md_size);
> +       /* Copy in two stages to keep the __counted_by happy. */
> +       new_md->u.tun_info = md_dst->u.tun_info;
> +       memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
> +              ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
> +
>  #ifdef CONFIG_DST_CACHE
>         /* Unclone the dst cache if there is one */
>         if (new_md->u.tun_info.dst_cache.cache) {

Hi Ilya,

Sure. Just stressed it for 24 hours and - I cannot trigger the bug
with this patch applied.

BR
Johan
