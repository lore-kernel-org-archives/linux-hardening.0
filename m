Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F84FC8E5
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977350; cv=pass; b=T78fGFl8TOVwYkuLa2Jx1oHIMKkGLU7pG9BsN+LvmXUsmlWyP1U3dFxWZARqSOpr/bixAGrn+GGxE6jX/jbIDgOVWlK1h5/AkJi9fn/8sMvGhr1dLsipFstU/TWmFse/NhWK3R0wVgjnQxRAoGvuQFGZBc+sCbqEv4i2FYP9hjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977350; c=relaxed/simple;
	bh=Bm8IXeZCCjjHRHqufoiH0uSm7tIaA4fZ4x02DGLBDgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNLC6ReR1O5O4XtSoKpg0aKEKDX851ovlymhTDZqSBmijfZktP6EnG2PXR+rTrHKxFUv71BMl+iaeeGdzoo5T+WP0Y0s42TXJNMCeMngINkYd8ZtNV2uBEXP+hhjRHH9zqR78uZ64L92AjpRhmZQoQfGz3iPkPvumYTDAqKSILM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkAqllS7; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkAqllS7"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35179d0747fso306969eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=VDGPq6cWLP0Y9MIrUcivgftapgs53fUiGJc3/HE+cxUW02+TxK8jpe0ZD+jMd1pcCe
         maBFj2kgqzBa3ZqBmcsJAZyIlLyDU3WrTJUEDWH98ncQ+RcuTCfL7L982miLH3ANbQVV
         6NGaD3SbMcA4Y8Y96Paqpm+TKOlZVJ9IlqfQle3LWftc4Vt2D8qWr5Cn6vj2hAc67IwI
         kZF2X5Kt6NcGZuVjUo1cxfmGCR1U07WPhwhzLk0OPSEaNkpzVoJOUqfkFFthCaGJ7skb
         xC6GaJvUoz/dCVMx5eusUOELqUXFI2KMJtu650Vj8TWotk9j1xg3/KLXF022yK6DHbo/
         DmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=cQES0jNkd3GUI+N627/n1uqexiTjFZjAHs8z7ZFinAI=;
        b=iVKsvLPUwpDfX79Qzp19kD9gavyawTIm4hn7nYnnl/a/B5dyl9TakOiu0brVObHXfZ
         5TBh0cCTY81HtYprYV6++JPd/69cpRkkkO1Db97IbYR+yLWmneKheu+ChfqlNOXxMqPh
         8dD9gJsYhsw74UkTWGS0DEEYZfChbtPmDS0yMvIPuWgzhts5NUsCNLU2x7RIYZHhRsN8
         u7GjDLmxaGvnY4fteE9j5Seb2XIrpfZuqI0aFCVpwbMr+M1YFz46TOesB/0pvgtxbBfJ
         bSpZoHKr8HUzOESoo+Xyoyv9zwHelVWGha+M/VDJVEbknAniAEDBUiQiE8O1pRBlYNnL
         G7+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=EkAqllS7uOOZxDGJ4I1yKdIi3WQSBbyUhPsWLoVzgJERDBlfP0X9cEpWzjyHAR90JC
         Z1zW2YqVc7X46XPiuAerNf9mNnAJ0uUF6PLz0rzePzi7U1lf5J9vz/gZr1IuRwk27MI/
         4/D886vhZESIUjDPJZRvHbQYWiiMvCS3NjhX5siJV1JzVFlBVMBE4d5Q1ZOlRDw5uGo0
         qEQHzjWEYvo+agj8c1xw4Nkq2SVQg9Ys3jvU8s3NkIQ4fYLQcX3kMyght8wz2N51o7tV
         AXXBZTinlSID6wvgzNqIrr0dJv5ZGB14N23uEZXq5jf7doeVho73k08XFK/CJX/hTW5i
         pPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=NBAt3vlphixzKSupYD4UvO7FRwhr7fukFat71S2gZ6ON3RfiAT2zgDChUViLFgnRY3
         gZLUdd2abDla7TkQN3Wp9tzkpJureGyu1FrC4AeJgTlcapMdev1MaYATIHquiOg2Hgpr
         /kmQK9erlaHjPJxDSTVnCX1tTlk2akK9wHL2uc14sOJU0uOt4GOs224u8NXBsiZkn1st
         FQ3+EIEvfkCXd3EBXgMhyj25Yhj5P0WST7SCj3Q88R9x6k7xyuK9wtfo1BwGMjn3pUW/
         PFIo+pMEjZq3U8MjGjAWdqfOS65FGlOfAQAFyRZ0SHFjGiLPjkRC2A7TD60xkM7eMr9R
         JPsg==
X-Forwarded-Encrypted: i=1; AKwUvBxYWvIhCCfEeWK0+Z5eqySHFvDZxTcv6vn55gdSlH1duhfF71RcoRjPHWOLaTDHJ6C5rW1TUsfMerA8VdfwElc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu2u8nlV3QfQ6BZT1K3DCZjtpv+QcNrhfAR2QVSvo7w8wjy989
	XAFbDSBr3cT27mFvxKCDiE3zFlimff9GPMIudth6TQ1dQinG/fBcUTmSpY2InquT0pH2YzB/RCB
	fV/L+3FTpw4qQuAMXZqUWbd5sOWn+a5M=
X-Gm-Gg: AYBFou2r0Po+VGG4oaA9vnT82yCvDSsQmkvxQWiRYVwUpT88Yyy64+r7e9Q06/5ruMY
	JQIjQ5grpSFPncE74fumFHNydNlbq4owtULi6gbzFf3F2TfbOLFpKinE3f7N9mfMBptcV+tR4Rt
	k9IHaAM6+fpGqZBNnwS2hfNV2HwgkxJ3NSI19nkz6r1Gm7aFno4gNBAqC3jGH/9TM0Hqx7Vj5qw
	Mp6nRrCqKNomY7V0K4sSI/0o+8wwbOl5R7X3r2uVSfv+TfKWdk6ewravFFR1Y8XmZl0KPhETo2h
	9udZpQ91mGcENdQqTeSfLlemt5vmkLQGQxitjTXq0yW5uiZ7XGPXDb4oUZTYe1DQk1IpmeuVc6P
	iROe7IWct7bk15grsxrrpKOEdgmXUqh212o5a5LMku98NKt6lK0yKy2vLifH6x24EZp1H7kHaRE
	uSkkj/Cp/Hl+DKQGO85ZkohTy1Lvzq2uPqt3h0DrF/5ykpwPa1HXg=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
