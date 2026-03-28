Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C573431E7
	for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725434; cv=none; b=F7aed43oXdX3rdFBr3qDqG/uuxS99va0TxkUtJ1dthpawH0zUxYsgAUvXZGQZ6b18hGCFrnZMED3acH1arhfUdxo1jgFx1flDgk9zdHN6UsOMvu8XunovFiG973gsjFFZTZ3rWhrbnyXLqK7QpKTA+NNu35zmzrBEtTth7fX7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725434; c=relaxed/simple;
	bh=SwNri+m6r5Pc4DADGOBN1ypwIFXaYHog8hy+qDQAWHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCaLYBVSe91apJUdQkPXK23tJEEEsFiNiSy/Zlb0lKu6K+vGKdrDYgwQcn7gFoRCRBXK4ndJ3T3u4cW0I37tKdSjv0xCPHSqcu+QXt2BrWiv1vUBBMzNrKNAf+pKmnYCX5HQEIs05SyW4qolrL0MfFenPO9ga2Yd5L1yUBML0LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DWRBXcaW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DWRBXcaW"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b979d16dd0cso572417066b.1
        for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774725429; x=1775330229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F+xcA9ciccWstUGPjkLGPmgeR3rFmlOhLADsIoRH1EE=;
        b=DWRBXcaWork0RUdn5bMH1fLpYB1GzDXc1BH2ZSoZJK7wt7gWH3nhbs+Bw60WlIsGwW
         9kKXZ3DKnVPpFGup1u+RXgXI4UmV95dLg6Ug3ckcxwcLIOfVe/rXDm9Yb2SyuPVsnk7m
         Gp2Cao97hkR9dFp7t4eP1jKYwdxKdxobazLds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774725429; x=1775330229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+xcA9ciccWstUGPjkLGPmgeR3rFmlOhLADsIoRH1EE=;
        b=NipKnnu7cXPIGvCUGh1LTcA/6LzrXE5o6TEkiWf+n9WwquZEd5fKXSLRbj+xAaQJfB
         MGKAkoCmJwqjZmZXWOK79O9qUDTNeWYwrXuPq1sgOiUFc4dK8LxXc3GkCHI5xHpgtBv9
         FnMiBQLsi373LBSGkpTA19UQ9bWNYYiZM13AL2O4ytiq0MM6ZS3vnIbleV/4/NgS8mez
         TFdl2wrYRzvkozWWgfaHCLsQMRXjIEerOqUUUP4MW4PsjJKooEXHHDatAy7LVphuQ8pl
         oDa9X8hRFBL5MVZRagwZTcm2kFQGXSXrst4NtHPq+szq1B4KV3ZVOsSMza+F2v3qHOP7
         w7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy28QsYFStwfkZg++KGov2s/th5prnHT0BTNDC5jTqPO8RqwkLb9NcGLNbUItnajug1ogdX+drpVCeO9eHw24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQCEVmGVSsx6aZEl0lTnCn57i1hfllYGyxFgqqyuXs6nOhhnE
	2WI2rF/mVjHbYek1W/ZbA4yGOxcUug51znsKMcdsAyjAvnT49qh96Uvr5gM9tv8ALQg9p/U/863
	Nvzm6LVE=
X-Gm-Gg: ATEYQzzBvIfvb+jRX1lAjBVM/v/cBgTB1/umIf4ogXw+s4GXzImybKz7R+qHKYk63Df
	n38htR6Snk4yOcIfwaQ4mMja/zQ226D9bgxOzPOyJhL2n1YMxvgGqgJwNKcJagOL8R6bSLYeOHd
	VX4eGpucpEE4ZKroWdSvGxazuF091wFEj5hDY4ckHOoxhDOQqdAxgOHZULX6b9uq431MFXYV69f
	zctaAEcSpkK2OkcN54yGaKKRTEdVhKDh46vzdWgwvvXIkrJCmkxspmznTcBeaUG9Zmzvnm775/+
	fs9QA7/m1B16FtwvQ/HHk/AvpcXTwMBXdzzwLpUlCF1SGvyhz+OXR0gUGWbD8+JbXTYk7gNQLRy
	7cO/1XJkeXUTKu9HLfFgrH1267Yiytp4coGbfqRESc9l6b43i9vSfpq1gYV9QcPIz56suRixq5x
	sBNhsjzRpdMzuNLy8r0FFYaxO1WDX3j8Bk7v64ItQOFa0fLonp4Qd95r/u3mp6MyESKK2bP94T
X-Received: by 2002:a17:907:960b:b0:b98:3fdc:150e with SMTP id a640c23a62f3a-b9b5016b0dbmr464661466b.2.1774725428901;
        Sat, 28 Mar 2026 12:17:08 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae269ddsm104116866b.5.2026.03.28.12.17.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 12:17:08 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66b3d06e2bbso3271074a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 12:17:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUleT1g1z6P1ZymHDGg/AFvGrX8HR8Vg8H2pmHH6ZSGQnmSMYqK1YE7/rpqGEBlB5hDZ+EIXngtHDspQT6GF2w=@vger.kernel.org
X-Received: by 2002:a05:6402:4587:b0:66b:a96e:5eca with SMTP id
 4fb4d7f45d1cf-66ba96e613bmr631314a12.14.1774725428093; Sat, 28 Mar 2026
 12:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
 <CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com>
 <20260327224928.7c4220cb@pumpkin> <CAHk-=wgHK0tyYym=gkq4YRHMywbuETcn835=A7uSTSTPspzf1A@mail.gmail.com>
 <20260328110814.0a59e12f@pumpkin>
In-Reply-To: <20260328110814.0a59e12f@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Mar 2026 12:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwRPqvYLsWn_dbFHs5hHry=5HW2OZF8pT_mBzpbJvW7Q@mail.gmail.com>
X-Gm-Features: AQROBzAMYfpWyjNrFJDdcZffOpwjA3KcTK3cThIpxyvl2QrUW8Ov2g-Km0K-SwQ
Message-ID: <CAHk-=wiwRPqvYLsWn_dbFHs5hHry=5HW2OZF8pT_mBzpbJvW7Q@mail.gmail.com>
Subject: Re: [PATCH next] string: Optimise strlen()
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Mar 2026 at 04:08, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Fri, 27 Mar 2026 17:29:21 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > The trivial cases don't even matter, because all the cost of execve()
> > are elsewhere for those cases.
> >
> > But the cases where the strings *do* matter, they are many and long.
>
> Is that the strncpy_from_user() path?

No. For annoying reasons, execve() mainly uses "strnlen_user()"
followed by "copy_from_user()".

See fs/exec.v: copy_strings().

The reason is that it needs to know the size of the string before it
can start copying it, because the destination address will depend on
it.

And yes, it's racy, and yes, if y ou modify the arguments or the
environment while an exevbe() is going on, you get what you deserve
(but it's not a security issue, it's just a "resulting argv[] array is
odd", but you could have made it odd in the first place, so whatever).

It would be lovely to be able to od it in one go and not walk the
source string twice, but that's sadly not how the execve() interface
works (or somebody would need to come up with a clever trick).

The main user of strncpy_from_user() is the path copying: see the
'getname' variations in fs/namei.c.

And sometimes pathnames are short, but we had a semi-recent discussion
about the distribution of pathname lengths due to some allocation
optimizations recently:

    https://lore.kernel.org/all/CAGudoHEMjWCOLEp+TdKLjuguHEKn9+e+aZwfKyK_sYpTZY8HRg@mail.gmail.com/

so while short names are common, longer names aren't *uncommon*, and
and loads that use them tend to keep using them.

We ended up aiming for ~128 bytes for the initial allocation
(EMBEDDED_NAME_MAX is 168 in one common config) for that reason.

Don't get me wrong: there are certainly many other users of
strnlen_user() and strncpy_from_user(), but the ones I've seen in any
half-way normal loads are those two: execve() and pathname copying.

> I started looking at this because someone was trying to write the 'bit-masking'
> version for (possibly) RISC-V and I deciding that they weren't making a good
> job of it and that it probably wasn't worth while (since x86-64 just uses
> the byte code).

Ok.

I do think that in user space, strlen() and friends can be absolutely
critical for some loads, because the C string model is horrible.

But in the kernel, I really don't think any of this matters. Our
strlen() is bad not because it's bad - it's bad because nobody really
should *care*.

Some of our "rep scas" users have been kept around exactly because
absolutely nobody cares, and it's a cute remnant of a very naive young
Linus who was using them because he was trying to learn things about
his new i80386 CPU, and started a whole small hobby project as a
result...

               Linus
