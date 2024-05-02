Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CB57C83
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689569; cv=none; b=XfBjweGkkwNvDCZgImTFJeKRlvOinUlAXyavNlwE2zmegUH7ThYarCTXmiaPQM72pnTsmwMH/QNI9kDqrWblkMZ1VebW3Rp0qEEYKZXRQj60RXiX6gJvQ329xOMcgM4me/QKOfiTUMvz/qhY0Wy9eNt7xPkUG85fiQtFbNpsVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689569; c=relaxed/simple;
	bh=6kgJA6OklOrNUE2Q8TmR1v5wqycP1UenmSnwgIFFV3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC5gk/jModZ/CVX/WcbX8Z6zN8kwpV0HfBnN434LJ2trYKIP8+ubFNUojeg0/yUP8kLoQKiJ4A7NczV23KGbxj/ZZYNsUAAY9jsyaEk+Kg3EuECiU6y+T6j/MtL9vYOJbEXDnHOWZTTZk2YNGN/wpnSCOHqNvO5XanXJCJL2/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bv/a7IfM; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bv/a7IfM"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ef88ce8701so1755737a34.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689567; x=1715294367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfrJLkNktZfuMB+SoJQ7DumtzHrpuMfMLiSMpOw3O3Y=;
        b=bv/a7IfMG/7RvZBf/kMwemhEE84GuBdI2TIfn4A57kihfsP7z5aVw059TZB8JGcGqD
         809i/VUAvaawEZgD6qh3OKcAl4pAoE2foIsDeBRD5/1K+ZuGNWcwF47ciiqz9+bFIHhd
         PSj1bYMlSKXFVz65LyZrcJLA1QAEPahLK/3wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689567; x=1715294367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfrJLkNktZfuMB+SoJQ7DumtzHrpuMfMLiSMpOw3O3Y=;
        b=kmlAfxlFEJj8Nx0F9mBcO1V4i2VJBVi5vy3nfbdF3Nocxfg4Rab5t7ST4gG5wWaBX8
         NCnKg+7b04oXVLyTl49tUwUbPoBCa7RWjmJJ8bJJrkvpoM/a0MeCSjXSvjB4OXQ210S8
         2AZ7pqvTfirTeBLF+C0IE6/qs3yr+Ij6B/MnD65nzmKbA5l/Bng3Tm72o9Oo6fFbrYOj
         MHU4zt9sN8RhLOuB1GygyGboxovSy36/WDLMAeD5O4dKPYfnzVWyHtRT4EmtR4ek4MQ1
         /RkgKbTTawMGUOcSWcTCbK2n2RPfRI/LHUGf47w+KB3iXiDbM3VBFAa0skEIq5xR1W3c
         u7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWp6BZtRBtqUI44A/faHYl7JRScmP6wmBNgn+CRC8noMMX0/LMXNtNGxAGp2PC0mUDIAlzvDGLNf0cxdmqdmMMRxjWqnoWsPFT5mkDZlyTp
X-Gm-Message-State: AOJu0YxIEoeTzauI1jUXrdrlBDuQzAaUDc9glY4VCW+jgw8ifSuuW015
	Bu57hzWWBohv3k0q5PEs92LsGfP3pHZ66Vril81XGfOTOTbikhyno55T8//kZetsdvYVrslEPNU
	u2iWW09JsBeyYJfNh0M2bBcWn/gTKk6m3Y34B
X-Google-Smtp-Source: AGHT+IHVn2dULm2YcxryFkg3yP+dujD1r9smiX0/7F5nF1Oe1nfBMPF+wKK2fs/ZwboCl3pUBrUnaTcaSpGYjnGam7o=
X-Received: by 2002:a05:6870:911e:b0:23c:a6f8:9362 with SMTP id
 o30-20020a056870911e00b0023ca6f89362mr1552432oae.13.1714689567324; Thu, 02
 May 2024 15:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-4-jeffxu@chromium.org>
 <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
In-Reply-To: <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 2 May 2024 15:39:15 -0700
Message-ID: <CABi2SkXmGR41o8LwM=oD-PCZWvcc5zOie65wvuk5zsAQPymmRA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 4:24=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 15/04/2024 17:35, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > selftest for memory sealing change in mmap() and mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/.gitignore   |    1 +
> >  tools/testing/selftests/mm/Makefile     |    1 +
> >  tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
> >  3 files changed, 1838 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index d26e962f2ac4..98eaa4590f11 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -47,3 +47,4 @@ mkdirty
> >  va_high_addr_switch
> >  hugetlb_fault_after_madv
> >  hugetlb_madv_vs_map
> > +mseal_test
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index eb5f39a2668b..95d10fe1b3c1 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -59,6 +59,7 @@ TEST_GEN_FILES +=3D mlock2-tests
> >  TEST_GEN_FILES +=3D mrelease_test
> >  TEST_GEN_FILES +=3D mremap_dontunmap
> >  TEST_GEN_FILES +=3D mremap_test
> > +TEST_GEN_FILES +=3D mseal_test
> >  TEST_GEN_FILES +=3D on-fault-limit
> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >  TEST_GEN_FILES +=3D thuge-gen
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > new file mode 100644
> > index 000000000000..06c780d1d8e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -0,0 +1,1836 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <sys/mman.h>
>
> I'm afraid this is causing a build error on our CI, and as a result we ar=
e not
> running any mm selftests currently.
>
> The error is here:
>
>   CC       mseal_test
> mseal_test.c: In function =E2=80=98test_seal_mremap_move_dontunmap=E2=80=
=99:
> mseal_test.c:1469:50: error: =E2=80=98MREMAP_DONTUNMAP=E2=80=99 undeclare=
d (first use in this
> function)
>  1469 |  ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNM=
AP, 0);
>       |                                                  ^~~~~~~~~~~~~~~~
> mseal_test.c:1469:50: note: each undeclared identifier is reported only o=
nce for
> each function it appears in
> mseal_test.c: In function =E2=80=98test_seal_mremap_move_dontunmap_anyadd=
r=E2=80=99:
> mseal_test.c:1501:50: error: =E2=80=98MREMAP_DONTUNMAP=E2=80=99 undeclare=
d (first use in this
> function)
>  1501 |  ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNM=
AP,
>       |                                                  ^~~~~~~~~~~~~~~~
>
>
> And I think the reason is due to our CI's toolchain's sys/mman.h not incl=
uding
> linux/mman.h where MREMAP_DONTUNMAP is defined.
>
> I think the fix is to explicitly #include <linux/mman.h>, as a number of =
other
> mm selftests do.
>
When I tried to build with aarch64-linux-gnu-gcc, this passed.

aarch64-linux-gnu-gcc -I ../../../../usr/include   -DDEBUG -O3
-DDEBUG -O3 mseal_test.c -o  mseal_test -lm -Wall

I don't have the exact environment to repro the issue and verify the fix.
I will send a patch with  the linux/mman.h.

I will probably need some help to verify the fix on arm build, Ryan,
could you help with this ?

Thanks
-Jeff
