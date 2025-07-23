Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752326C3A6
	for <linux-hardening@vger.kernel.org>; Wed, 23 Jul 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260232; cv=none; b=iLLSvuk+CN7/HPorPtiJplCFMHvJDW/SSy5GeEWDT1o5cMnaBrYIaKFwydiQ0UkspmpIQuiFdhivFPzKkk9Rl7uvAwAbzA6HsG5dB//dkkKyeoinKNbOTB6FlLxVXqE97bWsIkrDxHGh8JnyMKnJ31VezSxTHg8eKMuN5jeTmYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260232; c=relaxed/simple;
	bh=6TC3UZ1CN3dH5mG1AHfrYHY2reYpGpU4IW7tdQuyJpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQUGDefmAFD/OO4csCQSaxfNG2rJat8G0aM1GVakNp+BUjRsuPuKOBz9VdBBNt9aXO5BsK4LixStM5yDMBW/CS8YrFn3L4Qeo7Hlw+gNEFExXjyCwP1Irc+jwtFzXXSsWL0TLTDFvn86J1RtV05ANzWc7lrxtK3BgIQix3y1uSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q+sheZCQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q+sheZCQ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so58035871fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jul 2025 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753260229; x=1753865029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TC3UZ1CN3dH5mG1AHfrYHY2reYpGpU4IW7tdQuyJpk=;
        b=Q+sheZCQ6hecARGXA5vlJ/+cM/zS8w5QM6SKxxmZVmjqom2JvKJQCdG8LxeL3CkSOy
         jBcOV9GJxxWnwZ2MG87fzzLapF25tGjRwNVzkvseA3nCrFpSU7us1gTwvQyarTDoZLsJ
         DLH0WfzOaqzMlM1myHiznGh/bJWuEeNFttpEyqd6VxZzEh8rvvHMLTces1MaM7YJHOm+
         uRRRYLCTlq99VaFQcZcPYtt0thuV7Kjz20ERDQDDaQJwx+CSkPEsmgpwo03EDI614gI6
         M+HROCRsrxLwXfNYfSxG5xcBdrxUG5NsqYHHt3QT9EHiraaBpNEULnpQlMlXlGVwMIMN
         ERDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260229; x=1753865029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TC3UZ1CN3dH5mG1AHfrYHY2reYpGpU4IW7tdQuyJpk=;
        b=mgUcDzHaj9cG1UPtHXINUXuaoiOI/XGCjGZB/t0iTi9/EzATJDfb1C15sPkl8tR5ol
         xhPDYMM09U/4Cpj81e0EJgtqVjk843itSxX3KCQgD/LSFPT0NY8lTXXbUFDEHdJY9iaO
         I2s/XAu0L1U4CRyaVgYh7KO67DXR7FoCN7sjgmxg37EHJVFy78qVlhr5gTUCIBVJ4phc
         AlY7TRuCwWj+T9NSeZW9RF/py2Xynqu2FLYGT3wX8Z8w+58TbpiR1nk11NP2QVIMVgiU
         /nyAfKB8uR64LtVnuX/sD2z2QhmTpb1N+pTobDu6YKi1AWE4rXlN29UCPHM1UMA4ZKDH
         JJsg==
X-Forwarded-Encrypted: i=1; AJvYcCXwJjNW51s+ExrkBb7YjoUpcqJVZ3LEU5xtacq2EZt+o6ks7hzF1Chj0DgE7srSmBxmjz3faiL1xFStcr9XCSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGCJG6ilwyAsCSMV3+olGUToKDnu8ANvN+dRvgpIeXg802sJJ
	dCSc3H6CuSKpRVw6UJjJ6QLM+NteLbLybxowaKqmP0cyLSngcqV+LaOq9bQ6V6O/xoeT3dFmMnB
	V496HRaltl1Pjyw8ycYKnko1Rlxix8l2FNAmEhqTaRg==
X-Gm-Gg: ASbGncuV9nGXaJpPEOyfSbyf7X5dVZJnsp1z62iVspYSoAust6pnMdFutRPvHH69cun
	WcLUbIVqHFHOAAS1+LhdoDTeNOP4VMoMSplLmiB1nH0Qg08yHCh4NAzBQbE0O5QGOLSpBxW3sNW
	uB/chWF+lAS5wGADoQYu8RVlqofqoSepFjoYvzIkWmEWfmlcXTX7CcMYyf0tidA2Paje5MZF6UN
	mGxXAoY9ta8NTn+RiYbYTj8/GKhB4v2YllN5g==
X-Google-Smtp-Source: AGHT+IHAFBrQohHc/2BHWRgsaNp0FeUIp88x1fnp5TVgXj36+HqgTyzHYQ9aaWJAVlgJBvSW2exqJ6lon2LfY81mcuc=
X-Received: by 2002:a2e:ae18:0:10b0:32b:a9a4:cd01 with SMTP id
 38308e7fff4ca-330dfd1fed3mr4451231fa.29.1753260228769; Wed, 23 Jul 2025
 01:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com>
 <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com> <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
In-Reply-To: <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Jul 2025 10:43:37 +0200
X-Gm-Features: Ac12FXw1wjrtcFNe5Jsgn2117sH2qWPQ_2KZUL5ZF_HLG4DNwY0V5wirW6Lk63M
Message-ID: <CAMRc=MeZ4HHJGkVBysLyusW5G-rM0iSQV1qqmFJUe1rsZrN2AA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Jul 15, 2025 at 3:13=E2=80=AFPM Thomas Richard
> <thomas.richard@bootlin.com> wrote:
> >
> > On 6/25/25 10:26 AM, Bartosz Golaszewski wrote:
> > > On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
> > > <thomas.richard@bootlin.com> wrote:
> > >>
> > >> This is the eighth version of this series. I just added a missing he=
ader
> > >> file in gpio-aggregator driver to fix a build warning reported by a =
kernel
> > >> test robot [1].
> > >>
> > >> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@=
intel.com/
> > >>
> > >> Best Regards,
> > >>
> > >> Thomas
> > >>
> > >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> > >> ---
> > >
> > > This series looks pretty good now, any objections to picking it up? A=
s
> > > usual - I can take the GPIO patches and provide an immutable branch
> > > for Linus to pull.
> >
> > Hi Bartosz,
> >
> > When do you plan to pick the patches? Will it be ok for next merge wind=
ow?
> >
>
> Well, nobody responded to my last email. This is a cross-tree series
> so at least Linus must confirm he's ok.
>
> Bart

Linus, I'm willing to queue at least the GPIO part for v6.17, does the
pinctrl part look good to you?

Bart
