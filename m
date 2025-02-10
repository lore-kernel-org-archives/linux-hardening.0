Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC71C07C6
	for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178791; cv=none; b=jUbshl3k/E7Mn+5ro4KD7tlL4YhCkNPg3P3QovPbvttJQfLQxDk9LYJzo8oLcAwExU7SMvs3prwgTB20eHpFn8sli99K6x590BtUMJLeZ18+X8bS6grohfBc6BzW0PtKbkBvLnj49qsn+RzeGSOM7pmPEIWWfT62F9fv+hEUV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178791; c=relaxed/simple;
	bh=X0/PXNOgWGzr20OYVC+mAkplv1xOmw1KN7bZLZtDOzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjEcPSgiSqCk3zrF0wkuOAiYLY3+Wk/+8FjDPAx9g/uAGbMTJI+a7aPCke71/uyOdbXht9xUqrk3xGa8uR1YLeOtI3jFgIAR0/cCiNs1dCmaNiPWdEb5slzZjw+ZTYQcolEr3bMZ5yylyMdpbQ2waE/rpFwJRmlKOJpmEHI1ECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fAbRhpl5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAbRhpl5"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f768e9be1aso42961607b3.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 01:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739178788; x=1739783588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0/PXNOgWGzr20OYVC+mAkplv1xOmw1KN7bZLZtDOzE=;
        b=fAbRhpl5xH6/mhPqhCH1TJ63F+KmyaPrUaXvninCjnE1PQS2j+4xEtFK3dFY3VQi9y
         94qhnwL/eLKsJYbhIwA1vivoVu9fbRyX53wHRu1yIm14nlWwBviPepVN3XXDLYanYsmq
         bh9zrlrQZ5ngVyNTwdsE2pTty9HVHBDODq2kVs+vu2joxeB9+9l828/kKSpK0HeNhuE/
         DCCtUUOsExu7dfSBfOgIc/Y/EYf9Fuk/V0E6Im0eO59Cp/09BaOB0O+fcHDHC5O5ddQZ
         M9LfvZGEuZm1RePNbAozdGWyw8KdGd7DS0XLB607lO+Yr2u2Cw6q1Es3QjnEPc5lmQTL
         wJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739178788; x=1739783588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0/PXNOgWGzr20OYVC+mAkplv1xOmw1KN7bZLZtDOzE=;
        b=i2RTS5Ss66+ziBkTNGHdfZ/NzP2+nvqVN51qHSEkec2PdaKi+8dLLbXxirE56FYUKA
         gklUmubeR/3DlYw1r5Gt34v5wi7LQ5A5FRnuzb02bWIHm5qqeMnRbYHfmcf7nc3HhMVr
         vYmMBz2BCoYDp6C41LY8+5lVPCax9mudjE2qXMG4igUsN5ydiHHlCJ6NByO+R8zaBrLK
         HYEESB12Sy04a4VLjwRpOMXQtQspg6ZkO3IY5tqnpW66NhS65JIjOl8s7TdJnENJtWKk
         XY/aGiS28H3ofDnDjV2bjQ/K56l413fflmO9DR89rCN7okOG+dtGdPuK6q1Yhzpy8Tav
         75qw==
X-Forwarded-Encrypted: i=1; AJvYcCUdQ94Yi6k8VY03O+VxK/rgMYiKOicsOOXGCyEbYh/2FkX6WgtNkg2cw7c1YJY/8fnH31scPYQfW1A8/Ip9JyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxOMbRmzjPKq06lQQo1ZDkrQznwYZHrybwpUzAsvwmVMGC5Oo
	+hoszrN24FMOQswddSjeCdFgWtPkVCt7rxFAD2rFijiwjW5dMGktWGEY3JQ+WAXM9Er1fe4GOcf
	22WZnr9mhNmRL7X/73sd6ujAq1TPFUq4SMO+OWg==
X-Gm-Gg: ASbGnctzhSeLw3uzWem//YWT/y9X+BqIvG4689cKa1fWKdE6TEFKK2UkDeNKBQ2MQ1c
	KFJaPMRyAov2yKph82a2U7+k8LicdXqImiYpGyoApMsckSdUXH1NVN8XLE6MJYoZrxkLzyF85
X-Google-Smtp-Source: AGHT+IH4sdhIuLACrBWvBB25/H/W2wr5Xete97rMTNDwftuaz71XXeB0d2e+IethOrADM/o4py/UCwCnCABGKhL3Ors=
X-Received: by 2002:a05:690c:45c2:b0:6f7:52ba:ecc0 with SMTP id
 00721157ae682-6f99a64afffmr138750697b3.11.1739178788584; Mon, 10 Feb 2025
 01:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203121843.3183991-1-andriy.shevchenko@linux.intel.com> <20250203121843.3183991-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250203121843.3183991-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Feb 2025 10:12:52 +0100
X-Gm-Features: AWEUYZnWdpmJ8wm_BCN0nhuakUPiK-G08A79OENgbUCHTeTHJ5SP5B35rKiAX_A
Message-ID: <CACRpkdb7f6YH3PvZiK=GXx=Jbr-xGUdeZnCOEDsozVociS3F-w@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] gpio: 74x164: Make use of the macros from bits.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Make use of BIT() and GENMASK() where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
