Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513811CA1
	for <linux-hardening@vger.kernel.org>; Sat, 28 Sep 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727486985; cv=none; b=eKoLlhXcy6C58YMeP4Qfpla31zMClT6dxH1Z44JXFXrlOmRStCoHN7kR7qtyipHgYXvLGYWEx9SOntBksTzl+XpwD8F7WoAEs6oQKDo7c0Y7F68IpgJjqXovQaEEFMuc3l906RiWexNr2oAHSZmg//KaHmvXRqPHIqHd4s40JmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727486985; c=relaxed/simple;
	bh=XB5GPV3VXX6NFggGKwEtj03PLF7h6PQiNHKmBTmU7d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGgEvqTO4ShDuEIngGApX5xBIE3Og00jnhjr8lazkoVOEZzSbMUhBm+Cv8G8cdveFDmtNTbYTLe2iFulHzdClqZ0Zjg9rb8Y+eird79iTZ5+ekl3aAnRw96wdeXc2JcqafkzL4jiYRvci5jWYdWPOBw+HXOapjQe2U/kE7o/wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fXx4JC44; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fXx4JC44"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e1d7421d14so71129eaf.3
        for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 18:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727486982; x=1728091782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iPoeWNn1CRuCE+lX/Mj/SS2Ot+/U3xHTVe7Ymr4oB0=;
        b=fXx4JC44IapPRTARIlA6JmVPWZuA7xMCSlkpLqLSdMgIiDI6TDDo/s6psyoLY17RJZ
         cPDTl/ABIz+ulZq8+yEyceOYB6hB4V53nUbCs3o68X2OQ9dNMN9ny2vq6FOOhoaFUFeS
         Vc+ANneg5j1y28zfPce1ccSD7wtAy5nx20GMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727486982; x=1728091782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iPoeWNn1CRuCE+lX/Mj/SS2Ot+/U3xHTVe7Ymr4oB0=;
        b=RU7LM3lbRGQuHn+vX3vOEjWuorRhKkJBxQWW4C2M+g3f6kKA6tgTDkqMWLMOKtlqa4
         l9Xc3YoHNz7HAVsme+QE3r0kqtGIGObhnpcQzVGtOGykWrCNJKJK16LQT2wBvw67IUZS
         yznCFfppA+jMNvmcGzmTvVfuyqPjN2l30bohn8letquN+3BjSZ/QKduT5wy/vRI0x5AX
         se/iIxgQLOQzqzpSQh+hwR2+BKGe+XBYj6IEoMjkbZSHdnGJBk8HWbg5XYe3cQZHmHG7
         NI7qU/gvvNNV23thHdri/Z4f38hEJsUevNQH7W4I77jr0WnhtL9pQaAvDKB4q732xysU
         2WPw==
X-Forwarded-Encrypted: i=1; AJvYcCVA4qBpj8L5yBP248Zy1k8IKQ4Wg4EErkW/9CawNLDE/I0RQit7M7CiarLQJlyfFgIk4IEMOc0SxuR7vg8tkoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpb0QTHFR/t2okyKZe+ukHQknaZhgOA7BucNtALoh2F/Hx+nI
	TEQ/9AnV90JT6rAJZUo3mIoaRhmoZPeK/rLj9V4G6RZ6I1UQas1VYgqYQmXyLaGrG4QZPhPsy8D
	bgKnzN0/SQy61MOQk4vMU/82Qs14Cqk4JnpEx
X-Google-Smtp-Source: AGHT+IG6yCz2YCRY3b6UWv0rfHj8RZH/CpUeGPy/zmSdAorhaRHP6/0tjz0IVuTmjoxElW246JGoYhQNCrH3tbXB5H8=
X-Received: by 2002:a05:6870:9692:b0:27b:9f8b:7e49 with SMTP id
 586e51a60fabf-2872ac35581mr319258fac.11.1727486982174; Fri, 27 Sep 2024
 18:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185211.729207-1-jeffxu@chromium.org> <20240927185211.729207-2-jeffxu@chromium.org>
 <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
In-Reply-To: <2vkppisejac42wnawjkd7qzyybuycu667yxwmsd4pfk5rwhiqc@gszyo5lu24ge>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 27 Sep 2024 18:29:30 -0700
Message-ID: <CABi2SkU62r8bLCeitzVwAW-r7L8-Lfmy8Cp73DE2HaeLzUXVXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

On Fri, Sep 27, 2024 at 3:59=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Fri, Sep 27, 2024 at 06:52:09PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update doc after in-loop change: mprotect/madvise can have
> > partially updated and munmap is atomic.
> >
> > Fix indentation and clarify some sections to improve readability.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
> >  1 file changed, 136 insertions(+), 154 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 4132eec995a3..68986084e191 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -23,177 +23,159 @@ applications can additionally seal security criti=
cal data at runtime.
> >  A similar feature already exists in the XNU kernel with the
> >  VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall=
 [2].
> >
> > -User API
> > -=3D=3D=3D=3D=3D=3D=3D=3D
> > -mseal()
> > ------------
> > -The mseal() syscall has the following signature:
> > -
> > -``int mseal(void addr, size_t len, unsigned long flags)``
> > -
> > -**addr/len**: virtual memory address range.
> > -
> > -The address range set by ``addr``/``len`` must meet:
> > -   - The start address must be in an allocated VMA.
> > -   - The start address must be page aligned.
> > -   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> > -   - no gap (unallocated memory) between start and end address.
> > -
> > -The ``len`` will be paged aligned implicitly by the kernel.
> > -
> > -**flags**: reserved for future use.
> > -
> > -**return values**:
> > -
> > -- ``0``: Success.
> > -
> > -- ``-EINVAL``:
> > -    - Invalid input ``flags``.
> > -    - The start address (``addr``) is not page aligned.
> > -    - Address range (``addr`` + ``len``) overflow.
> > -
> > -- ``-ENOMEM``:
> > -    - The start address (``addr``) is not allocated.
> > -    - The end address (``addr`` + ``len``) is not allocated.
> > -    - A gap (unallocated memory) between start and end address.
> > -
> > -- ``-EPERM``:
> > -    - sealing is supported only on 64-bit CPUs, 32-bit is not supporte=
d.
> > -
> > -- For above error cases, users can expect the given memory range is
> > -  unmodified, i.e. no partial update.
> > -
> > -- There might be other internal errors/cases not listed here, e.g.
> > -  error during merging/splitting VMAs, or the process reaching the max
> > -  number of supported VMAs. In those cases, partial updates to the giv=
en
> > -  memory range could happen. However, those cases should be rare.
> > -
> > -**Blocked operations after sealing**:
> > -    Unmapping, moving to another location, and shrinking the size,
> > -    via munmap() and mremap(), can leave an empty space, therefore
> > -    can be replaced with a VMA with a new set of attributes.
> > -
> > -    Moving or expanding a different VMA into the current location,
> > -    via mremap().
> > -
> > -    Modifying a VMA via mmap(MAP_FIXED).
> > -
> > -    Size expansion, via mremap(), does not appear to pose any
> > -    specific risks to sealed VMAs. It is included anyway because
> > -    the use case is unclear. In any case, users can rely on
> > -    merging to expand a sealed VMA.
> > -
> > -    mprotect() and pkey_mprotect().
> > -
> > -    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
> > -    for anonymous memory, when users don't have write permission to th=
e
> > -    memory. Those behaviors can alter region contents by discarding pa=
ges,
> > -    effectively a memset(0) for anonymous memory.
> > -
> > -    Kernel will return -EPERM for blocked operations.
> > -
> > -    For blocked operations, one can expect the given address is unmodi=
fied,
> > -    i.e. no partial update. Note, this is different from existing mm
> > -    system call behaviors, where partial updates are made till an erro=
r is
> > -    found and returned to userspace. To give an example:
> > -
> > -    Assume following code sequence:
> > -
> > -    - ptr =3D mmap(null, 8192, PROT_NONE);
> > -    - munmap(ptr + 4096, 4096);
> > -    - ret1 =3D mprotect(ptr, 8192, PROT_READ);
> > -    - mseal(ptr, 4096);
> > -    - ret2 =3D mprotect(ptr, 8192, PROT_NONE);
> > -
> > -    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
> > -
> > -    ret2 will be -EPERM, the page remains to be PROT_READ.
> > -
> > -**Note**:
> > -
> > -- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> > -
> > -- users can call mseal() multiple times, mseal() on an already sealed =
memory
> > -  is a no-action (not error).
> > -
> > -- munseal() is not supported.
> > +SYSCALL
> > +=3D=3D=3D=3D=3D=3D=3D
> > +mseal syscall signature
> > +-----------------------
> > +   **int** mseal(**void \*** addr, **size_t** len, **unsigned long** f=
lags)
> > +
> > +   **addr**/**len**: virtual memory address range.
> > +      The address range set by **addr**/**len** must meet:
> > +         - The start address must be in an allocated VMA.
> > +         - The start address must be page aligned.
> > +         - The end address (**addr** + **len**) must be in an allocate=
d VMA.
> > +         - no gap (unallocated memory) between start and end address.
> > +
> > +      The ``len`` will be paged aligned implicitly by the kernel.
> > +
> > +   **flags**: reserved for future use.
> > +
> > +   **Return values**:
> > +      - **0**: Success.
> > +      - **-EINVAL**:
> > +         * Invalid input ``flags``.
> > +         * The start address (``addr``) is not page aligned.
> > +         * Address range (``addr`` + ``len``) overflow.
> > +      - **-ENOMEM**:
> > +         * The start address (``addr``) is not allocated.
> > +         * The end address (``addr`` + ``len``) is not allocated.
> > +         * A gap (unallocated memory) between start and end address.
> > +      - **-EPERM**:
> > +         * sealing is supported only on 64-bit CPUs, 32-bit is not sup=
ported.
> > +
> > +   **Note about error return**:
> > +      - For above error cases, users can expect the given memory range=
 is
> > +        unmodified, i.e. no partial update.
> > +      - There might be other internal errors/cases not listed here, e.=
g.
> > +        error during merging/splitting VMAs, or the process reaching t=
he max
> > +        number of supported VMAs. In those cases, partial updates to t=
he given
> > +        memory range could happen. However, those cases should be rare=
.
>
> How about turning the above into a man page?
>
yes. I have a TODO to add a man page :-)

> > +   **Architecture support**:
> > +      mseal only works on 64-bit CPUs, not 32-bit CPU.
> > +
> > +   **Idempotent**:
> > +      users can call mseal multiple times, mseal on an already sealed =
memory
> > +      is a no-action (not error).
> > +
> > +   **no munseal**
> > +      Once mapping is sealed, it can't be unsealed. kernel should neve=
r
> > +      have munseal, this is consistent with other sealing feature, e.g=
.
> > +      F_SEAL_SEAL for file.
> > +
> > +Blocked mm syscall for sealed mapping
> > +-------------------------------------
> > +   It might be imporant to note: **once the mapping is sealed, it will
> > +   stay in the process's memory till the process terminates**.
> > +
> > +   Example::
> > +
> > +         *ptr =3D mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE=
, 0, 0);
> > +         rc =3D mseal(ptr, 4096, 0);
> > +         /* munmap will fail */
> > +         rc =3D munmap(ptr, 4096);
> > +         assert(rc < 0);
> > +
> > +   Blocked mm syscall:
> > +      - munmap
> > +      - mmap
> > +      - mremap
> > +      - mprotect and pkey_mprotect
> > +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFOR=
K
> > +
> > +   The first set of syscall to block is munmap, mremap, mmap. They can
> > +   either leave an empty space in the address space, therefore allow
> > +   replacement with a new mapping with new set of attributes, or can
> > +   overwrite the existing mapping with another mapping.
> > +
> > +   mprotect and pkey_mprotect are blocked because they changes the
>                                                           change
> > +   protection bits (rwx) of the mapping.
> > +
> > +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
> > +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > +   for anonymous memory, when users don't have write permission to the
> > +   memory. Those behaviors can alter region contents by discarding pag=
es,
> > +   effectively a memset(0) for anonymous memory.
>
> What's the difference between anonymous memory and MAP_PRIVATE | MAP_FILE=
?
>
MAP_FILE seems not used ?
anonymous mapping is the mapping that is not backed by a file.

> The feature now, as is (as far as I understand!) will allow you to do thi=
ngs like MADV_DONTNEED
> on a read-only file mapping. e.g .text. This is obviously wrong?
>
When a MADV_DONTNEED is called, pages will be freed, on file-backed
mapping,  if the process reads from the mapping again, the content
will be retrieved from the file.

For anonymous mapping, since  there is no file backup, if process
reads from the mapping, 0 is filled, hence equivalent to memset(0)

> > +
> > +   Kernel will return -EPERM for blocked syscalls.
> > +
> > +   When blocked syscall return -EPERM due to sealing, the memory regio=
ns may or may not be changed, depends on the syscall being blocked:
> > +      - munmap: munmap is atomic. If one of VMAs in the given range is
> > +        sealed, none of VMAs are updated.
> > +      - mprotect, pkey_mprotect, madvise: partial update might happen,=
 e.g.
> > +        when mprotect over multiple VMAs, mprotect might update the be=
ginning
> > +        VMAs before reaching the sealed VMA and return -EPERM.
> > +      - mmap and mremap: undefined behavior.
>
> mmap and mremap are actually not undefined as they use munmap semantics f=
or their unmapping.
> Whether this is something we'd want to document, I don't know honestly (n=
or do I think is ever written down in POSIX?)
>
I'm not sure if I can declare mmap/mremap as atomic.

Although, it might be possible to achieve this due to munmap being
atomic. I'm not sure  as I didn't test this. Would you like to find
out ?

> >
> >  Use cases:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  - glibc:
> >    The dynamic linker, during loading ELF executables, can apply sealin=
g to
> > -  non-writable memory segments.
> > +  mapping segments.
> >
> >  - Chrome browser: protect some security sensitive data-structures.
> >
> > -Notes on which memory to seal:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > -
> > -It might be important to note that sealing changes the lifetime of a m=
apping,
> > -i.e. the sealed mapping won=E2=80=99t be unmapped till the process ter=
minates or the
> > -exec system call is invoked. Applications can apply sealing to any vir=
tual
> > -memory region from userspace, but it is crucial to thoroughly analyze =
the
> > -mapping's lifetime prior to apply the sealing.
> > +Don't use mseal on:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Applications can apply sealing to any virtual memory region from users=
pace,
> > +but it is *crucial to thoroughly analyze the mapping's lifetime* prior=
 to
> > +apply the sealing. This is because the sealed mapping *won=E2=80=99t b=
e unmapped*
> > +till the process terminates or the exec system call is invoked.
>
> There should probably be a nice disclaimer as to how most people don't ne=
ed this or shouldn't use this.
> At least in its current form.
>
Ya, the mseal is not for most apps. I mention the malloc example to stress =
that.

> <snip>
> > -
> > -
> > -Additional notes:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  As Jann Horn pointed out in [3], there are still a few ways to write
> > -to RO memory, which is, in a way, by design. Those cases are not cover=
ed
> > -by mseal(). If applications want to block such cases, sandbox tools (s=
uch as
> > -seccomp, LSM, etc) might be considered.
> > +to RO memory, which is, in a way, by design. And those could be blocke=
d
> > +by different security measures.
> >
> >  Those cases are:
> > -
> > -- Write to read-only memory through /proc/self/mem interface.
> > -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > -- userfaultfd.
> > +   - Write to read-only memory through /proc/self/mem interface (FOLL_=
FORCE).
> > +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT=
).
> > +   - userfaultfd.
>
> I don't understand how this is not a problem, but MADV_DONTNEED is.
> To me it seems that what we have now is completely useless, because you c=
an trivially
> bypass it using /proc/self/mem, which is enabled on most Linux systems.
>
> Before you mention ChromeOS or Chrome, I don't care. Kernel features aren=
't designed
> for Chrome. They need to work with every other distro and application as =
well.
>
> It seems to me that the most sensible change is blocking/somehow distingu=
ishing between /proc/self/mem and
> /proc/<pid>/mem (some other process) and ptrace. As in blocking /proc/sel=
f/mem but allowing the other FOLL_FORCE's
> as the traditional UNIX permission model allows.
>
IMO, it is a matter of  Divide and Conquer.  In a nutshell, mseal only
prevents VMA's certain attributes (such as prot bits) from changing.
It doesn't mean to say that sealed RO memory is immutable. To achieve
that, the system needs to apply multiple security measures.

For writing to /proc/pid/mem, it can be disabled via [1].  SELINUX and
Landlock can achieve the same protection too.

[1] https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@collab=
ora.com/

-Jeff

> --
> Pedro
