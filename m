Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C82149C53
	for <linux-hardening@vger.kernel.org>; Tue, 25 Jun 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356911; cv=none; b=XR1JwWC0AU34B6dBxOTGzk+QQrg83HwDy5o3EqJUjxTz4XO100nAh5opOTw2Y/uALFx/hd/RKd+xYwCch6/eEjQn1oZE+Y+AKfC1N3sduEz70+SNYTSulaRvbdQGjZxHlZKiqC4u9IzYKnGZ13PTekf0NKRQHoXpPR2INbZxbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356911; c=relaxed/simple;
	bh=y8RROw7hK4bFGNKaZjwYn3WbP4jQnIdKEQRsHJfh6EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkyUZCZJbTPLqCKwuepqKUUHZpBVm4tQHDwSTaD0uw8hSmOmdvo/y1xsPBMi1B4OGj1B4A503EnxUbkmlTI/eFNGVzPIc6Jiqj17pp6DCdHaKp+7csILwvM1OKNxp9jT+8kPDr/nINhMuPo8TDIRoO8SxO9u1D6tohdnltwUczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UYHxFu7R; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UYHxFu7R"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a3652a732fso24760446d6.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jun 2024 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719356909; x=1719961709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u4uD/4mMNchcd2b711P+PDpdk0X0lw6OjibLkEzG1A=;
        b=UYHxFu7RjYkm0eFT9kdSVmHzdKBxuy9JrNYF26oUvw3cx06HW+HRygJoqQShUbqH8b
         kD6cJ9GHaf+/qbyox890aAUQrbaM0o+9KiUaQDkjSTIJZG0OWwhrsdzZ9DkWzyNDp822
         ZmTmuyP1FHZ3vjcIONWMlXxBjGS2GApe4FQYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719356909; x=1719961709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u4uD/4mMNchcd2b711P+PDpdk0X0lw6OjibLkEzG1A=;
        b=AGiZs9yFgQsEP2Y5HfVwihNmQ+E7pvFu8A9HTUfDy1xQaybcE6lJOdvjFx2XdthA+4
         IwLXxluNL8aEs7IaYQhu11y1WNHa6lGo3zSgnFkPMUMOb9S64DYIiJPoD4vDEbE2PUR9
         6LQyFui8gjygNtpdIoDPsKcyfuwxP4p+N875qKdkNCoe4/VA45XLS5grFVaErRwF18Cn
         wN+JbvSziOwD3RAgc0RledWRhIUhC96Qs7dqiwTajpVJijPRwN/1jPIe2t8m7xEVIJPh
         GEku8K9NHsrVMpt56zwP8GWSTmp6UrrzQZaK7A9xFI1gFsLMAq5vJA2aK5p+Fxxexf77
         vBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzbr382I0EvOiv/9bAJZgGDN6paNx3jONnl2iW4ENtoY9LqLfLro/I244mfF34Vm/O2C+lLBSVZm2RNFIMI7lsNQ9ig6hOGJuupWDEemZj
X-Gm-Message-State: AOJu0YylaYQVy+joAYdJA/FbagUUn++SaLa2CFlMUJjVY/KfAyOS5YDq
	hjGxOeHTQzOFPy4AE5n7OtDymQUQhGhN2SAqYDy0btUVCn3UmpcJ26gvZDApoTAZ9YOxlPFU3L8
	=
X-Google-Smtp-Source: AGHT+IG1ZO8CmSXB9oXN3fUzjeh1pCtEibybxf+7G4eBfaF4/pCH3bDRSY4moOlsq80y63ZyVIfWew==
X-Received: by 2002:a05:6214:20e2:b0:6b5:24b:f430 with SMTP id 6a1803df08f44-6b540a91d2emr107813896d6.40.1719356909415;
        Tue, 25 Jun 2024 16:08:29 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe7a9sm48776746d6.27.2024.06.25.16.08.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:08:29 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-444fdaed647so66951cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jun 2024 16:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjNUElyViiYxy2hDJ1opqgt1GRC7Aqsxl+fScknrgoYS2PJLxOjyPKmCarYODY/+mj6viePT/wMcOUvfMBJEJIUmijxFUGVqU++gDv2h2H
X-Received: by 2002:ac8:5753:0:b0:443:4d56:5f40 with SMTP id
 d75a77b69052e-4453aac2407mr732101cf.9.1719356908641; Tue, 25 Jun 2024
 16:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=V_TGvRgZy9uFzF_tGX25oYzVrjHRrg-CphwmhmJRwsKg@mail.gmail.com> <20240624135452.GB8616@willie-the-truck>
In-Reply-To: <20240624135452.GB8616@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jun 2024 16:08:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xzynqn8H8G175OodJgiCoV4TjTQQQuzOcbSAzcLZcyhw@mail.gmail.com>
Message-ID: <CAD=FV=Xzynqn8H8G175OodJgiCoV4TjTQQQuzOcbSAzcLZcyhw@mail.gmail.com>
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

On Mon, Jun 24, 2024 at 6:55=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, May 17, 2024 at 01:01:58PM -0700, Doug Anderson wrote:
> > On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> > >         local_irq_disable();
> >
> > The above local_irq_disable() is not new for my patch but it seems
> > wonky for two reasons:
> >
> > 1. It feels like it should have been the first thing in the function.
> >
> > 2. It feels like it should be local_daif_mask() instead.
>
> Is that to ensure we don't take a pNMI? I think that makes sense, but
> let's please add a comment to say why local_irq_disable() is not
> sufficient.

Right, that was my thought. Mostly I realized it was right because the
normal (non-crash) stop case calls local_cpu_stop() which calls
local_daif_mask(). I was comparing the two and trying to figure out if
the difference was on purpose or an oversight. Looks like an oversight
to me.

Sure, I'll add a comment.


Ironically, looking at the code again I found _yet another_ corner
case I missed: panic_smp_self_stop(). If a CPU hits that case then we
could end up waiting for it when it's already stopped itself. I tried
to figure out how to solve that properly and it dawned on me that
maybe I should rethink part of my patch. Specifically, I had added a
new `stop_mask` in this patch because the panic case didn't update
`cpu_online_mask`. ...but that's easy enough to fix: just add a call
to `set_cpu_online(cpu, false)` in ipi_cpu_crash_stop(). ...so I'll do
that and avoid adding a new mask. If there's some reason why crash
stop shouldn't be marking a CPU offline then let me know and I'll go
back...

-Doug
