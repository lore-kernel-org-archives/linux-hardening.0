Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8325DD0C
	for <linux-hardening@vger.kernel.org>; Sun, 28 Sep 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759088037; cv=none; b=OH2GIpBw6FXqUeI5zhkzfsNdFqrEHYoBAuiC2dvv3G4meiiz6ekI0pg1plrEOHpOOOso17cl90x9du+PiY21E0646BVsbL8YPbZJw6LrRCjbckHs1Z08K80I8LEUjcpf4rkQt231R2Umz7x/M/e3k1cksVdU23UMtFrmqscRfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759088037; c=relaxed/simple;
	bh=SY2WQpP4TD98VH+yCLub/gCUkYNLxrDYyequyKHzXt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFt0Pg8jP0OibZ7R5bBHQGUnBW3y5PLxBGjTehu/uPjwWLjDeJ6HokYMm0pqC0LJBLoruk6JBVz5u6vXYjWI2b2fCqCsyW20lGt3nafBpnxuiVZlcdw1nZct9+m/MqsHKuKg0fJF6YWbbrMIUxCNPxYQHJSAYo+Rb3MI9hu2rOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1LxD8wj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1LxD8wj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3727611c1bso667015866b.1
        for <linux-hardening@vger.kernel.org>; Sun, 28 Sep 2025 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759088034; x=1759692834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY2WQpP4TD98VH+yCLub/gCUkYNLxrDYyequyKHzXt8=;
        b=d1LxD8wjuw9nLarfwFKOJIFfFvrGgw/E2dsrVP8Ogmy8ygZ/j/KMOFkXJjwLtW00Nu
         0SOY5of7YQDgCmYg4WY7NKJJMIDwREU60O8sVmYJOKp3bXXSxv/vivgMP/20YBfYKrUl
         scdhEIcKARbZhEYOYD8R4gWspC8UlAEvHx6lUwwq4amPKc6xXstwr1cQ5TwuCOcyTJoX
         AiuqL+g41p8m/ugcNONdV0nCWIugc9tzkZM11jCeD7740UynR1Kg2wZoj5Mt+OJoYq/a
         SIEopqgbFvdEDdSBESOfhjXF5TfPDDCW75TQGlmuxbzko0JWe4V7pzGAQ1x4rKlGUezp
         sFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759088034; x=1759692834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY2WQpP4TD98VH+yCLub/gCUkYNLxrDYyequyKHzXt8=;
        b=d86DkChepNh2aSYEuDm5rhlGf0G2w+GYXWQMwtDi8B1RbhEtPduIM8BcpcDeC6JMj+
         GHtLJ/Yaoup5k26ZKH3/DXGSmtGyYirKIIjvgNu3Myc02vG+QF1g+FBtMUtEQ9u9Dn7m
         cyVsTXScLi7bIlSkYSXEe+RPLEoODm7qYNO42j4r4iJcXFGQ6n8KcYt3nkMqtUcc8+kl
         aJ3KNASxcf8XB598q/axTEr3D1R9bKg43ccRQjGoIeTDjn9/HH90ZUnGnyX9uMQJhqit
         nD6CFsqWv1qVwlKatc6vy75Di64fy6/r9NQ5w5Op6jFKrqtojq6nkIGPcFXadUDbK4/A
         /LiA==
X-Forwarded-Encrypted: i=1; AJvYcCUQSFyXWVkDaJbDOT9NU1blKHQpTCo7A2O90iKQZAk1HV+GvB+ZKQ0+ztGMuzLPpoe1LVkzvhNRLXOUfnyZW2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnk9dn3MCz8jOELi/RuIYVy+llMLzes/CqzzVO4dDZHFJtmd8+
	VD+bPgOE2TYumDbUhCbEKtrI3f1fQTo4F1TEvqlA5r5E+7xmJb0/dyoKNRCn0YLPaot3HOtF+rr
	ybzeaVgPyl2Pct2nfNWFlPWJUAY4Xl8dhFg==
X-Gm-Gg: ASbGnctYAA/IPEfzftqRkHuEpMBxhiUPFiVinW42fFLFZGJGSHn2+kOkqX3ZOtKb+UU
	10KI2hwOxdUlm8nlkT6HrO8mQCvZRcaMvcHdJOuXXnhnTCdOtUle+Y7ditkzazzMHvJYADTGFiC
	xUfqOEOpVxcYDr+xQu2WsOsdUDUHQILagShnzGTAFcBmxhb+BwlDQTRYdxAMf4+tVuQjzEl/M52
	V18/HGbuuMaZS7zSg==
X-Google-Smtp-Source: AGHT+IELSeCgCGyqnYFwLjpP9I/QUkSXTi30I9okuHYya2KnsNvX9kEtVC+RW54UOV7fvTUxJOJ9A57qSXR6SnQFGv0=
X-Received: by 2002:a17:906:c145:b0:b07:88ef:fe1a with SMTP id
 a640c23a62f3a-b34ba93ca8amr1820788166b.40.1759088034191; Sun, 28 Sep 2025
 12:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095229.2149740-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250923095229.2149740-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 28 Sep 2025 22:33:18 +0300
X-Gm-Features: AS18NWCwQng2zvXar3j9bvUGzv_wYAqN6A_8i_T4MH41majXCfzU6gFOBz8-dpw
Message-ID: <CAHp75VcEQ_14EY0Fd8GD17K7VBe29VN-bU5OtsFwKfpQHWrnYg@mail.gmail.com>
Subject: Re: [PATCH] lib/string_choices: Add str_assert_deassert() helper
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:52=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add str_assert_deassert() helper to return "assert" or "deassert"
> string literal depending on the boolean argument. Also add the
> inversed variant str_deassert_assert().

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> Note checkpatch complians about adding a new line before the macro
> definition. But this is the existing style in this file. So keeping
> it as is.

It's a checkpatch's problem. It's fine to ignore it in this case.

--=20
With Best Regards,
Andy Shevchenko
