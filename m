Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05098377550
	for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774697744; cv=none; b=S+LG8IJoT3u/5YtQEUMwlMDSrYK29OAxpzbcYh0qj84+cFkIDcG/n4TZjYfTYsXz0ALOCRrMjxIVocnDrFUB9nWFXwb4NanpYbNn4Gfx1D3N0zLwY8qBfXwi/7VPfPq6WA9i2Y1Nv4mPFOtN2bLe576zDx4AyE8PJBoIG+v5S3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774697744; c=relaxed/simple;
	bh=xzxAZRqM3f3BSfQnT9B9nnZkdz16p/gpmalRInh1zq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcA6uV09EEcluwPBpvkNT3+nDbdha1wdFvaDHqiRGMqIsb54YOopnrUdLOLOJvp2p3uiUi7Z2+o3GMS0jxMR5vogo3YHSaeGWwFmg0xiuGWfBvJLNjD6H2+wAbbOrNbi2Df2vQVNgrTJIV5wIc1+hPs8uQRC4hzVRqsulOdL8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxFKC/Vw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxFKC/Vw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486507134e4so33434145e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774697741; x=1775302541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bskGa9+wIac+9AV4zAHPQV3SylMDRVZ2RcNk/YVR8rE=;
        b=jxFKC/Vw10AD2w4itfycYJD3pqlfxXuq3CdDGY031boa0E4CtHmMxxSs+ilHhrGjdb
         UjCUVc4+39WZyHPIkVYMN2122cS9N8+gKBs9Ket6kTwJE+RTTj+DujnAh3leho5ymm/u
         oaoByG+BrkfizglDR7zcDzRDvapdaIbW4fJbRoie2Ho7qUDpMMrfNGImTWrJW1Entz+D
         //jXBHn1Do4JngeoYkWHrJnIO/NRy1LP5mOOkwJFR2QGkpQNf+4Zg9QCIc5hFPTIjZNh
         Fqx6G4Zo6dQC38aBw6oD1BEoXVc3vT4nBbZlAVzv0hMrtlmUpkDpaHJoeCqxo1ZCmr7C
         MPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774697741; x=1775302541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bskGa9+wIac+9AV4zAHPQV3SylMDRVZ2RcNk/YVR8rE=;
        b=pMn42rXl9ihI1RT3RZg9LCY/gqMqueChqrR0wJAtwfKJ93lMbE7BKuYOQANK71O1gr
         cYVVGjqYSSvC9eYqatBJdIe4ERnvObTPeKzJDJbZzRszVDjg1TUmCNJtN+OocsD8vzny
         SF0cxCRW6Z/KHLehw0Hl0t7wY01sGeLWtYSAMdEm+JzKE0So+EYC/r7h7FLjGaCT0UpF
         sszb7wfLkw1z10FUgQ0C+w6/BKi4z6l1vav1DfOSrSp05R+qqLM4cjuBl0hhzankeBlI
         EgbGRCsHInzLv9xLWvRMkKhzNmjRbDeD3iH19SAkUypfrM1LA3tOEkJpBGMgbnJaY1i+
         RoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgj47Kx/InxKAddiJPxxpcNSDnFzuwWHKx1zZAQdG+mMGMUWMQliUZU8mESuSwv/+2O7FOCnibyRJ463estWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPHJqw/kgzKHpd2ubPKC5oMPVLTr1mRazLvLF+MhzsrpGw1Km
	6vJIdpoNgRq1ESjgpNS1HcgIarAH2SFvaLFAbCGBY+7fPHG2nCQxGNTazZm69N+b
X-Gm-Gg: ATEYQzywN540BebSCaxHyCGmyvjhkKN1DM6QchZa12K8KzoAb7XOrZCM1EgDbyqmEEr
	l/XaB6DLmISVT1kAD7WCZZBUm/jiMp+a+jtMRiCJ9+nWl4XYWD/8j0GTbmSSQ//zRp5JsdEqGay
	dNu0iy6O3TAVMbvss4vjSRE3YYsDaeUvbm2miHUsttGt58+mhiWQuuRJNquHMudeysIB+uah7/o
	bQqYYFlTbAcBpYGG+HAsxe6o4C2yHwLfwfDtpyA+8CGdG8dWAw9Q6MVEggcdKGcxYpeGUrw/r7o
	E5Wz55zbYuf/7uaLIFf0UdlhnRzjDvDHTkbZO51db3wOP4GrlBg0bFfrE2eIErcj/W4OO+1BSoa
	YuVChk0zxSRGap2eVjA8R9U4s7D8EHlhRRvt/FYi6VzAhj3zz9I8gyqkvf+BspIRuZEbkx0z0vx
	4hSt5W06g3yStJm2D8hKYNOMYQ+dzZABxJBtBhnGUXbk+QTJ0OTwYHfjPVD917+NWn
X-Received: by 2002:a05:6000:2f85:b0:43c:f66e:f2d with SMTP id ffacd0b85a97d-43cf66e113cmr868346f8f.27.1774696095926;
        Sat, 28 Mar 2026 04:08:15 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e29b1sm4420470f8f.8.2026.03.28.04.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 04:08:15 -0700 (PDT)
Date: Sat, 28 Mar 2026 11:08:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH next] string: Optimise strlen()
Message-ID: <20260328110814.0a59e12f@pumpkin>
In-Reply-To: <CAHk-=wgHK0tyYym=gkq4YRHMywbuETcn835=A7uSTSTPspzf1A@mail.gmail.com>
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
	<CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
	<20260327224928.7c4220cb@pumpkin>
	<CAHk-=wgHK0tyYym=gkq4YRHMywbuETcn835=A7uSTSTPspzf1A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2026 17:29:21 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 27 Mar 2026 at 15:49, David Laight <david.laight.linux@gmail.com>=
 wrote:
> >
> > I've not measured strnlen(), but it wouldn't surprise me if argv[]
> > processing wouldn't be faster with something like the strlen() in this
> > patch.
> > After all arguments are usually relatively short. =20
>=20
> No, we used to do those a byte at a time. It was not great. execve()
> strings are often actually long because of filenames and environment
> variables.
>=20
> The trivial cases don't even matter, because all the cost of execve()
> are elsewhere for those cases.
>=20
> But the cases where the strings *do* matter, they are many and long.

Is that the strncpy_from_user() path?

>=20
> Again - where did you actually see costs in real profiles? We really
> don't tend to have strings in the kernel. The strings we do have are
> from user space, and by the time they are in the kernel they typically
> aren't C strings any more (or, with pathnames, have other termination
> than just the NUL character).

I started looking at this because someone was trying to write the 'bit-mask=
ing'
version for (possibly) RISC-V and I deciding that they weren't making a good
job of it and that it probably wasn't worth while (since x86-64 just uses
the byte code).
So I did some measurements - mostly to prove it was a waste of time.
The slight unroll of the C versions was a 'I wonder what effect it would ha=
ve'
change, I was surprised it doubled throughput.
For such a small change it seemed worthwhile.

I've just run the tests on an old Haswell box (I don't have any recent
Intel cpu).
The 'byte' loop (and the unrolled once one) execute at 1 byte/clock.
The 'masking longs' loop runs at 4 bytes/clock but matches the byte loop
for 16 bytes (mostly because the byte loop is slower).

The 'elephant in the room' is the glibc code.
That must be using AVX and manages to beat 32 bytes/clock on my zen-5
(slightly under 32 bytes/clock on the Haswell).

That makes me think about the exec path, the fp registers need to be
trashed which should make them usable in the kernel (even without
disabling preemption).
You might need them reloaded after being preempted - I'm guessing that
is done in the 'return to user' path these days, rather than trapping
on first the access?

=46rom what I remember kernel_fpu_end() got changed so that it didn't
restore the registers - so pretty much just enables preemption.
Which means that subsequent kernel_fpu_begin() are also cheap.
But code can't request 'kernel_fpu_begin(if_cheap)' and use the
fallback slow path if the registers would have to be saved.
That could speed up some code for 'medium length' buffers.

	David
=20
>=20
>            Linus

