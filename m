Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7191465F67
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874767; cv=none; b=Mx4+hB8fnRqf0mVoBnyybrIkBiFwve8FIp3k50bSVOMwNqEL84l/aQ+/dNk4a62QdL9e+SYJZc2fc2rPE8/X7/aabSJIBnTg2vBfSA2/Sognh6spHK+z09xAMCS+CXMsYaDIb+mx76f6TKY2uamm6KPkkYDKqJCEa6mYB73l8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874767; c=relaxed/simple;
	bh=cJQJkndsCeAK6yj/3t9R/gTo/9xR0Q84xYZxZvdj0d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty6XzkBPmQ/7P2X1URNPl08vfBTCnumridctas1xqMCtrIEBcqVDt3ZrLQixrf4jBkTvaTSTJanVwZLuxQ3j+e4dtREe+DXJGZ6yuexSXjUkpAuw4GEDqfyhXLa5a9bUOMgiregYNSRG+PI4p7Ll3AgScZPaTnlyUdYxxUU0nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qru693K1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qru693K1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60641C2BCB3
	for <linux-hardening@vger.kernel.org>; Thu,  8 Jan 2026 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874766;
	bh=cJQJkndsCeAK6yj/3t9R/gTo/9xR0Q84xYZxZvdj0d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qru693K1lmTB2v29DqSy3hkhCbN4DW7J73G5z1rt5L852KE+izqjUajyJNCvBMIds
	 s47XzUcj+GS04/2rnuG93cwYm1EzXe1LhThbOXAfIR9ymREUzAfv0i90DdjgMJGoqk
	 MICLyaHjx2muNgavkPzYN0PM5OuLFwduz6zMS5pRb2xLZjMr5q9+Ij3PpOrheW8HvT
	 yHSKoBdneDfM0UqfrZMWsuX0laAVUylvbUCEkAsm2xF2Cbt56DrBQF8gW9/CXqbHxd
	 HKNYbxRsXF/ASfK6vYckuNeHAqwWz50b5skReil8ovQSVRFDlgs5yJESPFACeSocIA
	 cXUl6qwZGfvqQ==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c21417781so2324286a91.3
        for <linux-hardening@vger.kernel.org>; Thu, 08 Jan 2026 04:19:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbKC0v2Xt7EwDoJGPHx0j4XBpYNCc+im8jNUGpPRuy1l9cC/+5MjLT/oig8oGcNduiXhEIjGwiCdQratUmZZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGYwmYxk6QXlTxV3SfVImYMPmTqsEFQDsiIzR3vlI0CZd+6ry
	n0KT7A5W8haAbKtqSTM78iDBezHYs79eJr4AIIsQCbD/bHH5mfesEJ/Ps8nimZm9EF8eEO4rk5P
	Dq2tccU2vlRoEaPuIPTnrqXZALYs2Ndc=
X-Google-Smtp-Source: AGHT+IGY9I09ghB/OKAnX6IKZSUHulDd50CRsCJgEvmpi4fEki7tUR1qnbJfSumjAQRkbj4/MlmmcxycGPoWFIHIkFk=
X-Received: by 2002:a17:90b:1c87:b0:34c:a35d:de16 with SMTP id
 98e67ed59e1d1-34f68c282c6mr5650429a91.11.1767874765813; Thu, 08 Jan 2026
 04:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-32-ardb@kernel.org>
 <20260108120829.6ea6aa0a@pumpkin> <CAMj1kXFY=Os10Ov6Wv6XNxqLqbEAWTOjkdaohxL3SvveCLWnLA@mail.gmail.com>
In-Reply-To: <CAMj1kXFY=Os10Ov6Wv6XNxqLqbEAWTOjkdaohxL3SvveCLWnLA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 8 Jan 2026 13:19:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVw-+S7S83ipn0vqxwz=ud2bLSKeZQLvy91BMVkVKy-g@mail.gmail.com>
X-Gm-Features: AQt7F2r36v5pc9VFMJGXotydZ1MiCabtOFiw9ODZvPQYjU1PUwN9wuOOTgHL42c
Message-ID: <CAMj1kXEVw-+S7S83ipn0vqxwz=ud2bLSKeZQLvy91BMVkVKy-g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 11/19] x86/rethook: Use RIP-relative reference for
 fake return address
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Jan 2026 at 13:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 8 Jan 2026 at 13:08, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > On Thu,  8 Jan 2026 09:25:38 +0000
> > Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > Pushing an immediate absolute address to the stack is not permitted when
> > > linking x86_64 code in PIE mode. Usually, the address can be taken using
> > > a RIP-relative LEA instruction, but this is not possible here as there
> > > are no available registers.
> > >
> > > So instead, take the address into a static global, and push it onto the
> > > stack using a RIP-relative memory operand.
> >
> > The comment implies the address is 'fake'.
> > Does that mean it could just be a constant?
>
> It could be, but it isn't, across all architectures.
>
> > Clearly the unwinder would need the same change.
> >
>
> Why? The value being pushed is the same.

Never mind - I guess you meant 'the unwinder would need to use the constant too'
