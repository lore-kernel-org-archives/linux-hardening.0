Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3394E56B
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847764; cv=none; b=uYrJnORvfSoDeLV9/XkpSdJxxpVpaHtNoYd3e+Rr06Ci7kMxUqj55vNZL+tLa4GiQzJ8h8SD5O1QptzSoZWtSP/4YkvaCgEpU8pMu0lmYhCuaYwL/6uwZO6y+JFeZi6KZtYz8mzIc3q5C9RWBclQUNcmWCEGX5Uq1nYBxikQApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847764; c=relaxed/simple;
	bh=vA7tvTQxROFPNSNZmoB+xRvwpT15aZOnZMRAVU3yE5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zck3mQmGp6ZHD2AFAbIQNmBiEcgPuE/3KAWmfiL/MA7s+y1/DpGN7cDyHKmI7Jcj95vMmTxNk6WgyCghQCieraYvJx6LWIXlgdVdMGcAsy5L30pCayiMiVm3jXZSdSfS8TBCPl7i/g42KGvVfjYcYg1qMoYmN1ZPqkGlN+25HWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aQyZUZTw; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aQyZUZTw"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-218642337c9so1176348fac.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 20:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706847761; x=1707452561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY7gduymNb2zU8foO6bHqxA7R4wx0/8BTl8lBqhvbv0=;
        b=aQyZUZTwSfdF9GVvvBhz9gla/Tj8GAEMgMn00U2j9246xVlcC7/RgWmIPXJRmFr7lS
         xV3xp2Fm31nUIgTJNupttWMcGq7VZmsGzkCg76sftejdNg9ZpoFDoMyNe9EilkOyT48d
         CJnMT2kkU7v8cCpYt2lCKZtj389I+MuqeFZQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706847761; x=1707452561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY7gduymNb2zU8foO6bHqxA7R4wx0/8BTl8lBqhvbv0=;
        b=eP1uOFJSuPboONSZTxWswGLdftpGAaX68WKPJ+stbiDvBBMJ66jLPu+4nCsoTQnilI
         1xbtJ53K3GRQVgfzweKsHz61tfjzxbuw7kIKZ1eRY7+YzjQsU6yflcGa4hIepnVUmi0I
         nnYlkQqfo4Zbjoej3w14TL32wjB9i44JheUd+o9G2fiX/PWIzIE9IojimqtH1gp4uohH
         mH+X/576Yo0xvHYt8p6itn6n55sAZ4QwMnugXeyTqZyh1z4bI2bvYwd79yJeBur+5mtl
         6lEQgd6Qgzw496MD1b2bM653o+1jJCKmA8m2NAZcl3xlhN3tkWU6TEJDAx4BxjWRDXfL
         f2LQ==
X-Gm-Message-State: AOJu0YxfwuYi3JP8rpVr2bZjpBwnDGDaJQhJWdK32UAP/7kdnsoeim0T
	uwbFrxA9oUSTT2rCg9CE8UUfFYiarI9sWmRXcidNnj6qJu3fNZfmWTFbhuqzVisUjtLZAym7eB7
	shwP92rponw6liDXq/XogS9Gx9NN/q7vHQ/1C
X-Google-Smtp-Source: AGHT+IEkUEa7oB3LxBaxRdRQm5KW+tylq4x0W184us0zAIA6K3G/17ndemyjfLrzARBtr3pklpjp5BmCmP98g7ITzIA=
X-Received: by 2002:a05:6870:7908:b0:214:2a08:897d with SMTP id
 hg8-20020a056870790800b002142a08897dmr8699235oab.46.1706847761083; Thu, 01
 Feb 2024 20:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org>
 <20240201231151.GA41472@sol.localdomain> <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
 <96087.1706846050@cvs.openbsd.org> <CABi2SkWP=N_V9+VvH3omw3gw=VcRqhqenti-qABijo-SNqXxhQ@mail.gmail.com>
 <72434.1706847038@cvs.openbsd.org>
In-Reply-To: <72434.1706847038@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 20:22:29 -0800
Message-ID: <CABi2SkW=jDvjknG-OheqDg0qtZRKRO-byK=YMyeE6ohcch4eTA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Eric Biggers <ebiggers@kernel.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:10=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Jeff Xu <jeffxu@chromium.org> wrote:
>
> > On Thu, Feb 1, 2024 at 7:54=E2=80=AFPM Theo de Raadt <deraadt@openbsd.o=
rg> wrote:
> > >
> > > Jeff Xu <jeffxu@chromium.org> wrote:
> > >
> > > > On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kerne=
l.org> wrote:
> > > > >
> > > > > On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wro=
te:
> > > > > > [PATCH v8 2/4] mseal: add mseal syscall
> > > > > [...]
> > > > > > +/*
> > > > > > + * The PROT_SEAL defines memory sealing in the prot argument o=
f mmap().
> > > > > > + */
> > > > > > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > > > > > +
> > > > > >  /* 0x01 - 0x03 are defined in linux/mman.h */
> > > > > >  #define MAP_TYPE     0x0f            /* Mask for type of mappi=
ng */
> > > > > >  #define MAP_FIXED    0x10            /* Interpret addr exactly=
 */
> > > > > > @@ -33,6 +38,9 @@
> > > > > >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, me=
mory could be
> > > > > >                                        * uninitialized */
> > > > > >
> > > > > > +/* map is sealable */
> > > > > > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
> > > > >
> > > > > IMO this patch is misleading, as it claims to just be adding a ne=
w syscall, but
> > > > > it actually adds three new UAPIs, only one of which is the new sy=
scall.  The
> > > > > other two new UAPIs are new flags to the mmap syscall.
> > > > >
> > > > The description does include all three. I could update the patch ti=
tle.
> > > >
> > > > > Based on recent discussions, it seems the usefulness of the new m=
map flags has
> > > > > not yet been established.  Note also that there are only a limite=
d number of
> > > > > mmap flags remaining, so we should be careful about allocating th=
em.
> > > > >
> > > > > Therefore, why not start by just adding the mseal syscall, withou=
t the new mmap
> > > > > flags alongside it?
> > > > >
> > > > > I'll also note that the existing PROT_* flags seem to be conventi=
onally used for
> > > > > the CPU page protections, as opposed to kernel-specific propertie=
s of the VMA
> > > > > object.  As such, PROT_SEAL feels a bit out of place anyway.  If =
it's added at
> > > > > all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure =
this aspect has
> > > > > been properly discussed yet, seeing as the patchset is presented =
as just adding
> > > > > sys_mseal().  Some reviewers may not have noticed or considered t=
he new flags.
> > > > >
> > > > MAP_ flags is more used for type of mapping, such as MAP_FIXED_NORE=
PLACE.
> > > >
> > > > The PROT_SEAL might make more sense because sealing the protection =
bit
> > > > is the main functionality of the sealing at this moment.
> > >
> > > Jeff, please show a piece of software that needs to do PROT_SEAL as
> > > mprotect() or mmap() argument.
> > >
> > I didn't propose mprotect().
> >
> > for mmap() here is a potential use case:
> >
> > fs/binfmt_elf.c
> > if (current->personality & MMAP_PAGE_ZERO) {
> >                 /* Why this, you ask???  Well SVr4 maps page 0 as read-=
only,
> >                    and some applications "depend" upon this behavior.
> >                    Since we do not have the power to recompile these, w=
e
> >                    emulate the SVr4 behavior. Sigh. */
> >
> >                 error =3D vm_mmap(NULL, 0, PAGE_SIZE,
> >                                 PROT_READ | PROT_EXEC,   <-- add PROT_S=
EAL
> >                                 MAP_FIXED | MAP_PRIVATE, 0);
> >         }
> >
> > I don't see the benefit of RWX page 0, which might make a null
> > pointers error to become executable for some code.
>
>
>
> And this is a lot faster than doing the operation as a second step?
>
>
> But anyways, that's kernel code.  It is not userland exposed API used
> by programs.
>
> The question is the damage you create by adding API exposed to
> userland (since this is Linux: forever).
>
> I should be the first person thrilled to see Linux make API/ABI mistakes
> they have to support forever, but I can't be that person.
>
Point taken.
I can remove PROT_SEAL.

>
>
