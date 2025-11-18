Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7083128A6
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462599; cv=none; b=izlnP/rc8OyeThHtINHF1oyZquA2BPcIkMRhlS9uLQimYMmg1F4J9WYa6BPFaLaYRMfczACSUkxBck1xd/7YKgXY20GHGnmRRVwvMu+hfQkQcjT9mwEFetUoWZ/OPwIF1rUiWVNAsXjhs6918SHKXa0acUt5nmDWgpVpc73jM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462599; c=relaxed/simple;
	bh=cULPnxlYxRor7xb6WgyQHhwhJNX4WNcpyHEJffogcTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtOBMrqHc8O8OzDuXU41s0JyaCvfFTvK31TCwC0m67H7i5EawVMqyHMpZkMW4NRgXGVmdeOvulE+P4OKyu3qj+JM079MkHPON2A+oYOKFpdQ8vJxZ/+GNFuJJH7L4kkFzqBNg/dF8xUl2guV/B2vS7IF3+2m7H3ta/rIDE15vTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tIbzsENs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tIbzsENs"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5957db5bdedso4951338e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763462596; x=1764067396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwxcHbalj/gzROkBRO2ggxWJPQdZjwifoppJYmsJlms=;
        b=tIbzsENsNw9Zgp82R9obzut6M+4f0n28JHe995WJ3dW2Wrop7IAmnJV/wCd8xWBCX5
         ejNdii8uldmlwegnFnjswpXtqEl4heTqbuxlRmW47YuwBaxirhkBpn5qtYfDpod5QA6m
         cK7OXUtjQr/fTWv1vaW3wlRUCLiXH6ksMfY8Zztg0Al0MXbMMUrAW3hHNaIswreAnq4R
         Oh0ZfLTBclzl7gnwrgsOQo+43i/ufWX/knl7k3bc0OM+Z3qLLA2sRkFdFj6rrTBq0Siz
         EwmhT1PmPLCTPOa6ZpoixH1ROa3bjBD24/vH6XJy+ajFOtHVEylu3SgXF2zNXg8UsxnX
         VVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462596; x=1764067396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwxcHbalj/gzROkBRO2ggxWJPQdZjwifoppJYmsJlms=;
        b=u15Wx6Rnd2DO8wYL0mImixPccoRZeecP95qmEl8Oqzz2Oh3myq7CWxY9CYzSru2D1Y
         ht1VjnJCfN8F+7Td5JsT2G7aL35CnBbn4PjutTivmYUxsyt6dpMmeLPzMoJHcC2APZoj
         9vpdKVzD4tq5DbsuL8J+rlGhcr10EuxLb4fdrfzZuzVLBiaRnVV6VZTM5EwVE593sSfW
         Y37uZ2t8gMPxVczGi/uZMB8X5V4+Xt3RRmK1gviQJajVmiVxr2BaAoBr17mvQ3X+TpY4
         I9VViuTKDtnNGEE2gvndztMO/ZCupdDzsSMo7iJtSQFx71F8KP0MhWlN4uNEzP+hRCNJ
         BVdg==
X-Forwarded-Encrypted: i=1; AJvYcCX4X+r+/3H69G/cGu2B2xkMX0nSKIzX0v0tfc0gQbSoPv4RV6vVHw54ghv6DUjAOgvgKBhFUnQYPKIfUw6qEc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF23JnXti0TNCi+1iTE0Q7aWmGxP7l1juOxthyD3PP3SINGdpR
	x5YdXwRlim/NLfAQZskeV3D4vx5lHYV20ovuAFNND4S3AZLBYnGr7j4aBcNwMBvwiapPZCID8BZ
	TPozIU9lG0aTotfMaYJpeIbrQbaRAPr5NpoQBnSG+og==
X-Gm-Gg: ASbGncsfcDi3mgUa66qCGQ6/+mX7536C3n8S4DbS2aKF0WzYoiBYju/0laA/by7zwxn
	X49abswO3NkBZjdka9EW+dYFK9tOKqC+Zzhs1r6ovrt09tNtVkgxIYXs7OaKRLQQ8VMz7dvjOFo
	TvaHIQZugyRcIZaTbKToA3tlBc3A2Y0zVvNmVhhvFiTLrrWTPJLZ9Fvc/PEfmR+o6nuCTETyVMp
	DQSAbcOToX66tC3r8MzvDWO7mO4KI4SGY/tneLhIzORBZDXsnEuKS8Wd7ZIPhg1rnHp7LTPkLiY
	Fvos5ilr1Z3OJRC/dEGmkwC6aJiAc72FUrH2W30Mbq8ejLc=
X-Google-Smtp-Source: AGHT+IGZH7IofUyLRlJZS/Hh18FQf0IVVMolh/6L2ngrs661Xhv2z9sh/hLy/IOJnE9uwousnufpg+YtoTNWfmdH62Q=
X-Received: by 2002:a05:6512:6d3:b0:595:7f64:fb7b with SMTP id
 2adb3069b0e04-595841b89ccmr5130260e87.16.1763462596207; Tue, 18 Nov 2025
 02:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
 <CAHp75VfhQ-pv5J-WAaTz+mRu8Yp4JhB5CxNxDPBMaoaOVJBdXA@mail.gmail.com>
 <CAMRc=MecMJDNA=ry6YnyFxq_EeTDG6hfx2+wg+OTPBfdzXKFeA@mail.gmail.com> <CAHp75Vd962ASEjeiJpv_CcQALK=dayzSQRCN3b5Cyp5GmdjdVw@mail.gmail.com>
In-Reply-To: <CAHp75Vd962ASEjeiJpv_CcQALK=dayzSQRCN3b5Cyp5GmdjdVw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 11:43:03 +0100
X-Gm-Features: AWmQ_bnOYPPuTq6nrG9OdzkHA7AlGNgHpM2or48J9yW8Xp9ORwVzQ-e-E_ITQcA
Message-ID: <CAMRc=MeXQgkO80i3wnC1ogs6U8ZV8FzH13n8emaG63eznwey6g@mail.gmail.com>
Subject: Re: [PATCH 0/2] string: strends() follow-ups
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:32=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 12:14=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Tue, Nov 18, 2025 at 11:09=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Nov 18, 2025 at 12:04=E2=80=AFPM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
>
> ...
>
> > > > A couple follow-up changes to the new strends() string helper. This
> > > > needs to go through the GPIO tree as this is where the strends()
> > > > currently is.
>
> > > For the
> > > strends() I proposed to get rid of strlen() calls by
> > >
> > >   char *p;
> > >
> > >   p =3D strrchr(str, suffix[0[);
> > >   if (!p)
> > >     return false;
> > >
> > >   return strcmp(p, suffix) =3D=3D 0;
> >
> > IMO that's a bit less readable. Unless you benchmark it and show it's
> > faster than the current version, I'd say: let's keep the current
> > implementation.
>
> For the static suffixes the second strlen() becomes a hardcoded value,
> and I expect the benchmark will be closer to the variant I propose.
> Otherwise it will be definitely faster as the strrchr() implies
> partial strlen() and strcmp() is the same or even faster in my case as
> here we don't do the additional calculations with the pointers. Do you
> really need a benchmark for this?
>

Ok, I don't want to load too much string-related stuff into my tree.
I'm adding it to my TODO list for the next release where I already
have an item to replace the OF-specific implementation of suffix
comparator with strends().

Bart
