Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282002CA5;
	Fri, 20 Sep 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815691; cv=none; b=kD/dCvL8VKN8ZiRfuMFSgPKaA7kr2jBRKhgD2X+6tCp2yXzuWm7xLL019786XtRUlusi+tMqUC+VtbRjkdKVFY6Dcla1Q6lT6lr/eMjlZ6iEyyTMxEIjGMF5G1360HmDXTEOy/gN6bVm6HQiY3Fa0NV8LTpOB7TNw6Da2JSLEEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815691; c=relaxed/simple;
	bh=dGr8VCgpoT4GAzJ6jLsUy7kzh7xG8cZDe/TDsJJBQAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGQ7xbg5CF1Z8rXDdZnzUMaBfNvCDqZVP1SAUyikSUESOfe03psX/uvsbmQZ7xCXW4JnXPYxG5y4pAAXsdBs2dUiOMFZmcTm2GcVxqs2CqYXGm7NOWmqZFF0cVhKdyUc4YK4zfdWvHLJLlUiyGWqncFNZCYvdODBW6qBP4qXxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNDXKUUY; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNDXKUUY"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-710e14e2134so1000244a34.0;
        Fri, 20 Sep 2024 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726815687; x=1727420487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHr4CLAL9+PLufjQx8EsnJpLJejqc6CFGLEEsFS2WtQ=;
        b=LNDXKUUYB1TfpuTL511PZsabiaxeoicomJi+so+aO9WdTh7SVUjQPlwCt1HkjluwUe
         oTWKaUfY1h4mqDI17w4NiaPNmlXlBiZhDGzDxgUGtgY981HcDtui0rZQtFwQUDwXAYWg
         EciydsgmNfe4/52VBvMHe5xP/7DQFAjUchPdkIDYKjBWItwrtSWisn/rnQGjP7D22w4G
         kMm2NqEdMakCYPnR7Gxds7iISgMKP2pfi4YDfYHJwE1eLsaBU7aVGpI1osZbxd1/3Tbv
         JAoEz/aHAbQuvpWtUvzf4AMgIp7sy041iaYNPMI4YsiEnaoczJOhwE1RNDXjJNOkevdD
         97pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726815687; x=1727420487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHr4CLAL9+PLufjQx8EsnJpLJejqc6CFGLEEsFS2WtQ=;
        b=VR2oyMszqJqR7B+HtG8Dj56hQRWBd2kyLTUbV8cOQ31y2NkdvmRmW+ZaAc9BfPt9PD
         mjyCzGWX1zIK8xpSe1PQ032P4timT9R4AeIAGwhLmj9X0LQFzZH+P/WUjIjjrTd8JS0z
         A0oHzKDoue1G3Qof1gWq/ityl491pyUexk0dfEk/FYaLNvbBrF6VeYxKDyN2Fsn2U+Vy
         6gFK3lj95dEYecaRp66OHvCA2FGYQIK3dqGQ1/ZcDwVouuX6SfAU3ZfLEnWByBgKAcS9
         2mGQpbV/0Z94EGe86VmUfNkYy1Af/kHOIG/fUQBZaCuieNyvsvC2ApGZJI9ZboxwsZLr
         7lGA==
X-Forwarded-Encrypted: i=1; AJvYcCVTHdeEt9zaFr2vGP2TMkFz/TN0xupzijxnOTJp76u/U+T5bygeNR7LuUgbCAIegzK1IcpvQpiPgtGiRy0iPFM=@vger.kernel.org, AJvYcCWE5YPlOgxDA78wXDwTVKfun9WRMRwsM/N/MuOFwY6NBu+dpxj9kAZHtvTIqyAkwIZQaPtms8dyIV82F892@vger.kernel.org
X-Gm-Message-State: AOJu0YyZq90Jfc+oq2kT5B/bC0j0ku2stwIsMKJtYBTKiieCXEiohlLh
	54NmyhhE3EmxmOwjWcghuKrIIqM9Bxwam9JpPb9BtHXf04A/vjjchocIKdjUxwgKiZyVwmbnBxX
	CjEJxdevv531jrrRchr5LxiyE7DI=
X-Google-Smtp-Source: AGHT+IEBO0scP5SseYDLr0jn6BjKBhIl9PkBG6U3Hcq3o5Zw7pZgVIZuOicuwHKSHJdyLg9LNv5j3XPY/G0a1tgoXTs=
X-Received: by 2002:a05:6870:6388:b0:26c:78ce:b138 with SMTP id
 586e51a60fabf-2803cf6d932mr780074fac.27.1726815687234; Fri, 20 Sep 2024
 00:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <6a689c83-24de-4d3c-afc1-107439f66130@linux.alibaba.com> <CAAfSe-sbz2na_yZ8XgLOaLrY=NOR8RSeQ_+f20qk3jEFxdsKMg@mail.gmail.com>
In-Reply-To: <CAAfSe-sbz2na_yZ8XgLOaLrY=NOR8RSeQ_+f20qk3jEFxdsKMg@mail.gmail.com>
From: Cixi Geng <gengcixi@gmail.com>
Date: Fri, 20 Sep 2024 15:00:49 +0800
Message-ID: <CAF12kFtLZL_oLP8Fds_QYmC_yazGzbFH4OVOxvjH=yFHJMoHyg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-sprd: Select driver on ARM and ARM64
To: Chunyan Zhang <zhang.lyra@gmail.com>, cixi.geng@linux.dev
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Enlin Mu <enlin.mu@outlook.com>, 
	daniel.lezcano@linaro.org, tglx@linutronix.de, orsonzhai@gmail.com, 
	linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, enlinmu@gmail.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chunyan Zhang <zhang.lyra@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 09:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 19 Sept 2024 at 15:51, Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2024/9/19 15:25, Enlin Mu wrote:
> > > From: Enlin Mu <enlin.mu@unisoc.com>
> > >
> > > sprd timer is currently available on ARM and ARM64 based devices.
> > > Thus select it for ARM and ARM64
> > >
> > > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> > > ---
> > >   drivers/clocksource/Kconfig | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> > > index 95dd4660b5b6..296c5f664583 100644
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > > @@ -494,8 +494,8 @@ config MTK_CPUX_TIMER
> > >   config SPRD_TIMER
> > >       bool "Spreadtrum timer driver" if EXPERT
> > >       depends on HAS_IOMEM
> > > -     depends on (ARCH_SPRD || COMPILE_TEST)
> > > -     default ARCH_SPRD
> > > +     depends on (ARM || ARM64 || COMPILE_TEST)
> >
> > I don't understand, if this driver is available on ARM, why ARCH_SPRD i=
s
> > not enabled on ARM architecture?
the ARCH_SPRD is not enabled on ARM by default for some other configs
will enabled at same time.
we just need the SPRD_TIMER
>
> It is probably because GKI doesn't select ARCH_SPRD.
>
>
> >
> > > +     default y
> > >       select TIMER_OF
> > >       help
> > >         Enables support for the Spreadtrum timer driver.
>
