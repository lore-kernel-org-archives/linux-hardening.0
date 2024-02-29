Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48A70AE4
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232010; cv=none; b=MgS6aFDoAhfjLlah8KWQICKUX9esuhtpW5Kgn/Ogy4BnFvv02H8nlFzIkMvzwWDYEwr7BEBKJrxRJynP2EczIhsdkN4RBliXbBRYnuuRnvNMTDtS48ROtAIZt9U8q16/Y6FQvfoqPKYmOUGT4rOOqMFIVMu25JJYm7Q/7y5ybMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232010; c=relaxed/simple;
	bh=nldKV6VMvMKd10q9dN8TTV6KiBI++xPO7VnBI/q7h94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY5dln4w5LpHyCs+2LCm+LYmofKHj8NHwN8sCi5IY+KVrremjF+6GYuFerldzEbTNGvE/BHCppv7zoNoOk6GGuYR+xqu+8EhIOkguRwSC/UzwlOcWngAX945tI6le62ddscQdYkiZe7fBR/tahwFzC4zR+Vuj9tJEAwQelUCXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gC7BOxy4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gC7BOxy4"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so190400466b.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709232006; x=1709836806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nldKV6VMvMKd10q9dN8TTV6KiBI++xPO7VnBI/q7h94=;
        b=gC7BOxy4HEnXyVVkNliBHd+DheHJvZ9YBrck9wUE+g300bpaJkuhU2OP+aYrNPJpO0
         j50si6wRJZ74CQrFLVS7WATI2X2lMZBKcT/HMNrU0vKVtyLACNUp7VEgVQhEhcgENbw3
         ZVZGLXHqD2DgYCtax7ZSFfPN/4Z+miZPA22p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232006; x=1709836806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nldKV6VMvMKd10q9dN8TTV6KiBI++xPO7VnBI/q7h94=;
        b=KTcPwHD8uqeUHOtY+jLX+yNc0RyegQPmFTnMuguF3Z9Gk28hv7zx2WHOyq4/IF+3pp
         csZ6yKaScv50y02DMPushNsYkqUJV3NZf6VBM8VpEJ6b9jYEcK+wdVJDbY5RMwJcx/MC
         6Hj3djk4yoLBfosdNhGNORVBEGtA03VRIu3w1vwVhgTRzMrCnA/GcmG7yZRDUg/ktzX2
         Egq1PHYr+nnPu7RvXqefjxK4hnFq+To3I7zMfJ6OOS0ChP4E6MtwdLpp9x33e6BWQhDL
         YiQpQph8qMQVuL1F7udWfDcaQv1ohUDq/3+7oUxk3TFHfDvHiheTs57R6H/nZpiAKOLA
         5q4g==
X-Forwarded-Encrypted: i=1; AJvYcCX3ePQrlrAC9pwuTXvpt77HsEwiTpbvrlNjXj0kOgHPkmRAdG0hOPdu69lvBui4adSHgeLPXGTIdicr7+goqMb28sjvbYct9bwiXWMEU8no
X-Gm-Message-State: AOJu0Yz/GAZd9u/3+UvN+I8N32NB1clVSo3plSuvXI4hq8sZDnKTocbO
	Kk+bKbkAx6EWRoiDRsF5OIjMSkzjw8JMheO6nlWYEjyy6QD2DiiV2PqoogkQEqSb18ytd0cjz8H
	rIjCH
X-Google-Smtp-Source: AGHT+IEr1y6jlQa7R85njmzdCuLCqCoD0g4iA3M/2lMtbI8uMwhH+d72RmaCNtw3wMFJ5FUO7Q39AQ==
X-Received: by 2002:a17:906:48b:b0:a43:1e2b:b069 with SMTP id f11-20020a170906048b00b00a431e2bb069mr2109336eja.4.1709232006174;
        Thu, 29 Feb 2024 10:40:06 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id hb15-20020a170906b88f00b00a3fcbd4eb2esm925275ejb.1.2024.02.29.10.40.05
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 10:40:05 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so8465e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 10:40:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmV/IdmZi1cetr32dhGbcDNbenCt8Zbitw8sifxgSEfvVuRvMAgl/If0E0fpKFUldz22ugWeWnsYCkRE+TnuFrV8Z31r2AQlZ+ebDC4mjb
X-Received: by 2002:a05:600c:5185:b0:412:a039:945b with SMTP id
 fa5-20020a05600c518500b00412a039945bmr217511wmb.0.1709231682297; Thu, 29 Feb
 2024 10:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
 <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com> <20240228131104.GB22898@aspen.lan>
In-Reply-To: <20240228131104.GB22898@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 10:34:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VYV_EMFXS0vvMZLGSRZcGwit6=DMdgSW349bVAu_7a1Q@mail.gmail.com>
Message-ID: <CAD=FV=VYV_EMFXS0vvMZLGSRZcGwit6=DMdgSW349bVAu_7a1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Chen-Yu Tsai <wens@csie.org>, 
	Stephen Boyd <swboyd@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 5:11=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> > I'm still hoping to get some sort of feedback here. If people think
> > this is a terrible idea then I'll shut up now and leave well enough
> > alone, but it would be nice to actively decide and get the patch out
> > of limbo.
>
> I've read patch through a couple of times and was generally convinced by
> the "do what x86 does" argument.
>
> However until now I've always held my council since I wasn't familiar
> with these code paths and I figured it was OK for me to have no opinion
> because the first line of the description says that kgdb/kdb is 100% not
> involved in causing the problem ;-) .
>
> However today I also took a look at the HAVE_NMI architectures and there
> is no consensus between them about how to implement this: PowerPC uses
> NMI and most of the others use IRQ only, s390 special cases for the
> panic code path and acts differently compared to a normal SMP shutdown.

Thanks for taking a look! I think I just included you since long ago
you were involved in the pseudo-NMI patches. ;-)


> FWIW the x86 route was irq-only and then switching to irq-plus-nmi
> (after a short trial with NMI-only that had problems with pstore
> reliability[1]) and that approach has been in place for over
> a decade now!

Ah, interesting. I guess this isn't a problem for me at the moment
since we're not using any alternate pstore backends (ChromeOS just
does pstore to RAM), but it's good to confirm that people were facing
real issues. This matches what my gut told me: that it's nice to give
CPUs a little chance to shut down more cleanly before jamming an NMI
down their throats.


> However, if we talking ourselves into copying x86 then perhaps we should
> more accurately copy x86! Assuming I read the x86 code correctly then
> crash_smp_send_stop() will (mostly) go staight to NMI rather
> than trialling an IRQ first! That is not what is currently implemented
> in the patch for arm64.

Sure, I'm happy to change the patch to work that way, though I might
wait to get some confirmation from a maintainer that they think this
idea is worth pursuing before spending more time on it. I don't think
it would be hard to have the "crash stop" code jump straight to NMI if
that's what people want. Matching x86 here seems reasonable, though
I'd also say that my gut still says that even for crash stop we should
try to stop things cleanly before jumping to NMI. I guess I could
imagine that the code we're kexec-ing to generate the core file might
be more likely to find the hardware in a funny state if we stopped
CPUs w/ NMI vs IRQ.


-Doug
