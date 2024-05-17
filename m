Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED465F
	for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976133; cv=none; b=GxENYZY62i8bQz/2mTDorEJD94bgXU0AUYjqAIxbuqGqT/++Oe8V922KFXig5/tDhLpimaiGFDpfAwm0NFi/b1oiI0+oxt/Mq2vIqyTc9ZgcT9Oph0veJ9aOW2t2C5IXIcfMqZjFEWoWt0XALKTMfFhlbc+kaA5gyaz8ZXBcSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976133; c=relaxed/simple;
	bh=DcLykhJMcIDe6aDsyWYaRV67CNAtmB+1qJjDiOrFBUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XodbZIqxf79l+zqGDRwb8bf6Esx8Cs+wfx5LZuaP87mlwg10nHkpYWhDsZGgCHCBONiiOnyy0GqmMrPOBYj9fQRwiOI+v8YI6BtAgjHDMPp998vFf7QFAuHMeNWNuuvuKfYb8hViT7ua+NHcBo/iGTIoMtQPe2SHRynbPgFEoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eyEOmq4F; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyEOmq4F"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b5a87505cso5217426d6.2
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715976129; x=1716580929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI1RNJPjqCg8PPMHmPp0pCN9b95JX+day8N+NzvHcvM=;
        b=eyEOmq4FAvAUa7h96fDWUq7x68Hexe25ClCHqUMbqLO5syHafQ5kolGBdNEdPMpUaQ
         seE0n5Q0Wh/0EjEF9Cz1zIOJ10KF2JRtnX4RTW3Fk9Y16s+bnKdHz4irNlHvMw1HPoGz
         1Dv5gWDi0S2JIb9Eu/8QgbgXkv8jNJfsY+zW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715976129; x=1716580929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI1RNJPjqCg8PPMHmPp0pCN9b95JX+day8N+NzvHcvM=;
        b=Rnu5kt7P6E21wi11dNkeZESDwqkp/EdRbAdTNbFlbrB1lIH/3Hge8Wzf0gPxBblMQO
         ViWOVO+irMTUdDFG/oH/oseOsZ8nfigH8r1zYk44HpnvSOYdquC3cXa+zC3Mom+m8yMf
         15NT93XLopYhgb4V6LShI9+IkZQbh01jpoBuMcWMJluslQtV0AL3Y+KV588O9PKzrF3h
         7uZ0ZafyJFf+vfHwuFfzNq+pSm3wn6d+m2QLNBHvsDsuEPO4s7UTrNGAmeSrjGn0Caq/
         0PW7Z5LtN42kw9q851/hP6ez7CNXUR9454Jnc2L1bXPb6leWM67Rha+2+sD7+EI7avAo
         +Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCUHbAG0DG92IlPgrxoluMfI9N/PCwXeV15X8HeP2ZIjteAcr7/ecRZEJaEBtxelPme4/9RZxZgQyNHf0S27lKubHSutoWve3w52Ib2YUiwn
X-Gm-Message-State: AOJu0Yy69CN0egWnjbaEFkScLtc+5id69KXVnnb+yEiflW5c5x9uSIdS
	2SXcM2Y4cgD/fPzadV9soPorNGLv6e2nf6FA8OiKstL/nePbLsaXLIPo5dhwy6jB2zABctH0J7Q
	=
X-Google-Smtp-Source: AGHT+IGaoEH2BzPxwsoWTROuZG70h1TLeWzjlCeAy8/scIAQ+OW8HrPnSCllVBcoijvfMVk4l/f8Mg==
X-Received: by 2002:a05:6214:3b87:b0:6a3:5639:9409 with SMTP id 6a1803df08f44-6a356399495mr99194556d6.4.1715976129153;
        Fri, 17 May 2024 13:02:09 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a32f54e985sm63921346d6.95.2024.05.17.13.02.07
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 13:02:07 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43dfa9a98d2so3921cf.1
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 13:02:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSZdGQcYuMsQCt0KYlMQxVNi1e3eY8HVUmAenm3EiimOnfFMkr/4GqoFzCdHVQcO9rGXqokTlrdyx3gpGqitVZ3Xp4mHwoqCkeY76O4nLp
X-Received: by 2002:a05:622a:488e:b0:43d:fd4c:2ec7 with SMTP id
 d75a77b69052e-43f796ee600mr579861cf.8.1715976126793; Fri, 17 May 2024
 13:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240412135513.GA28004@willie-the-truck>
In-Reply-To: <20240412135513.GA28004@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 May 2024 13:01:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8-E-9Qhzdp1L_3g_P_fGmYVUh6zDoFMb7=pzN+cHg=A@mail.gmail.com>
Message-ID: <CAD=FV=X8-E-9Qhzdp1L_3g_P_fGmYVUh6zDoFMb7=pzN+cHg=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Misono Tomohiro <misono.tomohiro@fujitsu.com>, 
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2024 at 6:55=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> I'm doing some inbox Spring cleaning!

No worries. I got your reply while I was on a bunch of business travel
and finally cleared stuff out enough to take a look again. ;-)


> On Thu, Dec 07, 2023 at 05:02:56PM -0800, Douglas Anderson wrote:
> > When testing hard lockup handling on my sc7180-trogdor-lazor device
> > with pseudo-NMI enabled, with serial console enabled and with kgdb
> > disabled, I found that the stack crawls printed to the serial console
> > ended up as a jumbled mess. After rebooting, the pstore-based console
> > looked fine though. Also, enabling kgdb to trap the panic made the
> > console look fine and avoided the mess.
> >
> > After a bit of tracking down, I came to the conclusion that this was
> > what was happening:
> > 1. The panic path was stopping all other CPUs with
> >    panic_other_cpus_shutdown().
> > 2. At least one of those other CPUs was in the middle of printing to
> >    the serial console and holding the console port's lock, which is
> >    grabbed with "irqsave". ...but since we were stopping with an NMI
> >    we didn't care about the "irqsave" and interrupted anyway.
> > 3. Since we stopped the CPU while it was holding the lock it would
> >    never release it.
> > 4. All future calls to output to the console would end up failing to
> >    get the lock in qcom_geni_serial_console_write(). This isn't
> >    _totally_ unexpected at panic time but it's a code path that's not
> >    well tested, hard to get right, and apparently doesn't work
> >    terribly well on the Qualcomm geni serial driver.
> >
> > It would probably be a reasonable idea to try to make the Qualcomm
> > geni serial driver work better, but also it's nice not to get into
> > this situation in the first place.
> >
> > Taking a page from what x86 appears to do in native_stop_other_cpus(),
> > let's do this:
> > 1. First, we'll try to stop other CPUs with a normal IPI and wait a
> >    second. This gives them a chance to leave critical sections.
> > 2. If CPUs fail to stop then we'll retry with an NMI, but give a much
> >    lower timeout since there's no good reason for a CPU not to react
> >    quickly to a NMI.
> >
> > This works well and avoids the corrupted console and (presumably)
> > could help avoid other similar issues.
> >
> > In order to do this, we need to do a little re-organization of our
> > IPIs since we don't have any more free IDs. We'll do what was
> > suggested in previous conversations and combine "stop" and "crash
> > stop". That frees up an IPI so now we can have a "stop" and "stop
> > NMI".
> >
> > In order to do this we also need a slight change in the way we keep
> > track of which CPUs still need to be stopped. We need to know
> > specifically which CPUs haven't stopped yet when we fall back to NMI
> > but in the "crash stop" case the "cpu_online_mask" isn't updated as
> > CPUs go down. This is why that code path had an atomic of the number
> > of CPUs left. We'll solve this by making the cpumask into a
> > global. This has a potential memory implication--with NR_CPUs =3D 4096
> > this is 4096/8 =3D 512 bytes of globals. On the upside in that same cas=
e
> > we take 512 bytes off the stack which could potentially have made the
> > stop code less reliable. It can be noted that the NMI backtrace code
> > (lib/nmi_backtrace.c) uses the same approach and that use also
> > confirms that updating the mask is safe from NMI.
>
> Updating the global masks without any synchronisation feels broken though=
:
>
> > @@ -1085,77 +1080,75 @@ void smp_send_stop(void)
> >  {
> >       unsigned long timeout;
> >
> > -     if (num_other_online_cpus()) {
> > -             cpumask_t mask;
> > +     /*
> > +      * If this cpu is the only one alive at this point in time, onlin=
e or
> > +      * not, there are no stop messages to be sent around, so just bac=
k out.
> > +      */
> > +     if (num_other_online_cpus() =3D=3D 0)
> > +             goto skip_ipi;
> >
> > -             cpumask_copy(&mask, cpu_online_mask);
> > -             cpumask_clear_cpu(smp_processor_id(), &mask);
> > +     cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
> > +     cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));
>
> I don't see what prevents multiple CPUs getting in here concurrently and
> tripping over the masks. x86 seems to avoid that with an atomic
> 'stopping_cpu' variable in native_stop_other_cpus(). Do we need something
> similar?

Good point. nmi_trigger_cpumask_backtrace(), which my code was based
on, has a test_and_set() for this and that seems simpler than the
atomic_try_cmpxchg() from the x86 code.

If we run into that case, what do you think we should do? I guess x86
just does a "return", though it feels like at least a warning should
be printed since we're not doing what the function asked us to do.
When we return there will be other CPUs running.

In theory, we could try to help the other processor along? I don't
know how much complexity to handle here and I could imagine that
testing some of the corner cases would be extremely hard. I could
imagine that this might work but maybe it's too complex?

--

void smp_send_stop(void)
{
    unsigned long timeout;
    static unsigned long stop_in_progress;

    /*
     * If this cpu is the only one alive at this point in time, online or
     * not, there are no stop messages to be sent around, so just back out.
     */
    if (num_other_online_cpus() =3D=3D 0)
        goto skip_ipi;

    /*
     * If another is already trying to stop and we're here then either the
     * other CPU hasn't sent us the IPI yet or we have interrupts disabled.
     * Let's help the other CPU by stopping ourselves.
     */
    if (test_and_set_bit(0, &stop_in_progress)) {
        /* Wait until the other inits stop_mask */
        while (!test_bit(1, &stop_in_progress)) {
            cpu_relax();
            smp_rmb();
        }
        do_handle_IPI(IPI_CPU_STOP);
    }

    cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
    cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));

    /* Indicate that we've initted stop_mask */
    set_bit(1, &stop_in_progress);
    smp_wmb();
    ...
    ...

--

Opinions?


> Apart from that, I'm fine with the gist of the patch.

Great. Ironically as I reviewed this patch with fresh eyes and looking
at the things you brought up, I also found a few issues, I'll respond
to my post myself so I have context to respond to.

One other question: what did you think about Daniel's suggestion to go
straight to NMI for crash_stop? I don't feel like I have enough
experience with crash_stop to have intuition here, but it feels like
trying IRQ first is still better in that case, but I'm happy to go
either way.

-Doug
