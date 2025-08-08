Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9372550CD
	for <linux-hardening@vger.kernel.org>; Fri,  8 Aug 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650026; cv=none; b=PrnNZpOWfGBK95I8Gfoejib2PfiIjxQQ/o6sfqF6Oy3fFvAsr7bin4dJ9SONEDfm8BS6DZAWdHcge0t1YgvD35BawH0aEyy6N4/rSEnAavlxw573NpdNg3Zf5rU1HtSp253EhS7CO3UrdepdtpJ51xXOoGS8Q3FdBhYdxpV+CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650026; c=relaxed/simple;
	bh=T/9tDEacu9UlvMURMVhrDf6nZJFdlhByYvHn1E0d6ts=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uH/3awiIR22dl48+4IHxptP3bdqlRFnt4u96sOIc2fQBxmXQW3QyRSmlVSwrfo22V0BnsOqOvDfydkJjY0eASiGXlMACLpLAnN+EZbv8AUWD6HqW6h1Z5Xu+YymuPE2mzAJsZ1GBIr5YtXtCbRRnJ7Cj9AknnrOfhuW1iEk0vXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbL35Fuy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbL35Fuy"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso7144a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 08 Aug 2025 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754650023; x=1755254823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/9tDEacu9UlvMURMVhrDf6nZJFdlhByYvHn1E0d6ts=;
        b=VbL35FuyVwCwfuBSMi2zWwTJMGndryNlkGlU5yJDfKpcCVQygTy7jhOuKX1gLIlZFv
         s+JDWeEhvmnj5S+wHA8s8OxDjhNu7aRI2vfQf5pPzytB3FIH9H5VXKfxNObWNmsvWmId
         N9VzzWL63Uyn8n4V2/0bRCFxeBGhbmjZYrBJjm4LGFgb3ozDKIu86Z3RPSNYsIAYmLrQ
         ZgugRK7uyElouDS13FduL/NrzGhvGBgzhpcx8Z5ZyR5osRBbYBTVr2xlmSI0eVUCnjYU
         H1HdPYyRH6BGFhG1GVIsn6EmvwpOjI7KR7OuoQVJoOzC0ITooWDMfjv9mTxQAfG7uqTO
         NxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650023; x=1755254823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/9tDEacu9UlvMURMVhrDf6nZJFdlhByYvHn1E0d6ts=;
        b=CU2Iw6rPTu4GbvAgXrQQBi71Ikdqlv4upCpiqkXhkEyz/l33znRnaVWVFMTUmzTVjw
         G2r9oYjmmjbH3CDNu8VK75srAuAyio5twK1391SIEHcdKODp3WyrKD8pQesR/wKqsRoK
         X3fLIQ/wn3vqYg2+Nq1Y7SrzujtLF+sJT62X8meGX2hLlL5aB9N4ykAaR0P3IJ2Nnawj
         gBligizNcTmpT3gEo3QHfdbQLBV8NqByMpFlwsPzrUSE85Ac5onfzR7WidGMigFmVufy
         vChiauq8ZN9R+A5ruCbcmKwrfnA+0eRgGS8NH+MSIS4nPnTK+34YT7QEi4k8K8Rzzmhz
         bFHw==
X-Forwarded-Encrypted: i=1; AJvYcCUUCxs/Dtfpb0ma9JBF0bCHoQ8E0kasGTkldCUwxIW6kE41qZbZ93iawjnkpUHOznS637Ak/yNeDRGjrLkYtIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEKTNCDrf3PnEKrWZzDltljqTWplprFPSxvUTFDuab6Xz9/Ma
	WKH5wamgB92VqwPpiwFkadpJyv6J/zDnXFq028zy0ZSatg2YMd4I1RAatHEGlT6GEB0FdXx/ln2
	y2bfbZU7zf/J8uVIwTNdfUknOHA+JRM4oRVZ2YC6i
X-Gm-Gg: ASbGnctdUulaDXoczyLwmlppQGnkFnp7uStJCVDOTrfZqWlR/YPmIZalairXR4FcV+i
	zHUxs5+EuzEPX5BQlkrlUz8ySk4tsiLG42G22Ujau5Bko0xaNz2WJok8S/EMmzDwVtMW8DieWCf
	9wzaximbgtY9bVogQgLhfj5dQKlri4951HTEKzB0yaOzasRhuFL/CoFNGFaqkZd4HsblEfIWylW
	ox5RvV2x9bR69NNb8V41Df2rCHC5EAK1g==
X-Google-Smtp-Source: AGHT+IFqOmNnaK5hefSrnjtM0v0uNXgTRRJ7WOVrAmeMc2Mba23uf6PFMYJdn94b5J227yyK03JrXiS6iK15JVlPDHg=
X-Received: by 2002:a50:8ac9:0:b0:615:6167:4835 with SMTP id
 4fb4d7f45d1cf-617e4938cc5mr58598a12.7.1754650022459; Fri, 08 Aug 2025
 03:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Aug 2025 12:46:26 +0200
X-Gm-Features: Ac12FXz5MNEBgvVXLpyOXJS0S3xY8nUmV94N9fcForngE0yiRR5U9n3XjTzYizU
Message-ID: <CAG48ez0ww6FhoidYcBzw-1LOSFr_OW=j5X7ch32Go1dgRo7e2A@mail.gmail.com>
Subject: abusing CONFIG_RANDOMIZE_KSTACK_OFFSET to assist with exploitation
To: Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I just published a blogpost
(https://googleprojectzero.blogspot.com/2025/08/from-chrome-renderer-code-e=
xec-to-kernel.html)
about how I wrote a kernel exploit that uses an AF_UNIX bug to go from
"attacker can run arbitrary native code in a sandboxed Chrome
renderer" to kernel page table control.

One aspect that I think I should call out in particular is that
CONFIG_RANDOMIZE_KSTACK_OFFSET was actually helpful for this exploit -
when I was at a point where I already had a (semi-)arbitrary read
primitive, I could use the combination of
CONFIG_RANDOMIZE_KSTACK_OFFSET and the read primitive to line up
things on the stack that would otherwise never have been in the right
spot.

Quoting two sections from my linked blogpost that are directly
relevant for CONFIG_RANDOMIZE_KSTACK_OFFSET:
<<<
## Finding a reallocation target: The magic of `CONFIG_RANDOMIZE_KSTACK_OFF=
SET`
[...] I went looking for some other allocation which would place an
object such that incrementing the value at address 0x...44 leads to a
nice primitive. It would be nice to have something there like an
important flags field, or a length specifying the size of a pointer
array, or something like that. I spent a lot of time looking at
various object types that can be allocated on the kernel heap from
inside the Chrome sandbox, but found nothing great.

Eventually, I realized that I had been going down the wrong path.
Clearly trying to target a heap object was foolish, because there is
something much better: It is possible to reallocate the target page as
the topmost page of a kernel stack!

That might initially sound like a silly idea; but Debian's kernel
config enables `CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy` and
`CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=3Dy`, **causing each syscall
invocation to randomly shift the stack pointer down by up to 0x3f0
bytes, with 0x10 bytes granularity**. That is supposed to be a
security mitigation, but works to my advantage when I already have an
arbitrary read: instead of having to find an overwrite target that is
at a 0x44-byte distance from the preceding 0x100-byte boundary, I
effectively just have to find an overwrite target that is at a
0x4-byte distance from the preceding 0x10-byte boundary, and then keep
doing syscalls and checking at what stack depth they execute until I
randomly get lucky and the stack lands in the right position.

With that in mind, I went looking for an overwrite target on the
stack, strongly inspired by [Seth's exploit that overwrote a spilled
register containing a length used in
`copy_from_user`](https://googleprojectzero.blogspot.com/2022/12/exploiting=
-CVE-2022-42703-bringing-back-the-stack-attack.html).
Targeting a normal `copy_from_user()` directly wouldn't work here - if
I incremented the 64-bit length used inside `copy_from_user()` by 4
GiB, then even if the copy failed midway through due to a userspace
fault, `copy_from_user()` would try to `memset()` the remaining kernel
memory to zero.

I discovered that, on the codepath `pipe_write -> copy_page_from_iter
-> copy_from_iter`, the 64-bit length variable `bytes` of
`copy_page_from_iter()` is stored in register `R14`, which is spilled
to the stack frame of `copy_from_iter()`; and this stack spill is in a
stack location where I can clobber it.

When userspace calls `write()` on a pipe, the kernel constructs an
iterator (`struct iov_iter`) that encapsulates the userspace memory
range passed to `write()`. (There are different types of iterators
that can encapsulate a single userspace range, a set of userspace
ranges, or various types of kernel memory.) Then, `pipe_write()`
(which is called `anon_pipe_write()` in newer kernels) essentially
runs a loop which allocates a new `pipe_buffer` slot in the pipe,
places a new page allocation in this pipe buffer slot, and copies up
to a page worth of data (`PAGE_SIZE` bytes) from the `iov_iter` to the
pipe buffer slot's page using `copy_page_from_iter()`.
`copy_page_from_iter()` effectively receives two length values: The
number of bytes that fit into the caller-provided page (`bytes`,
initially set to `PAGE_SIZE` here) and the number of bytes available
in the `struct iov_iter` encapsulating the userspace memory range
(`i->count`). The amount of data that will actually be copied is
limited by both.

If I manage to increment the spilled register `R14` which contains
`bytes` by 4 GiB while `copy_from_iter()` is busy copying data into
the kernel, then after `copy_from_iter()` returns,
`copy_page_from_iter()` will effectively no longer be bounded by
`bytes`, only by `i->count` (based on the length userspace passed to
`write()`); so it will do a second iteration, which copies into
out-of-bounds memory behind the pipe buffer page. If userspace calls
`write(fd, buf, 0x3000)`, and the overwrite happens in the middle of
copying bytes 0x1000-0x1fff of the userspace buffer into the second
pipe buffer page, then bytes 0x2000-0x2fff will be written
out-of-bounds behind the second pipe buffer page, at which point
`i->count` will drop to 0, terminating the operation.
>>>

<<<
# Takeaway: probabilistic mitigations against attackers with arbitrary read

When faced with an attacker who already has an arbitrary read
primitive, probabilistic mitigations that randomize something
differently on every operation can be ineffective if the attacker can
keep retrying until the arbitrary read confirms that the randomization
picked a suitable value or even work to the attacker's advantage by
lining up memory locations that could otherwise never overlap, as done
here using the kernel stack randomization feature.

Picking per-syscall random stack offsets at boottime might avoid this
issue, since to retry with different offsets, the attacker would have
to wait for the machine to reboot or try again on another machine.
However, that would break the protection for cases where the attacker
wants to line up two syscalls that use the same syscall number (such
as different `ioctl()` calls); and it could also weaken the protection
in cases where the attacker just needs to know what the randomization
offset for some syscall will be.

Somewhat relatedly,
[Blindside](https://www.vusec.net/projects/blindside/) demonstrated
that this style of attack can be pulled off without a normal arbitrary
read primitive, by =E2=80=9Cexploiting=E2=80=9D a real kernel memory corrup=
tion bug
during speculative execution in order to leak information needed for
subsequently exploiting the same memory corruption bug for real.
>>>
