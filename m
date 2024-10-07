Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813B12E75
	for <linux-hardening@vger.kernel.org>; Mon,  7 Oct 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313255; cv=none; b=FY6rlLfE1mIRDZX85igTjOlze0W/fLMEW86ikh4mjoZjLnwXZ9l3d+RdmeqW6sTo4qMBFp1odQDZHN8/w4/B8bUT1rRZB+449Z20OxX0jKGIAYlI4ElO9shuZ0pSaLF1+N5lueKfWcIuL7/qQ9bobN5/8NVsc9hA9iWEwgRy3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313255; c=relaxed/simple;
	bh=eeLGTaY8KqxzkNo9oqB+n+UXnmZmzTM0bn/5+C2T2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNcTBNZEAWg5bYIXVOWQZf0xcJBVZKl7HKcZvtWWSLDAn5yvaJXF7+iocSRNwHGB00G6x6t8b2NdgYRml9zlwroBMnKyh6FqGadcRx8drcDwfx64BXJKuvceaiErmeVEWF48HroYVHID/a7lG/eSjJbfkmdITBO40dh1+a/8oIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I5pFAtIJ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5pFAtIJ"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-287233b10ddso182905fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 07 Oct 2024 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728313251; x=1728918051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc57RBPlFJ6sr22T7uR9ml2TEcMyvPjZh/UA86D9Fkw=;
        b=I5pFAtIJsbZJR92ZF9Ugr8NxMk/M0WfSipG3o8ff8YpoQ4GYwpQZzWa5U2Icp3bDtv
         iGGImHsxmCaNUR8TzgnDe5cQVeujAGR5TZmeT+5kMZI9tVmbAo6OQbFBQAB8Le/6Unow
         8y2gqSdDRRaGxLmaNHY5W/aE3qcEN/lLHMRUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313251; x=1728918051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc57RBPlFJ6sr22T7uR9ml2TEcMyvPjZh/UA86D9Fkw=;
        b=PMKppJhkuH1eYXydCfdyGjcXavuz/9bU4v0YtcU+40IHuThgPAJUo3QgRGaqoaLDot
         a3Ces1Nppr2+VFCL1kBDSYXUkPkDLmEsj446pWpbxXMtnmxcG5kbA4qgyz/go91IRSQz
         ykMVP+xL39ow2uOK0yQzjHF0VZjUIRU7XImdhFxDRTw7qGcfSYCvgpGUgEiWGnZW7j3c
         StXaHMihcyr5IXNNNZveTHmgEQLl5QSpejq9n5A5SJ/1SZ3JydIpog8Fa2j3C0rVVPbk
         xKTYWKhdQBVPveKq1KOniK+xp2MSFWPADZJRnzN0otptf6aMhdEp9eYWgB3AAwLYxLAe
         8ibA==
X-Forwarded-Encrypted: i=1; AJvYcCVECorFVcDQke7iNa3t6jEulnKCfTC6e2+FmiMLoIc+jaOooKEEYkCqWbYa3GUVW1cuqBKsCXuMTPC2peTeUuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYyxHk54UxWX01EuQn6KZWw5IR6AO9U4mQaY+OPqz/vlF3JzG
	rSZkozEMnT3x3j94x9KWRcD7f3qk8jjKV1wJqrBnxsy0kB+ZcAPDQVnntZMRDeVRJGxvaI/3XOC
	DXBkjgiyriN0SpS4xhkraHbo+CfV4CF1GJvQv
X-Google-Smtp-Source: AGHT+IHFS/U+IzTBLUlqNS98m4n1M2wUlsBQufb/OJIUKIaVZlSRTFRaFeWPqL3+7T+d/Wx/XC6deEwpzONz55ZPW/Q=
X-Received: by 2002:a05:6871:58a8:b0:269:1020:a8a0 with SMTP id
 586e51a60fabf-287c1e0d926mr2733439fac.4.1728313251339; Mon, 07 Oct 2024
 08:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004163155.3493183-1-jeffxu@google.com> <20241004163155.3493183-2-jeffxu@google.com>
 <20241005200741.GA24353@redhat.com>
In-Reply-To: <20241005200741.GA24353@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:00:00 -0700
Message-ID: <CABi2SkV7wXa-41d3w+oL=+1zCcT=qjynRTdWnkVr+BoDqQK+3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, mike.kravetz@oracle.com, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 1:08=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 10/04, jeffxu@chromium.org wrote:
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems.
>
> Can't review.
>
> But as for uprobes, I'd prefer a simpler patch which doesn't need the new
> CONFIG_ and/or kernel boot options, something like the patch below.
>
Ok.

> And I don't really like the fact that this patch changes the behaviour
> of the "generic" _install_special_mapping() helper, but I won't argue.
>
This makes the minimum code change currently.
 If in the future, there is a special mapping type that can't be
sealed, we can refactor _install_special_mapping() to support that.

> Oleg.
>
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -430,6 +430,8 @@ extern unsigned int kobjsize(const void *objp);
>  #ifdef CONFIG_64BIT
>  /* VM is sealed, in vm_flags */
>  #define VM_SEALED      _BITUL(63)
> +#else
> +#define VM_SEALED      0
>  #endif
>
>  /* Bits set in the VMA until the stack is in its final location */
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 40ecab0971ff..388373c11593 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1510,7 +1510,7 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         }
>
>         vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
> +                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|VM_S=
EALED,
>                                 &xol_mapping);
OK.

>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>
