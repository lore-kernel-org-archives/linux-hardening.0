Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E028244693
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593423; cv=none; b=W6jMoaez2lItXIgrhNVHjU/zGOiqU/V8NrlMvF+2HVVF5FqVmLiLkH63jGvHK6eosS+PApbXrTPx9mlziRFa/E9KRf3Hlg5rrUGvLLVggeHzJpF4AMrYBrhZRjizUgDW44iIyd177ozHiAX872rmRPJ+60KKK1mNmvFM9oq0Pn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593423; c=relaxed/simple;
	bh=4NsuCs21FfORtH1DAcJU346wyrSVbDZYpctIUxODfi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7w2IPIeeKH6LlLwd8oCMBImFCn8nrEgNitSZFJ1tWx5ICL8kVZWWTxXk7zMRhshOBN6fP/C9NogSPx7jvTk2O1/IGEjetauYcAvLoHXDO5bCJ7zntTQpTAFlQHxR4gG8x0L/GefYpqjF+adTEyGQTggxnx2tPmXMZwca3etd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zft87NWu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zft87NWu"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32adebb15c5so40510401fa.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749593420; x=1750198220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NsuCs21FfORtH1DAcJU346wyrSVbDZYpctIUxODfi0=;
        b=Zft87NWu+w49oRVtguIABucAm11rvQn344jrUA+7DrmVwTlgLJl07qVH8luEeKONM8
         +JgXFWa8Z+KO6t33jnySZp6c8vH3GeqYm1Xyz/sZneylJWLTniJlnxRVBcsA0b58YeiL
         WpIh5/zfbedvt03dWwMYPelweyi+2Y2qix6osA7hVFXbEsuOAXRtPh9pXW1sb/0W6txL
         AOeR5+wV8W5hFnzPpl6Gmf2cxFzeJ7GzPtPAw5DFfN0gxW8Inok/Sgizaq/SbSZK6ku+
         yXSNK06BYK5m/R2e6uwalnuL70G/c/kf4qLmUMmFd6Pl1wKl8UXhwsCJizUaBuCxgYAn
         Csag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593420; x=1750198220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NsuCs21FfORtH1DAcJU346wyrSVbDZYpctIUxODfi0=;
        b=Y6hZuXf9f91UCFF+t026OW/fzLx784Ib2D/0L4/EX0S0XECZm0nAGzy7ASfjKIUCJm
         hQXTgGvHJJTJlbNUOwOaLCVxyMF/M5N33NMyuvjyR1VOV3pfnhOCiTumsOeP0YaqFINq
         Mjwm1qG+eemfnj4kYu9YlBg64B6R5swEoQtJpn7phAVrrssasRMh+K9CmOxWSl1LmOFr
         O6fVJtHRNldkUBY4cz/lWMCsj+zXArGQGLFIjDPMn/fS8oujVxsTR+xveyYbgWP1oK54
         y1RJOx5yfZCtyRFy/kmA6aS5vrjVsEtvXpAOpCWZ/HoOC9yayIKBeYtzubyWW6TC2Dnw
         PNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGsW/LvFcRgTH63kIzxBYK0EG9//cgXemUz8+ENPGUmZfFEk2lcO/+HANzaZ2qj+EkcR360K3EuzKXhUoWyOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0mJEqGxpr2+8zj2TKw6VKWFkH3NCfnTOW8qphh+qRXg3GcgJ
	FnhKIkwhaiBJsSQI5okMy2p00r0yorPc1iam0CC23skJRUE0ytlDOBGbsXX4UFnQEIDGnHG8XsB
	owzazxl5CRcJPot5cpowR1Rhs34hidwHdT70PzaxvAg==
X-Gm-Gg: ASbGncs9hzGIdpM17HcjAR6jMCWuGt0ffLWnZXpSxO7Nk6JXN85yJRyDIN3uHmS9A2K
	6ccox/7h/il5iacXXNTnCa2op1+KP9y0ZDxY/PkbyuvYzMofRl7eOGa7fQXhabr71XrymOi7yrF
	d8mlcbBIDDPWC+/uiUDAY8qPFrrwJxTnKRthpj9oSdrEE56kAvgqi1/w==
X-Google-Smtp-Source: AGHT+IFXxwww3rRneN2BUjxLNPNhg4yAnXFXP/2lKFW4OFSo8Ks3J3g+tSHPB6GX39sicVQXDwM/c1CXLqu6v3dqFFk=
X-Received: by 2002:a05:651c:1501:b0:32a:864a:46eb with SMTP id
 38308e7fff4ca-32b21926dc7mr2464121fa.0.1749593419575; Tue, 10 Jun 2025
 15:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-aaeon-up-board-pinctrl-support-v7-0-1ab73ec0cb98@bootlin.com>
 <CACRpkdZpn5xy+6yb-mQd6wDs05X0QqRCQo7QpL6=aEWtyU-zTg@mail.gmail.com> <ddbaa399-6bad-4c97-8456-b597442e5be6@bootlin.com>
In-Reply-To: <ddbaa399-6bad-4c97-8456-b597442e5be6@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Jun 2025 00:10:07 +0200
X-Gm-Features: AX0GCFv2Yttg6_a--xuQp4PbwFHmH30QcrKQqT9QjOj8bCT3ACO4rWmYyV62F-Q
Message-ID: <CACRpkdY-6UeRai7AVO0uA_3JGtGNips5C4GtSFgw0SHky3ozcw@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 2:48=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
> On 6/10/25 14:42, Linus Walleij wrote:
> > On Mon, Jun 9, 2025 at 11:51=E2=80=AFAM Thomas Richard
> > <thomas.richard@bootlin.com> wrote:
> >
> >> This is the seventh version of this series. Only few changes, the seri=
es has
> >> been rebased on v6.16-rc1, the pinctrl patches were dropped as they we=
re
> >> already merged and a fix was added in upboard_pinctrl_dbg_show() to ha=
ndle
> >> the case upboard_pinctrl_pin_get_mode() returns an error.
> >>
> >> Best Regards,
> >>
> >> Thomas
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >
> > Looks good to me, some testbot was complaining about something
> > but certainly we can merge the majority?
>
> The export.h header file is missing in gpio-aggregator.
> I can send a new version today. Or I can send a fix later.
> What do you prefer ?

Just send a v8, it's always easiest.

Yours,
Linus Walleij
