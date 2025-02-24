Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BD266190
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422660; cv=none; b=TMHTp0FDVmn8vDT6KrJsyRoYcq7QgHVLwYcynARkkYqWxU6HgZaUlnRH79jD7ASUO7fWByxGdX692MBjcKyskWQi7Ny865LvpVvNk/ZzbMV6rqUwwhYFxKUKXxivu61/b/Ar98JpJovFSzjE5Xo7VjEztOC5tIVoHs+VrpoS6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422660; c=relaxed/simple;
	bh=khj59qHPmTHqrt6WaeToKlT0AivW47rW2SfqTzUq9gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLyWuWRAkRUD2vTYidceUL/uFtX52xc5ZT77IO6Ea61gnFxpNAXnYR05UDxYXPMipZQekXz7Saz2THE1OY4RgGSdd2BbhTe8IDqvduUyaU6LG7+QFhRRGuPetygi47vJj2jjgjFqB+3dlyeejmUEgE2Vn8sYseXlJwAV7EC7Y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CpcE9dJ7; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpcE9dJ7"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f40b7899f9so75647b6e.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 10:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740422658; x=1741027458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3xWA/77tS/bA1FDIGO2ulCuHvVLqpsD27PQsdyeLvA=;
        b=CpcE9dJ7cjnzj/lF4aefTjDC9/dHuSQdNXujN1lzu3gHUEeQ1i7CM36vYPVTbrQx2c
         PkkwQ4vtxgH6nSyesy9KlAC4GbuAmzsGZB2uC7oL0S4FCdorLyobQEcqMxPUIMobhC7p
         ookijqy+E7cEc60OkFm8C83sRJBXk186jtqG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422658; x=1741027458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3xWA/77tS/bA1FDIGO2ulCuHvVLqpsD27PQsdyeLvA=;
        b=D27WYULiH9DkLdacpCqVxdiuCydRYcV4INIwbtcR7WgLbyafXwk/OMnSNR/qU9LINy
         EKn5y6JLXnxPg8IT9y4H9mDXnRLLC907T+Q6iZeG/owIAZDnpsYC9ZlXNPjzqZJ+xcR2
         ODyfIUKIELyXfnbqnZd5u/n8NKZADckXZM9Y0ht+/eKjh/OXY91wMGsObXsMJhvuUzl6
         XHk19BAeUKY2/vMqz3rfFhy3CrB/+SEy1VxUZWPEUpo3JTpqCfwbkp8ow6Wgy0LlAsMw
         k1EFDx28hBCGIzRaVoPNDdP2Nd6en1myRr/ntJzIKjNJWlXotovBqxRxwtdOuUMKaUwU
         lKaA==
X-Forwarded-Encrypted: i=1; AJvYcCWszQJfY5OfsauR1u81BmAvcQR0Cxr2SW17pIJ506sc3rcL3dNMc7SJnx6C06tzRuznILd6CcM0k914XhZeb+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RubY6NjDXnyG1Ae3tusfFIdTPiATBKbdIE/iWU1pB2kl/ZIi
	EkD6lRKK3Rxv76c9UwxNYMyLECYnzHkBTDzyCdsDXrVqSsm4VRuzqPDemVOq0TvNBJ0/BoaOQyz
	BTi+LBSg8RN84VjbI4dp+bchrFXUVI+JcSjSJ
X-Gm-Gg: ASbGncuez0zkWZgWgNNFbwd0mGObNAGccqZ6WdFFEd3vz/XP1Ug7p8QkgIsax7FojUG
	ybkPUnqJpYTBFonDEGqNGVx6esbQsRpUCM2pmsrEglF26yc5lyib+lH020vc2oY30KjdZc6ikPt
	tzqWdipEn+PHbaQUgeFp2Sackvz4uSLNYXCcFW
X-Google-Smtp-Source: AGHT+IFN+bvliOIeTRCEzzqueIeoaQOjdPQ9OrltDO6mVppq+7ugAyjJAg5Sdh7fwscXh0PnNqV1UaZJHQv0Bp5Y3+U=
X-Received: by 2002:a05:6808:1525:b0:3f4:1f1e:7459 with SMTP id
 5614622812f47-3f4247bf741mr3932358b6e.6.1740422657819; Mon, 24 Feb 2025
 10:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
In-Reply-To: <443992d7-f694-4e46-b120-545350a5d598@intel.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 10:44:07 -0800
X-Gm-Features: AWEUYZmHQiSO8llCjmhY8a1Y8Dk59_j8_WwL1SOLQEoLurxsiSGp7YKgCz-mRG0
Message-ID: <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: Dave Hansen <dave.hansen@intel.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > +#else
> > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > +#endif
>
> This ends up looking pretty wonky in practice:
>
> > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
>
> because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from the
> other ones.
>
> Would it really hurt to have
>
>  #ifdef CONFIG_64BIT
>  /* VM is sealed, in vm_flags */
>  #define VM_SEALED       _BITUL(63)
> +#else
> +#define VM_SEALED       VM_NONE
>  #endif
>
> ?
>
VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
the build. This is intentional. Any 32-bit code trying to use the
sealing function or the VM_SEALED flag will immediately fail
compilation. This makes it easier to identify incorrect usage.

For example:
Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c,

#ifdef CONFIG_64BIT
[ilog2(VM_SEALED)] =3D "sl",
#endif

Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
in case that  "#ifdef CONFIG_64BIT" line is missing.

Please note, this has been like this since the first version of
mseal() RFC patch, and I prefer to keep it this way.

Thanks
-Jeff
