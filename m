Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD62599A30
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097243; cv=pass; b=NxHp8MrLk8RyvxmEZtY01LNBn4BU0cpmzkxAjXM4pifOiL9pdcnloIcx+d7qluv+MRF6Q+2zEs5gf1ZSIU2ajLgazOv9HVouI+r8YQlV5dsZ8Oj2bJY18i/BsdwgxnLZOszfm4rS8LlmwZbwMx/8snM7DFDKw+Eq6t4lsjwyIUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097243; c=relaxed/simple;
	bh=L1vTqlNSlo5T5a/keujEElxWpHoRIlrc2YZnv8bHcdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1UCJ7OGHJ4chPu5BNIzPVJyS+Q3opVld0mj+BmgQBxEeLpIX2p4QtTxwDoGpC5hXZQSm2zD5uP95RtLnlgqIh+sqxjpql2E2u8wNL477Uqsw9iqHnFtQPzEly69M13WMDZRx5Ex521IOMNX0FAoa1b7w4lmuYBnK+hukatYAzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pydcasoe; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pydcasoe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso42228795e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 13:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097239; cv=none;
        d=google.com; s=arc-20260327;
        b=M0q8h0pEhAqi25OaepUS+SrcBlPhlcn2tCx2Pt4PyC6T+PpBvGu6MRm/KCZwJ+tgUm
         p2lqosOayl0c8esjIlHVuVDlYc02GZ9aCtqoFvnDLmfU7ugg+Aq+Ic3Ak5UdDr0yCJnZ
         f5LBq2rUT3GhtI+MS+Daeh1taeHHWE8WJaQxI2WXS/Vhxm1YCgnXCYd7p60Tt/LtxLqX
         /rVy2anhe2Jz1FNubTFEI5jup/EzJ6Mze+p3LMm9P0CqDkD3u33xEMug6vDDy4qVik6q
         mGelmRHYnEThOCE/+V5w8sjcEeYzmORkCzUvAmdxCrS7cSO+NYuu2pNOzJ1fL6cICGC3
         NewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jPqdmgliSQJVYELUQkNWh1QYQRXFQZopw8GTjLjl5RA=;
        fh=y3qyDWXoYQ5fgOsBnpEpY28PGXJ+7vmhoI7NLdiOpao=;
        b=BXrw8a/RbZfA80JruC79v6iyeWXsiF5TESl7qs9awxNKem/HuBBiIYm1JpJdI/93lW
         wLfV/9SIkigJLpLLg2QHs5bf1l7vL2uORXe6ocV6x7MfbEvYibtpIFwFe0cBhkOvdgXR
         WSJFvd/8HU4Hd1vqbuEcZVjUCCIceEwL/RoUnggwsqUqlF/UZvPwOsOz61nXHuWnAiMC
         98IP3ZptEyViRO4UEjW3sCcuY4VZd5wZ1CgzlTRdpre15dh3Zw5LOX98YIN3WtKdXxi+
         8mO2/2C1urobG1ElQU3/QYB+iGXFar2lScqiNFOpUc2YTud44pP8KE5UfwhBH9wbC1Jm
         cGCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792097239; x=1792702039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPqdmgliSQJVYELUQkNWh1QYQRXFQZopw8GTjLjl5RA=;
        b=pydcasoe4z/47yqageleE0oT4D4l35B9GzwOMMkmLnyVBXxWkqtSTxt740PAkPYnut
         RwhTbirSyc7BwPGrROB7IS70FBeneuUhuGOhEx/6ZCBStMrxb19i41lCPkZ29hZ10R5l
         pjr6Uz1Kmq3l6ksOdbp9K3vimLyRdgAlFuSLO06CaGLoWfIA4YZfWoeWWT6LxqVeIW9Q
         ETNGNlQxxuqVVnWh87bf3uQ1GoC3RJfCzBc1D2EZbFW7w4xK8YIwSQsms49fhIBbIXEN
         Chx/JWi1ky5QwxvlY9zhxvJ3bfweEXjzZxmXwVDeUkJt34hr7bVbMV1NWBMM8LdcVGfc
         1oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097239; x=1792702039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPqdmgliSQJVYELUQkNWh1QYQRXFQZopw8GTjLjl5RA=;
        b=n/S1b21K0OT1NY4rQ6k2GHaR4JEdDNBxs25P/OLmZtkSUKniL/LxsASRb0VqKKIgAV
         AvHfVZhnOo5jhILRag7icuh3f9Myku2yyFq2I2GozUElbXYrgk8h7ySZh+MVflr3RM+b
         5eZbnd0hZI8NrbkhNWqxVN4u1vs9f1Tzp3r/W+gRTKlFEwBzuMA2iOCGLExxe3tQeLPj
         ZL6jLIXZ36LXgTUnLSkIAFIStK/NexXrbi9+frhAqwU4UJfef5ujlc1jv4W1TQ+vpWG2
         BDdBPFD1jCg6ZU1cDzVzhaR5z82HeCWVhpQJislDt35JyTBGYWHmp4Kc/0SnqDXvA++p
         +a8g==
X-Forwarded-Encrypted: i=1; AKwUvBwsf4+wpPhb1lsvJPn3uWayfzueTYCJ3pqDXJpdnqYgiTdeCERwXoC2RLYJh4lRRv6+/wBbcOexPz6dOkAfSzM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6c/BDsTfErf+0njzIbs02zBQdOjXM8I3bHF6YACgOK1+7bFbR
	g3f/u+ovE52DQr8xGYpFwwZIyEcb4cq43G07alAB9plYGyLg9rZUFMyAPR+YWwOoDRD7oSpiJJi
	BSGlCONVceav8aqD7dksw38uF+dcJ5p+qo32K0Zh0
X-Gm-Gg: AYBFou0WveH1sF+C8IUgYoYTevw+/VpYZCtF+fa18aLTyIvlwX5n+CgTxoBtGpafgR4
	JAUwk10ITN48lm86XT73CS9g6GYmoaoU5vlXmQg4wmY1j0s6KVh4HS4py7TAhaZvqco5prAmOkl
	awkYBdaRW/IlENkug/svH99+G9nwN4U5GQ0CYidcJAbpXWv4Ygs1JoQC5hXuwt7837+bDlS0c8f
	PXO/wn/dSisAKYMIxScLIbGVGVKlBOagfM1sY1DH1fQZ2ugqCwX4BEPllrIM92dh7/FGXCierJF
	XKdb+aOd6cAAyPAvY8cSui0wNfHZkZrkGxhsnrI2CoOQoLSiEv+92UP4+n2mibrvElDoSRc8Qdg
	B80CKCDpx+u2ekvro1nq8Qc5sxn2B9EGYsw3sce0SAClamNn/JIM035Mj0FjAk2B9XlpvfB57ip
	uOe+Er9MdevFIV8d4/dBp/VKSW1g3D5QJXvVH6SCJcgLmK67WEJ4S5
X-Received: by 2002:a05:600c:1d20:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a18e4f50ecmr425834315e9.34.1792097238491; Thu, 15 Oct 2026
 13:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org> <2026101532-fantastic-deafness-e04c@gregkh>
 <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com> <202610151304.AA5EC855@keescook>
In-Reply-To: <202610151304.AA5EC855@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 15 Oct 2026 13:47:07 -0700
X-Gm-Features: AclHuK-rLxxhEDBL9-rcDMumk-sd1jsus0ssxmyF55pyppHSQxHMSWMGokd2Kic
Message-ID: <CAKwvOdkn-CniSBEb6ospWuLSGHmXkZwM0JuPcnNbW8biv7TC9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ian Rogers <irogers@google.com>, 
	Greg KH <greg@kroah.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:07=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Oct 15, 2026 at 09:47:34AM +0200, Miguel Ojeda wrote:
> > On Thu, Oct 15, 2026 at 9:11=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> > >
> > > __must_init might be smaller?
> >
> > That sounds fine too. I like that it says that something *has* to be
> > done (like the original name did). Hmm... On the other hand, I guess
> > "must" could sound like one has to initialize the field "somehow",
> > i.e. writing:
> >
> >   struct S s =3D {};
> >
> > definitely initializes it, yet the compiler would warn. Would
> > "explicit" hint a bit more at the fact that one has to actually
> > "write" the field, even if it may have been initialized anyway?
> >
> > (Of course, if one knows that the attribute only applies to fields,
> > then it doesn't make much of a difference)
>
> Hmm, I just noticed Clang isn't diagnosing for file-scoped definitions.
> I've opened: https://github.com/llvm/llvm-project/issues/232483
>
> Do we want to wait on this attribute until Clang has full coverage for
> all initializer cases, or land the attribute so we can continue to add
> coverage for function-level coverage? I'm worried about a compiler bump
> (once the bug is fixed) suddenly exposing a bunch of missed
> initializers, but then again we also have no users yet...

This is a false negative, right? When it gets fixed in clang, the
existing uses in globals start getting checked.  Nothing that would
require compiler version checks, IMO.

>
> -Kees
>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
