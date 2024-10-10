Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC11CB302;
	Thu, 10 Oct 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568797; cv=none; b=a4krnehcqDNn3BD0KSNi5/TO0krFUj5eIAr5AUcvuyXpmo3n3U+hqriWCcIZS/KP9qIv4LiYHOn7wwLlTVl9mzDSKTcoSnN8bUNluIHirMF06lPfvdXXT5bYS36lB2kmbl4ASkv2lT5DPKzHwY7lkEugLbEIYJyZFohb9jlXGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568797; c=relaxed/simple;
	bh=7Ww90GvXc+Ix4uHfxVqsy07IC53s9MBe4r1CMRExWtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwsewyoNrL1Nq7ir3mVuAL+5kcsjos0UYwgdqTghdKrdx1qmqRPR47BlQFcoMIwQ881GLeqLlQ2UQJuPrVFcUS5jacoxeP8WZ5m0IYbd4uhZ4GludYNRACZUSNxDQ3id4IqpabaF6lwYsh3ReiCTzVSffrMeJ9D3mRug56UzhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ92nFQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ92nFQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E590DC4CECF;
	Thu, 10 Oct 2024 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728568796;
	bh=7Ww90GvXc+Ix4uHfxVqsy07IC53s9MBe4r1CMRExWtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZZ92nFQMVWW1+RICgwZc/druk4wm9AjT2YhAd+HQ4Fn9Bn4ttiorbO60CTiMBnBFw
	 luu8MMxOjpTcXVTH85bFKRB9PT9+DjDvQmKtf0y3ctpuqFTLPcyQirCI7sOO5xAh6J
	 NHdRjrmJEdeDEQgjH7ZF+HVrPJfObxcMkhOJqngrdEQj503vtn2wBXj/ip//6nhYfV
	 k1eCaIvMBqeknmMrciv9BkiXTS+Ib5A1Zcv/qns5BIIqXFE3Xiy3tJeOBUpdD31WRM
	 oITCNRF1a8C/AnBilu6UFs0CTCewHERg43w65X0Yq083zvvLpPYveZ1rZUXmy0hWSg
	 AKz30M9NTpvsg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539973829e7so962221e87.0;
        Thu, 10 Oct 2024 06:59:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJrcbwgf4XFJ0Bh5scumfQPMFVwXlKWcS/71gVMsYtNUKCVW9IM7pKh4tRYwg2o3oxBz3JFeqebdnN6torQno=@vger.kernel.org, AJvYcCXhjbJAcG//BtRdvFSqUZgEmR1eVHD9fQ9eHPzhutoXjy2qYEK3eDnmTgAz3Ub56mNOcKGXVMidUBMBjbuy@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVC0vce7xLkRokXjrovRT+G+LVgtXbrO8XL4rF5mRoiJbwClc
	d9T3B6LI+caza+mXac2EU3LCJpp4OiPuJzRarBPEI56T+BRBELb4wHJYq2P3RU8bLap14T6eFdF
	Y4zs1WGWBYAKqZb8NgA0oAQvxEIs=
X-Google-Smtp-Source: AGHT+IGOT1AWXDpwLRrYOsifyHE4hA+rB+bIHQ8EyJ6+fEcFPu4Ly5om+AN1zutWYtdrygOWdUpxHDoFHhsaDqz9j3U=
X-Received: by 2002:a05:6512:3b23:b0:52e:74d5:89ae with SMTP id
 2adb3069b0e04-539c4951548mr3966891e87.39.1728568795311; Thu, 10 Oct 2024
 06:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com> <20241010122801.1321976-8-ardb+git@google.com>
 <20241010132623.GI17263@noisy.programming.kicks-ass.net>
In-Reply-To: <20241010132623.GI17263@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Oct 2024 15:59:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFg+JWMrfw40y2=0f9jr-3ebUxsFPprAK5diK4GQke_4A@mail.gmail.com>
Message-ID: <CAMj1kXFg+JWMrfw40y2=0f9jr-3ebUxsFPprAK5diK4GQke_4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] objtool: Deal with relative jump tables correctly
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	keescook@chromium.org, linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 10, 2024 at 02:28:03PM +0200, Ard Biesheuvel wrote:
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 3cb3e9b5ad0b..7f7981a93535 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2101,6 +2101,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
> >  {
> >       struct symbol *pfunc = insn_func(insn)->pfunc;
> >       struct reloc *table = insn_jump_table(insn);
> > +     unsigned int rtype = reloc_type(table);
> > +     bool pcrel = rtype == R_X86_64_PC32;
>
> R_DATA32 or R_TEXT32 please, the budding cross arch stuff has their own
> names for all that.
>

#define R_DATA32        R_X86_64_PC32
#define R_DATA64        R_X86_64_PC32
#define R_TEXT32        R_X86_64_PC32
#define R_TEXT64        R_X86_64_PC32

Clear as mud.

I'd guess we need the '64' variant here, but I'm not sure which one to
use for a .rodata relocation pointing to .text. Any hints?
