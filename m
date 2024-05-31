Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80782866;
	Fri, 31 May 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187799; cv=none; b=DFcFWqmOEIz+WgRkPFFERB4UL8cQE2q9g+c31TrZkfR8xawjuKblENsjv8JLDAGUPnAQ0HQzUCI8wfP8EJWJlpdQgZJQ3sQ2DSNHGKiMNA3EUXkdO0C6tPeRMB8GBe56y7khsFqt9vsWM6fa6K7ZoOUXtVuu2UKfjnPn8VBPaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187799; c=relaxed/simple;
	bh=QT8jsy9BjKZNv8X9KAnXUdxKec2WrNfhYs2tkh8Z9n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXoMovl4Ehg27opqD3k3GPgHQY4ALUCVsQcGGK2CTTv85AUJbrBfMr5aHY1hRLY5bh/T2DogMXJyH6s6PXZU2rtPf7V3XUGMe05SiHpkPy1LXGtjC8dK7dGsznQ1tCJFI0dU2LYxCSeQBGNYEtzIFwDJ7mJcXlnmrXZoJeOFqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1FkS+UY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1FkS+UY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d10so20525245ad.1;
        Fri, 31 May 2024 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717187798; x=1717792598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=twLijwTOj4W6ARqqInAp+sh1XdnAFooJeHYSV2DKonw=;
        b=P1FkS+UYjV91MRnUhLnt76ROzkSASrn+96unQRNu2inIYZQfOw7t3giDbUh7qUYgjQ
         4M3QKU4ZTlIAQA+SPudLiL2vLY6GaTdsA4VKRZ7tOKMYhJ+j71jBXUAiLOU/isrs/zDk
         5jAbzenVHLPlQvtpUqAyU5qGA3eA7DYngv5Tf5LSGPhsgeWm5jTkQ96R7R9KLTEPNf7q
         GR4/jCrMhsOt/u1dyXHyLEFUL7DllmXqlyaNCRHCZjSo0RDawDZ9MxKAD7eMXlRYKn2V
         gJlW8KkZwdim9B78ce1xT7tu8f7YCbrqbLXmd1F/+XLPkuTWd4LWUZhFwqkNpuRPTO9m
         CNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187798; x=1717792598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twLijwTOj4W6ARqqInAp+sh1XdnAFooJeHYSV2DKonw=;
        b=nNr7DqGBCAkpQh9g+cec3A0dX37G3DpA+6kRWLTYtnAZuA+mS5ZTUA0kIy3CakREHL
         Gjt+BVlMpdm6Mm3+S7lzI9sMHUosM6gCwRShPzVCNz2XOQMbAL92ZOm4Hj4C/YTpqZ13
         CpZce4Y7oisIDdck7g1baYsv110XvW0ZZNpmdsQfQ0MYdZetjmOPoDaU0rVDnBPBQfim
         MJiP7EdvxM5lGjO7w3OTpd1T0PyxUrBoGnDeGAOXVUVIV7M6t583BgVRFgz+lnoIAbg6
         d+IDemSd8QACFxiCyn7OHLRhFDdEVJwgQ9a5ltix2MooJhEqOUJk7Yd8DnFLug+SsKZs
         bESQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtJh+AZFnThDEM9oIJuCYDDOnnoGjS5TyeyZ/vs4W7oG2OA6/4dT7G7dpHp8463RZ0kt1yjKUkXzYlRIpCHAjJgduwen1XbfyyIT93V/8TO0+86oJd/IeQp4+lJU0BY7kkjORD/XV/lRITcJAj
X-Gm-Message-State: AOJu0YyRCCoVxYEuTL/KTOlinHmR9erj4kQShqPXF+q6F6cqrWBCQcJB
	HhthmOMMTcdbGruknEaSAwHEh1ZKRvJMMZ3FEseu+Vphe4soaCk4
X-Google-Smtp-Source: AGHT+IHHP8QAg76F7jjbJT2bI58nRgcqFgYuv5Qk4QfOSBQI34clBHl68Uk4KCQNaiw4SFdV18/XsA==
X-Received: by 2002:a17:902:ed54:b0:1f3:ea4:7ed6 with SMTP id d9443c01a7336-1f6370e66fdmr27847175ad.61.1717187797708;
        Fri, 31 May 2024 13:36:37 -0700 (PDT)
Received: from Gatlins-MBP.lan ([2001:558:6025:79:9460:fb03:8dbb:8b69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632413e63sm20862525ad.276.2024.05.31.13.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:36:37 -0700 (PDT)
Date: Fri, 31 May 2024 13:36:35 -0700
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Pengfei Xu <pengfei.xu@intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
Message-ID: <5yx5aykf77x2gufpaf4nlrdhiqh6ioiqicazp4wq6dosu6d62g@xmj62qw7xa7q>
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
 <c068193b-75fb-49d2-9104-775051ffd941@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c068193b-75fb-49d2-9104-775051ffd941@citrix.com>

On Thu, May 30, 2024 at 01:24:56AM UTC, Andrew Cooper wrote:
> On 29/05/2024 3:20 am, Gatlin Newhouse wrote:
> > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > index a3ec87d198ac..e3fbed9073f8 100644
> > --- a/arch/x86/include/asm/bug.h
> > +++ b/arch/x86/include/asm/bug.h
> > @@ -13,6 +13,14 @@
> >  #define INSN_UD2	0x0b0f
> >  #define LEN_UD2		2
> >  
> > +/*
> > + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> > + */
> > +#define INSN_UD1	0xb90f
> > +#define LEN_UD1		2
> > +#define INSN_REX	0x67
> > +#define LEN_REX		1
> 
> That's an address size override prefix, not a REX prefix.

Good to know, thanks.

> What information is actually encoded in this UD1 instruction?  I can't
> find anything any documentation which actually discusses how the ModRM
> byte is encoded.

lib/ubsan.h has a comment before the ubsan_checks enum which links to line 113
in LLVM's clang/lib/CodeGen/CodeGenFunction.h which defines the values for the
ModRM byte. I think the Undefined Behavior Sanitizer pass does the actual
encoding of UB type to values but I'm not an expert in LLVM.

> ~Andrew
