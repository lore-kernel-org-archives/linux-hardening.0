Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4F1A9B23
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434109; cv=none; b=BHp6rUUjRYRPZ3NoBmkD+4E95HJrejfOgFbdrItCMvlCRiGDp9CNWcghsvNFkQoiYCGagDXEPojrgfPkHwwsLGEJTGclDnLYy9oIsZMAeeDyQhDNFCi4HQUgaI3cxfzcTtBDcFWqb/icCNUmHrVCUEku8ChaXBAQLuKR/pkBJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434109; c=relaxed/simple;
	bh=Of10dtPjq6kWwFSX40vy9fJ7xn30JPo1sH0xcAGR6B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NKome6oXjksMe4eQJ6EjjNTxyYwpD7GwiDEdfha3PBLZDzOkCKhFqPC6y/LMjy3w/vacTbeYfKJmcw7rx5yyhBJmHj9z+q8zbEO/ECkRMzAlU1YpV5uRSiJ3WT/W15thn6GwGRkpToF4CYwl70PehfqhAi5NuJasvucsR27ocz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aRXp1Kyk; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aRXp1Kyk"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72726a5db1aso535132a34.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740434106; x=1741038906; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPTTDChOSqTCFQv4mLssfhA9N88UjfFx6y+XJgJnTAA=;
        b=aRXp1KyknTPyek918yF/w0JNb75j71x4YHHsjhpbdS29zpJd1A6QT83AGTVEaCDdvk
         vHAtucYQ8MgFakUdNImQe19Z88OdLaLCnQPUocRpGL7HJ2XgMv/rkOURwK4n+Fcyfk/L
         7IyBjhrBnq6KUReYVmZd2SuWU2BDNVwY+ZF9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434106; x=1741038906;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPTTDChOSqTCFQv4mLssfhA9N88UjfFx6y+XJgJnTAA=;
        b=Fp8I7SGSVZs2Q4HZOIAM6bFxE4I/pSjEDVDqX+6R/AuHg0WeI4ujqH+PDvJ/NEUwOs
         wZg+Mltbqf3bBuNsJATBRTUKnJZu/HmDb4r0MpyAPBlWpTuE2g18YuT4kFYWgbENFHU9
         IWkYxjTKOmyQtfGb2onXC2bH+ukFN7VowGnfi3zjbm1Cx7nmN8RalxtlLwxbMotwB7YE
         Sbu9IgZzdvr1YBqGLQnVM8vS9Xk83tA2GIkrYh524s1f/1nNUECpdtTaCS1YZlPe2pD1
         R5oVWwKzxP3ieFiKtnhn05peJzwWLvsFM0IfQILQPfjFP3yisqfSUUzysStqcNFB0Z/7
         lD8g==
X-Forwarded-Encrypted: i=1; AJvYcCUa8+MlfhP8tOpIHEHE4CXoTk06kKLu3hAOp9OOoqjjUorgW4txQRRGtJaIkTnFJcui5muGxTeE+n98bNUoJOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlKcDOgDCNxrTCfLIobGUxy6GWLBSRLUEfOmgTBgstoJ018JI
	ARDVCnN/k/bTd0HCheiRuqKEmB0csOr3wMm8gfqmF2eTcLQOCouWQ1RBVdxNm2u7yvZ2AAQ09HF
	Au55jvCdtpZucHNdxapS+gSbgkgTQWsO3qv52
X-Gm-Gg: ASbGncvVwQ194WDtbA/NaVtXjM058qII9/oyJAIKmo/4iJBzE5DUyJefexg8QEA15Od
	mVQseML18aq3Ws9aPcoFBys9qVNa/cTc9SxxQn1wyKHsyCryo3Mn4dwcD9Mv3NMDMDgn8Rbbdm4
	pULNfPu4j+dE/7qcj2UqCqLVbtV12IbEjvP2kX
X-Google-Smtp-Source: AGHT+IFwwLbERjxJfPs0yISPzcIvd1i2WMO0vsZI2MTAgbx4mU/byaBF43rcmsNs7HBDDxb+7CjeT5YTOOP1+HnX5Xk=
X-Received: by 2002:a05:6808:13c4:b0:3f4:1ba:9e89 with SMTP id
 5614622812f47-3f4246a145amr4457000b6e.1.1740434106640; Mon, 24 Feb 2025
 13:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-8-jeffxu@google.com>
 <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp> <CABi2SkVLOWEZ6vkUwZyQspz8aqBZ4yhfob-SmscA5RhNv_vS-Q@mail.gmail.com>
In-Reply-To: <CABi2SkVLOWEZ6vkUwZyQspz8aqBZ4yhfob-SmscA5RhNv_vS-Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 13:54:56 -0800
X-Gm-Features: AWEUYZlWnyV6Jdfb2-SNecn18hyqiYaIseEaup8aJSHrCsv9Z2O_gnjBeFaB_Sg
Message-ID: <CABi2SkWzgcFo+PF58K2azNZ1BgmgM-7LtJ8NmOgscN6_NyEo=w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 1:06=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Mon, Feb 24, 2025 at 12:26=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Update memory sealing documentation to include details about system
> > > mappings.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  Documentation/userspace-api/mseal.rst | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/us=
erspace-api/mseal.rst
> > > index 41102f74c5e2..10147281bf2d 100644
> > > --- a/Documentation/userspace-api/mseal.rst
> > > +++ b/Documentation/userspace-api/mseal.rst
> > > @@ -130,6 +130,13 @@ Use cases
> > >
> > >  - Chrome browser: protect some security sensitive data structures.
> >
> > Did you mean to drop this line?
> >
> Ah, thank you for catching that.
>
Actually, this isn't a problem here.
The "-" here is part of the text, for list, so that line is not dropped).

-Jeff


> -Jeff
>
>
> > >
> > > +- System mappings:
> > > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_=
MAPPINGS),
> > > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso,=
 vvar,
> > > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, r=
r are
> > > +  known to relocate or unmap system mapping, therefore this config c=
an't be
> > > +  enabled universally.
> > > +
> > >  When not to use mseal
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >  Applications can apply sealing to any virtual memory region from use=
rspace,
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >
