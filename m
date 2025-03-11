Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19834264629
	for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730092; cv=none; b=CGdWf5W94p5u5OI6BTK3Uahg6gYDUpbPu0VuzQh+NGtWtNbZFzChKoHk1SRTuhh1PGVWN5oxNyfOF8lNKI25SrolcFMDfBeZSnNZEV1h2VUCFeeLuhwB8NdzhbBpHdUO8p51vr43H9W8mZct6vzhFxYqhvjje+pF9cImBagQiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730092; c=relaxed/simple;
	bh=lx6oQy6ulCdJcKW6pyA6L4sW6xfoPq/2WIZT3ctB5TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSWF+xjhMP8FyodB0iNRi/XRLJ9tiPH7z/VrV/L/TkTq9dBN5qnHZKLZcUYBEcJWYbXyvA65z18w7CgO0cngHS2hyB1UV8BXbhs/io13aMYPjFGLKfNWm0M7N/dpqU0abSCKqURzlSR3qnWqVb6WuGWIEyUwozJNrrovB57HVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JoMB+255; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JoMB+255"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-601a15186f0so260222eaf.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741730089; x=1742334889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqtLjg1DzXxI0seit2K5+J+AUgYKo7ZSLSErJeqONSA=;
        b=JoMB+255sF2i8fhdBJHvHjw4KW+rB8y5LAiR03LkvLMSV674R/GMu9+QF8XjBMlpqz
         iLIP9Pt+mkVatgHHlktlkUlhiF7oKMQxzd0X6B/zR8iXgWVe+k3uO1AlcPb0lFuld7Sz
         Fl5I6xQ3tKuvWG2SAZHNszd8/Y2kKFFKjteKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730089; x=1742334889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqtLjg1DzXxI0seit2K5+J+AUgYKo7ZSLSErJeqONSA=;
        b=LUpNnjuzcZmiejAAH88lKdpFaI/b8y16fmhUKqnKs7VBhhLBjdkClTzoRsLWp0R2sO
         lzavU8w1gXh8dpOjqUsiy8uVZiNvgPcsN3+WSURdEOfFKWx6ARnZq+XtBorPzl6J0rAd
         /Ou27LCzu9zEmH0G0WWWQmg8Y2poQEV6bxMePpsSb5I1n+kfpJ86BLQkMJZbajS0hGlb
         MROrO+ozz767Jr7HiS8xRtaMfZcXVOjFvXicF9XCQKNIDkQCxf75GKHarAl7KBX1BbIH
         U9AjsNYTeVWL8vA6KrCkoHiSIUoCqTkDIqeK7YOEPNNqQ5pcB2n7EELOAoH5oJZtLMcd
         r9mw==
X-Forwarded-Encrypted: i=1; AJvYcCV61Jf7ofUJOb2IWxjFjyTKmtCS+qa+m1f6vBxskd9tspvjYKrs1Og/o52LdUf80rfxERp3eSyF0lSauCICvBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxai3F7aEcE+/ZePqDh+a0ioAutOSUl26KtbgwU671fvHGyxbZ
	HG1m8LsjhxJ30n/yW5sSepCPNuE5lL8Ai08hNAFHsEERJN/ZVU5i4hXjcXcBRl2n+6tVVcCspTQ
	UrxnpEiSVgBbpW60Wu0M7lo1iYrcLZoplRN84
X-Gm-Gg: ASbGnct4eqhx3j7RsgMb12AZc3AuNUj6cA7n25defGDTQ0SH8VHQPdqez2dVsr9K5dO
	08lG1CmkPhUyt1DRDsBnmfWY/WmgUvCf50WrOxzZvQysqakDbFbntVJDkGH/QNN5o4RBpyaWXnQ
	asrboiz6AsbgE/VmZXiXgfQ2AR
X-Google-Smtp-Source: AGHT+IH2IPSslGXs3S6U3SZyEjhufps+FOgJ4MI5DY7Uu+/0+4vI/knID5uO2tWz7qPzGa2aOnkdzTN2mj4h7r9KJSs=
X-Received: by 2002:a05:6808:228a:b0:3f4:1be4:b1d4 with SMTP id
 5614622812f47-3f6a2b39ca2mr2959328b6e.2.1741730088963; Tue, 11 Mar 2025
 14:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311123326.2686682-1-hca@linux.ibm.com> <20250311123326.2686682-2-hca@linux.ibm.com>
In-Reply-To: <20250311123326.2686682-2-hca@linux.ibm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Mar 2025 14:54:37 -0700
X-Gm-Features: AQ5f1JoHdL7fy9WOBHHtsPNXX2PhdRPHU3FfnSh5XG6auVNGW-V5IoHWDbRycD8
Message-ID: <CABi2SkUG6ddwOpZqp3frfHh+AvQP3fyhfN5WOn-cCNpavUhZ3A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 1/2] mseal sysmap: generic vdso vvar mapping
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:33=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> With the introduction of the generic vdso data storage the VM_SEALED_SYSM=
AP
> vm flag must be moved from the architecture specific
> _install_special_mapping() call [1] [2] which maps the vvar mapping to
> generic code.
>
Thanks for fixing this merging problem.
The new selftest in mseal_system_mappings should catch this :-)

Hi Andrew,
when you apply this to mm-unstable, could you please insert this between:

commit 5bda54a4f304a7c3d65a40c9c3f015901caa2ce6
selftests: x86: test_mremap_vdso: skip if vdso is msealed
and
commit 884323e928c6938923e5dfcb8a601b3363e1130b
 mseal sysmap: enable x86-64

That will make the series complete.


> [1] https://lkml.kernel.org/r/20250305021711.3867874-4-jeffxu@google.com
> [2] https://lkml.kernel.org/r/20250305021711.3867874-5-jeffxu@google.com
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  lib/vdso/datastore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
> index e227fbbcb796..b7c7386c98a9 100644
> --- a/lib/vdso/datastore.c
> +++ b/lib/vdso/datastore.c
> @@ -99,7 +99,8 @@ const struct vm_special_mapping vdso_vvar_mapping =3D {
>  struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, u=
nsigned long addr)
>  {
>         return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SI=
ZE,
> -                                       VM_READ | VM_MAYREAD | VM_IO | VM=
_DONTDUMP | VM_PFNMAP,
> +                                       VM_READ | VM_MAYREAD | VM_IO | VM=
_DONTDUMP |
> +                                       VM_PFNMAP | VM_SEALED_SYSMAP,
>                                         &vdso_vvar_mapping);
>  }
>
> --
> 2.45.2
>
Reviewed-by: Jeff Xu <jeffxu@chromium.org>
