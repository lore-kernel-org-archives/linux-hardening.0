Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D46166B
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573683; cv=none; b=r25HcM6BoD9dEbalcTIOeIqGpfC1bSghB6kzAmjbrFRg5Ros7aJTuPdlUZ/dLFAQH1OQHCbTXFqYAWl+2fvWsmYJPEDoAXkKjsXVFkIbgihflxs+zdSlE7dGch3k8TefrHngKRNDPnwugfcGjOu43mjk8RD5SzOU5gsFGUCZW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573683; c=relaxed/simple;
	bh=tfmsGbKyPBL3Ittd+OpakBE0HsGkb62jQroArNWygKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNJ3DaX8R5Q5dAUsd5vlK79pxVU1ZJmyU2WswhDQRtch1Hmkmp+KvQLyEEP9RVwUE6J6nCEmf7TPf4m7S91reYLC69fI9hV5JdEmZzTUdNVLBKQ2yWFia9sen8d0pb/2oqRoNNV0msj94J85g4PmYtSNF8l37rG1DkfU5WD0bWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJ1PNG76; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJ1PNG76"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4595bd5f8cso18797566b.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709573678; x=1710178478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfmsGbKyPBL3Ittd+OpakBE0HsGkb62jQroArNWygKo=;
        b=kJ1PNG76qJ5Hxcv8LSryZZlFeZDVa1IzeQeQeUAJ2H8f58sp6Niu9kotN1LZNI9tRP
         rGePkKf/5M2FN9eHOayctU3Gl3esYzU2cF6SDdmQjdlejFS7keA9kiGEHMU/zxiapOCV
         UQYVH41TeTnTquJMtgfRn6tN+XLQ5qJ9n8nLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573678; x=1710178478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfmsGbKyPBL3Ittd+OpakBE0HsGkb62jQroArNWygKo=;
        b=MonXKX2Ti6fIbNW68l9e4yxsfRoyCSEJmRutxPbT//yZlcgQGX+y7/oaWYXY4Ht7rF
         vTnox4uFjRLywpZMtcJJyIVKcECEBA2PwhS+9nn7Etr/bnEG+L6o0j4MQvaWwGSnd1Wo
         gbZ73YD/5i91n22xKKNdmEJp81wavqLy0/gvacgObbPd1ixg0SP1UMD0Zm3tvIbQCfci
         bBfjGQTLGdHGKRUjW3NQcFs2tRUYDqOS1ggnCCyaB1QuEJKXaOYyUZHJQH1m8YMHQhRh
         EbKhaWHo6G3VQM2bYKpgWeOYkOSmUMmvajLJb5UkjkN75ynIRKoJHCB1nm5n6/wilUrm
         bUKw==
X-Forwarded-Encrypted: i=1; AJvYcCXtMWnT0qB/3OowUFurDBNRccUDCCVXvGptVhoe+uE8uYLrZzJ7Eraliwek64hFUNpUCdiFw4TyS7SPFr3+IW+MlXZdOAuVgBZpGFwnYNIt
X-Gm-Message-State: AOJu0YzKvz7iw/2nSsGGLKKFjG/0feTDpbPGZSde4N5qx3myyQkKS+HC
	/BYj//AEs1RB5qwa/nFlWnHBAcVB6tDzBDhrJR3WPv/kacMcbraL0dy9kpxWKkXEOTDcYiLyJ1C
	WLvu9
X-Google-Smtp-Source: AGHT+IGAVBbwhMq7eNb8pbLAw7kQs+7tO2iit/fJHpaqcRaoIg+f2QdRPxDOmNOZPnhWruPbhnhOjw==
X-Received: by 2002:a17:906:48cb:b0:a45:206d:6bcc with SMTP id d11-20020a17090648cb00b00a45206d6bccmr2604638ejt.2.1709573678130;
        Mon, 04 Mar 2024 09:34:38 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id kj2-20020a170907764200b00a44180ab871sm5050573ejc.50.2024.03.04.09.34.36
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:34:37 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso1035e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 09:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUE4yMrWAWBM7yI+gAPnAghQdefFo30nFSuIAANRyCh4Jx8QycZE5yd7u+AHgx712Kvnnu5NtQNKb8V9RhXtPBuaJ5EtTUCqgCZ2Ec5M+6H
X-Received: by 2002:a05:600c:4f07:b0:412:d6be:a32b with SMTP id
 l7-20020a05600c4f0700b00412d6bea32bmr2093wmq.6.1709573676220; Mon, 04 Mar
 2024 09:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com> <ZeH81_k6TFk7W4tm@FVFF77S0Q05N>
In-Reply-To: <ZeH81_k6TFk7W4tm@FVFF77S0Q05N>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Mar 2024 09:34:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJhvVO7k0hhz_KPH4eSrJQdb+k2CJQeCAP40+PYAdDBg@mail.gmail.com>
Message-ID: <CAD=FV=XJhvVO7k0hhz_KPH4eSrJQdb+k2CJQeCAP40+PYAdDBg@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
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

On Fri, Mar 1, 2024 at 8:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> Hi Doug,
>
> On Tue, Feb 27, 2024 at 04:57:31PM -0800, Doug Anderson wrote:
> > On Mon, Jan 8, 2024 at 4:54=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> > > On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chr=
omium.org> wrote:
>
> > > The sound of crickets is overwhelming. ;-) Does anyone have any
> > > comments here? Is this a terrible idea? Is this the best idea you've
> > > heard all year (it's only been 8 days, so maybe)? Is this great but
> > > the implementation is lacking (at best)? Do you hate that this waits
> > > for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?
> > >
> > > Aside from the weirdness of a processor being killed while holding th=
e
> > > console lock, it does seem beneficial to give IRQs at least a little
> > > time to finish before killing a processor. I don't have any other
> > > explicit examples, but I could just imagine that things might be a
> > > little more orderly in such a case...
> >
> > I'm still hoping to get some sort of feedback here. If people think
> > this is a terrible idea then I'll shut up now and leave well enough
> > alone, but it would be nice to actively decide and get the patch out
> > of limbo.
> >
> > FWIW the serial console dumping issue that originally inspired me to
> > track this down has been worked around at least well enough to not
> > spew garbage in my console. See commit 9e957a155005 ("serial:
> > qcom-geni: Don't cancel/abort if we can't get the port lock"). It's
> > still a little awkward because we'll be running fully lockless during
> > panic time, but it seems to work...
>
> This is on my list of things to look into, but I haven't had the chance t=
o go
> through it in detail.
>
> From a high level, I think this sounds reasonable; I just want to make su=
re
> this doesn't lead to any new surprises...

Sounds good. For now I'll snooze this for another 2 months and if I
haven't heard from you then I'll pester you again. There's no crazy
hurry, I was just hoping for some sort of decision one way or the
other. For now I'll hold off on changing things to match x86 exactly
until I get your take on it too.

-Doug
