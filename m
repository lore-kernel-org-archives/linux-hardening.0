Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96C1F12E8
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071742; cv=none; b=iVhwPItZGifY3KTG1h/k7O/Hj4Zkn9rOjkVjvosmaihCxQjzEjGF83GxFwqGDz7PlYe17un4plpeJ5+nG/nSy+qeX3clZ+0yU60VmjeDBKq8/UKj+54CWbcxL/5DhPqIemrYC/71RWoU2ReABC1TCqRu/BYad9qF8XGmbdE+0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071742; c=relaxed/simple;
	bh=KoWJY9zkYepiSQ6LxhxIZJqO/8vuCvngIXkbv4j+zUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4vBLp+mLEpfZ0eloM+ZJC8HOrFb81I30bXIsAoR9YjdVS1wNghqOPdY4R/yM8O6EU4Oh6kz5xZ6EBJPp3dgeKiIxmumYrTrSLeMPNJWPZx7fvrCiXSwIjgdoTFtRxB5aSYG/mNFmOAsj0qlp3hkqN/Mil29l89T4Gy23Idc4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JymZLxyr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JymZLxyr"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7430e27b2so876150866b.3
        for <linux-hardening@vger.kernel.org>; Mon, 03 Mar 2025 23:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741071739; x=1741676539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJaV9m0633U6fIGHEowB7sV4tEsNpRnSQKQBdyR7X9w=;
        b=JymZLxyrWuSmD4WYY209S2EiVb8I5yf+fKoX/t2tn6I8cV4tlYpjRY7g7uEerC84+R
         agXspdj+c3HnU0JS+kThRcI+Fbuwzt7BmMCEExzYB1MP8mhdnDHu5eo635PeWt1bSRJp
         7tRKYBM/KH4xJYQHQKWxVm5VLsAH+ZEqbqU18ZBhtO9XAhznB0QoP2y61rPJHkuObmB0
         RxtmMlKTZPb2Y/7DRAZ1/i81zML26K1XH3B755eWlcdNxWcw2EZvcWwiNytYkcwWFgHT
         +wIWvqpDYHhHC7VM65x0/uUdTLFmOxqqmxClrCM+gxEWUnsqFceLzKGDBj6e/2G/g40G
         fjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071739; x=1741676539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJaV9m0633U6fIGHEowB7sV4tEsNpRnSQKQBdyR7X9w=;
        b=Dmj240QG+9lfxkIUHptaSZG2Wb5FFGmSdZPQqJZfLLioU/FqO1XWbrjd80gGRQ3Ffi
         hLpmJS9hoeoVQKqqwxTkA97WsTbId2GWQ4rcYtej85lqelYl3Sf828nihSo/YgzTNJjH
         4dgoT91KfKcAj+WIaQWvnH/9sZz94iKumgdbMY0dk6JnxrqiO7SO//lr7EnN7/VHQQ7s
         ZFN65II7lGBvgooLW/5bG24KYfSbRgiSUag+0xlaEmod0dFDbFPdX/E5jQnb0Dc0A4l1
         WqO+hnaHfJ5yP40uDDutzZjwrO0SNPoJJ047fi6Wf4M45XzZfkgD8fe8L6E8+Az9QRfJ
         U/1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ06D20HSx0PMrx/Qez7TUhmLeLqYs+Mu6a6lqWKafGjqqmnlSSFQHpaPmvQrQqeR2wopY4WtsbjJdw9WJDGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18KLSEO8HGFGeparvcGTHCVbH2XSh48b66qGrVC8DJf/k5+/o
	VeSACgsVaV9By8wRcA3/QTrrriW5JfgAKx0Ek6AsU0kz4hJFDYLdF0I1QM2Cg75LUz/m6uWZT8S
	9UcSi8jKFlqpwRz5d9TRedRY9tWVbx3MR
X-Gm-Gg: ASbGncsn/kdOlYaJQWAeRUAFlIJMR8sMh1r4rWP+F3nlI4PMpo0CTdApDOQUyQwetIk
	yjbriukLRV/OrecVuJ3lJyUIp9pKAI4FNeTVbJFAF/t1Wx7aC/uV6Sw3Vo3joXZv1JypRxcBZIW
	6aiIKiazxtId5L1QuiG6kaBLWb0w==
X-Google-Smtp-Source: AGHT+IFKPzwdmINVWHep3VVgFw62OffNbIuQz/dg7v/uaeT1WOpSoineGjcjifBLA9J/NUrAIVRQ6oCT+iPz1wIj6ak=
X-Received: by 2002:a17:906:3c09:b0:abf:46cd:5e39 with SMTP id
 a640c23a62f3a-abf46cd6821mr1285699766b.13.1741071739302; Mon, 03 Mar 2025
 23:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
 <CAHp75VdeNoz=QoiMF6hK+eJZH2N7+vUm+1-ovmwGAY5NZ_zTqQ@mail.gmail.com> <87sentnv6u.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sentnv6u.wl-kuninori.morimoto.gx@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Mar 2025 09:01:43 +0200
X-Gm-Features: AQ5f1JrcNUGn5LHPcGle0YzVWPN3ErNOyXPSFq1yWsPYrnafuZSwprx-5l4HhBo
Message-ID: <CAHp75VdJvs-K3jVVuKkisQ0d=3s0bbyNthUKmDa0T58MjnoSNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] lib/string_choices: Add new helpers
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:53=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:

...

> > >         passed     / failed
> > >         succeed    / failed
> > >         success    / failed
> > >         successful / failed
> > >         succeeded  / failed
> > >         worked     / failed
> >
> > It looks like something with the 'successful' / 'succeeded' needs to be
> > present.
> >
> > But in general here is the BIG NOTE: some of the strings may be used
> > in ABI, which must not change them.
>
> It is indeed one of my concern.
> Not only above, but some drivers are using capital letters at the beginni=
ng,
> but helper uses all lowercase...
>
> I agree we should not change string if it was used on dev_info() or somet=
hing.

dev_*() are not the ABI.

> But I think it can be more flexible if it was used on dev_dbg() ? not sur=
e...

All dev_*() and pr_*() and their derivatives may use these helpers
without thinking of any breakages.

On the contrary sysfs nodes, s*printf() when used to prepare strings
to communicate with the user space and so on are all the ABIs. You
need to study case-by-case. That's why I suggest you reduce this
series to just helpers necessary for let say gpio-crystalcove and
gpio-wcove drivers which I can review and ack and that's what will
have all chances to go in this cycle. Then repeat for other helpers,
no need to send tons of helpers with tons of conversion
patches/samples. Do small steps at a time.

That said, I would expect the series out of 3/4 patches
1) add str_in_out() and/or str_input_output();
2) use it in gpio-crystalcove.c
3) use it in gpio-wcove.c

This can be easily combined into an immutable tag/branch and pulled by
the affected subsystems. With your lengthy series it will be ages to
get it in.

> I will indicate it (=3D the strings might be changed) on the patch in Ste=
p2,
> and follow each maintainer / reviewer opinion. Is it OK for you ?
>
> But hmm... I will double check the new helper, some of them might not nee=
ded
> if it was used only on dev_info()...


--=20
With Best Regards,
Andy Shevchenko
