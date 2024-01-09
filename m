Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8928EA
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jan 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwrKlaVh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3374e332124so2254640f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jan 2024 16:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704761685; x=1705366485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlpHzVp7c/St5rVxXWzyjfxKkNrOqBIpF/puim8t1Sw=;
        b=IwrKlaVhBkjXECZmSQrKmj4vqR03VTyecRJh5zap8mE+4qChWOCvoX5DFjuDJfm7cQ
         8hntCtaJYNzTDg3w+OZ8cjDgt7gaeWS8lknrifGWLmCZnYLe5MsHnf6U1BRXtoX/woGX
         4WjL3sPM/ZQevHCxBiSvQoqIpTRd4Pft0VnN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761685; x=1705366485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlpHzVp7c/St5rVxXWzyjfxKkNrOqBIpF/puim8t1Sw=;
        b=ljG+Yu6Gq9FAhcyNM533HNBVlsC0+VgR06QnxqGYJ57qlKKqH4t2GBK1uwswIO2o9p
         5C56+FGd94kX/qGXSG+QnOGjzSpzo9G5FBigpYF4agg5E78ovDx+x9D2hZw+V9CH8JZ7
         vlQu+DUt1vlG3L3vFHKw5CroUNxsnO0gHc+EsqWW+nUDHTFE0OpKcaGGygAQfLXjwxK/
         aAWMvx3ES8dFBsMlo56nj4fusfCXJEu4Q5R12Fj/cUtjMy2pM95P9K2109UJIRI7G3qM
         mJe8ESv78TjmyiCGpB0Q2TDVek7ckbL1k3KbEzzlJXz+ELwFpkr8Zjp8pTGyg34JXQRr
         YEtQ==
X-Gm-Message-State: AOJu0Yy0sAmiRZCZ/yl2a4orySEJ4AyXN0h5CM3wJS/YvyLdH+11RvAx
	GrXacBeIvYMWttLIsCPGY9XqSA4uZvqxiTQADoKMFbU4bYvLw7s=
X-Google-Smtp-Source: AGHT+IEyKrg7DuxVzLFl8xuzWMgPuA1gXeCzx6bAoNyJoFPNVCEx8ZZ7hH1n+6zqozJ1Z7qz9XTmBQ==
X-Received: by 2002:a5d:5410:0:b0:336:67fa:971a with SMTP id g16-20020a5d5410000000b0033667fa971amr120829wrv.101.1704761684876;
        Mon, 08 Jan 2024 16:54:44 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b00557b0f8d906sm362178edw.70.2024.01.08.16.54.43
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 16:54:44 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so11025e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jan 2024 16:54:43 -0800 (PST)
X-Received: by 2002:a05:600c:491b:b0:40e:490c:48a9 with SMTP id
 f27-20020a05600c491b00b0040e490c48a9mr9627wmp.3.1704761683548; Mon, 08 Jan
 2024 16:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
In-Reply-To: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jan 2024 16:54:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
Message-ID: <CAD=FV=WtJCkdSY=HYDmBjn3hc4TYT7j0bMxGCV-=B3o3bm-kpQ@mail.gmail.com>
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

The sound of crickets is overwhelming. ;-) Does anyone have any
comments here? Is this a terrible idea? Is this the best idea you've
heard all year (it's only been 8 days, so maybe)? Is this great but
the implementation is lacking (at best)? Do you hate that this waits
for 1 second and wish it waited for 1 ms? 10 ms? 100 ms? 8192 ms?

Aside from the weirdness of a processor being killed while holding the
console lock, it does seem beneficial to give IRQs at least a little
time to finish before killing a processor. I don't have any other
explicit examples, but I could just imagine that things might be a
little more orderly in such a case...

-Doug
