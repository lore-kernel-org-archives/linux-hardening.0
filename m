Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303D16D4FF
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719495; cv=none; b=BXIeU5d6xuQhhGcHdv4DgGD9gp2DgfaZibmF1SHK0lb3XeHqSR2BBtjgfmUwRZjh9IJgv6liHa7Vnc1+aW4r3m1yu7NQTTMVWWIp13f3LjL/E/Oeh3NgIZpHUXFO95KVcNrfASoUgFQ2Dzm2G2WTHvubOq8Mw9us1NQhEEE+7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719495; c=relaxed/simple;
	bh=5Xgl+EcOjT7f93shPiHRMJ4pO5M75AEYdIGVDYwpN8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlRvjYLCN+JF+S7SIs6q91GRWajPE2Bkb1ZLSIMZsUkE2Nwi4VkYa+Qe4E4fC2clmjuzQ2RzRSd8TSJZpict0y4Zs7EwmBWqKWVP09glRcUTMStEjV6Q/SQx+FNjZ31GENPT5WsouQA5dGLKa7K6YOUwjXKxBzzb/WRl+G1djUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oe9j52uy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oe9j52uy"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso553a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720719492; x=1721324292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmi5HLcqE6fK5ySS3lyqzl4ypWFtv4L42PctvT1OoP0=;
        b=oe9j52uyDrHceb9y99ZhuiWajBBOOb0Vu5p4YsdN8JRq9bMms36Ydg9DebfagfNYFp
         2bb8egBjYqI+xW7EYeBcnd68Br5gRMChOOnv1uqkpO/NzNAN1bdURs9I1Ys8TSpUaFUB
         GK9K/LdgpHQT24rwAzYds0+QH0TmzpcXFL/v7MaLkVVEOTer+y6D3tDqGPyJCuvrEBY8
         XXCOUzLIJGfg8/lRf2OZr7daWAW25E/BcHRFh8ZBjgx0FxsEAfmQUDDc658XqYyVrbzV
         Xk3n+MfAS1xGB9VXYXXzajf/EM9AjqCa/EMP7xGfTCwggDaU48a3latx5Cg8Bu017uWV
         qMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719492; x=1721324292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmi5HLcqE6fK5ySS3lyqzl4ypWFtv4L42PctvT1OoP0=;
        b=tiDmFNCQLVPpHVgKoAuLzZdYAp10gmPb4wsbaUhtZEs1U5OtRbvHhr3IXlgaIuuPUa
         e7T1MRywsl1Z/UTRIYSwgwuDZvgR/EKgddTMwM9elsJS5ZGdm4AX1A+4NXxG4ieBUXBU
         GdM2K1wNe9/mtWqKFF4Tji3GoPBZRewKz6wW9ZTG+ia3Vo+qEVUMU568dK+CL4q/JWWi
         8yHr+FrhhpigTCS2VXA9xdO4X1VSii0rYJGvVsQzJS2x7vb8CdGfloXVpxYpjeuK5Yiy
         ZS+xf3VlKNBYl9unWkH/ARQxWMfXq98aW0ccnk4izGEmsps64WYmFI+p76fEE90B2NAT
         eixQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKJNqiY4xfdZPvKOJmaYFuMRgUIP244+smJF0oe5hzaaai1KPb9HMsgzC62bFRSag0Xvfg7bt9xAt3TwHeEHOWL386xkj/XJUZn6FQbXkM
X-Gm-Message-State: AOJu0YzhO7Cnzuu45QxneBFvsDf+uMRdtXVGsbBxkVWeRKm4OnrdwLCr
	4g3rvAQBCt+sjWfyb2/Jnuw1Kn+35z3COkAxiUMTNQiIksJ9UAGHf/qtHMEL3Xk2gmNyxxurxwb
	0neFTD+PnOSU6BGNCWVwhqlmh2RVDdYeZn9q3
X-Google-Smtp-Source: AGHT+IH7ZVeKGtFW1ffbCmLAUEv4AqAX1Zjzfy/SAWoRHxzSGzNdtgnfN009pJNeMEQH46pIXGbzCkhrPdNrgHUru00=
X-Received: by 2002:a05:6402:51cc:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5997b09fef9mr1782a12.1.1720719492339; Thu, 11 Jul 2024 10:38:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711171652.work.887-kees@kernel.org>
In-Reply-To: <20240711171652.work.887-kees@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 10:38:01 -0700
Message-ID: <CANn89iKqZD68w1QtM3ztL_X290tj_EGyWRvFrhyAz-=T+GkogQ@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: Replace tcp_ca_get_name_by_key()'s strncpy()
 with strscpy()
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] use of strncpy() in tcp_ca_get_name_by_key().
> The only caller passes the results to nla_put_string(), so trailing
> padding is not needed.
>
> Since passing "buffer" decays it to a pointer, the size can't be
> trivially determined by the compiler. ca->name is the same length,
> so strscpy() won't fail (when ca->name is NUL-terminated). Include the
> length explicitly instead of using the 2-argument strscpy().
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/ipv4/tcp_cong.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 28ffcfbeef14..2a303a7cba59 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -203,9 +203,10 @@ char *tcp_ca_get_name_by_key(u32 key, char *buffer)
>
>         rcu_read_lock();
>         ca =3D tcp_ca_find_key(key);
> -       if (ca)
> -               ret =3D strncpy(buffer, ca->name,
> -                             TCP_CA_NAME_MAX);
> +       if (ca) {
> +               strscpy(buffer, ca->name, TCP_CA_NAME_MAX);
> +               ret =3D buffer;
> +       }
>         rcu_read_unlock();
>

Ok, but what about tcp_get_default_congestion_control() ?

Thanks.
