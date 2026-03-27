Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BF410D18
	for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636557; cv=pass; b=XCeSIZ2T0dgrOz7H5ERcb5ti0qNsuLfXe6vXvM1GbNtveuGcqjgcW7xSweKBmHeY6dnqDExN+LBLd9dRyViohlEvcl1W+lz/jmDNL06TP818iby7GvV/vowVubkmiK1E+SMxv4sLpeu93oldcT39IOVx7MsvdIxAD/+9hb34thU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636557; c=relaxed/simple;
	bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6tdvtrqUTBVelbvgP9cdArPveD5UVuNlqbxicc4cf+AjZs2NowHW7o/7/06hrB9cMGIUx54Bv/n4xsi3oHoAycNwqPzwYHUvpK/Amawm5nW46iV3NCw4IkK4PooM5qxf8odOQDLZlN/p7CSlgdmDIt0WV54xjMvX6JAmW+PLmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPryKOpP; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPryKOpP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6611f41eebcso3281157a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 11:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774636554; cv=none;
        d=google.com; s=arc-20240605;
        b=kwHZWqts9YZ9c0H6qy02XSxfScj7cy/ywkYwdMBvw9jYeg1Zmn+2hmcAQ9voGXgx6U
         CRCg8v3y17mubil1PhZYr7NZ4P51/PAu69W3mGOWoJJa/2jr30dTu42u+sRtBIaNgLDA
         5rVPmlx6ev3fYGovKV8PyE6y/UWuFZWkdUJ7yebtq6gXbEKP5Z5Amlfexm7tFVcdJ/2q
         3BiMw6elLbDClPpkkIk2qaTYjUmD10G0BBRuFU5FzXfwmh45IviwiRlsa5RQ4GZshAjN
         f3m5uwRbSbDOAiDCqlI5Cs377R4LGKAwFvvYs4h3CEvFx6TYC1T7OcCbnqfCqqvrLkhj
         Q6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
        fh=vJcVGnFO0Sn6DTnD8MWbWqxgOph9iMyBK0K6FnyvcjY=;
        b=a80F0cI28V0iqigtHqRCWRfOh5sNjDQoJSbcVtbkmFXu5MLLvRPhUE11y2HtOMQUZf
         e9LLz8e7kbDCw4+dDCH4+lADI6dj0xtvVqiWB+UxZw1L2ewoAT667RJ/Kp4y934UBSDy
         FpcG89TqIwXQLKiKT4hQ6SSV8fLUeJUsjS30u+M2IXgeqGAvSJAshOAij9jBsihj6fbx
         VfGtjOd4fHv992AdmKFbuKF2tAIAaAxjxRGwoKSPfnIhcnpMQySTJljod42auD9UuzvN
         nNprpllFUTK/AlUmlXSU2SP5wi76MyudFqcthyO8PFobVF0nAi4sKPFp+XjdEts4QOWM
         LS2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774636554; x=1775241354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
        b=rPryKOpPzY16cdqL+RO7c6Vi8KkMV4fg4uaQ6eLGkQji1YKHG/sdkJKRO4NZZkft6m
         pbH/2gCZQV5J+FNIAcF2BF/Hbg1G0j1wCD+Us9ZalpE6SvHuCOFNDTyd7l8Ba0iRftiR
         3rFP5ISKQdNLtrd1gRBMxxgP+OF2y2ej3wozGmDapjt3GbO76d2O1J46LpWs5HtG7JPo
         DYpr75J+Nx8dk9pfWGySJ9aw2j7BY8ZszouBY54rA0/oYMwL2Yod8/D9TN5kRs8mKPnS
         EOWnP4MuGO1LJD5Gjr4AQPxZfNmOb3RHx5cWR/tQG15Y7ecxzreFLqsGI0P3N2c9xMDP
         OIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636554; x=1775241354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
        b=OkN+mZt5IdWGPOhaBa7FKcqVtr4Cko/o3Fw/m7/UBkRJRYVVrVE+XyilfUbFs358/F
         ZPfaIHmwIiuUzM3QKA8eTgLPqMbJaWsSEO0L64CxL9eoE3OW1IEPAaal4ri8arCTQjJG
         eOczgg/2duncJYzfsA9tfsfgtiTnLUIhEh7T6E4ljSsCduQhJSDL78IMXoWCSTvPoeFW
         zH1zkIdHdn8FJpTbryAX1SXDZmSRZv7fmZs0J1roVq2OwGfRgXuSAnbq72V2T9fuWoMV
         jNmX6ETqzLy+oyMYig08oi2xV8fWJ3uVW1T+v13PlMNxW9/Jm20UrxzGuvM+1EjQW8Zt
         Mt4g==
X-Forwarded-Encrypted: i=1; AJvYcCU+QXpjajOHD2a73EznPqzycwAnUcfXN+6p5f9iaGJfqsmhCx6OwBcss0aWD2bTWPAgUpczGFtSSiOoCHrKq/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4aPtUiiiE9koA8mwYjSy53xOm41fBJy9u/0lDpD0rYtLBh9+
	znD4LuFWuP0oAt6+o99w4mUIlP/rafBTcAWs0iyiqZEm4RUvVFXm6cyyrlhEqjaov0ld1Ymk46V
	Poj75lwLwwPrJTTLP1viRUivf8nLIqBU=
X-Gm-Gg: ATEYQzwEQVUABBRRf/KasyGHKOu+bW2fX54XduuN5W5YY1osc5tDcTOelOMPCWjvu1S
	SYG3CM+46b+u8o2nlEHINo+AnFN/Xp1f9p0mLLeQL+b4wawhSZFKyQKJ3kf/yC6b2H6X6Iplg+L
	hI+tJRHQoPzs/O0NT+Kjs8NL2MDqXOx+0ehWRE//wBvctX6MJ1f+vTLGxeYrzpeCLQMtIt9HtTy
	YqDGkDlE6BsOWS3qg3Ejf/vZnPmBkul5BV8URhgI8SuHGBonMm7QB3DFE2WuTWPLu2Vr4Xw0cgt
	ZBnEbaV7uypG7/U7FIkDFotqL9wGAJuYSTybek4vbGHlJk9LaWSbIUuZUKN0ZXTfgctFz1ih/Tt
	5AtFLuA==
X-Received: by 2002:a05:6402:4494:b0:663:6d0a:6f97 with SMTP id
 4fb4d7f45d1cf-66b28f72394mr2419395a12.27.1774636553813; Fri, 27 Mar 2026
 11:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327030310.8502-1-rosenp@gmail.com> <DHDEWIRRJTP1.58HXGTBGH4A@bootlin.com>
In-Reply-To: <DHDEWIRRJTP1.58HXGTBGH4A@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 27 Mar 2026 11:35:42 -0700
X-Gm-Features: AQROBzBmB0kpJXECWuRS7Ed_1LjUhTq7PZ0stLx1p30txIODqyrw8I4yJhCfQ60
Message-ID: <CAKxU2N-21Zt3+5D5Q=ZjTdS27QtJWOPZZDTiqHGENqjxgCpR3A@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-i2c@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Cosmin Tanislav <demonsingur@gmail.com>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:12=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Rosen,
>
> +Cc Cosmin, Romain
>
> On Fri Mar 27, 2026 at 4:03 AM CET, Rosen Penev wrote:
> > Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> >
> > Add __counted_by to get extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> This is the second version of the previous patch, so the subject line
> should start with "[PATCH v2]". You may try using b4 to automate this, it
> takes over this and many other boring-but-useful details.
Didn't realize that. I searched for attr vs atr in Sent...
>
> Additionally I suspect b4 would have a more complete Cc list, including
> recent contributors to this driver like Cosmin Tanislav and Romain Gantoi=
s
> who might want to review this patch. I'm Cc-ing them this time.
I use ./scripts/get_maintainer.pl --no-git-fallback as it was
requested elsewhere.
>
> > ---
>
> Also a changelog would be nice after the '---' marker, to help reviewers,
> and a link to previous versions. It took a moment to me to realize I had
> already reviewed almost the exact same code.
Will do.
>
> Other than than the patch looks good:
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
