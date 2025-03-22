Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053B2E339B
	for <linux-hardening@vger.kernel.org>; Sat, 22 Mar 2025 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742608255; cv=none; b=qCNRgNW8KJcQrohFTwsRHBlOnFAVsgprxAhriYBQS90TS8KH2dJqf+iPoi83otp9pMMTPPfADFgIeUWTsaA092r9Qsdl4HI3AW8T5wrLBctQPjNm7eeSY7cUkFZ0Xo85gKKw5qFD7qBg+ORMCgspNoSnFmuK4RIXCxGP2d0kncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742608255; c=relaxed/simple;
	bh=m/tzIm+7XlBnnxEQSz+SdbtZkGlp6oT6j2MmSPNUbFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLtD6xtEshBKAs2b7LifL7vR/jmgcUgAu7XigK2Po0LpQMgXrY2+Dmv2NWtk+X04ojslJqS3lUuZilreRMvVBX5/8suBkj/qT1HKp2xVsob0zS6bEyU8Fz3c2xYyOmbkJbU0PhdqTGtICrq2opObO48LO8gsXtMZaZb7JiYuJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnxfUX7+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnxfUX7+"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso4371a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Mar 2025 18:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742608252; x=1743213052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bAMqt/kp5xNdpGpWqBm0DUWrT3oTcv1M70fkdyOEMI=;
        b=ZnxfUX7+o1Jx9qyOBgaigjP9wa0+dKwIw2g2jgNiwKLEeAjgB8wbvRJoLGvW3GZHeK
         OmtlAodYnzdaIcsleFXn+/JaBJAP1cY4c75qCj/P7PU8CiJXhryvQWMSQ2VXrshVfjWG
         mg+QqVC/L2ymFTshM7HaMh/JGmnPqiEP0SeWiqMoq1qeGChW05e88m2llzfvcD5eaFVI
         0XE9ITQukaiBfsqUnP6qv7VpeR3zSy6I58FRyaJYTRwqPJXjERPQjjjxL8yff6hPrduN
         czGrh6+zijdC1TQydZeNHvjr8UbFm3msItWpofLgCM8mdm727PN0T30mimaGfMZARwG3
         Yl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742608252; x=1743213052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bAMqt/kp5xNdpGpWqBm0DUWrT3oTcv1M70fkdyOEMI=;
        b=bNNJMryXpHJv52qdBGoQsyflWNtga8aazaX59XZPiUm6wyVaY9y19ua/Rii0OVdJTD
         1HpgkH+5Udwe3Bif0fe2HIn+6x3Sy/rvYBTcVhdlPBRbnHSqdaUEwLhOkLu5SolixcnZ
         VZdO4dmJdJriL3CUCh64yTuCmmxBiUPvwEFq5a/2GZ9eTM5zGsTaWMXbc6JfVKQx/waO
         ax1ZFfO9eV8yPYZnSqGiJO78gFKKl0NIGQWzraT1MehIGgsb5qCRr74xZ4zmewpOiZjd
         cx31IwJ1jSe2QFAnCZLfz7dbQ5/SKv0vLIk224XGCGhjTrzXa50iidI1csNR8a8nFzPV
         VkOg==
X-Forwarded-Encrypted: i=1; AJvYcCXc7ul/mahlP84bGXxepQL5KRf2YQXrwu52LyITg1SkOzNiENrK9vtyuw07DmHszu7ZKCVRWb9Ia4Jd6ImDP4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVOHIplfVD0c+Zr1R0cXEsHfRQnAwJWp7tdH+OS/dArn0G3wE
	UIQ9spkra26r0w8srgH5HXoinW3oR+hMLj94vovRUzX8ENVLfpqgy9Nt9vUEwQ0A/UwSVoOhR0L
	Q62UDu9vsUaJsF+/Pw4E3/W87FVveIghceJvV
X-Gm-Gg: ASbGncvzaMMAZhDvmIZY086Ai/jwRvna1MFhc3hnMx1bgltZMeFggBdz/E0bWoENqXk
	iTikHaM6Dh+oaPdCOYGr3ruOtCV0+JOoRDHRuIoAVYxg4mdHx6wWI6ntIOSHDAVqTZkkLn3vHXG
	N3AsO891K8eCF0HZPHaW0YYyPj8sllE4ijdmnnDTgsu2arLbSDExPjYbxV8/uJyzOQ
X-Google-Smtp-Source: AGHT+IG7SqtDMOefUjHv5ne9WUK3g+yBu4XthxH3f4TMP/qf+N1EOd9SjiMcRqk87Yg1qrHnesdNGamPnVPjQCloWmQ=
X-Received: by 2002:a50:9e46:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5ec20b2a1e6mr23783a12.3.1742608251799; Fri, 21 Mar 2025
 18:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321202620.work.175-kees@kernel.org> <20250321204105.1898507-4-kees@kernel.org>
In-Reply-To: <20250321204105.1898507-4-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Sat, 22 Mar 2025 02:50:15 +0100
X-Gm-Features: AQ5f1Jod17mZvChlstZSJR1ZRw7owBX6xbKHmuayoKFP5Ryp9maZ2Z5eVrzRgpc
Message-ID: <CAG48ez2-stu91bgZawx_AaypEuMnc5=nJQUiDzUCb+CbsJS6kw@mail.gmail.com>
Subject: Re: [PATCH 4/5] slab: Set freed variables to NULL by default
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 9:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> To defang a subset of "dangling pointer" use-after-free flaws[1], take th=
e
> address of any lvalues passed to kfree() and set them to NULL after
> freeing.
>
> To do this manually, kfree_and_null() (and the "sensitive" variant)
> are introduced.

Unless callers of kfree() are allowed to rely on this behavior, we
might want to have an option to use a poison value instead of NULL for
this in debug builds.


Hmm... in theory, we could have an object that points to its own type, like=
 so:

    struct foo {
     struct foo *ptr;
    };

And if that was initialized like so:

    struct foo *obj =3D kmalloc(sizeof(struct foo));
    obj->ptr =3D obj;

Then the following is currently fine, but would turn into UAF with this pat=
ch:

    kfree(obj->ptr);

That is a fairly contrived example; but maybe it would make sense to
reorder the NULL assignment and the actual freeing to avoid this
particular case?

Another pattern that is theoretically currently fine but would be
problematic after this would be if code continues to access a pointer
after the pointed-to object has been freed, but just to check for
NULL-ness to infer something about the state of the object containing
the pointer, or to check pointer identity, or something like that. But
I guess that's probably not very common? Something like:

    if (ptr) {
        mutex_lock(&some_lock);
        ...
        kfree(ptr);
    }
    ...
    if (ptr) {
        ...
        mutex_unlock(&some_lock);
    }

But from scrolling through the kernel sources and glancing at a few
hundred kfree() calls (not a lot compared to the ~40000 callsites we
have), I haven't actually found any obvious instances like that. There
is KMSAN test code that intentionally does a UAF, which might need to
be adjusted to not hit a NULL deref instead.
(And just an irrelevant sidenote: snd_gf1_dma_interrupt() has
commented-out debugging code that would UAF the "block" variable if it
was not commented out.)
