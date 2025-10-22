Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009134C801
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140416; cv=none; b=PgBqR0THTFB8Lfk4R9Ei5Bk1tzzuhkqif+Ie0x+uoWG9rIc9HHl/IYi6IzAbvTUFALbKCAkEP4IFZbcyTQsuRwf26UYWgLGwsDC6tu3OhJ1mNO8DoIONMnE+E8vtl8MBXriBGe+BLm40ETLDpdgJR6ictUxsyqza5U1hQjQzXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140416; c=relaxed/simple;
	bh=orIYgaMNJClTUKA2Pj42SRVGg9kx4atmkKO79VfJkGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov0QQmaY1Iqi/aM20HLG9bLrWtadqaIwDq/Zy6U0kWX0VdZMShc3c+oLKar/4TvzVpbXn2GUKdiLWEbwI802gGBfXd+tYwqdImNI+dS3x5G4zpsSdKU2An3zcZTGNrJwlCmsAaY+tM0jeNEZr7CxD7UKU41SwGTH2Lf7qu9E4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vrD7MCFR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vrD7MCFR"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-586883eb9fbso8514846e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140412; x=1761745212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Gx1TCR16ehe+RsUpMtumgWDjpXuT38xi+HNgTYzlg=;
        b=vrD7MCFR5TiQfiyQ4b02oUQqocgr2+soVZ1doqOvsLFk21dlz6ansHvxpg/DOmiPM0
         Ts1epqVzsKPTxIZEgTAPG9E2iwlz02J7DaqDODW1db/2njFkQJbarS6Levwn4DB2q6gi
         ohXRYq70x90qVfc11r+1GmB1lxZfg+Ml8RL/1e+MdroVDnsqQDagTA7w4x/luiWwUnb6
         Kb7fsbnaZGMqIEhPMYWYXn3oxcCxsfcUswJGBDLQkWp63WfpuWv1mjLkguanLZJD6xVq
         x7Q3AK/upmP1LgDrkGUPeyKJLmxAtJs6N38B9cckdbfVEdtCoqnHqdg6YYIUcJ+3qH+O
         t6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140412; x=1761745212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9Gx1TCR16ehe+RsUpMtumgWDjpXuT38xi+HNgTYzlg=;
        b=uKpLAP+HhnjQykNStWtHZP4tlgKd3DNwaGBCu/guJ+a8iXke6FnSYCCtY2p3lsbFFl
         /Qmo5Y2t8JZJjKvGymouG0+qEDGDKi1JdhtDBP2cyWcfTnB9rc2AiljdsnQcOd3O3Gcz
         uF2lMVoMAm1yVv8D+TJguV5tl1kscH6s93DwASKEe8mCSYJ7WrJ4/6nyT1pwAp+srDNr
         xUP9obV6OX8SWoMLqUH6ucQDxzFQngSuGVLBsXNzlicW+Pgn22GqbEjuhfBI5NUzWbjS
         XC2bpKerPXvL0xPfxkhGIj7aCT1MjVukc9kKzm5DgHNo+Xw66WMfqfG9GLjWXnWxpiQy
         zV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWik5cQFj+oDSEobnsH4hppQK5fcCRmiUi28+9ucjkvbC2Mv8HDc/U7qzdKWXW6JwarliLYPqr6Y6pWsvXp2E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IIpJ+kjNueDM/yYWYZYzjOwZgiR5tabcS8uYZ0wze48tujou
	rJNgXIi7Vm8/btHMY8XGVieuX/KCwhlRFfISgKSdsLi0EYJvyWvfAe9S2c50VoeJPCHpBz2O+A6
	ql46qIpamDsboaXLw4sWFt5zoQChr5zSgfKIdjatXIg==
X-Gm-Gg: ASbGncvzAaER39m/91loBCaRq2816zShyBqpSPidzCbXXnoGOdq0KaOsVjDXszjWnuL
	/Wb0kGioKGgQcSWaHxTiNLYwPDcaXi15NnH7Oanky30m+F80him8mfKKCc0lqQwzpGXm2n8aOjR
	L9fTRCYgUD0tT9/0Ye+kUURNg/+SjCb191MMMGEB/FljNM7A1nPcLt1KiBAohpe0UJZdD6GnV+8
	ln0y4mu8TAs9aE10gCLsPKVzbhaTe3YmIUIz7wLjp51P3WpS2FnsXR7dLaAE6+6TW0p4MnUi9g/
	oIMHgrb3VJBtpawLN8UcRYjGMI4=
X-Google-Smtp-Source: AGHT+IEKqm8lYyfETbDHoX6GlVAlvBKAEAKibR9/ZUGF9ZkgmvVU7aDY+sPQ7pncE4VQkSkH1+uh5CHDb76NK4aZXko=
X-Received: by 2002:a05:6512:694:b0:57a:1846:df77 with SMTP id
 2adb3069b0e04-591d8550fa0mr6598936e87.40.1761140412394; Wed, 22 Oct 2025
 06:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org> <CAHp75Vewc2OoD7=eoFtrkPrGRuB9ZGT2vu4Z_wdHZUDZ8igUtw@mail.gmail.com>
In-Reply-To: <CAHp75Vewc2OoD7=eoFtrkPrGRuB9ZGT2vu4Z_wdHZUDZ8igUtw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:40:00 +0200
X-Gm-Features: AS18NWC2AFr1HYLKJbD6SJ_gfPPZz3lolA3TRfFJfK8fopnOG8MhqaQPJHZTguM
Message-ID: <CAMRc=Mf_qfFzWqy6ND+YDuXcv5NOYiRTo9QY76V719PqJBMxPA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
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

On Wed, Oct 22, 2025 at 3:34=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 22, 2025 at 4:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > Implement a function for checking if a string ends with a different
> > string and add its kunit test cases.
>
> ...
>
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -562,4 +562,6 @@ static inline bool strstarts(const char *str, const=
 char *prefix)
> >         return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> >  }
> >
> > +bool strends(const char *str, const char *suffix);
>
> Why not static inline as strstarts()?
>

Because it's not a oneliner.

Bartosz
