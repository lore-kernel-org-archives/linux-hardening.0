Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497114A60F;
	Mon, 14 Oct 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898584; cv=none; b=JZhlx3HZ2QMDRM7DGE3IDSXLJcndEsMm03TmPD4Eq3yJcYNKzlYsBAJxRH98GWiQ1crOINYGZflkXikFhbIgW8cHGpoAcnE7pi4NxFL8RPEVWSVsY01ClkKGW5ixo7cRDIjbb7P9gHc+AQOwdQ3LsjmIi4vmiUBw87BVqX4DRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898584; c=relaxed/simple;
	bh=qBsDQzAs7QP3X6cKNCdApLam/YNuSrGBVVymI8+/YI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxIIYOMzS128yBjSvvdeunuB0Uobe70HGZne3OuphLJk0Jtfvf83Wot6SNgxGHsmR8R25tAi/wRflvkw90Jjfwfba/8z+OQDQe1uON63WudPXQ78FzmNffLSBfYtRLashGBO9AZ58lOPlO+YMh/7SQH15GCZhWeUuvniAW1KO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZlqLdla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZlqLdla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49524C4CEC3;
	Mon, 14 Oct 2024 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898584;
	bh=qBsDQzAs7QP3X6cKNCdApLam/YNuSrGBVVymI8+/YI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZZlqLdlafNYwTQp3iI6kjWi2EgQo9Meag/2vRweHt4QP1snZ0W0Elr5wgiN4V+eEj
	 qy6Hpp6Ditayif0vktZFh2pewpX/V7lBF+/TUzKpiyn2jJgNnwmD/JpcXnrBLTQXKM
	 +ep1sq6jSo2Pia4oODy2Vhf5nwgbOIDIgz+JvUVujdVCjVnagGzZg7da9/HXPp36Uc
	 h4teqzrRrPLRQRScFWwCzoPdw6aDnQF2dJYyoUFRxhHJmXJ8MwG9UeTF6i3jgjXzbi
	 SE+JlhgpsqWKuGrJGJprdR75iIN7metAVc8dLRR0HddZp5EzgAm/SMlKRcced3a63e
	 ghui9ZmMtkjfg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e690479cso1533499e87.3;
        Mon, 14 Oct 2024 02:36:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPrbMJpHijytl3NmLnHiNKMh0VzzoHTvVRms0iRmF7BCmUyig9gCopDPyy/HIETA2Rh3+NDNMxOURl9406bXY=@vger.kernel.org, AJvYcCWEDpy+KlwFffkb1aErAqHMz60TZnuqoCWw+c5zxoZH9DMmgRkT7kA/lnExQMVXtTT8GdmzVpjqEIa0Emcb@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVDI626FL3yO1hFi0gbrL5pKz064Jv/r2COnA/cfbNXYWa8an
	yVfzlvP/6pzFYkM6SDbywV29Aa4izUf85VEQpwyZAvCmZ40LSNPlhBfROWMGH4udmXeTnc0Aldb
	ed6jfFtigxqHJXwI5vjnCJCNYKi8=
X-Google-Smtp-Source: AGHT+IGt5EXUDsyicAY+SuCAlZVRwBl+6YpbpfCaQBaSxgEH6ByDW9QmHgxUn/tZZr9bNYXXcX0C91ipOf90HXHxHTA=
X-Received: by 2002:ac2:4c46:0:b0:539:968a:91a8 with SMTP id
 2adb3069b0e04-539e571da42mr3496869e87.47.1728898582693; Mon, 14 Oct 2024
 02:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com> <20241011170847.334429-16-ardb+git@google.com>
 <20241014042833.GA20015@sol.localdomain>
In-Reply-To: <20241014042833.GA20015@sol.localdomain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Oct 2024 11:36:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERhCiKMqCr7wCPitQCcPNj7uuEJsgC9jGxSdBWxAwqdg@mail.gmail.com>
Message-ID: <CAMj1kXERhCiKMqCr7wCPitQCcPNj7uuEJsgC9jGxSdBWxAwqdg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] crypto: x86/crc32c - Use idiomatic relative jump table
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	keescook@chromium.org, linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jan Beulich <jbeulich@suse.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 06:28, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Oct 11, 2024 at 07:08:54PM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> > index bbcff1fb78cb..45b005935194 100644
> > --- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> > +++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> > @@ -53,7 +53,7 @@
> >  .endm
> >
> >  .macro JMPTBL_ENTRY i
> > -.quad .Lcrc_\i
> > +.long .Lcrc_\i - jump_table
> >  .endm
> >
> >  .macro JNC_LESS_THAN j
> > @@ -169,7 +169,8 @@ SYM_FUNC_START(crc_pcl)
> >
> >       ## branch into array
> >       leaq    jump_table(%rip), %bufp
> > -     mov     (%bufp,%rax,8), %bufp
> > +     movslq  (%bufp,%rax,4), len
> > +     addq    len, %bufp
> >       JMP_NOSPEC bufp
>
> I think it would be much better to just get rid of the jump table here.
>

Good point.

> I have done this at
> https://lore.kernel.org/linux-crypto/20241014042447.50197-4-ebiggers@kernel.org/
>

I'll go and take a look - thanks.
