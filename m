Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA316BE26
	for <linux-hardening@vger.kernel.org>; Mon,  5 Aug 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889311; cv=none; b=Y66nJIhgUybVK2zO87pJbkeFMDOJmmjBB83LTfQBc396Ds3a7Y+rpzlwR/u5R1f4sm2wE7bYsp1Z9FiU52yPOdui4nir4jErywGnChizah6S5E/vd3OJtht9Y2U7uc0m2MeDqEwt69Fxib2aTPTpZSaNf7cbRzOt4sSQI597Tlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889311; c=relaxed/simple;
	bh=wHMEn1zFd24Oer0tEUkzcZ1FcJ9lIJ1Vzd9N2/oCrQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIsrroXxfoYXJC9v0qR+lVpy8S01YNdnY9hPDymM3vsPhGnT0sgOP5uszsNYXpWA+VJ7JCy0H1aCue9biuG75aSSqs/86/3k1weU2saIs8AWU4kCWb3nZoQ8IebcBeO2kyCg8QTvvxpypuKRWR5L6Ua5rasSsxNjn3KS90zsTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RW+9PDGA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RW+9PDGA"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so49517a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722889306; x=1723494106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2VtB6mWVBKDX2VzFpUFwlx5syPrh3Cm35/Cbik5opc=;
        b=RW+9PDGAdRntYEsD/yXU25dF1GwjaNHX1t9MvPml8Bn9pz7Mpr70Jmem8lghMqB05R
         DxXJhNG7Fs+11EtNXOhaABWqeT/a2osSlvJLokaXhWDoKXxD4AV9XVwAO42lInSTJ3Xb
         qicH7ORn447IzrkXH+7AEgQKWLunIE171lzyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889306; x=1723494106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2VtB6mWVBKDX2VzFpUFwlx5syPrh3Cm35/Cbik5opc=;
        b=YluIXijSXiS0AqT5sGW/TDI5eVRngoiYy2UChRq1BdznHYHjVMikom22FkhcRaLkAS
         wQPyweLuCATSrUuMrVOz0zv3rKdLaPazqWoS0Y2gDpAC7oIYW4gHjnMVl2SyGfKIKPF3
         jfv3lhvoexJkuOq6uJg2oSBDsNXQAIYdytcGMcAULhek5VKU211VrLawfvGxiE+1ZR+J
         UMThb9CsgzM0p9F6NKzSx9jG8+tJSHD80NUIjYbZb7KfndHE0wiTmoaGQ5nHudnxjIx6
         QhPwHrtF7MIwazk5z66TIgPG4syrqKJk1juJUtBl+bVLVuSRWgSaMDHOnECHvhH6ODjm
         g3dw==
X-Forwarded-Encrypted: i=1; AJvYcCVFJtHGA1B6/Fjv6oRt3+ZIQyZwyRAUpnQhwzes3yWb7txYqGl5vvIou5tzoit+iIC0hJBUG6BdZ/02gyPUmcq+nIjlyumUmdJZoVvDc580
X-Gm-Message-State: AOJu0YwXFOSwjq5udXCnpOsVEcsOKpECZjv7HiWgYdhLBbLQSku5/8k4
	dOmfThi8p+MjskQGrOc7zqr2wni7DtbPWqCxg+y/mAjM+QX0QXRcOhhuPVmuDP4NOukhsEfp3lk
	/1CtQ
X-Google-Smtp-Source: AGHT+IFUyVQ86ctf6UUA44HXFZo0JCwzJkwZDvDVk3XvFT3w/v/kiMbhh+GlbztEDA4DtgCVT/Fe6g==
X-Received: by 2002:a17:907:3f8c:b0:a72:5a8c:87c6 with SMTP id a640c23a62f3a-a7dc4dc1848mr1077570066b.10.1722889306625;
        Mon, 05 Aug 2024 13:21:46 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcb19csm483387066b.42.2024.08.05.13.21.44
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 13:21:44 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e12f6e56so21085e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 13:21:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/WVYMXmXBfziVg+bzJ78ApzSGVP8VXXZN+9iatBLGCz3mDIM8yCzmXxxwuQXfMkZGVBcyR9fWQhBga/QBMhyIPzvLL+rkOp1B1WGWIKxs
X-Received: by 2002:a05:600c:502b:b0:426:66a0:6df6 with SMTP id
 5b1f17b1804b1-428fe266b40mr116535e9.0.1722889303787; Mon, 05 Aug 2024
 13:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck> <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
 <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com>
In-Reply-To: <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 13:21:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
Message-ID: <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Yu Zhao <yuzhao@google.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Stephen Boyd <swboyd@chromium.org>, 
	Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <maz@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 10:26=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> > > > +     /*
> > > > +      * Start with a normal IPI and wait up to one second for othe=
r CPUs to
> > > > +      * stop. We do this first because it gives other processors a=
 chance
> > > > +      * to exit critical sections / drop locks and makes the rest =
of the
> > > > +      * stop process (especially console flush) more robust.
> > > > +      */
> > > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> > >
> > > I realise you've moved this out of crash_smp_send_stop() and it looks
> > > like we inherited the code from x86, but do you know how this seriali=
se
> > > against CPU hotplug operations? I've spent the last 20m looking at th=
e
> > > code and I can't see what prevents other CPUs from coming and going
> > > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
> >
> > I don't think there is anything. ...and it's not just this code
> > either.
>
> I agree -- I noticed this a while ago [1], and I added
> cpus_read_lock/unlock() on the caller side, because having the locks
> inside callees can be a problem for callers who can't sleep.
>
> [1] https://lore.kernel.org/linux-mm/ZnkGps-vQbiynNwP@google.com/

Sounds reasonable. I'm happy to review a patch doing that.


> Also, do the handlers always see `crash_stop` set by the sender? If
> not, would it be a problem? (In the above link, it has to do extra
> work to make sure that handlers eventually see any updated values.)

I _think_ this is OK. It's been a while since I wrote the original
patch but I seem to remember thinking that I didn't need to do
anything special. Tracing through the code again, I see in
gic_ipi_send_mask() the comment:

/*
 * Ensure that stores to Normal memory are visible to the
 * other CPUs before they observe us issuing the IPI.
 */
dmb(ishst);

...so I think that means we're fine, right?
