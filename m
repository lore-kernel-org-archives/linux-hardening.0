Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FB155351
	for <linux-hardening@vger.kernel.org>; Mon,  5 Aug 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878014; cv=none; b=nHrBYQBqhMDhHBp0soz19UZulmFM6dGTZSI4+13JcaCbIqsHwK64HUckN1rVlbrHuuniWar6aNVn2vJgIFrKCIG5Z7mL2mL8rlbTAnKVTbYlHw0o6Eg5APM+Jm6mAwnILVYFV+QDOhc8c9Z/qOgwfTudcremvPE6w3+Gvwqb75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878014; c=relaxed/simple;
	bh=yfWYEXxdeJwgAdLFY31FsjB5SlxcoS41niHTgjnNpUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhAoyXSBrCLBgRJGQbYzwT5Kybx5ok4uc4bwUI0AIFvsYDlWnbI2w2YM1li/Cylb8yQjOXQuS6YGYLE6Q2jMX5it/q1BiLTimxH0gdv7UhZOybIX08K8xSn7cWBIbQfoR5nmBal0EOs+bPpG2zrQKZsJAgwZqaJtMCJGVeiOlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O/AmQTus; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/AmQTus"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fee8813c3so50618241cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722878009; x=1723482809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxGPkBBIU/UYFLm9bnOMyrs15Eqxvamgnzbs4RGwsYk=;
        b=O/AmQTusYp/jCbeFzg7wGT8FsCs5/tsrKASqCh3Ay32lV4ZTkIAZSbg65DA6mjtu9G
         fwejmamngru0r3rv4le9Y1otFyGAArwqxxBAkfgOAInPwXU2ncyCmxIq9LnBdRumwW4/
         TMKI21ufdwKP3C2CcxAGExfnJFA4xkRzWpPNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722878009; x=1723482809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxGPkBBIU/UYFLm9bnOMyrs15Eqxvamgnzbs4RGwsYk=;
        b=xK/5xFKCHVKFcv62TIuRQ4mTVNGsiiiBH5TrMJXXKIGqBGzT35BwR/QkqXwAHP507R
         s2i9vFRxD764DRjYXALz2mENASj0evFJW5u/2EARBClF/KBbPAZHWDvKT/HZQWx7wccv
         9saSuG4rjRN7yIEj4ziEKU5BrW3qtOw55yP+YIuHF22Z8JkhymIMMf+6JefGP5wRX7hD
         RitPwOr8/2X3J3YCcg5fD3I0/piFimZiGTXsV4GGZeC/9TZnyPR0M69fJh4deTgIhLeb
         XmY1I+HVtme9tYHDt5b3ToPKWlJq9uvzlJm7WeAA4SuRRf3z2jp8xK3DBzFUIL46CmB/
         mdrw==
X-Forwarded-Encrypted: i=1; AJvYcCUpe+IyeSTQXwPhZlw0rNGZtNifW/LSiCJI3cZRkRlmU48PsUySZmtDk/EvSAh1me61NXBHSXs/kiPNRwfI9P5f722mqxwpb4I0xreoPgsw
X-Gm-Message-State: AOJu0YwE/3D/7i1eDPP/iGcW66tBvJ1OceFW5lfidAi69r979UYz1DGz
	3dGLuBNhWWgOWtDw+aFksAhSA7mqZrGW7UwCTezzGpl7B8d7H+7++lEq9ROd5wTKBPPULOsCe7Q
	=
X-Google-Smtp-Source: AGHT+IH0TBuPEvPDXGzkBOLi7NMqYZmRtT8tMrOVhKRVVMbLMeZ0S5tkFFuRLR2cttwo7JePR/NY7g==
X-Received: by 2002:ac8:5f48:0:b0:446:63e9:dc87 with SMTP id d75a77b69052e-4518910fecdmr154674171cf.0.1722878009523;
        Mon, 05 Aug 2024 10:13:29 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6aaaa4sm31113551cf.8.2024.08.05.10.13.27
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 10:13:27 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fdc70e695so30261cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 10:13:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+cB6/JrjgZvsGhBkh9rpos3zV6rEDucWUgZqL9Y56Lzxxx/x4rjwX1WTitEn6W9z4BgHvAbYDSClTFLSnqqoOOvmU1qreJndOaYslz879
X-Received: by 2002:a05:622a:301:b0:44f:cb30:8b71 with SMTP id
 d75a77b69052e-4519b663469mr5297181cf.25.1722878007233; Mon, 05 Aug 2024
 10:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck>
In-Reply-To: <20240805165336.GA10196@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 10:13:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
Message-ID: <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Yu Zhao <yuzhao@google.com>, 
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

On Mon, Aug 5, 2024 at 9:53=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> Hi Doug,
>
> On Tue, Jun 25, 2024 at 04:07:22PM -0700, Douglas Anderson wrote:
> > @@ -1084,79 +1088,87 @@ static inline unsigned int num_other_online_cpu=
s(void)
> >
> >  void smp_send_stop(void)
> >  {
> > +     static unsigned long stop_in_progress;
> > +     cpumask_t mask;
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
> > +     /* Only proceed if this is the first CPU to reach this code */
> > +     if (test_and_set_bit(0, &stop_in_progress))
> > +             return;
> >
> > -             if (system_state <=3D SYSTEM_RUNNING)
> > -                     pr_crit("SMP: stopping secondary CPUs\n");
> > -             smp_cross_call(&mask, IPI_CPU_STOP);
> > -     }
> > +     cpumask_copy(&mask, cpu_online_mask);
> > +     cpumask_clear_cpu(smp_processor_id(), &mask);
> >
> > -     /* Wait up to one second for other CPUs to stop */
> > +     if (system_state <=3D SYSTEM_RUNNING)
> > +             pr_crit("SMP: stopping secondary CPUs\n");
> > +
> > +     /*
> > +      * Start with a normal IPI and wait up to one second for other CP=
Us to
> > +      * stop. We do this first because it gives other processors a cha=
nce
> > +      * to exit critical sections / drop locks and makes the rest of t=
he
> > +      * stop process (especially console flush) more robust.
> > +      */
> > +     smp_cross_call(&mask, IPI_CPU_STOP);
>
> I realise you've moved this out of crash_smp_send_stop() and it looks
> like we inherited the code from x86, but do you know how this serialise
> against CPU hotplug operations? I've spent the last 20m looking at the
> code and I can't see what prevents other CPUs from coming and going
> while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.

I don't think there is anything. ...and it's not just this code
either. It sure looks like nmi_trigger_cpumask_backtrace() has the
same problem.

I guess maybe in the case of nmi_trigger_cpumask_backtrace() it's not
such a big deal because:
1. If a CPU goes away then we'll just time out
2. If a CPU shows up then we'll skip backtracing it, but we were
sending backtraces at an instant in time anyway.

In the case of smp_send_stop() it's probably fine if a CPU goes away
because, again, we'll just timeout. ...but if a CPU shows up then
that's not super ideal. Maybe it doesn't cause problems in practice
but it does feel like it should be fixed.

-Doug
