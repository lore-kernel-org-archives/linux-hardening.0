Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBD1DED70;
	Fri,  7 Feb 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933991; cv=none; b=HDqlMOy3+yLCk2dhgN4i8qlIYWHS0GvuQsYRNzjN2+daIw4Md5TzUA3MhGtU1Nce/5bQq3vrlGwbqgWaRc9zX77JtS/DVwHbaFRRKx7Gj1jGLkg/UsQPq7NW5WLUhDvjueCUHDon1+SfqJZpU+K06wzozXz6Z7HGcny+URnJVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933991; c=relaxed/simple;
	bh=aZ19R1SS1Qu6WngnQMEvJagwa5mZ8kHBwxwl1TDJjrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac+C7zfAjwa1Un5yOmeZEWsHTj4GWfX0XEe8QeXRitZoPjLBX91ABRECnWn6mSLnQNfhpmh95jxOj5jY4W0A6601ZbxW/03kdUVvp2bnhaP2p0tK2kx5s+eST3eMVi+GyynPyKAZ8oWXQ/rcx32+Eto/zDgvgIwnBAClXN/x5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVT7IJrI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVT7IJrI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so21933f8f.2;
        Fri, 07 Feb 2025 05:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738933987; x=1739538787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27KkUDNJw1RLFiIkfRRK6X+WdEXXvAVT3A6L55vHOpg=;
        b=mVT7IJrIunEyE3v6LQ+VVX9Ajc8QcBwyoFWbt4kPjTIR3ZXLlaULTaxetXq/oASgWh
         nQhckjc46mb3JHMo8006YVt7HaDaIXjAA5+irZKVcjqK1rg4XuJsKxbTlIj8+JE6rpN9
         56MRKcRynXj3QpAn2XFLmKD7Pc49IlMDCAzOYKLFEGQMSWLD7UpG+FH1Tr8nhkN4NNrt
         /fUjOOMlCe+QlouJxLZLlUFuPhIFq6ZwyiQ3lC+f5wsgfY3d7MtF74WwXKvQ4y2Be6Om
         LYCfpA4893+EAy8U5ZQ8z6vFZ9XCcE3GL7eMho/mOkrztIWzcgCNXJWTQbUkSKJsB2ai
         z94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738933987; x=1739538787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27KkUDNJw1RLFiIkfRRK6X+WdEXXvAVT3A6L55vHOpg=;
        b=WdSLHbU5WuNPn+TCX5rbKJD17l8kKvGH6OlwhMniKxAzP4/42wArWpxjfUezaHRh9C
         fo3k9YKyxZwRLsxF3XpmzcDJdiXJsUOF97l0N9Vn2pD1G2vjEozVf09VbTYmno6a5Xia
         LcHUNgH2aMRXh7uihAVYWqhcJZExVne1Fa7sL+sKKkBUV2Scj/dsCPSEOPbWGdQ/tlAC
         c3RSrdkuiMJuHPiGPnn/0RxNA9JE7nNesYjar1kKjHFNbsPPcZKDw5qD7jdMfRQQBT4d
         0HZ/aZGhAWCuGT1kWmD66kcqogtjNsVMIsCqNcVFT2FUBSMhJNTEZWLsWLPbr8hjiZEx
         oWbg==
X-Forwarded-Encrypted: i=1; AJvYcCUMWVst7sLyHccylqPOzzYmQPl46QJJiugxjs7KiTvNj5rs81ourS/E5mB9XdCoQ1oy05pEbhyvGbWjqm33@vger.kernel.org, AJvYcCWKhBf42UF1LZET/OmyW5dRIR2NtWRhJJad9zOMjfnUgrGWHTnyYEkAjOrhUc72nm7sxhPahSg/Tw7YmNHeWeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYrTh/G4sP/NHfTkI+R1DdZJvuJg7KaW60GmJhsnoeVM7ZOBy
	iyy6/avVU7pLr0irrAHs4EIpR5MMbRMknuAuVjAFAJYZhXRCl5hf
X-Gm-Gg: ASbGncuIczz8rd72YZZt+hP5vWF2C47IzMiB6YblQNnJUow5ruzqeR3rKLSe/e91V4v
	4lGkS3WlcB1P+TmOM8GAiYVMyMjnbJsrgFHC8gQFaFYkaAKFExZjugoD4aZLNCjtAYC2CZOyLAO
	Mz2drkAhjzNnspfT2laEbNSV1L+Z1IEybQYplVcitKaxQfDsS9mEmZHkusT+up+7o60Q3vGWCq/
	kx7Y8LRfFM0qMm7jmN6MpLTHRPf5kyHYJfv9Ta0c+QMAwlORz1h9dTZpwj+qcauLZRjFggnMDmh
	57NMf3//fh4X38Ts285K2tgEhLms3vdebsBY6DwhhC6GPhZxd9+cqA==
X-Google-Smtp-Source: AGHT+IHA8MZY98vQni86hWr8I/ooUhp299QFYV2Fy/D2NI8xPW8MtlegAc+P6NjTDdvd1Frmah7O1w==
X-Received: by 2002:a05:6000:18ac:b0:38c:5cd0:ecd5 with SMTP id ffacd0b85a97d-38dc9343fc9mr2203254f8f.38.1738933986355;
        Fri, 07 Feb 2025 05:13:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb55b7a5sm1615751f8f.14.2025.02.07.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:13:05 -0800 (PST)
Date: Fri, 7 Feb 2025 13:13:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Andy Shevchenko
 <andy@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Miguel Ojeda
 <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] compiler.h: Introduce __must_be_char_array()
Message-ID: <20250207131305.0fe9622d@pumpkin>
In-Reply-To: <87mseyrv6j.fsf@prevas.dk>
References: <20250206175216.work.225-kees@kernel.org>
	<20250206181133.3450635-2-kees@kernel.org>
	<87mseyrv6j.fsf@prevas.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Feb 2025 09:55:00 +0100
Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Thu, Feb 06 2025, Kees Cook <kees@kernel.org> wrote:
> 
> > In preparation for adding stricter type checking to the str/mem*()
> > helpers, provide a way to check that a variable is a character array
> > via __must_be_char_array().
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  include/linux/compiler.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 7af999a131cb..a577fe0b1f8a 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -221,7 +221,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  #endif /* __CHECKER__ */
> >  
> >  /* &a[0] degrades to a pointer: a different type from an array */
> > -#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
> > +#define __is_array(a)		(!__same_type((a), &(a)[0]))
> > +#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
> > +							"must be array")
> > +
> > +#define __is_char_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
> > +#define __must_be_char_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_char_array(a), \
> > +							"must be byte array")
> >  
> 
> It's probably unlikely to ever encounter an array of _Bool or array of
> structs-with-a-single-char-member in the wild, but it does seem a bit
> odd to base the test on sizeof(). Why not add a
> 
>   __is_character_type(t) (__same_type(t, char) ||
>                           __same_type(t, signed char) ||
>                           __same_type(t, unsigned char) )
> 
> helper and write the test using __is_character_type((a)[0])?
> 
> Or if you really mean that it must be an array of char, not any of the
> three "character types", simply replace the sizeof() by
> __same_type(a[0], char)

I'm not sure it matters enough to slow down the compilation by that much
cpp bloat.

	David


