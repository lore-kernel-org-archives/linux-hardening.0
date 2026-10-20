Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515960;
	b=1/qARmb5Ekuxp2M0a+wDRpeTzkZ5zW4m57XywPM/VeZOmpxbavsGJnfVQR6CP5fst7Cl
	 ynhcGGuBU8CLn9ml+a4Obj1O9sd58MtSFxJwr2Yb8lDOIvVToNGOYB5yqSzXRZhOcKNGY
	 /LzuFdmz+T1so3Y2lxl/r86xgnEhQQt/0/uGTLEuSchpL1jKwX7yp5Uu48ZVfSlQbJio9
	 yFByx2kM4+F2JjF5UFiVqy1s9JFUbox7REbZo9CwvoA297AIbgHgpqYtzMujIh808bNCY
	 Dz9YV++lPRO79Nv9NZtXnhrIT/tNT7ZzndsG4ncoBSFn7Vc6XDyZlQ/3RiFiyK8huvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
	b=suQAeffw0JIDi63qyY4k9jYrW5Ht5Tp45juyWryxGF2iABEWTpL8IOWgcSSV04P8SqoU
	 T9dmw0ItZ0LUtmgiTD3+PXvX0sX84FhJ4nNpn2zdC5JGDuygZLDzfq75RLEpn4M+1RnBs
	 zoECSxhd9ESFHahhhjIV0NFvw551KsKf1m0aHIXTnr99F9XnFBH7RtVcR5YpNPX0AcqE7
	 0OFK1vlYKtXBF6l8bM7U0FcPXzz9GlEQwGqYV96Aeqc23sswWqeBQnKuUkKsUe79el8kQ
	 +qlG4nmIim5m33aMGrRdwWYRiUkldwKmM7EZ2h5VHuCoF7ZAIHKaUpngYHksxsGOmVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="EjiCtsY/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A26606A326
	for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 17:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A26606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EjiCtsY/
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b126b23502so976547b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 10:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515959; cv=none;
        d=google.com; s=arc-20260327;
        b=Jk54pFdUvBUrZFpI/sQy0acyP0wIwMBojzn8z3WaLNL8XiWHNtog2ILCH/EbMFMRNv
         eJcuHNzP0o+GB3SRAS2Sfw37KsJInqS01IWLd91XK4HWy28tn0VpjGj7Oh6vVEgumcOi
         2ziwOUdFzSWyF4sKtws92yMf+B2FDYNYO/clG62N/xVdpJPv5Bk83GOh04sLs2XUhptk
         nwLGYt8KD8iSZbmK2epA0e+yKfKFEBSaHA+wk29KAHFn6zO9WxwDdcFskAOQXdhEQb4n
         8ykaKu3jK4KAQMCUKgTabdKrVObNlGlRTt5PhTbquYaZMK+4Eb3J6z+vgB0WB+S9pO/L
         AveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        fh=Vr9dwJQTAngegHWoTlaBjpTtwQPeuFzKuhejVq3VGDU=;
        b=qDXdBl5FobKzIzTNxo/ukmGDf4u2gUjo7/2GHWIyj6dkwh/Ii2iKmO7ateFw13y31G
         45WLkpIHYZ0MZmLUyoXis11IBRBP5rRAPisH4fSJo1tqYoiXkR2GYLKnZ80S0Bx4Cwfr
         oYTVZHS3awXu2VN0Y8Fdr7lqxjnW692hHl2fpOrpoUme3k1M1n8P2c4+ifRV3QRqy9YS
         HyP1x5ZS3bKRAx3WaXNdS+H5Es/rumq9bqp8LVfgExy8xXHirooZI8N88cpEqXjLUt/s
         +YTuVVG+6e+9FTT4NXINgIQBPTmvflfMESuDWtyi2gWBo5QNcSmsoMspbu/PGoDfMNoi
         3Daw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515959; x=1793120759; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        b=EjiCtsY/ZOF90gjCs/BDy14TUFvLnpqFVe7zF4DpPHBfTP6HnmeZFgtdMcb9BvlJTp
         4pxSbR5yKKYpyLVtBdpCBsvyBRD54nXnijUfOskpIyUAV1j2g35x18xFYvNJmyTIYgZt
         0iuxf+Px6JyXIGwyCSNSM6+QMU9PoDZyA990d3LGTuvOicsVF4XRBN0VpNObEKNthGjJ
         axPCwU/9cS7gMDkq+phYi5LAcbFA9Pi9h/h2LkktmB6IW4qqlRmTx/BLgILC5JIcw7dF
         bhbJlMjF2Utkn9qL1MppP7RH2+AGU3g8+qlJjopyhCLl6gosrso1m+nEzVxM4AKoFKV1
         xu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515959; x=1793120759;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        b=JZUFgASeZZ3tTdpqvdJ52tXkQhHRVWeSPC1nD6kCWyNXHscmuA+CW0TkBmdOt3Lm7f
         LbC7vNE5ADuyAwipEieKh5JraZ/BMDXP9MdzrXoHwWbNhaRCaw/CgtCyd6aqqlT2yD4x
         uy1Rjvdefj8dVksGAW0A9V/qWZcv9Oaov7f9BD/qXHXwlfhSE6oD6xgPH10mcG4Hj5jp
         Xr0N8/d5T+VTVTEldN1Yl7XCDfLI0yBSl9D+UdhU3O343LHNqTDbzKrmaxXSbwzaYIo5
         tfvSio7i9GB3MV+L5GOPl6OKhyxLn+OuXn75lFhK9NktAEf4D1d9+acVWZEeQc1PDVup
         9c+g==
X-Forwarded-Encrypted: i=1; AKwUvBydqO0UUWO3PkIiZNHBd5trkIdC+4xC4JQE1sNELa+zkvu8kYd5ImuXxGIdK7jccEkMaIpqO3Ym62McZjS0Or4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLglDSMSzJzBIsMs8qW8ROUaLnFB4i1mz62cuAk7JE4eiAYgfqj
	YwrBdYZUZCvRgpbGIjZZVoqyYP6T8O1AeX27xPUDiu5PMAO5Y4+Dpx36QsfmEF6qa8dLBzbGta4
	pAi80NOd7LHKQ6YE1UW07hlB4YVyI3Ds=
X-Gm-Gg: AYBFou3e1klN4YVJFOR4v5aZsrx5QFPdNEPlXoLF1WqzhhSeFQQFNrSU0YQZZ9zx/id
	npwo8+TgkRmW/FJ7SHMuKIvX9Tt4tOH9p4LnA2CKx064qknUJ+c+TbHXLg4KweALliX+QVuMJ5+
	BwRLdqB4WZ0ywv4eZZ11lSYbLi6lO2dSqSYGvA4hPiY+rAQRSJFaAi+J+NqzL9rKnQLWqcgMT1S
	aCCMtFM1Nf2A7GtUavX1fCGZ5HVGHVG6XmuLUNvvvBS7ofarfeW90fDtW/3MsAWJuMiUWmZJsSC
	9anC5dloODbtLs3BHyREVGIPI27HKeP5Q56xsurCzwlzyRWPbcxPLQ==
X-Received: by 2002:a05:690c:6087:b0:8b0:da84:d1c1 with SMTP id
 00721157ae682-8b0f1f1a89fmr64960787b3.0.1792515958898; Tue, 20 Oct 2026
 10:05:58 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 13:05:58 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 13:05:57 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 13:05:57 -0400
X-Gm-Features: AclHuK_DtrU2XCq8YwSMY07NqOt7wGt-hW6PGZPkgwrcRUr2dimhQIUPQ6PwL98
Message-ID: <CAPAsAGz89aKUHzm6U9PQZfkGq-GnWsm8AYHeo5+4u34LHk4uZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

> On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
> does the word loads of the dcache name compare and of path name
> hashing.
>
> None of the KASAN test cases reads memory through it, so nothing
> noticed that KASAN did not check these loads at all.
>
> Add a case that reads a freed object through load_unaligned_zeropad()
> and expects a report. Skip it with hardware tag-based KASAN, since
> arm64 turns tag checking off for this load:
>
>   kasan_load_unaligned_zeropad, x86_64, generic KASAN
>   without "word-at-a-time: check the first byte in
>   load_unaligned_zeropad()"                                 FAILED
>   with it                                                   PASSED
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
