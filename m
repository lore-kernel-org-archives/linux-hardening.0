Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F93C0C
	for <linux-hardening@vger.kernel.org>; Tue,  8 Oct 2024 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361151; cv=none; b=UqnRxVqMNLKfnROCn0ipvjXoVR/7GIbqEhzgUvIZoUukOSZS5/RxuDcpyB4OievjEHiz+fEw3a5N5L5oXMSO2Nl4Jh57k8aMmYVI9FOfF7AGPx+xgcmSIuOcYhT42jI1EjCdvLgHMZU1zmv2TXi022r2oYSbW8SmGYpjx45SsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361151; c=relaxed/simple;
	bh=W7VaIoSXBJvQ243FIbn/gC/Jz8eSE7zharLEKgCtYGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdsXayGY3Ey4/dA4t+NBuYCrpMySd5hLtYbMz+VE1f/0wcnx9qaJhXd7IG8u3sg1DID3Q913cWAlgmmcK7PmqKHsDBZgWJH865BkhJeziuIIxSJ2B7RVhcULR7IuThrxjj/YuzLcs/CPBH6sgri/0bZRI7L0cdeFOYz5lm43Zmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E35Lh4wh; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E35Lh4wh"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e1cd2f996aso215733eaf.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 21:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728361149; x=1728965949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZfQvH/MhqM2R9awaLXpo3SGscfTUNKuXetgTd0BBdk=;
        b=E35Lh4wh9myTHkeJVZbipsYWqGTLLRHxBJ2Vhs1vVdBKgnUEE6Rpe5r+nUhrRQfvJN
         iVWOZEmhYzexipZLQyt5KU20hUo28ier1/vhttQNrMIlihfRVS3noD9Fcge2sx950Ku6
         Qk9o+8LebvugUzFuiSdkKII2Ut98Hv0OdrfEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361149; x=1728965949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZfQvH/MhqM2R9awaLXpo3SGscfTUNKuXetgTd0BBdk=;
        b=WeJP3b7+wC1fKsuGECAR8CFKuUOuU3dzfaWmwSFPshbJsABZt2R89NzE1A6oarvCNr
         6jWpZAbowMvrYaeZyuDYZufew4r9nZF1FInWscsoqmzLanGkjUnhbWYA1D+OvJVWgAPI
         qrfAvxWiFRg56bjB9paDjf1c7FHAqVXDhrIVV8ibEn7V2czMjVpouJxoggpfzUkev2Tm
         VWYZBnj0xideN/g9TLT6L8Wjo1Zf5JegByfD12L0aoeIFq5DR7yTDfssUNEwSdLmhTmk
         cogX35YBcKjagM9EsByuCgWKPM9PNykHFINZ/Cz80axJH6pbYEJq7Mdq3aeJ3DU4cIJj
         oxuA==
X-Forwarded-Encrypted: i=1; AJvYcCVzo5YfFw6A1FcrkhCxIZFPUxjZLt5IY354qz6NLNTvYNESf+Yacd9bwThZaXyjOOT6w0d4pj5AWbjsKQJmdrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2af52HCX3E9rdHDSSDeAlFOpoO9aTR6+W8hkM/2t/8qSRr6M
	DfkLwLlfHJ1XC6cyCLYR5TdVmigDOGvoqinUiO65yVXXwT7uA/Cs+DtyB/KvTUHxwwJZRGYjLV6
	nMu3HKvss8fi7t2I00eJZAu2yPCb0JYT2oFCI
X-Google-Smtp-Source: AGHT+IHsZ/zMWhIjvBkKz+rNy860wt9i3yAjcZE4NwcRozFAITLm8eJ8L5musQvO+B98Ff8XeuX4MR/evRRD0knnv4s=
X-Received: by 2002:a05:6870:b526:b0:27b:72b3:cd9a with SMTP id
 586e51a60fabf-287c1db21efmr2874042fac.2.1728361149313; Mon, 07 Oct 2024
 21:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <20241004163155.3493183-2-jeffxu@google.com>
 <24700097-561f-4b81-a45c-e4f7b4b9b853@infradead.org>
In-Reply-To: <24700097-561f-4b81-a45c-e4f7b4b9b853@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 21:18:56 -0700
Message-ID: <CABi2SkVo=g8vSPW=_Eb4pxmarnwFVd-gyPqNNKLsgnSRKpqz+w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	nathan_lynch@mentor.com, dsafonov@virtuozzo.com, Liam.Howlett@oracle.com, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:42=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi Jeff,
>
> On 10/4/24 9:31 AM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  9 ++++
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> >  fs/exec.c                                     | 53 +++++++++++++++++++
> >  include/linux/fs.h                            |  1 +
> >  mm/mmap.c                                     |  1 +
> >  security/Kconfig                              | 26 +++++++++
> >  6 files changed, 97 insertions(+), 2 deletions(-)
> >
>
>
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 28e685f53bd1..e289fbb5d676 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,32 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +choice
> > +     prompt "Seal system mappings"
> > +     default SEAL_SYSTEM_MAPPINGS_NEVER
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, uprobes and
> > +       vsyscall.
> > +       Note: kernel command line exec.seal_system_mappings overwrite t=
his.
>
>                                                               overwrites
fixed.
Thanks

>
> > +
> > +config SEAL_SYSTEM_MAPPINGS_NEVER
> > +     bool "Traditional behavior - not sealed"
> > +     help
> > +       Do not seal system mappings.
> > +       This is default.
> > +
> > +config SEAL_SYSTEM_MAPPINGS_ALWAYS
> > +     bool "Always seal system mappings"
> > +     depends on 64BIT
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, uprobes and
> > +       vsyscall.
> > +       Note: CHECKPOINT_RESTORE might relocate vdso mapping during res=
tore,
> > +       and remap will fail if the mapping is sealed, therefore
> > +       !CHECKPOINT_RESTORE is added as dependency.
> > +endchoice
> > +
> >  config SECURITY
> >       bool "Enable different security models"
> >       depends on SYSFS
>
> --
> ~Randy
