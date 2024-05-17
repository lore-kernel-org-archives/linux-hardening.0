Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61140266A7
	for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976445; cv=none; b=FLQ6qm97HoSMvaoGgrrfvHwbIpB4ssCIXmFDsVWdN+9h6PRcqp+Iz/TVki06Btywcp33Q36POh+8r+MUhaePHFGlUjFS3J/MJVzMKq7Hq+hlSlea2+WGGmKAHPGOFTU6WOxIycNdP5zBAHGkLUzMt4+suXCDh1u2KUa5JfDkye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976445; c=relaxed/simple;
	bh=dVRW6o8FeAkIO0aC7Ma1uSuTqPNsC5yAZiZAAlFWrIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvG5LyOoPFg1r0XoT87U6uHRneqcXB/zPHCt470udg62Xvtddzg3KRAqXaYc7O+AL7bbHMeRzcvfwrma90kr+GNZ1o/vTN7RGUqtcncTaNMBC235GOHrbwUjXkzNiGLe8fun9eQmmXT32ZTxchfHdijyUNJb7M5oU9E1u24sjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yw5Ioswz; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yw5Ioswz"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36db3b34a09so5073645ab.3
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715976442; x=1716581242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biYMrMF+fwXPsZM8NuprY4eu1yNAofEyB+c42WZ5jPw=;
        b=Yw5IoswzhWcZhi/CpnyzYh8l+OnZl4IfSm26hLe2XG/H+/gT2UKmEInTSQMmVSGa1e
         LXutXJ1fV5VTMJXsIzhxEkNAWABfAC3wleI8l0VNFQWC8746r4t/G25QFx+Uqe8DPFfo
         AqzOqJ+iaBcPN7nfv5oEjM15l8pGAgFs4ugmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715976442; x=1716581242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biYMrMF+fwXPsZM8NuprY4eu1yNAofEyB+c42WZ5jPw=;
        b=mw5tSzUFLxV3PrbVi0aq6Yxf97z9gKR+/EsM6YbEh1mk0hHm/gRATI1sBYiH+B2YdZ
         NLiYyROFDzCtIWnhgaaJ7CbunlbTC1Ir5aeiYXVJRQJOVNZRudhnduP4cI+WAJgw/YZr
         smXOBlK4VTne+f/r1cxxLg6KOKJ1io+olY3kAAxN2xZr9gucUysx0NByClx1we9uERvo
         3vcm9ri9U+1+lVDOCRV5SJrFBDd6IDHPHh1J00TzG90hU1C72KKdA97QbVp39UxsF4Mr
         nwPczxExiPPsG1ZNUjRffTq2pggwehWXl8F+LK+qcTjji1O54GR68klp68F5PcayNPkT
         uB1w==
X-Forwarded-Encrypted: i=1; AJvYcCX1OtYMZuwEpevF+PCIA95cwtuOiq0sR2ItwVcscL9qo71Ceelw/OOd2hdfJvCgOf6EdYHPxV4Vq8rshM/sPUVJ3rtTsWS8rd3oSUNXZlQA
X-Gm-Message-State: AOJu0YzShOrBuD+6Xf6s/GwAuUOlFEevr7Q03kJrT6T/ZsMk1slCZE+n
	qoMofkU+xdN2bytZI5AlyOSBnHazfDfVckfrKjiVt6VolVolHH5FogKJKhQPLBfkUaMv2yCYdJk
	=
X-Google-Smtp-Source: AGHT+IF9Tq7d8WJeOoqlBCW6TRk2X8Iyign/OYNMIhDL1rHdo64n4yPVn0pZ+748IaJ2OmAY6fOB8Q==
X-Received: by 2002:a05:6e02:1588:b0:36b:f940:ef89 with SMTP id e9e14a558f8ab-36cc149624bmr283949245ab.13.1715976441901;
        Fri, 17 May 2024 13:07:21 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d6d99csm44401755ab.24.2024.05.17.13.07.21
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 13:07:21 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso25705ab.0
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 13:07:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTeqGLuh/i99TorxKxCJKCuNPWiWBAUSB5PwBvCWvHUWP3cM8oEZs9CFdRSJGLjxMJAFOQsZn0CRWUyTEUQw0X6vWvFNX+cii0F6kbEJWY
X-Received: by 2002:a05:622a:488e:b0:43d:fd4c:2ec7 with SMTP id
 d75a77b69052e-43f796ee600mr580481cf.8.1715976130337; Fri, 17 May 2024
 13:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
In-Reply-To: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 May 2024 13:01:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_TGvRgZy9uFzF_tGX25oYzVrjHRrg-CphwmhmJRwsKg@mail.gmail.com>
Message-ID: <CAD=FV=V_TGvRgZy9uFzF_tGX25oYzVrjHRrg-CphwmhmJRwsKg@mail.gmail.com>
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

On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> When testing hard lockup handling on my sc7180-trogdor-lazor device
> with pseudo-NMI enabled, with serial console enabled and with kgdb
> disabled, I found that the stack crawls printed to the serial console
> ended up as a jumbled mess. After rebooting, the pstore-based console
> looked fine though. Also, enabling kgdb to trap the panic made the
> console look fine and avoided the mess.
>
> After a bit of tracking down, I came to the conclusion that this was
> what was happening:
> 1. The panic path was stopping all other CPUs with
>    panic_other_cpus_shutdown().
> 2. At least one of those other CPUs was in the middle of printing to
>    the serial console and holding the console port's lock, which is
>    grabbed with "irqsave". ...but since we were stopping with an NMI
>    we didn't care about the "irqsave" and interrupted anyway.
> 3. Since we stopped the CPU while it was holding the lock it would
>    never release it.
> 4. All future calls to output to the console would end up failing to
>    get the lock in qcom_geni_serial_console_write(). This isn't
>    _totally_ unexpected at panic time but it's a code path that's not
>    well tested, hard to get right, and apparently doesn't work
>    terribly well on the Qualcomm geni serial driver.
>
> It would probably be a reasonable idea to try to make the Qualcomm
> geni serial driver work better, but also it's nice not to get into
> this situation in the first place.
>
> Taking a page from what x86 appears to do in native_stop_other_cpus(),
> let's do this:
> 1. First, we'll try to stop other CPUs with a normal IPI and wait a
>    second. This gives them a chance to leave critical sections.
> 2. If CPUs fail to stop then we'll retry with an NMI, but give a much
>    lower timeout since there's no good reason for a CPU not to react
>    quickly to a NMI.
>
> This works well and avoids the corrupted console and (presumably)
> could help avoid other similar issues.
>
> In order to do this, we need to do a little re-organization of our
> IPIs since we don't have any more free IDs. We'll do what was
> suggested in previous conversations and combine "stop" and "crash
> stop". That frees up an IPI so now we can have a "stop" and "stop
> NMI".
>
> In order to do this we also need a slight change in the way we keep
> track of which CPUs still need to be stopped. We need to know
> specifically which CPUs haven't stopped yet when we fall back to NMI
> but in the "crash stop" case the "cpu_online_mask" isn't updated as
> CPUs go down. This is why that code path had an atomic of the number
> of CPUs left. We'll solve this by making the cpumask into a
> global. This has a potential memory implication--with NR_CPUs =3D 4096
> this is 4096/8 =3D 512 bytes of globals. On the upside in that same case
> we take 512 bytes off the stack which could potentially have made the
> stop code less reliable. It can be noted that the NMI backtrace code
> (lib/nmi_backtrace.c) uses the same approach and that use also
> confirms that updating the mask is safe from NMI.
>
> All of the above lets us combine the logic for "stop" and "crash stop"
> code, which appeared to have a bunch of arbitrary implementation
> differences. Possibly this could make up for some of the 512 wasted
> bytes. ;-)
>
> Aside from the above change where we try a normal IPI and then an NMI,
> the combined function has a few subtle differences:
> * In the normal smp_send_stop(), if we fail to stop one or more CPUs
>   then we won't include the current CPU (the one running
>   smp_send_stop()) in the error message.
> * In crash_smp_send_stop(), if we fail to stop some CPUs we'll print
>   the CPUs that we failed to stop instead of printing all _but_ the
>   current running CPU.
> * In crash_smp_send_stop(), we will now only print "SMP: stopping
>   secondary CPUs" if (system_state <=3D SYSTEM_RUNNING).
>
> Fixes: d7402513c935 ("arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP sho=
uld try for NMI")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I'm not setup to test the crash_smp_send_stop(). I made sure it
> compiled and hacked the panic() method to call it, but I haven't
> actually run kexec. Hopefully others can confirm that it's working for
> them.
>
>  arch/arm64/kernel/smp.c | 115 +++++++++++++++++++---------------------
>  1 file changed, 54 insertions(+), 61 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index defbab84e9e5..9fe9d4342517 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -71,7 +71,7 @@ enum ipi_msg_type {
>         IPI_RESCHEDULE,
>         IPI_CALL_FUNC,
>         IPI_CPU_STOP,
> -       IPI_CPU_CRASH_STOP,
> +       IPI_CPU_STOP_NMI,
>         IPI_TIMER,
>         IPI_IRQ_WORK,
>         NR_IPI,
> @@ -88,6 +88,9 @@ static int ipi_irq_base __ro_after_init;
>  static int nr_ipi __ro_after_init =3D NR_IPI;
>  static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
>
> +static DECLARE_BITMAP(stop_mask, NR_CPUS) __read_mostly;
> +static bool crash_stop;
> +
>  static void ipi_setup(int cpu);
>
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -770,7 +773,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_str=
ing =3D {
>         [IPI_RESCHEDULE]        =3D "Rescheduling interrupts",
>         [IPI_CALL_FUNC]         =3D "Function call interrupts",
>         [IPI_CPU_STOP]          =3D "CPU stop interrupts",
> -       [IPI_CPU_CRASH_STOP]    =3D "CPU stop (for crash dump) interrupts=
",
> +       [IPI_CPU_STOP_NMI]      =3D "CPU stop NMIs",
>         [IPI_TIMER]             =3D "Timer broadcast interrupts",
>         [IPI_IRQ_WORK]          =3D "IRQ work interrupts",
>  };
> @@ -831,17 +834,11 @@ void __noreturn panic_smp_self_stop(void)
>         local_cpu_stop();
>  }
>
> -#ifdef CONFIG_KEXEC_CORE
> -static atomic_t waiting_for_crash_ipi =3D ATOMIC_INIT(0);
> -#endif
> -
>  static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_re=
gs *regs)
>  {
>  #ifdef CONFIG_KEXEC_CORE
>         crash_save_cpu(regs, cpu);
>
> -       atomic_dec(&waiting_for_crash_ipi);

Upon reading the patch with fresh eyes, I think I actually need to
move the "cpumask_clear_cpu(cpu, to_cpumask(stop_mask))" here.
Specifically I think it's important that it happens _after_ the call
to crash_save_cpu().


>         local_irq_disable();

The above local_irq_disable() is not new for my patch but it seems
wonky for two reasons:

1. It feels like it should have been the first thing in the function.

2. It feels like it should be local_daif_mask() instead.

I _think_ it doesn't actually matter because, with the current code,
we're only ever called from do_handle_IPI() and thus local IRQs will
be off (and local NMIs will be off if we're called from NMI context).
However, once we have the IRQ + NMI fallback it _might_ matter if we
were midway through finally handling the IRQ-based IPI when we decided
to try the NMI-based one.

For the next spin of the patch I'll plan to get rid of the
local_irq_disable() and instead have local_daif_mask() be the first
thing that this function does.
