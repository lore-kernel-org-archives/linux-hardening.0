Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74498392819
	for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017827; cv=pass; b=ldQrmgEjBlbBH26c6EpJIyJrskzNr7V6D8nozLGZ5hfZMJWFveD2o7+CrZ8W7s3B9L/fXRN11HwwdyWNVrUU7yl3Ai9xOCo3PEl/4t06jRaiBKEj1LxIHsmT2wQUNUDu/boMsirKosarRY1DQVXJ3Swuvdftduisd4UVXUn2Nbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017827; c=relaxed/simple;
	bh=pdSmqKRjR4iQnKLcXzrbYQIwBM+k4EOWLhC5BihQ0Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXmYlXTP0xYjChrc0vaRlouOaud0ESGhq0203UGGnwLqlCag6GtP+fDWAV4XQDnjqJQbdpddZB3wSkM9z6ddTngWp/z09KGNbcnVLCC3jbocUeTgkvhrvn4EGuV8ysUl39I/wPt9Zr4v/SXgqlEKwvroh1+F4M1fpGw/deVmAAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpEKcBzd; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpEKcBzd"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-505d3baf1a7so395231cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 03:10:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772017824; cv=none;
        d=google.com; s=arc-20240605;
        b=jcjRCwFd6JJ9sw224tcZbHx6yWfHPnpEs8Z5FTlyvOmEqVR0brTyHV11dsEWMke+om
         t3MuDOCWzPO8AE1kmyY1HYjynvgdh3OBDV49fMch+SGu+ZPzLLu8Im+EEnmPTpJ2UBW8
         PaIE2dT9zdd5tVUATjjON/kO0S0zEaHPF3O2bWBYIO0OJGq/vT13xPwhnCMAF+MoziJH
         21WWzeqjY3bK4pcMeVEVx83MpuU//XNVL5W5WxzbAx7fCquxfgBVfhJ2fVssOR6VKq4/
         LNay1QZzAtM0zZ9+k498hWsEtHXxG4/ipED+/q1SrH/Ee6280gimnXahoenyhfbcOUse
         t2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DsZeuYgIqCV3nl0yAnM1bCPBTAlfUBvv1YNt3VOPvvw=;
        fh=mzDguj89lqqAyl8QymNs69mr44Q1KTfwckJF8tGSilk=;
        b=PYGaGyck8IXaPe6YhLdgagVIsR0fHzmsThCvedRevY+Llydbnd9j37HPIWi57mMSas
         gfNsO3iMtA1MC678wd/69wOf4UpohG9LV1LHsb6xgGpdMkfz19O/VuNGeC0vXIiWHG4U
         /iD8UHIWpOSPbVr8hljoMmObYQoRM+9r6jzgbGFOEC3Xxb37F4r8tu9FNaZ7RyatOI4T
         RLVlLbQfVHwmBKzCzmh0u9M6F/Dm0iEQ8jv0rRIcTp1mp3YPtFrvdXN14EFrl2ejPZWa
         W3yYmlUCZzvjyZIFeTdNL3L9ms48xbddAFNQkY0wXlTt53v9n/7+5Dj/HyDorwDaeSsy
         Cdaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772017824; x=1772622624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsZeuYgIqCV3nl0yAnM1bCPBTAlfUBvv1YNt3VOPvvw=;
        b=HpEKcBzdV5v+S0bJfABuMsKpm603PS5lVp3JaDKOBLc8ralbLU1qhzKAiXi2oJr6+Q
         TDI/D874FMqTGtAIu1tqkUz/F/Xj/ZORMrWSHkA/57gLc4uNt/FvgiMZJc0/+jpzohvY
         sUNciLc2IVSAAwX9JlqMqNIcuwF39KcLTrntW2Az9k4RO/+aXC5QVWNic9l901sPnBWD
         s2YXbBal5gbfOTHMFvJvAp3z1ErKhbgmfroCjbbX/vffCL9uHXpvBgzyeWyk0yro/l+6
         GeSM2t11dfe+x6z9HROICMWst9VOW2h3+Kpv0xOHcIR07pZiOoVorBmNiKYXQMXc9LVO
         XgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017824; x=1772622624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsZeuYgIqCV3nl0yAnM1bCPBTAlfUBvv1YNt3VOPvvw=;
        b=XiOtQl2i0StZ82p3ZEjFSWfbSg7K6turtihsBHAMbY7/ybTBXAAOaPB2dMRjuBm4xi
         8rk3eCKmP9qDkBfVZAzUUN8bg8aWgQkV8qbPipWBIGaitAhVmH8WXmjdM37LbvJdX/Gf
         1+0aCydcsYcTxFL26DuUerBmuflT+AAJL3wlybPPJR7rovF36EZYgXVo0CDGer/2wf0O
         WILDWKKbU0pK/3eFoBeHQ1abCRpjXnd9oATSjz208k6U01Q+p8OPWGIIuI4ewuKtE+2G
         s8W4S5VHfzNMTiopZ9wLgJYp3eFMzcEfqPWlgvqxOAUnwCvisEhgljnQ04wEJiceWUgL
         VSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPNMYIjGiIHdXdCbme/FDveobJjw90mvTsyVJJ1qsD+cKzqOtH5P4Nxe9+pA89z6dSHItE4BP4o06x0SHjjg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQnh+AevfA4lZlXwo/vmxsRmFrSkDU6GtgBinG+p4i6+UnaAi
	7VV2xt5jqY0484du4ENKN9OK8x2YIT8VskcPQSBQlzv4mwJZp1I5m9EfgFms5qT5e/GHkkJSf9z
	QIls2V6yORdhDRI914Db5plre0Kh30CZBp4SfbZAf
X-Gm-Gg: ATEYQzzVWNjrrcT1AnF78zCiRQ24n2MMTYDtD0+NvJan01EAC1J5Cp4Hq/+bEn84rrq
	YiUlta3PE792a3d14w45VWRU0rrKthRn9124ErnO95r5MbPpuR+6/wv8rC28jaBUrF3CBBqmfQS
	KiF52KftISj9rNMJIR1opV9++eILaBfa29XHibGMpUqNC6ogdM4nxCoAPcahIOxJ8gLxLKCq+cU
	J9Z+z3vpQx/vsffk/HJHxKvXoetsBAuqssUzlMMnnM12TQqF7c0LXtEHbodiK4VLgbok6+QMXT/
	OZAiu7Vo
X-Received: by 2002:ac8:5e54:0:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-5073a34ff5amr9511671cf.13.1772017823830; Wed, 25 Feb 2026
 03:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224170427.2296592-1-tabba@google.com> <aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
 <CA+EHjTxgX8RpVxdf1rrri8m_=oG-0_KpYzhEKaZXXOr2UXWegQ@mail.gmail.com>
 <20260224230637.38f93836@pumpkin> <CA+EHjTyWtdwQe3_pyrrC0jfhX30jHwYVNQkgNE7UoeJG0O=NLA@mail.gmail.com>
 <20260225101119.0481a005@pumpkin>
In-Reply-To: <20260225101119.0481a005@pumpkin>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 11:09:46 +0000
X-Gm-Features: AaiRm50dTqHM35T_Gr2FtAgNe5MDjMHgpegZZufX5aEUZ-yZbuAPJu8SobGd67E
Message-ID: <CA+EHjTxmj=m4GwV5TJbYkTt5tnwW-kc_4=+_wncsgpHQ6fjNRg@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
To: David Laight <david.laight.linux@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

[Andy]
> You need to check this on _all_ supported architectures with all possible
> related configuration option combinations.

[David]
> That very much depends on the exactly how get/put_unaligned are implemented
> (and the behaviour of the compiler).
> ISTR something about not using 'casts to packed types' for the them,
> which might cause the compiler to generate other code.
> (Brain can't quite remember...)

Fair points all around. To be honest, proving the behavior across all
supported architecture/config combinations is more than I can chew on
right now.

I initially stumbled across this UBSAN splat on arm64 while debugging
an unrelated issue, and I thought a targeted put_unaligned() swap
would be a straightforward fix. Given the complexity of the
architectural and compiler quirks you've raised, I agree this needs a
much deeper investigation, or potentially a new write_word_at_a_time()
abstraction, as Andy suggested.

I'll drop this patch for the time being. If I have the bandwidth in
the future, and if this splat starts causing real problems, I might
give it another go.

Thanks for the thorough review and insights! At least I learned a bit from this.

Cheers,
/fuad

>         David
>
> >
> > So this patch shouldn't introduce memcpy fallback penalties on sparc,
> > but it still fixes the UB on architectures like x86 and arm64.
> >
> > Cheers,
> > /fuad
> >
> > >         David
> > >
> > > >
> > > > > Have you read the comment near to
> > > > >
> > > > >         if (IS_ENABLED(CONFIG_KMSAN))
> > > >
> > > > Not until now to be honest. However, are you asking whether
> > > > put_unaligned() breaks KMSAN? I don't think it does, max is set to 0
> > > > when KMSAN is enabled, this entire while loop is bypassed.
> > > >
> > > > Thanks,
> > > > /fuad
> > > >
> > > > > ?
> > > > >
> > > > > --
> > > > > With Best Regards,
> > > > > Andy Shevchenko
> > > > >
> > > > >
> > > >
> > >
> >
>
