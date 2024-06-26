Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAC18F2E4
	for <linux-hardening@vger.kernel.org>; Wed, 26 Jun 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424676; cv=none; b=SDjI4Dks9V2L1B90Pi4otjEXZ/J7OfGd7oaBRI0oO7oXsTO81xbvlE5UqnCNNT2CaHwlPA4gN28W4UNeXJJCQudQMQnKsHK4Nn0qkDUg3+zLnX7Q53ZQ8toDi/6k/PRPHlbnGSFcT3cDbM0Z8uJkkZNHvJCu2Uwz/IIiORBn+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424676; c=relaxed/simple;
	bh=GRLet1qjrsvDiaV72VUTVaZ6eScvIFbXauwCQRj1Y68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVoxiuyJ9h6X3rQeDA3SR/wkCUI9kFJb+fprr9kptL5NRa01vj1XjAoIpoCF9t/xCj5mTnCfQWCMQe4/22YZ/SYoPS4DM1nsszFF5ew9UdWpgkE6JyCpGeR4403v1aBWifGrFmFjhT8XNQtAtbo5ZQWxIwFbmJJ51TP0CXAjbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpSmLHgW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpSmLHgW"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so1108a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jun 2024 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719424673; x=1720029473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSFQ2ozCArK1ziItdEkmdcayjgVf9KTRCGgo8jhFr/k=;
        b=vpSmLHgWGq9zrvndGzPlMa+CS8f33b7seVnYxMba8auxE1voZzUu8mq5Xr/yKulDkF
         ElZ1XkNZPOxQmUtBnK+iJe5qYggYCZQCiSPSkcs3tayAXrfzSrzKGV8bNr7ubGTToBaU
         KFXKcDhUQQc2hpkQZ0FkhVFkEtOvpNf2smJ8XfABfNkjTgkpqvUMYOoVRIu1tEaiLT1r
         2BmhMk7Kb0VcUtaQMzltGQnl3TR3KqATfxPqwg6PXCFpuQJJk76L+cY+lrK/bWoAYqbD
         0yLy48ZLGRY0tfgiuduPCOvpM7UMkWz14L77jlE2VvN8kPL3GLZng3nsFo1l5sTk7kB0
         PiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424673; x=1720029473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSFQ2ozCArK1ziItdEkmdcayjgVf9KTRCGgo8jhFr/k=;
        b=VIFOD3EslXYaylBeiABSkP6MOkGj23eEbpxKslGsPNKrFn4mmUpdfkgF2WIs4tAjUH
         ua3SAhj1dILU8eWx3sprdxl9xTAJzqB2H72e4/Mc0wtMEcPF9Kgqogs05UvqKTA39sLh
         sskrGvBgTAccF3eTnUNci4P8/Aq7v21oU5t8YA/FSXqAR7CfhWRpLhOJwOLcXtvxHdBs
         gl2+h9akKcmJn9VocaA6dpcbiFIb17UTsSwPlYgRUYIoNO+WlQcjPqTZqYsreLJNiBAT
         kigCf1V2vNFZZm3o4KW/QzKS8RiWadhCMXTrNUd95ZxJFtcV9+YUcd7ykjX+E2NTm9uo
         K4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV9sQbq3jrRVHymX+hP70nswmVl0icraxsFpU7W0XK95lHqQWXNYMJMZtu9kRFesKTrguNI9GYomWuh5OkLYDX15TgwNs5zFJPqnDfuoEAE
X-Gm-Message-State: AOJu0YyIeNNlDkO3PDPiBi8spXBSo6sXS0jKA1Y9Yh/OQ6a3DgoGdlWq
	ZLdCgXHyy+wGtPvMtlJeVtI56InVjzfz727fQad7vi2/J1vypvFT2dKhXhVF6PJG6UU15fcoxNq
	YKZYr+CYMr2hQrqAPnzla9hCDnCsWfifxb5Hn
X-Google-Smtp-Source: AGHT+IFWQnamYHefze2gwXZm3NQ8xOadIGfCiBlU7f/NM5b4HVS6E8Z/ZHPCaXaMHlsKP1NM4gKiCHmuRGzW40kqlMI=
X-Received: by 2002:a05:6402:26d4:b0:57c:b3c3:32bb with SMTP id
 4fb4d7f45d1cf-5848cd67ad5mr21382a12.1.1719424672957; Wed, 26 Jun 2024
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-omap-usb-tll-counted_by-v1-0-77797834bb9a@gmail.com> <20240620-omap-usb-tll-counted_by-v1-2-77797834bb9a@gmail.com>
In-Reply-To: <20240620-omap-usb-tll-counted_by-v1-2-77797834bb9a@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Jun 2024 19:57:16 +0200
Message-ID: <CAG48ez0KCkoTm=0sDQJveG7nujA=CQApXFy2chwjizt8L02B+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: omap-usb-tll: use struct_size to allocate tll
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Ladislav Michl <ladis@linux-mips.org>, Roger Quadros <rogerq@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:23=E2=80=AFPM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Use the struct_size macro to calculate the size of the tll, which
> includes a trailing flexible array.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> ---
> The memory allocation used to be carried out in two steps:
>
> tll =3D devm_kzalloc(dev, sizeof(struct usbtll_omap), GFP_KERNEL);
> tll->ch_clk =3D devm_kzalloc(dev, sizeof(struct clk *) * tll->nch,
>                            GFP_KERNEL);
>
> Until commit 16c2004d9e4d ("mfd: omap-usb-tll: Allocate driver data at on=
ce")
> turned that into the current allocation:
>
> tll =3D devm_kzalloc(dev, sizeof(*tll) + sizeof(tll->ch_clk[nch]),
>                    GFP_KERNEL);
>
> That has surprised me at first glance because I would have expected
> sizeof(tll->ch_clk[nch]) to return the size of a single pointer, not
> being equivalent to 'sizeof(struct clk *) * nch'.
>
> I might be missing/misunderstanding something here because the commit
> is not new, and the error should be noticeable. Moreover, I don't have
> real hardware to test it. Hence why I didn't mark this patch as a fix.
>
> I would be pleased to get feedback about this (why it is right as it is,
> or if that is actually a bug).

I might be a good idea to ask the people who wrote / accepted the
patch that seems to have introduced the bug? I've CC'ed them.

The kernel slab allocator enforces a minimum alignment of
KMALLOC_MIN_SIZE, which on MIPS seems to be based on the size of L1
cache lines or something like that? This allocator alignment might be
enough to prevent the bug from actually causing an observable effect
in many configurations - that could explain why it went undetected,
assuming that nobody tested this in a KASAN build.



> ---
>  drivers/mfd/omap-usb-tll.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index a091e5b0f21d..5f25ac514ff2 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -230,8 +230,7 @@ static int usbtll_omap_probe(struct platform_device *=
pdev)
>                 break;
>         }
>
> -       tll =3D devm_kzalloc(dev, sizeof(*tll) + sizeof(tll->ch_clk[nch])=
,
> -                          GFP_KERNEL);
> +       tll =3D devm_kzalloc(dev, struct_size(tll, ch_clk, nch), GFP_KERN=
EL);
>         if (!tll) {
>                 pm_runtime_put_sync(dev);
>                 pm_runtime_disable(dev);
>
> --
> 2.40.1
>
>
