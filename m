Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B538D40A
	for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989982; cv=pass; b=Myns0dJNZ7qYp+bSox0A17pm/L+qn/E9VviTVwqMnI99yFPGPR2b0FZuHj/gGSM+k9uL2+wCaOEJON5RtFI3+MqLevgoFHnW7abTNPAxP3HSBm3N36NjfI4hd5KA60aHeqa5jtXpxCM/BJMwTHGyHr4Q5VDwv9jUxeppZFeS8Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989982; c=relaxed/simple;
	bh=hY2SxOvT9o/Xp4zyoVoyVI3wZEfRvmTSP3mGP0ibUFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQqgATJuPIN7bHFuKXur0lLyUEPEz57ktTukWUpaxGjAIEEpzYQAvaGB+2gm0dU50duXnDEiAw9It5ftrCq6Ds7VNBtqh2YlFjMYThDUpYNPgHDVQ+Zdbk+2Jzj3ER/orw5WI7gVXwP3tJ7vEXUfGO87h0YewOCTMzZ4HRrYTik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJD5nkwb; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJD5nkwb"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so2675809e87.1
        for <linux-hardening@vger.kernel.org>; Mon, 17 Aug 2026 11:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786989978; cv=none;
        d=google.com; s=arc-20260327;
        b=J/oe0gIGG8WFlNkq1cDwxgAePUj5/0CRJQAVVHDuI4yFssa5zQ/ZLQZmWOqDsGMD1k
         6sJUDChJ1pmr0pGugREjlCKpLrA603A56ZQFfgcyO1WOLq3y5U0B9kt5lsCrujZKjlR/
         93jaP9oRO+0Lc86q62qsp3gozM5oyXtycOCVJTJSfQsdBuhug/0e3dgkzOZTRuNeRy3o
         5j/9u6YWhmKDlh3pDHiZdp9mTABchjNd1xFvDM1msp0+9tbfPaL3Yq3nQdMqFAIsGRkC
         ej/ng/rcdrhH2Ffpjyh1w4qUji2XY34z4bEEXoz0OSleEDz0T/9hM8dVy1JJFMkH8Oic
         nzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c7o8fQxkzDHp1SWA8zZhLGLxaxvN0qtBR/ePXDA3zRk=;
        fh=KXac/TxOKcZU4TpB+Aw56f2dcairELsjbRzp+XeFOfg=;
        b=rkqeQtauSgvmmUn5Q7ELos0dAfINbGPsZv2Q9FtKquXzO6gEdfQ3DTMD6aar0nD2dU
         wMDgsqVTymlTWQ+GfsVh5In4RGB/B0TIIYDeGFaRsJCL9EYHUf32mxrp/qcjGj/bjzgk
         g40U7tQ1OoQw1upeGLnjt+/SdZ6Yr9R4HqmHnGTD5Lb/YQd9eM5zpmU2Z+9qqlDpOcP5
         aua29EaSZvHhI91a5p0nUqyKho5R5JZ2C9lWlQsdnvpN9+lfnGBMZ36rdhGNM3mp11Sj
         u4omTSxRuGuDZNv0vd3bJZSg8aE7gLZ2VWNz/JUmOKDUPxTmePo4VIKee256gBNqkLKz
         /mbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989978; x=1787594778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c7o8fQxkzDHp1SWA8zZhLGLxaxvN0qtBR/ePXDA3zRk=;
        b=cJD5nkwb+thIWOIDJwA4hC6GwnESECMsljaAWKJ2CbhJD4sbmTHoofqb8pm7mhrxJZ
         S4is27pBmQe2JdRlYSmz6rYSmmHKqVJGI8fI57Lz4txacKEyeA39PbGSH9wk/1mvQ1HH
         EF9MG9+QljHr9wZzArfi+kOhjsp/dd/ndLwKnByxb47/0ns4tyBgpyb8DQMS4+CGdwK2
         qM3UgoRUhpTczsTyXyTqlBsZSNewt1qgcpMQ4Ge/CNtZqAxGpnA4Y1sno0+lSoG7/dSF
         x1nvy7vskwUR8Bp6f63VROsFInB/ps8V3ttNK1BFXrWGY5pxyzlPF4a0OpNZE0zoHK9/
         XsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989978; x=1787594778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7o8fQxkzDHp1SWA8zZhLGLxaxvN0qtBR/ePXDA3zRk=;
        b=VCDQH/VukcyEwFIUEysf4EOmkv92kjk3omlYZysJS6mZE6SkoqIhiY57St0AfDkkZ0
         jfEk+a9FbKDuZ12Fh3jome3nG2Snc5rnp9CangR5xbhR21kbCm3UyVcvabeP95XLJEwj
         NdRiu38HfNS+5+ztnUnQz4frsNBh6UFtMIRkUsaSITrqJCDwAizF0JofooPH3gUrSv88
         sRB5J7lBTBPWy3bQAi1TS/8/QezqRd3N+Kd1oRQyRwY0iWYFjaULJ/LahWOcWop8A0Or
         41vMWrFvaKwplMNz8GpNQGhzH1DHbnIh/KEZ8Ntg4dZOHkVauYH4ioMplrLiSwTlfeAu
         +mUw==
X-Forwarded-Encrypted: i=1; AHgh+RpCgu+tMdvmLiAHJA4KmlGASNsEqlna7OC+q2pk8FfflYAvp/FVfrtltcnYVX9XzJlLXekoetekbW9QFqhfJrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU4UZ+h/QiptymbeTmUr0KpKX8SmE2S5kIe+6igmDBY5JbxEf
	sPtrL7tCjUyjuX/Me/4X8Z9PRiQwkrHjGUmqvkUvHnynUBvQR8tmQymT0ws8n5C6Az+W883C7in
	Vn5zwQ+a/wWx/vuEZQ6PJk3VecpGIh+E=
X-Gm-Gg: AR+sD10QlHNU0iFrHK80DnXa3ISSIflQ5YnkzZBFIdDOyDz/pO+XqF9EezlKTwj6O6M
	j5xETWcucOV5NjNSMbEobj3UVDTw2pW0jZ/Nvl3EwlZOolF2wscllepcuZZm58ODSnV3da/Up8V
	FrktNCsSKHUEjmNRPjQqLsCGHo6XtM4FOiP8d1ngyp1OjQfJxyxf6qd0hhoxtrlm69GW+7rH5Bi
	oIHBtGro9xKpQjT81hgupN/kyMhf2ccZzz44VHX6ZvSuDxLg/jCNH3hCCpnINfWUAdzArdfdBka
	p7FVAtqMMTEvQx81luauumT1oLJEb43ojy6tPI+MOXiE9jO3q+cLXSA2mFgigWEv2n+hC5sKE2Q
	RCWoy+4UDD5Y9V7/wk8YEMNqoSw==
X-Received: by 2002:a05:6512:39d2:b0:5b2:e890:e6b4 with SMTP id
 2adb3069b0e04-5b4591418c8mr4225069e87.36.1786989977421; Mon, 17 Aug 2026
 11:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <d5df0bb5c312478279f0d2fd5ec6305e41add5ae.1786747084.git.ahmadexp@gmail.com>
 <20260817-invaluable-hog-of-current-b0d0bd@quoll>
In-Reply-To: <20260817-invaluable-hog-of-current-b0d0bd@quoll>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Mon, 17 Aug 2026 11:06:05 -0700
X-Gm-Features: AcwNN1UfcBdidSzggHJjTL7Ud4WaUs0LCKzrRYabM4qhMdfH15u5P0J5gt3C7sw
Message-ID: <CAOQiBWNKJc8BPgmQg3nRBgzXRaQUphfRXJ6JXT5e=z-y15TupQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/7] dt-bindings: leds: Add IS32FL3207 controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending as plain text because the mailing lists rejected the
previous HTML copy.

You are right, I should have explained this explicitly. I dropped your
Reviewed-by because v5 materially changed the binding: it adds the
dash-suffixed multicolor-group form, makes reg optional for that form
so groups can begin at outputs 16 or 17, and documents the
RISET/current-limit relationship.

I did not intend to ask you to repeat the review without explaining
why. I will record this explicitly in the next revision and will not
carry the tag unless you renew it. Sorry for the omission.


On Sun, Aug 16, 2026 at 11:42=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Fri, Aug 14, 2026 at 04:10:49PM -0700, Ahmad Byagowi wrote:
> > The IS32FL3207 is an 18-channel constant-current LED controller with
> > per-output PWM and current scaling.
> >
> > Describe I2C addressing, power and shutdown controls, RISET, and
> > individual or multicolor output groupings. Require board current limits
> > for each output and document their relationship to the RISET-derived fu=
ll
> > scale.
> >
> > Allow dash-suffixed multicolor group names when a group begins at chann=
el
> > 16 or 17, which cannot be represented by the common schema unit-address
> > form.
> >
> > Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
> > ---
> >  .../bindings/leds/issi,is32fl3207.yaml        | 281 ++++++++++++++++++
>
> I do not see any explanation why you dropped review.
>
> We have enough of other patches to review, so if you ask us to do the
> same work twice, it's only fair if we just skip your patches.
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/s=
ubmitting-patches.rst#L577
>
> If a tag was not added on purpose, please state in the patch changelog
> or cover letter why and what changed.
> </form letter>
>
> Best regards,
> Krzysztof
>


--=20
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
