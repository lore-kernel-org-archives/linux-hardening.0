Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB73EF67A
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086987; cv=pass; b=dVtR29BZPZt3x2PO6du2HmssRmeUQXDKLFQ1PFbmfzi5OIMtYTwrayE2ku8D5ellEh/MjKM6D98832ZJwK/Xe5sjOrDLi1uMBca8BlRHZ//nbboJHA16Vw04FUUZZ3UhWz+8Msfm3DLfA5YCXOrs07WP/u4r46R0WotE1Qtzyp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086987; c=relaxed/simple;
	bh=vb8ZZRP0AUsWH7D3wGTnRXL9a0COAZFzJBs4dfJtueY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MggNX+uAVCbR30uTMRGiHEhFULkkhrN0EcV72xuMiZSeFabwvDspYHV1BgTo4Z7ahJ7dEfy46b/hnBVJZ0btylPDzN1LvO2YN1dx5gl015tUM5SYwxPUK0rXH2sthSd3Md59ytkmo8mjM2j5uV6ArgeESfqUYiKaGVXz/v8nEkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdVowrbu; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdVowrbu"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so1003670241.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 16:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775086985; cv=none;
        d=google.com; s=arc-20240605;
        b=Ppc6jWhTN/0re+JgcXk13syzW3JEZAjzqeKjubP1HnzNK8hwNiUn3ZA13fGsZ30cLY
         rgn13c3I2T/hNB9IOq1mIG+xI8LPM7GFWRsiIWxlnwJ0kEzFgUwoatuLGn/ya4EpMkgd
         7gFIMOxah/SqWmdYAoByMGBWBPPRS5ygilM5UkcFGG4tse9PArcmlj7ty2J1szF7b3Iy
         0d5WiaTmbWN11PaQ12RbTHhUuRxXIbQ/rWb4yYHCTcUsgVFoZKoSFZvzjLUToSErcA3A
         M2/UebMXAcEZ3XW2tSLBM1QBd6sEip4UjMlswKBrX5RXl+Ko//qqpw3qQMers2pvleK5
         uHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb8ZZRP0AUsWH7D3wGTnRXL9a0COAZFzJBs4dfJtueY=;
        fh=vzptO7hFsbQr8FsWuZrbuArNeEe2goxDmtOm/eL5WVk=;
        b=WkCKaMa7txn5kwR3BJ5w1ZYXKETM5V44YvGuZ3nCceti40KfqIKvJ1pXY4CcTbj+jj
         SwBI0bfkCAGUEa6fziapLsydGt5JYmJwZtPdGdQN5D0OHupPWO9Zl4Qky/afkTQPJIyU
         bGccI/ir/LBoVBUoswmbXeFHYwNyo00Y2R/Xf3viaeGYp8m68NkOQor3bNvG55K+D9Tz
         p81zSFGHVOoYXid+MrfpgQuibZ/Yi7tQ+LWcrU9r+iGsDaY/vY3R3gffaPWQhcn/Owfk
         5ZcfFr37ZTPuiYlkxJ2lqDRyBxk2iUGS771XeT9Y4Ci6jYpo1TPgchuw5gwbufnqTwKF
         AOng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775086985; x=1775691785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb8ZZRP0AUsWH7D3wGTnRXL9a0COAZFzJBs4dfJtueY=;
        b=WdVowrbuUfX2c+pzomoH0r26x9jw3GpIqiYAjlEiXUrSCLaJjPOf0F3tTbGTfHElRo
         MV26Ymi7xGB/DpSGNWZdL1ts58WSmXQDC2hFGVb3YEhZSNGOtq4q4gHJKD/JSv2hcWDp
         XBx8NKs2wH2tvmlPu9ngOCkJh/YKdXMRA6RQbDyX1r51eaQwBaL/P0jQSUszJzKuTSQo
         mxcmMzlt5qM6iY8OLtzREbwBmBFVTzGJ2mpluRRQj+o2e4+GQUA0zq5WjB3luk9S07+j
         USuGz1AYlY6Tc58kCyUlc2PEkfnbhxxsx1uR4DdFRZZZ33iMljvydPhDTBfIr2e+IGdt
         QqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086985; x=1775691785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vb8ZZRP0AUsWH7D3wGTnRXL9a0COAZFzJBs4dfJtueY=;
        b=kaGEJUAQitNvsoVOWyA3l0p2T4UMZMdHZu04VnbZVWagN8pHOa3DwA06BXW9+LTd4K
         sL5f7j2GLDlqBR8HR4SIXg6Ylj9zh4D5P8QRuA3h0ia+1jS8uEtVW5/gMdZdnU1XZ+ee
         X9b2WqqJzoaIQigWoVwXjQhBh/PruTU8BmX146Xkr2TlwpBfNqfCg8SY7wWSX7VUqQFN
         CA8Qcjua9zK171P5Xwmt8g3jh4zuchVFxot842qtuaaDE+hNqxtO+PAvAQX4o0RkjyKC
         sMLz6QL941Ii5Qg6qYEqmtFxJShxAl2MAEbRnQSO0UjhZX7pS/XusDMSdL8NgbCMFq+M
         Hdfg==
X-Forwarded-Encrypted: i=1; AJvYcCUbvrL6LIwqMN4bNHbRp+HC3D22tE9fd8sHzo2QlUbyTbGTldguq5iI0Yf9oa+XuyCRKtfsKe9/1KyV9b9FJrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3T9Jt8IDay++t+6JAau9dNbueEmbLzqP8ZwpF9GoQhdhbdekR
	xclFBP7LKslIYDWTRQDyb/fIltcs2TFMWLncdKo8vLlbW8IgINi25fieSsPA5a9JqErwXRS6Q/4
	ATig9aS8KfoMjsoituZ11tqCeUrGKSililqiP2FKW
X-Gm-Gg: ATEYQzzg2aR3nn6mqGTpr/b9zXF9bogBVLgpWV1ralvR+tQoheaquFUZ5kJ59+xB/p3
	5fCNju6Gpq2rnPURyb1WJ9OizppDciJZOplk1Okffp/jv7fmVvcyhZsnw7SAfIQAbq7fbZr+KYF
	IecV1QuTi6cA44rjTjUaG/+DzrtH3u4XWD1XYISkNWh6b/MkNyiBvpb0RlAhXmykSYTdnCM1Ytj
	O2ANJesjccHlDCzvJ31hqssams81Jshz5zIirTj8hZQNIKDL9mr9Ie+rhq7tqkbYhCmr9VvB989
	jEsPSKQ=
X-Received: by 2002:a05:6102:3e19:b0:602:70ca:64ff with SMTP id
 ada2fe7eead31-6058a9eb523mr128831137.20.1775086984541; Wed, 01 Apr 2026
 16:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
 <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
 <CAFhGd8paijFboDVr8rJDjScob047q+zgYAs038WuVozOG0aYaQ@mail.gmail.com>
 <202603311249.30B44C66@keescook> <20260401090815.GV3738786@noisy.programming.kicks-ass.net>
 <202604011313.AD471BC8@keescook> <20260401203053.GC3254421@noisy.programming.kicks-ass.net>
In-Reply-To: <20260401203053.GC3254421@noisy.programming.kicks-ass.net>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 1 Apr 2026 16:42:52 -0700
X-Gm-Features: AQROBzD_rcuI-ARbXbMVr7h8U1mc5_5HGF_2wM-4PZhtBnHiHxrvNEdk_0yl788
Message-ID: <CAFhGd8opNwwqjU35TqkbxRvHgwSb8KZ3+wa0Tr4KWumvjfRVTg@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 1, 2026 at 1:31=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Apr 01, 2026 at 01:21:17PM -0700, Kees Cook wrote:
> > On Wed, Apr 01, 2026 at 11:08:15AM +0200, Peter Zijlstra wrote:
> > > On Tue, Mar 31, 2026 at 12:52:10PM -0700, Kees Cook wrote:
> > >
> > > > I think for this series, __ob_trap/__ob_wrap is what should be used=
.
> > > >
> > > > And for other folks, the background here is that we originally want=
ed
> > > > to use macros for "__trap" and "__wrap", but the powerpc C compiler
> > > > (both Clang and GCC) have a builtin macro named "__trap" already. S=
o
> > > > I switched to just using the Clang-native type qualifier. We can us=
e
> > > > the attribute style too, but there was a lot of confusion during th=
e
> > > > Clang development phases where people kept forgetting this was a ty=
pe
> > > > qualifier, not an attribute (i.e. the attribute is an internal alia=
s
> > > > for the qualifier, and the qualifier is a new type).
> > >
> > > Since you mention qualifiers...
> > >
> > > What is the result of __typeof_unqual__(int __ob_trap) ?
> >
> > Hmm, it seems like "const" doesn't get peeled off. That can be fixed, i=
f
> > that's needed?
> >
> > 'typeof_unqual(int)' (aka 'int')
> > 'typeof_unqual(__ob_trap int)' (aka '__ob_trap int')
> > 'typeof_unqual(const int)' (aka 'int')
> > 'typeof_unqual(__ob_trap const int)' (aka '__ob_trap const int')
>
> So how can something be called a qualifier if unqual doesn't strip it?
>

Within Clang internals we call it a "type specifier" keyword with the
closest analogous thing being _BitInt. Even the attribute spelling of
OBTs boils down to a type specifier being applied to a base type.

This hasn't been clearly externalized in the documentation -- we can
work to improve that.

> (We might already have had this discussion, but I can't find the answer
> in the LLVM documentation page and didn't search our previous
> correspondence on this).
>

Justin
