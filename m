Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CC1B5EDB
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962235; cv=none; b=RMySeEf04ExRigK2VY3Vn94iKsU9d5PtMc+7EJs6tRfCc5p78Yy+6b786RKtyYCGyudTIjDsIjQsI107CtMHwUNSD3raqPKOYthx/vY3bvhtcI5NhOj3MPcr/SJw1S6S74bLux5+seGWlEUL46ZnpNG6OW5M6eIHMHyZrhlKlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962235; c=relaxed/simple;
	bh=5KVDQSRJqn1uLOrwPqOnPp59IExMMYu9Go6kY04yP5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uuwzf2Pb/VRzK29yN1sRuUBxFTPplBaw5e3p25Sj8s2cOAGM4OIP1Ftw0fv7HJm9kQWN853XB3uX47vEahM/RHiD573d1NpOXp5YxR23isIQMCEBMK3ZpkOntViMemUW2JU4pfqVV7K0NqOlYweCIFlKIuAXG8KhML8TMFRxxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHnp7tBX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHnp7tBX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20353e5de9cso48195ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724962232; x=1725567032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KVDQSRJqn1uLOrwPqOnPp59IExMMYu9Go6kY04yP5E=;
        b=JHnp7tBXqmcw9d2ybPEhuJbzHspZn6y79KTFnWRZhAYoCX9VSD7uwNzTxvLu5CSdC6
         fs+DZkaeuz9T3XzIAbW8Vf9d/1BSjH+KhFlZ2zCS+VtcCfEcdOfzv+Cpci/TRdXDp22K
         GzNqBj9uWk2oxMO4qQp4fu2ynndCEYNQelI1sQCV2xTzFJBHhPki+yNf37vhDIrX15U7
         Irfe1mNd8bXxMfqce6Suv7nwm5MEdBx+unOwZQYYKmPH7rH220WRFM4q8UfRL1/sd9g4
         IMT8kTrSzmsIfX6NC8SBA9uKwMh/tTWC/nxTNYaeAuXU8ZTqq1hp9QPH/pRzSHCGKBtQ
         tLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962232; x=1725567032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KVDQSRJqn1uLOrwPqOnPp59IExMMYu9Go6kY04yP5E=;
        b=jxhedh1Qi56MaZsE7XkBB2AM4mAuinD8PyxunCMWPRyCOmshbp/mcC1BAUe/6GRHYS
         q3FJamxiIyBxgEFQrWB/Qw8xLMLYUvFME4m/+G39qw5m20xNnrM7WZynQAtccXHuTBts
         4mL113WUtbx9QZDCxqBFfOx8p1f3ZFwYsGKxG6C1KYEs0sIPi9fKJyueJCqJx61eWkYO
         usK9lDcvaN0njTvjCwnTRpLyMfWeYzpORPqfmqEjjVlhqvZJMkNGtpxP1H7EW21fOTdv
         S56gTRMAVubVdz4fjK7kBuvHqTpkZhh1khtIFgtjGKjq8r3RhMO1ApMZXCUK1Ox+ZZwG
         LYeA==
X-Forwarded-Encrypted: i=1; AJvYcCW/BT36pMCAzJvM9lsMLru5xquj1EetMpQ2YBYeXShtnAC5tjuhIHLZrCsHc8xP/3bAlFa4EZdpSlR0UFl1x5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6mv/bOSX0vXx4eCsGJLyTq/5M70MhOkHWZwk8xw2hsZc4WS4
	9aHzs9bzi3EexwcDQId7nGnoNu3n4eqkWm5qpqZv4bxHpRT3ti0XXZg5lXEsuEV52HsqhAByPv2
	Nnl3L1gWxGwig00R/kfJ0F5UnVRpv0bL5pWja
X-Google-Smtp-Source: AGHT+IFQRNbNGLHbbGCo2uMEpZQ8l/Z8Qfl7lbbo3l69mIFsmK7QVww06v7HFuoldRojF6blnNbqjyk2g2kuM7Aop/A=
X-Received: by 2002:a17:903:2282:b0:1fb:19fb:a1f0 with SMTP id
 d9443c01a7336-2052388c8f1mr664215ad.4.1724962231569; Thu, 29 Aug 2024
 13:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpeQuBKj89rTkaAs5ADrz0+YLQ54g-0CshYzE3h06G0U5g@mail.gmail.com>
 <202408281719.8BBA257@keescook>
In-Reply-To: <202408281719.8BBA257@keescook>
From: Jann Horn <jannh@google.com>
Date: Thu, 29 Aug 2024 22:09:51 +0200
Message-ID: <CAG48ez3bxCBtWbMG7eooSivNQtb+kTixk6Z2EaEQbmLPB+G=bg@mail.gmail.com>
Subject: Re: BUG: null pointer dereference in seccomp
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, Aug 27, 2024 at 09:09:49PM -0700, Juefei Pu wrote:
> > Hello,
> > We found the following null-pointer-dereference issue using syzkaller
> > on Linux v6.10.
>
> In seccomp! Yikes.
>
> > Unfortunately, the syzkaller failed to generate a reproducer.
>
> That's a bummer.
>
> > But at least we have the report:
> >
> > Oops: general protection fault, probably for non-canonical address
> > 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> > CPU: 0 PID: 4493 Comm: systemd-journal Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]

So, the issue can't be that we went through the seccomp filter setup
path properly and the bpf_prog was never actually installed, because
in that case we would've crashed in seccomp_cache_prepare_bitmap().

I'm pretty confused how we could've possibly gotten into this situation...

What kind of test setup are you using - is this QEMU in TCG mode or in
KVM mode? Can you share your vmlinux binary, so we can see if there's
a clue left in the register state of the crash?
