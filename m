Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147531690A
	for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740310; cv=none; b=fMIUEgsbbDecsXdQiAmbS35QeA7xGK9YhhGfVi7HPBIbLq5grWrFB8n7SBh77aT+kw0ZY6RIHL/8Gw64+hgxyC5vPhV4nqENulEaUK6+aEAW7nsTD3VC/b+XGkupuPnTwT2UTPIMMoJ7uOaLlDpX805whaLIxjwJVq5N9vl2Oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740310; c=relaxed/simple;
	bh=Tvms9S2u+WWs1aqmeVPw1ZH+QcXa67JBCDgXQqcL1Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgQMQbE3zDlIlwBJ4aYCzBN1sJS+Reipq0eSLSI135ztf91nfm/su3/3Zvxd8HZgxO8CSHdKOeRtH7uQGJcRURUv5F2vvygIK5QGJKdUKEjuCDg6nXrJGt4aeR9IeTmkiJcSGtBlw/rkp08/lhribXvz2ho6mI7Ver5WA/s9vpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nonZE0uV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nonZE0uV"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso129011e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758740307; x=1759345107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvms9S2u+WWs1aqmeVPw1ZH+QcXa67JBCDgXQqcL1Nc=;
        b=nonZE0uVLQny5TOOi+KqIwped2yLEoydhjl/vCnV6UWHVCXFBQtsStcpMjfcSHmYws
         ndawyzrdlnsaFp4fBQZJM1CBnKMv0/qy6aJ9VV2wTAWd3UlrQnQlcHYXtVBgDT3c3eQg
         O19EoSwhA5vvdo/gxkbqulZRyLZC2GpCmDfsmqwAtSRsYNNMT9mZpBw38M1Vw90RX8ch
         MUmoQaU/Rd+WSIdCP04amGm5rSNRySj+N9pYWZ9BN/p61WWNsqfBDq8vTcuLs0h0ycxV
         8E0YIYD6U4psQRPtOX+qP1E4P3YMeSGZz9Cajxk2R3nq2FlpLF3FRcV5W55LbRJipTg/
         ZMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758740307; x=1759345107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvms9S2u+WWs1aqmeVPw1ZH+QcXa67JBCDgXQqcL1Nc=;
        b=D3G5iEGPhP0i1naY8pyAJGcOYGiZMRKU7xgsgF1Q696jBvv6pFRsKXinEJVftks1kt
         O4BAeYBMZN5jdjtSKVofiZTqRrF/jasOou6BpX2Af3nvXQVSLUmGaKg7H3mRfogd6r+S
         prQi2Vgy1hb+a/CBrwYfSYBm5lC87oUgGn1DkkqpY6YteoSnRCLmWmRw7O185Unp9EQv
         KLfvJxSzkx8Yy5LQvbeoncnx9q9oyGH0eamcdngRoSK+6v8BqQp6ZtNNgs8/3f+oxGn4
         eFx3a+yIuAJaYUcKHbWQnOhLsA2NP9gAM1LwjsnUBaqXZr4aQUksQYGy4Ecdca8bgpNf
         RgMA==
X-Forwarded-Encrypted: i=1; AJvYcCXmQr/5tdgL2dOC0sDCU28woTcbNHPx7LybN/bQ2bwp5/JRkgIby2FhsDJ3/ZaYGvYZH3VL2THM1ceNzF+0e9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufgNcMw33dwWZv1gZHZHZhWrqgLieLxkmrcRfTx//+acj9Xj+
	WZZMWWxt5jOrVvJfVSzwPcuRTVFEbIc1sbG1lELPRLPnQPDk7R95+I7o013kslYue/KvfdMzZku
	hyCU6WerklzBpsBedrZKFSRRRMXZ6DIssvJ9n1mE0lQ==
X-Gm-Gg: ASbGnctU4tziOe02oD5iFME/8Rnbqs68TogmcddMdYeRU4v2LhkS++ZCwDkfiFBJsbe
	UvqMi7d/EfsWyaHbV6CjNooECQq/e26/1VPjTkIl5MAzKPwG8CwCOKJoGc2zVVvdkDVgAlL2dgt
	S/xamOEiaVrFok63ZZroUj+s4cMJayQdLe/IwumMfGYgI/mKKy9KApu2OXSgXOogNHa+x/xP0NT
	G98F4Prckr8m87PkpiKzh7mC20iBOsY74qfhLI=
X-Google-Smtp-Source: AGHT+IG80v30cYAxmqw0nWtuIX67T8j0+pyB3RqSVPJrA4Q3f2yx4NJvYOML7KmCJ9NDodn7hTwpeLEpVOpaBNNnZoU=
X-Received: by 2002:a05:6512:1389:b0:55f:572e:2417 with SMTP id
 2adb3069b0e04-582d4442054mr147305e87.56.1758740306748; Wed, 24 Sep 2025
 11:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org> <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
In-Reply-To: <hyzzrjn7jzo3tt3oyg7azijouawe3zopfjzq6zfhoo6e6z2m4t@ssl5vl4g557e>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 20:58:14 +0200
X-Gm-Features: AS18NWB3RTCRDB9znJ75efLzXjjUdrkYJL4LszylIzL1olaMxdJPlHwCWt0jx1k
Message-ID: <CAMRc=McVc2aYFX-DKjtNNNs0eZLcq_jahR+_q3EP1T352XhP+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:25=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Sep 24, 2025 at 04:51:28PM +0200, Bartosz Golaszewski wrote:
> > Here's a functional RFC for improving the handling of shared GPIOs in
> > linux.
> >

[snip]

> >
> > The practical use-case for this are the powerdown GPIOs shared by
> > speakers on Qualcomm db845c platform, however I have also extensively
> > tested it using gpio-virtuser on arm64 qemu with various DT
> > configurations.
>
> How is this different from the existing gpio-backed regulator/supply?
> IMO GPIOs are naturally exclusive-use resources (in cases when you need
> to control them, not simply read their state), and when there is a need
> to share them there are more appropriate abstractions that are built on
> top of GPIOs...
>

I think you have never been on the receiving end of Krzysztof's wrath
when trying to model a simple shared pin as a nonexistent reset
provider or a fixed regulator in device-tree. :)

Unless you mean some other abstractions I am missing.

Bartosz
