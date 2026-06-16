Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAA42E004
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607209; cv=pass; b=lS6wxlGSF//yIKO3x/1R7XiU1D7i+J/VUCqpkV9M8B68yzHpVd29cgTGqb485lI6dTcJgnS4KEpKeWHQtjdFCV98kOxc1cFGb6Ql/cM5kcHKWSV5zPcFcGLoA4a5EKmufo0mgzIGX5OqAzhvtageOKvGxY/ro9MPX8Wncph9zq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607209; c=relaxed/simple;
	bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd78eZyTUhMdES4COA6tU8KLe+vVpwhmCfby5fR7aTlZF9Kar9AHFXgz4qGD+h7GyFwcYtd8oF1S4xvbQK2VVbQ3pVG1Yd6q7Ne5kiJ1aTN+xCBX9NnQGbnaHdJkfw1diY/X9Bod2u0XlYSITvqMBgWlN1SFkZ0euyXxmBcNATk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZWZ7/Qb; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZWZ7/Qb"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bef8b97655eso824223966b.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 03:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781607207; cv=none;
        d=google.com; s=arc-20240605;
        b=fGJzylFCYOi0RJAYAOl/YYCWPK4mleuQ1mIT3r0/huu95akyRkfUA01625qm7pqmCG
         u1UvR6uIa4X4VtEsdylOqqqO+8wepHGbHKjtmVZTneDO7sD6JYHtuinp0GH+YE4G8voF
         I26ltgTtpf1l4IbDPBwnotjUye528MMH8OVqbzQNlD7DtGT1S1F8RNctogkCrW/iuQn/
         dyMSEsMGWCCT37N2Hsxfs1iuiTs8KFSaSgaEL/3BcMrFArF3SH58fWuY7UWxBV20HYj3
         fkzOh2AgyTuojCpOTOfnu0M47/fwt/+R9bVZm4Of2HBTRXWfCD3ZitmgeixJoZ+CerQE
         /JCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
        fh=TeGQN9JXslUSUewXlwkv+nlQmP8qvn7t+Hjfkck1s34=;
        b=gzCqyV4R+EAuMMhtWO715CwvdG63C2OhaLfBk63Nlje1Q4Lo1MifH/Bk4Pk92OWU9r
         JZyiKBd0D+mvthyP6ewLQrIN9dHOgaQcK21IAvos5bNAwbDil3mUWZ0lgtm/Hw7ioKQv
         rCDATd/UTRaDB+tw9Y2k5STggcGycZOVKH9dHf3WncCuLrolUvW2Lv5fV5fSAQa0FDSn
         Hjt1Cedb4x9WI7wE/DtkvHAQgytSRrYFlHUUBlgGovfmFqOBhhjGDn24m/jNEkXmAVLL
         DQKE1JzZxIal9g7wqSi3q/XCgE4HSH9mk8gyKrOxsBX8PAvJW3OzzW2PRb/AZ1o71f4L
         EAPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607207; x=1782212007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
        b=QZWZ7/Qbu5/wXKAAe7BBWE8TKojhl14Ylh5uCK6xTtqKHldqqq2LvZGeyjX8yzSdEN
         ua1IR2Fyay9Qj4TNSURpztEpThuW4ERYTO2PYRAP1FtTguBtuAVHBr+O09m5gTansP9x
         ++g1tXW40DIPrYV+Qf4W5BclVvy24DbxBBNjNNfjzF/oeF0a3mf/nyH2hytwKAucYaHO
         vi7U4xvdCnH8vNXxX6lhrtSUyAYkQkuBS8RLiu68mkPS2JxB1dO5ez9YjuFPR+K8T7XF
         1g3Facb7HmzvdRSm+v1fQzr3uT8kjD8MRGypRP3ab+x2ga+UJC7kXh95yJlkNBjdnwiP
         zNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607207; x=1782212007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8jfqtDqkFcR2V41hWjXXdTsDb+mE92L2soubvNIyr0=;
        b=mnquiz5TuG85hXbZ2Srfcr1n5Lknn6HeJ40PT7eZ57lgUOv8YuUDQUdNCg8hUIv6is
         KJfVjkK54FP9a2sjIsmID3unfGh7sR3Hfgt+xFyMnEYT+MoJz8oEhX9IxqTt3lv1HHXB
         it6QIidIw8FD4PXWudkzeE5E9CFn6HtXgGqgfIzUoLR6MWb1a08yw4BlL3k4jA/2qWXj
         dpbBNGLwy4tNJlZo9iWVWlulkPGq3mQETSzqOWS++CsR/Nmq4IMjzwd/JEnILNzR0c/G
         t5e+3ZiFtmg36hAl5YTJLrwMe1f9IAtTytoXqQOV6ddeXvM903fy1xfNYnj96j79pRwY
         bqJw==
X-Forwarded-Encrypted: i=1; AFNElJ/t5e3wA9MvX6q2ZtMjk4XRWTWu0o5UlkZui5m+B6T1XjOK0MK5AMvEZn67TWdo9eV5qAKJSZFxoDYzWPawI7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20tjKjPq9WAQ6s6HfTw0PpiGXKVxHcr6IWg3jL/PTHRJUA/Or
	AKSf+Itkz9jSAsJAXFrLLbDLa/RXtlLObl2hY5p8Rx4DbI/JT158gc3xBNiDsZFRhfSvHcUu9R5
	XcxGSup2NTaX/sd0hsFRxDSNXeDbzGxw=
X-Gm-Gg: Acq92OH4BSsdqCnRGfnteWvEwwBgv7VebU+U9DijtqQKhAU1xJTV/Ri96ef2Up7ZzeO
	WmP6/jzRgGyzB5iC+ooSiR/RKnKRi/fDyZMzYOZU9Z2qid1lOnSTUTvdB6rheVkjHywgU5Vivbt
	PmGGmBEcWpRfbNN3DQrh0zNdMEH5UmAV2ywhAy/ty8k29JiibCSWKsUQPM45I/zbL/LAwyVgXwQ
	8fiOhbdnSm5+XYsBkp/XW5Fd0/zObGz0TTDZ+0ZqhRMyqEDP+mtpDHprvKe2XuKYv4NZHKt2EwJ
	17oCRTDhqcyKuxZiOtb0RiNDWfe+8YSYAKCstLTGLqrcU7JWymYU9AK4lNtQnRrvltbZOvzX9IP
	/ri+n86afEEvxv2/7z5gAXSPRbFCiywUyEwHnziWCSBm+P0ahfOSmuFmy03XDcJkU1Nsu
X-Received: by 2002:a17:907:c248:b0:bec:7185:d3d8 with SMTP id
 a640c23a62f3a-c0416f22ac9mr172531466b.6.1781607206622; Tue, 16 Jun 2026
 03:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
 <ajEo5pOp3ElX4cP7@ashevche-desk.local> <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
In-Reply-To: <bguen4zngbwsnoxbis7mfrmo6q3vbccpntfzr6bsiog76kdhvp@3lcygxwlg2kv>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Jun 2026 13:52:50 +0300
X-Gm-Features: AVVi8CcjIgkH8qO2D3eGoKeWXqvaH9stwzT-OUvZz4L2E19OrwgaPU72O6N3ARE
Message-ID: <CAHp75VeBE12U6dELhtxnL7ah4WEmAMVk-jq7vky1ynzdp_SAZw@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] iio: dac: ad5686: read_raw/write_raw: use guard(mutex)()
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, rodrigo.alencar@analog.com, 
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Maxwell Doose <m32285159@gmail.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 1:50=E2=80=AFPM Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> On 16/06/26 13:43, Andy Shevchenko wrote:
> > On Tue, Jun 16, 2026 at 09:21:17AM +0100, Rodrigo Alencar via B4 Relay =
wrote:
> >
> > > Use guarded mutex lock to facilitate code review when adding new
> > > attributes. This will allow for early returns, avoiding error-prone
> > > locking and unlocking in error paths. This also adds missing include
> > > linux/cleanup.h. Gain-control support will allow the scale attribute
> > > to be configurable.
> >
> > What about interrupt handler? You just added yet another mutex lock/unl=
ock
> > there. Perhaps this patch should be done before the previous one?
>
> Can't add the guard(mutex)() in the trigger handler because of the goto.

It might need a refactoring then?

--=20
With Best Regards,
Andy Shevchenko
