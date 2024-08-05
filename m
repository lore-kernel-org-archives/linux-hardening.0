Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E37155749
	for <linux-hardening@vger.kernel.org>; Mon,  5 Aug 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878813; cv=none; b=Na9QEjHAxtrLJ//7cyWIgy4eOdJvZ46W2ompc1NuVjBx2tEugG1yAnunDPwgK6AvcgCwysmGlrK48QrwgpvZmjMAkdxVVOe7pTunilfXXAD0pE3ouF+873oPeI42EaHAMwcywqjLwpCnbzncGhIZ2Zd3mz3NGhQtuN6BKucyKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878813; c=relaxed/simple;
	bh=BfyVsVHjJKi1F6yfKnpIkO3I1AgI2ybrg5Vki3MTz2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko+AGYWBDSH1mZnzxffK6OTdNlUZ/TH0HGLpJ7cIy//fw2EDC6+K5uPDFWr2JGY/hzmOlkTcqWoGYoqEmj3rRbFCwvD03YyfteRWQTu5W7tjXw9KTFMnj4bkkFgmAigrCFD7f4jFRo8Lk8wBvAXTa2cM3FY6TrWLutQJr3JjS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3QR55WcH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3QR55WcH"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fdc70e695so37881cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722878811; x=1723483611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EglBzbQ3A+v5piBoShAWu2ML7MwXzFUpUqj1zhiTV4=;
        b=3QR55WcH/hqZN7p4ok8s6He9mTMYWCjt5j+VwSxpjc4Yxf3AaL6xVkrgoW6iEC+ndm
         1uY4BjzkcqeUO28clh8LCYiR0ncSy3srUnanBkp2ol1m+27j3xMNJuH3CoXH8F+63vys
         6EQO/FknWcNZfyLyPxUMzel9M6w+/tvSZqis44XXzZyO4vd/EGav7ZquBSeqTp85dGTZ
         W+Jkv/oTFw5YMg0E/FctuSrTR34TvZZmhQpmfJ/wJPD+Wos2nfaYcIOW1v9Hii14MRna
         pDlFzMCZwlJl8WIxGu1FAwJtOHW7zWDvsh5DQ4awO4OIb7fiwer5fnuP4mPFh0pTdFnW
         HGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722878811; x=1723483611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EglBzbQ3A+v5piBoShAWu2ML7MwXzFUpUqj1zhiTV4=;
        b=MYucBvBuRitQkV1nJ1het7juYrQtqDEpsDY/gVtzuX494kLRuvzAE72xqCnvEOGniC
         nQ7AhdwDYEQ2apwbKqC+wVHGd0Iz+ghJFiptJ2+8r+tEulmm01s6Cm7b+KI4Qrs8UX5o
         ZQUoTXygy85oQU85+vRUu8rltW7w2HtomQlcko8ZbYh6PorZRarpssZygKjwxfBELcCB
         60CpxGdxaTqY85HmMD05cdvKppzfGs2asysbBmp5Rys7t+Rvfugjhjonz5yjwXoE0Ksg
         GWkuNmjyxum/TeRyLL6ZZcWjWcZjT1hpBR3/c8Pa9uHojH6NaA+Nic+8s1ZTtlC8qsw6
         9YOA==
X-Forwarded-Encrypted: i=1; AJvYcCUOgAc8DD/5WqgP/Wa65FF1Xtoc9p0KjRjXVnSa4nUHy6TzzqfilKHA8yUk/srZUveNVqFxxe4RS1GOqarKFOWP8IRa69PnoC8rniBtmMHd
X-Gm-Message-State: AOJu0Ywpt2tD++WAP/ENUyc2rsz4wFjwkHjwePCO1wuIg4x5uwkvdF9K
	+YdtvPkSR0LbXMDOMWC1s7Dq9DVnB8l7facUDfNHfZwHtJPKBvc05GGasWKeQ5Nc57rlVO2YPnp
	YkiddRky0xTDp4Go7b/5ysDdz1A82JPKeb//I
X-Google-Smtp-Source: AGHT+IEFwrke/5XyqEuopAYMueXOKOQsZOqTNH2UuzJVD0rnM3YoA4OYyIo7xkwlbNoIwn9d5zRyU5rd7rZaDcCW8SQ=
X-Received: by 2002:a05:622a:5b8f:b0:447:e792:c797 with SMTP id
 d75a77b69052e-4519b665a08mr6323001cf.29.1722878810465; Mon, 05 Aug 2024
 10:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck> <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
In-Reply-To: <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 5 Aug 2024 11:26:12 -0600
Message-ID: <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Doug Anderson <dianders@chromium.org>
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

On Mon, Aug 5, 2024 at 11:13=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Aug 5, 2024 at 9:53=E2=80=AFAM Will Deacon <will@kernel.org> wrot=
e:
> >
> > Hi Doug,
> >
> > On Tue, Jun 25, 2024 at 04:07:22PM -0700, Douglas Anderson wrote:
> > > @@ -1084,79 +1088,87 @@ static inline unsigned int num_other_online_c=
pus(void)
> > >
> > >  void smp_send_stop(void)
> > >  {
> > > +     static unsigned long stop_in_progress;
> > > +     cpumask_t mask;
> > >       unsigned long timeout;
> > >
> > > -     if (num_other_online_cpus()) {
> > > -             cpumask_t mask;
> > > +     /*
> > > +      * If this cpu is the only one alive at this point in time, onl=
ine or
> > > +      * not, there are no stop messages to be sent around, so just b=
ack out.
> > > +      */
> > > +     if (num_other_online_cpus() =3D=3D 0)
> > > +             goto skip_ipi;
> > >
> > > -             cpumask_copy(&mask, cpu_online_mask);
> > > -             cpumask_clear_cpu(smp_processor_id(), &mask);
> > > +     /* Only proceed if this is the first CPU to reach this code */
> > > +     if (test_and_set_bit(0, &stop_in_progress))
> > > +             return;
> > >
> > > -             if (system_state <=3D SYSTEM_RUNNING)
> > > -                     pr_crit("SMP: stopping secondary CPUs\n");
> > > -             smp_cross_call(&mask, IPI_CPU_STOP);
> > > -     }
> > > +     cpumask_copy(&mask, cpu_online_mask);
> > > +     cpumask_clear_cpu(smp_processor_id(), &mask);
> > >
> > > -     /* Wait up to one second for other CPUs to stop */
> > > +     if (system_state <=3D SYSTEM_RUNNING)
> > > +             pr_crit("SMP: stopping secondary CPUs\n");
> > > +
> > > +     /*
> > > +      * Start with a normal IPI and wait up to one second for other =
CPUs to
> > > +      * stop. We do this first because it gives other processors a c=
hance
> > > +      * to exit critical sections / drop locks and makes the rest of=
 the
> > > +      * stop process (especially console flush) more robust.
> > > +      */
> > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> >
> > I realise you've moved this out of crash_smp_send_stop() and it looks
> > like we inherited the code from x86, but do you know how this serialise
> > against CPU hotplug operations? I've spent the last 20m looking at the
> > code and I can't see what prevents other CPUs from coming and going
> > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
>
> I don't think there is anything. ...and it's not just this code
> either.

I agree -- I noticed this a while ago [1], and I added
cpus_read_lock/unlock() on the caller side, because having the locks
inside callees can be a problem for callers who can't sleep.

[1] https://lore.kernel.org/linux-mm/ZnkGps-vQbiynNwP@google.com/

Also, do the handlers always see `crash_stop` set by the sender? If
not, would it be a problem? (In the above link, it has to do extra
work to make sure that handlers eventually see any updated values.)




> It sure looks like nmi_trigger_cpumask_backtrace() has the
> same problem.
>
> I guess maybe in the case of nmi_trigger_cpumask_backtrace() it's not
> such a big deal because:
> 1. If a CPU goes away then we'll just time out
> 2. If a CPU shows up then we'll skip backtracing it, but we were
> sending backtraces at an instant in time anyway.
>
> In the case of smp_send_stop() it's probably fine if a CPU goes away
> because, again, we'll just timeout. ...but if a CPU shows up then
> that's not super ideal. Maybe it doesn't cause problems in practice
> but it does feel like it should be fixed.
>
> -Doug
