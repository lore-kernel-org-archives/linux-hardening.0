Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977C16D317
	for <linux-hardening@vger.kernel.org>; Tue,  7 May 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106132; cv=none; b=o1fJlIt21FsDU+24G5JtcmuVahizkOnptBt5dCy3Pu8uOqLMYrqauEaTwJgSZS9CZ/CuDp4JaSwwFQyDosyaERFysSha44KZWuHA93inmSA8kGyl5OpLcvJOLiZF4dlK3BcUuHAws0YmCpI93HTx3y52OIsMKQ+t+YVry0Pl90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106132; c=relaxed/simple;
	bh=WGrDCpLhmXG0OzKkWQlmblE8Fu1o4nkE0xfNOfdBRP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOyJ4gSwMzCsR51lC1ofsRL46vhT6Nek/pbwLCjpHlpJSYADhO9VLkBQExNLKkylBI+5vmvz+N0RdXLADa0RNZxLlCfKbZTHD6oGqDJxwWsWSdp3MbJ1Zxjh8Dttm5LpvH5Rij9dkyKaG3Wi79TfiIByWe2sP0yr95iaYBjeYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3asohX/a; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3asohX/a"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso3023a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106130; x=1715710930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wLflVW04KtJjzrqEX38+Aa3dYvsqD/1sar1AfKslmU=;
        b=3asohX/a0thUx9BdUrMrwqOlVpupyx8q+uiV3ouw6117tGqRUyQ6DAxVAZUj2A/TaG
         cnlJdVpMn816RRAvIQIPe6dw4ASO0sD5lzzWIQ2rwmnLsDC1xVNNPgUgBtzHa7L3X8fo
         uxq4gJJe25yEAtOUgTeps5dBXC+bCk/SQtXnWGYuJkXSQS6GOogzIOr6zkdZLjuBE9/t
         780z+x6aMSoqqE6i4sB/e17biCnPlgFNH5Zx6AnRum9MvR8/HEaMUAJgmd9CV63Y4BRt
         AtyZxAKQi9hL4lrsFAmXVTbDUN8XmxqAs8jISldmI+wv1s5k22EYIMNa+4okIPbwYzOm
         ZYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106130; x=1715710930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wLflVW04KtJjzrqEX38+Aa3dYvsqD/1sar1AfKslmU=;
        b=oWRcmr6q+LW6sHFMeQDzXFly3aeOTQ4M6uAkAoGMVEjNGwJmjepwzBgWWQPQSu+z0J
         7rJtgLmEGozJSF3isruxMhVrM5oV4rLHtfD/UWDPM0LKJZXR1VK4IBww0QDeHm4ww3md
         zDFnoEJMLEK28up/a9JDpWB5yMLngrqUgkbSP0RA4M24jvlPwarn0P29SeQ87cWbjyg9
         99Y1y543EMzn2aBFite9mDP6yZcW3Esn0AJo70DqtWqSP92xv+0UaWOW2F7I/iUvWv3k
         zQrksmytkymfy4b3V+dMASzZr73tkA/E5PXwB5GxyGxpFEjigGO6u03qyG4IHcrPvwMZ
         JGFg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRDikP/AYUGfz/PB1NauDL7d/ZwbS1uq68qnTkVdbrUoPqFqgx/TiIySuu0pGAa6+0SZ2R5LwjdlbFk+REjNTR80E3md+GRsvcIlqSLbX
X-Gm-Message-State: AOJu0YyRQUHCnRNH4gmeU5nTBQdiR+R/UmZLUABQbDVfrbPGWyIp/H97
	LRfCvx0N7M+qiknlBmA9Iemg8hG19DzUpbsBhlH1WGMzFvSf6I0d80jV9tPItXBN/SSD4l9fKQp
	SJdCgqc7q0kzPRB5h4Z2vo6MpIRk/73Kad3EF
X-Google-Smtp-Source: AGHT+IEAUzK+Q2fl59QehpxISiQK+7GwZsujcGUtEEc473hSQ+Nch2fZVwYDMTDd1EXoTB5TtIifc+BmsIe9TrH0kP4=
X-Received: by 2002:aa7:c988:0:b0:572:a23b:1d81 with SMTP id
 4fb4d7f45d1cf-5731ffc8a3amr12072a12.5.1715106129590; Tue, 07 May 2024
 11:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240507123937.15364-1-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 20:21:58 +0200
Message-ID: <CANn89iLANEp-tjkKSawPTmH8DxaSQZ_OoJaAYHjLPkmwGEJ6nw@mail.gmail.com>
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device _properly_
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Simon Horman <horms@kernel.org>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:40=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
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
> ---

...

> -       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFA=
IL);
> -       if (!p)
> +       sizeof_priv =3D ALIGN(sizeof_priv, SMP_CACHE_BYTES);

If we have a __counted_by(priv_len), why do you ALIGN(sizeof_priv,
SMP_CACHE_BYTES) ?

If a driver pretends its private part is 4 bytes, we should get a
warning if 20 bytes are used instead.

You added two ____cacheline_aligned already in net_device already.
