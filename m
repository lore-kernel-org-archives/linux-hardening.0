Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD076188A26
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427001; cv=none; b=i+bJ1hE1VYkTyx08oFLqpfDPhai3S4JUbJfAJz803+k2YJzGWX1yLCV+gPdFpev0X8NVY+ceYF7IFxCWVqpqc7RNjFetF0JbiBBpUnyuzAjdc44H8b7BLgNLP1aZaEOclXBPrUXxU+BKn9KPZVCssy8BHcstbVnArZIPDHoOBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427001; c=relaxed/simple;
	bh=oNfQ4tia5EGE6ACUTEBJMYDZJ9v/LW5wX588X1lUppw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWPSiWgg7aEIDe+2SnVfv6/b2cZbaAP8iYvzpPLKsRhiNqyOjlcZ8RyMFtlN4VR7/FDtZ12SSRLchhADTgwnjXdFtS6TyIPoopTP2inWhW412OE8DEIm/BL2iZUsXyy7zf2fC35tKzkrWnTJ/RqQ3Z6zc2Ke/mh8HLb4hO7Kjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iQN7pBsZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQN7pBsZ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so10283866d6.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724426996; x=1725031796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l5A3SKIR/YWwP2aJcT73ZHnLsJzRksHrml/jGPsy9k=;
        b=iQN7pBsZJxdRLS65shHFNdfA4clGBHIn22iCALi08T990jK+18GwpLqMiE/icyJLXi
         q2DrcoYC4uQh9mTuq377grkcgtnQB0Ep1LzsSDisK2KwOdXGdPH4CO5bIsFCG9lnGabl
         EYhLHF0W0dqKI1GOLfLh//vaXS7TuUnno+yJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426996; x=1725031796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l5A3SKIR/YWwP2aJcT73ZHnLsJzRksHrml/jGPsy9k=;
        b=V6XadGZcPr2UsEDqCE8mqe+LVmU45301cozmF0jluwjTvhCB+6lKldnugy0wZ/NAAx
         sbfWI8trQePL0XbVJUxVNmizTFQ4gwHBdjL0sp/mPS9739LhOP+4MHxN1eQqNJ/7LP9z
         yFYAKKbUlT5DT3trbWZrkszbB96IIBBeD0v4hnrW+eJN8tSb51xlN0BJZv5O5O4NvXkO
         tg92q4tHo+D87mir1tqeCEWVXP4NynnVzg+2+YMnbdwVvoQTdjBX9Z+F2OTkIaJ8u5KJ
         VPjW9pbnK94olWG4kCdB+3dEWWvRPt7S26WDwIT2q1KXJQ45z7quCeQOT8MT/iiUCWzS
         zRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCpOWa4rnu01xXNFUvxDzae0ydkLNRNAMtYAiLjz071EHdeQEJm4vsHqbmYB7AkWgKP9hA0Yi39I3CM7ZyToA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdcGpqpDN7Q9xJ4MZQ/aMv0iZga9OIdImiyC55rNuypcMbBMX
	WfwHyNPgBS6RUgaWvWj56LBRcBaPd4tRdXoHX/BHi9T3mtqTPKQfi/rbRQdYbFt3Rq2WkmNwb1Q
	=
X-Google-Smtp-Source: AGHT+IEstGp1WZ0SmsTfZnSlZ5kXsb+WXdilwqv1NPkKKVvWJ72unWKDlcjw7eO9vwP+EpDPEqnSKw==
X-Received: by 2002:a05:6214:311a:b0:6c1:6085:f118 with SMTP id 6a1803df08f44-6c16dc259bdmr28969656d6.5.1724426995836;
        Fri, 23 Aug 2024 08:29:55 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db5d23sm19429526d6.103.2024.08.23.08.29.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:29:54 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf6ea1d34aso10457286d6.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 08:29:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcvNFHsOnfCwiX5PsVHcQobPZ4dxj2VJRdn8RZqsr0EVGbHyp9SGUnLmz3j7V4tDu8xe3hWv5PzWQsHlwiGtY=@vger.kernel.org
X-Received: by 2002:a05:6214:5882:b0:6bf:5d4c:32d8 with SMTP id
 6a1803df08f44-6c16dcb7b44mr27582606d6.39.1724426994067; Fri, 23 Aug 2024
 08:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240823104552.GB31866@willie-the-truck>
In-Reply-To: <20240823104552.GB31866@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 23 Aug 2024 08:29:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2NDBCwTbLtuknejMhHeqgGc86Hb4RRWEsQc9BBasETg@mail.gmail.com>
Message-ID: <CAD=FV=W2NDBCwTbLtuknejMhHeqgGc86Hb4RRWEsQc9BBasETg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Yu Zhao <yuzhao@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Misono Tomohiro <misono.tomohiro@fujitsu.com>, 
	Marc Zyngier <maz@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Kees Cook <kees@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Aug 23, 2024 at 3:46=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> On Wed, Aug 21, 2024 at 02:53:57PM -0700, Douglas Anderson wrote:
> > When testing hard lockup handling on my sc7180-trogdor-lazor device
> > with pseudo-NMI enabled, with serial console enabled and with kgdb
> > disabled, I found that the stack crawls printed to the serial console
> > ended up as a jumbled mess. After rebooting, the pstore-based console
> > looked fine though. Also, enabling kgdb to trap the panic made the
> > console look fine and avoided the mess.
>
> Just a small nit:
>
> >       while (num_other_online_cpus() && timeout--)
> >               udelay(1);
> >
> > -     if (num_other_online_cpus())
> > +     /*
> > +      * If CPUs are still online, try an NMI. There's no excuse for th=
is to
> > +      * be slow, so we only give them an extra 10 ms to respond.
> > +      */
> > +     if (num_other_online_cpus() && ipi_should_be_nmi(IPI_CPU_STOP_NMI=
)) {
>
> We probably want an smp_rmb() here...
>
> > +             cpumask_copy(&mask, cpu_online_mask);
> > +             cpumask_clear_cpu(smp_processor_id(), &mask);
> > +
> > +             pr_info("SMP: retry stop with NMI for CPUs %*pbl\n",
> > +                     cpumask_pr_args(&mask));
> > +
> > +             smp_cross_call(&mask, IPI_CPU_STOP_NMI);
> > +             timeout =3D USEC_PER_MSEC * 10;
> > +             while (num_other_online_cpus() && timeout--)
> > +                     udelay(1);
> > +     }
> > +
> > +     if (num_other_online_cpus()) {
>
>
> ... and again here, just to make sure that the re-read of cpu_online_mask
> is ordered after the read of __num_online_cpus in num_other_online_cpus()=
.
>
> I can add those when applying.

Sounds like a plan to me. Thanks!

-Doug
