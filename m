Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05C24B22A;
	Sat, 11 Jan 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606466; cv=none; b=sYZV8lnb1V4QhUSwASOuVsT1r+ieYGgY+ztQOvq06+5xDXg19yyGlXLMTJkBLXxGoTeQXkxXfegSxZxRWNN80aTn/psO4zkPHmL3LM8/1nqQy8E6rsGzvdnOXv1by4sgfucxBfbNTtDEkSxaVR5Of2dM/ggr1+QtSwrPM8k6Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606466; c=relaxed/simple;
	bh=MWY8Vh9vyzPLy4+o8smc3TSgBb2SpB71E2D4V/zKYlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=los/pYknvmENAfPjLYP3X1TtAQlap6JxwuGWa0xycYTcWCaiLLoOLva/zW+sPrqvGF2B53I5Jvxw980MRPMZMs8BRiusx7IICyHOzQB5fZa4LJ07lsvfgWUGFSlDOqmuSmrcB7+k/Tn9JR/W+amVXwNgztnob/IkTa44k4dR2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RFV2eecN; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RFV2eecN"
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by smtp.orange.fr with ESMTPSA
	id WcfVtwGxJqZ5JWcfYtrFSj; Sat, 11 Jan 2025 15:40:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736606456;
	bh=HnmEdRI/JuEW7Q0XlIQvyBGESggVLrnEqhLzSdi7NTk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=RFV2eecNGBDURff6CsmQiUnSMGZ+OILUfQ3CT4jHPHY2iKa52cWELI57f8pWk4Kn1
	 p81xzRI/Nskg+BnzU5Ztax0n4RfzGKferszYGoBl7BEiadq5WgQU+DjLIyQziXiUv1
	 4TksPNibevjESAT3w+KczQp8DidNMBcAB00KRXm5/K3baBZ9ltRsKQvOTA4lo2bDT+
	 1MbnWX+1RSaGiV0A/yd1HPWUCFiVP56jEKhHMJ15OAa7NLxK/fJziSylSiYkQAGJiK
	 4/SBfCWekqCqmj/CADo/K75crqIkYLprpZZTUYTaMxyj+elSErYdQubMZ0IEpIFJai
	 +8+LxzYZftxhw==
X-ME-Helo: mail-ej1-f42.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jan 2025 15:40:56 +0100
X-ME-IP: 209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so584511666b.0;
        Sat, 11 Jan 2025 06:40:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0p0pvQtskPc57g6ZnhkqyLoSJC+7tUq7CdeN57Ifx+dv4tEl9o12VoiUkVo6CofA5JX+KtMjDCHafvJyW/jg=@vger.kernel.org, AJvYcCUFo2wPkTN3+zqsP/UDwuxmOhb488MNxfF/HFgDz9NHHRQGBtuO3WKkC0ms/nGYrSo+rnTdryZvb2MJiv6a@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/r4qgiSLGslJ7XaHla2zo6uFXp6pkB2COJUY4hP/0QTZsXoQ
	EK/n3IWoj5DV3BJcUk8p6P7mp6EK+u7YE2gwgYd/g+SlMqameMZ3lgnDTfxab4izuf83LFmHf5D
	RSGNAcmriy7D0rzF8zqCoZnTQav8=
X-Google-Smtp-Source: AGHT+IEWbXRgdQ6oOnCXEsh9qkGATUuGBQ1omOgQ7o8G7l70E+lYhM/OujP8uUXCdcbR/4GmuEOy9WZ4dA9GwgveI6A=
X-Received: by 2002:a17:907:70c:b0:ab2:e7c0:6561 with SMTP id
 a640c23a62f3a-ab2e7c076c7mr401455566b.22.1736606452879; Sat, 11 Jan 2025
 06:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>
 <202501081331.E4B6DF747@keescook> <CAMZ6RqJS5FwuBUdvVdXoZj6wZOJz8Nao4FzSzCK1VtbNF41sMw@mail.gmail.com>
In-Reply-To: <CAMZ6RqJS5FwuBUdvVdXoZj6wZOJz8Nao4FzSzCK1VtbNF41sMw@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sat, 11 Jan 2025 23:40:41 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJbinVpsGf6ADUtQTYPRRQN=D8Ne_n6pHtDUPXxED5ZvQ@mail.gmail.com>
X-Gm-Features: AbW1kvb4zdGjZYAy4UF-AWwj-igw1bOTlLKn6fbLiVDPF6WP_Sm6v2Df_P1KUsw
Message-ID: <CAMZ6RqJbinVpsGf6ADUtQTYPRRQN=D8Ne_n6pHtDUPXxED5ZvQ@mail.gmail.com>
Subject: Re: [PATCH] fortify: turn strlen() into an inline function using __builtin_constant_p()
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	David Laight <david.laight@aculab.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 9 Jan 2025 at 16:52, Vincent Mailhol <mailhol.vincent@wanadoo.fr> w=
rote:
(...)
> > >   * possible for strlen() to be used on compile-time strings for use =
in
> > >   * static initializers (i.e. as a constant expression).
> >
> > ^^ This comment, however, is I think what sinks this patch. Please see
> > commit 67ebc3ab4462 ("fortify: Make sure strlen() may still be used as =
a
> > constant expression") which required that strlen() not be an inline. I'=
m
> > pretty sure the build will start failing again (though perhaps only on
> > older GCC versions).
>
> Strange. I tested it with GCC 5.1 on godbolt and it worked fine. After
> more investigation, I only got complains from GCC up to 4.9.4:
>
>   https://godbolt.org/z/rW8r74vE3
>
> I also just did a successful defconfig build using GCC 5.4 (sorry, I
> do not have an environment with GCC 5.1).
>
> So, it looks like an issue of the past to me. But in 67ebc3ab4462, the
> minimum compiler version was already 5.1:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/min-tool-version.sh?id=3D67ebc3ab4462#n20
>
> In the end, I am not sure what was the issue you encountered at that time=
.
>
> Well, I am not able to reproduce, but if you tell me this is an issue,
> then I can just keep the s/__is_constexpr/__builtin_constant_p/g
> change in v2 and drop the inline function part (thus keeping the
> triple expansion).
>
> Let me know if you still think that having it as a function is a no
> go. In the end, the main purpose here is to get rid of the
> __is_constexpr. Turning the macro into a function still looks slightly
> better to me, but at the end I do not really mind.

Actually, I did more investigation and it is working for some strange
reasons. Whenever the argument of a function named strlen() is a
compile time constant, the compiler (both GCC and clang) will replace
it with the string length on the argument, even if strlen() is
programmed to return something else:

  https://godbolt.org/z/nK4b3fnM7

So it is only working because the compiler uses its builtin strlen()
instead of the function we provided.

Actually, we could just do:

  extern inline size_t strlen(const char *p)
  {
          return __fortify_strlen(p);
  }

and it would work: the compiler ignores the content whenever p is a
compile time constant =C2=AF\_(=E3=83=84)_/=C2=AF

Well, all this is really ugly. I will drop the inline function and
send a v2 just with the s/__is_constexpr/__builtin_constant_p/g
replacement.


Yours sincerely,
Vincent Mailhol
