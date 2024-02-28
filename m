Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DCBEA4
	for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081871; cv=none; b=VVWymbV8ef4UGEn4BDRpWPXmnBMqEc7SSZKxlm9B6vDkOPAxz5mmanmJpo4vRfewBrFLlsdzmCas4vhH0CfBV+E+DTURMyji4ll4P7RLeXGnHFWsfEh2CoDr1P0iP4r4RouHOMIbhwfW/9yHuaJl8lHWzvbDHw73kv3bXE+M+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081871; c=relaxed/simple;
	bh=J52l5GvbPpvQV0SlI1cajTdwoGcxKSQNv/+Bf2T6xFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYYK9sa0vCDXmnny6t2sboV6qp02LMHWX7AUAC3+NjIkxYtdlE/NJ/wDJB8YUi0B3y54F+p7jGMm4aDUEXZbdn2PdLEHeZIXL+nkCHfpfHSPN9/KQByYBZr1mXGB9gKcDod7tORta3k8CY0T43YsVHGf06u2yDVS/y3lyYRmIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CN51qTyz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CN51qTyz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a43488745bcso417023466b.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709081867; x=1709686667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr41oLUL07lwHIIdNtUg07Bh7MIOah2pszh7uTbsMgM=;
        b=CN51qTyz9YMfPKoGKzPK6BAwtj7cUksOGN1II/OHplX4rXpGcrPv8P/rD39TKjjFLd
         0wF+gTapHFUIX9gcwAQz2YVXKvLyTdSnvD144nnExUh67tw6NmfDBdv3wC6cpgcYflKf
         dLahHPnCplAwR8Me2dE1iMZFHHzvJAFbXUNo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709081867; x=1709686667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr41oLUL07lwHIIdNtUg07Bh7MIOah2pszh7uTbsMgM=;
        b=DL82qPqGype9sMz+3KBa4HY+64XWISqCFR0J+ATH2s1pZtEpnP/A+69Sa0y0lprZ8N
         eHBkRO9E/MN0CMqL/fhNha/mak+Q+5q+/nfUB95pog57YfB2xME/bIAOQpoADiCdw9ta
         0arutsYd+YYSAGzGsDNvcMtSOiQExXzfRRc/bo6Fy6xvBfWbu60J0REXVCettBBC+uBb
         v362ndgYuVLJpqA5+Gb1z9mCF5FF86IpLQksB5CFmc2eGWTkDBfttJCgb0VBmhvLmu+9
         FvVlQaG3afmGR+68WpxVmzpj3EUbIODlTt/9oulrTjjboJDtXDpG5uZZRRi0tXlnUdED
         3I1w==
X-Forwarded-Encrypted: i=1; AJvYcCUDpfNnx8pm58JnNIrt4XqPpRlYe7zJQoV0Jcb4pN56Wxz2iX+Cfpa/BWNSNPOGxLbla4lC6sl+aGntoJkRepG+tK+y8+BcnKuRWscgdkYz
X-Gm-Message-State: AOJu0YyaUFWNj16aFFRgWx5H05IbFwhdSftVZ1RZvrU44x4CDc87FHtR
	zFhw+OZPbrffbL6DW53PsgN6t6XjcfKQt9jb2Tj9ZuMoyi7JSUEsb6qW4ioU6Yh0eRQR0onC1Cy
	wgaPx
X-Google-Smtp-Source: AGHT+IHjTLDE+E/A1VKY/L/K72dxuvWP7v9UKNmBLpzx7le/CT3lrEF044WjKl/+u+AreVX6xhUS3w==
X-Received: by 2002:a17:906:194d:b0:a43:8371:2efe with SMTP id b13-20020a170906194d00b00a4383712efemr3408629eje.32.1709081867424;
        Tue, 27 Feb 2024 16:57:47 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ts7-20020a170907c5c700b00a43f4722eaesm153973ejc.103.2024.02.27.16.57.46
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:57:46 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so14905e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 16:57:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyJlPuGkhmjWZgVDALQnHvNAO7402FrpLLpwnooDoT1z7Q0sJW9idL/5AU00/yWR+tASx1CjzFmfx+S8C1CYUlppacB4hGZYdJcKw0d6gl
X-Received: by 2002:a05:600c:a39c:b0:412:985b:a1e1 with SMTP id
 hn28-20020a05600ca39c00b00412985ba1e1mr33142wmb.4.1709081866214; Tue, 27 Feb
 2024 16:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Feb 2024 16:57:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
Message-ID: <CAD=FV=XMkrWmA1D6UjdTs8oZiXxKc1xiUoRqtNqAE-7GoPk8mA@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Chen-Yu Tsai <wens@csie.org>, 
	Stephen Boyd <swboyd@chromium.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, 
	Valentin Schneider <vschneid@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 8, 2024 at 4:54=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
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
> >
> > All of the above lets us combine the logic for "stop" and "crash stop"
> > code, which appeared to have a bunch of arbitrary implementation
> > differences. Possibly this could make up for some of the 512 wasted
> > bytes. ;-)
> >
> > Aside from the above change where we try a normal IPI and then an NMI,
> > the combined function has a few subtle differences:
> > * In the normal smp_send_stop(), if we fail to stop one or more CPUs
> >   then we won't include the current CPU (the one running
> >   smp_send_stop()) in the error message.
> > * In crash_smp_send_stop(), if we fail to stop some CPUs we'll print
> >   the CPUs that we failed to stop instead of printing all _but_ the
> >   current running CPU.
> > * In crash_smp_send_stop(), we will now only print "SMP: stopping
> >   secondary CPUs" if (system_state <=3D SYSTEM_RUNNING).
> >
> > Fixes: d7402513c935 ("arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP s=
hould try for NMI")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I'm not setup to test the crash_smp_send_stop(). I made sure it
> > compiled and hacked the panic() method to call it, but I haven't
> > actually run kexec. Hopefully others can confirm that it's working for
> > them.
> >
> >  arch/arm64/kernel/smp.c | 115 +++++++++++++++++++---------------------
> >  1 file changed, 54 insertions(+), 61 deletions(-)
>
> The sound of crickets is overwhelming. ;-) Does anyone have any
> comments here? Is this a terrible idea? Is this the best idea you've
> heard all year (it's only been 8 days, so maybe)? Is this great but
> the implementation is lacking (at best)? Do you hate that this waits
> for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?
>
> Aside from the weirdness of a processor being killed while holding the
> console lock, it does seem beneficial to give IRQs at least a little
> time to finish before killing a processor. I don't have any other
> explicit examples, but I could just imagine that things might be a
> little more orderly in such a case...

I'm still hoping to get some sort of feedback here. If people think
this is a terrible idea then I'll shut up now and leave well enough
alone, but it would be nice to actively decide and get the patch out
of limbo.

FWIW the serial console dumping issue that originally inspired me to
track this down has been worked around at least well enough to not
spew garbage in my console. See commit 9e957a155005 ("serial:
qcom-geni: Don't cancel/abort if we can't get the port lock"). It's
still a little awkward because we'll be running fully lockless during
panic time, but it seems to work...

-Doug
