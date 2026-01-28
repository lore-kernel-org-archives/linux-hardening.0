Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824E284689
	for <linux-hardening@vger.kernel.org>; Wed, 28 Jan 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594083; cv=none; b=A8XehL1ZdOGLlnPrsHM9jMJnO2fwyOis918Pw20Wmj/cGlqfJOEcQ+Kc0lqklUNd7WbdcjS1HB/AaEF0y8WLTAP77N+fyos2x/FTwRs7oWI6wM24wpGOaWxaBuhJDVVV/OidEJezY8bTDnzn5mZXsHDBowqbSs3yuYjWCRyzZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594083; c=relaxed/simple;
	bh=yXZG8aeeXL06jpgbg8z3YqJbzBCtCJEAETvokSs0sMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT1MMjEOMqHFQ6P3DcjP0UoY6TCOiqhmTW/yPJ6iPotHqaHRJJp+gkoqkB8N85IKpw0zdxMNj2oPR+IC1RYYA76uNdL/cqoHyz9freBw27t0ZpnIcwQciqwFfomfgWMixiMy75JiSIdNfb6Q2F77ALLQdWQsViC7sA/AgsgkAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gX2C6Wal; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gX2C6Wal"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4359108fd24so3962906f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jan 2026 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1769594080; x=1770198880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJuxFAZp03kC7l/ZjQTx79mwznxD1l402NB4nY0zgkw=;
        b=gX2C6WalNDDhi4qC7bRIMmXLNEQs1phZI3CFHiNpi6aApcc1aTvk2zB/MWwkEw00jN
         YFQ0xReJrLbqMXmAIUHkjXqABznX0cien5stkEjrNfIHxVBmPsn4jSxe3ItDXkAQneEj
         B7sbt3Fjm3xA5p/27EMQcMZ3jGY8SDG55Ynq74O0fMcn+3pnH+kNmKHxxt0uXz5VCzG9
         Iw3Ko3EKr7p5gHsGKlS/GCTYaabCHU3Y0dQxCzYOFHwgOMs1bLo2gt+D94GievzgiaEo
         8e+7Vq2BH2pySvFLLMDERcCDlKaDjkbzsuICKZINLjCQY0jmWKpw+IJkfQLaDcj248tg
         TOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594080; x=1770198880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJuxFAZp03kC7l/ZjQTx79mwznxD1l402NB4nY0zgkw=;
        b=TDVtB6c6u3h2oM9tmr7A5/SUuriUsdf/I1ROVKGv3YbmlAHy+zbAJvwpPoEv6L4S16
         /a67w9dkqs12FPG86ErIa4zpJsjNZdup9nhsmnOtOY9BhJ9yIgeBSwIIiCnSSsQB3ZEk
         7So5vuaHuNjjZ1at4jj8EX84EY37ujLLxj4tUf6gkEvYWqzaM1D5Cwir5TEq4q0fjivZ
         rg4H0CCyMJHpgT23SI/4bou0Hz9RYIZlOo8QrBeavTgiEoX0MdbEV/Uc4joq9ufxj7IO
         7HS5z6TYM+oOTM94YnlnUxeHOuFcnIbmb5XYiIjSsMTZLm2VuFcpH/sHeNuUPbS0SLi0
         mJDg==
X-Forwarded-Encrypted: i=1; AJvYcCVzbYgmRoRqtwb9L+dC2JnGXbE9ihZtnuMN91gw00HGIMmO3Qf7ZujQNPqXEENdwf3Hy+N8oPS+r8gdPa7BG60=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzdg4paIvpDkVbNOItsty/jo/IkgoPBWUzArYZG14ZW2gtyJRd
	yp481uwAIpw9gxKwoIiJ1FcLHtb2oRHhG1b2pjG8sH1WSU6Rnsoz9iR4eoro1WE4gTo=
X-Gm-Gg: AZuq6aIeIMTOoirynbnkP9+o6L1l88BdGfbyyGExZNVbI4CDNTvEnOKJ7HanA/r1xy/
	QYeycFz2YqXC32t7KldmmU66u1EXLeaMFJTbZQQ2KW3Ugjt9P2bz5BJDf9UkWjsn6P9gDaaFmjx
	7K7DClXzTYYgWkfYbkCKgG1HrGTLGyhpSsPDQ1ykDQkHGvRTIexnMrMTSIdPyG3Qe1WHxUP1pWu
	GP0SNluyrLd26Gbnb569g2naRWGqxz9VABM1osKpSUUsJSbZvWPVITan9yQPbagOtMIlk4wVGze
	8huo5qr0OoRxy3tdZYXYW7C5Jso+ykBlVkTuPQC94z9wPqO6rR7tZkgFy7dAwcZk8UNjL/1EKIv
	fsYjTuxYF8RLOnpZbcdHi7psjWd5yD5fALaQ68oWlbIDu47RecyJp+vmARCh3t+c0j89jxMPeTa
	44uspGSFhalw0ZS7hE/ehQG14smm2Jm3toNLMDKSeYwlWB89mfIT1H2lmQu7BwOzVv9b8rnmiaU
	RmMbnnlXxrx0+gOrJPuO6rWcW6t28/MMmf41YQdIEzrm02f8M602b+oWE6KTmnofpdlxewT23tn
	IKR/vxA=
X-Received: by 2002:a05:600c:450b:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-48069c0fc10mr49957815e9.11.1769594080207;
        Wed, 28 Jan 2026 01:54:40 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d9b1116sm5036405e9.7.2026.01.28.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:54:39 -0800 (PST)
Date: Wed, 28 Jan 2026 09:54:37 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Martin Uecker <uecker@tugraz.at>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Alex Celeste <alexg.nvfp@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Aaron Ballman <aaron@aaronballman.com>,
	Douglas McIlroy <douglas.mcilroy@dartmouth.edu>,
	Bruno Haible <bruno@clisp.org>, Paul Eggert <eggert@cs.ucla.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Daniel Lundin <daniel.lundin.mail@gmail.com>,
	"Valentin V. Bartenev" <vbartenev@gmail.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	"Brian W. Kernighan" <bwk@cs.princeton.edu>,
	"G. Branden Robinson" <branden@debian.org>,
	"Basil L. Contovounesios" <basil@contovou.net>,
	"Jason A. Donenfeld" <jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	onf <onf@disroot.org>, Rich Felker <dalias@libc.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC v3 3/6] alx-0078r2 - [static n] shouldn't access more than
 n elements
Message-ID: <aXnc3aeRq045FWZy@aspen.lan>
References: <aXdhh1r7ePA5SrIE@devuan>
 <aXdirEZVgj8PKPxM@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdirEZVgj8PKPxM@devuan>

On Mon, Jan 26, 2026 at 01:48:49PM +0100, Alejandro Colomar wrote:
> Name
> 	alx-0078r2 - [static n] shouldn't access more than n elements
>
> Principles
> 	-  Uphold the character of the language.
> 	-  Codify existing practice to address evident deficiencies.
> 	-  Enable secure programming.
>
> 	And from previous charters:
>
> 	C23:
> 	-  APIs should be self-documenting when possible.
>
> Category
> 	Language; array parameters.
>
> Authors
> 	Alejandro Colomar <alx@kernel.org>
> 	Martin Uecker <uecker@tugraz.at>
>
> 	Acked-by: Doug McIlroy
> 	Acked-by: Andrew Clayton <ac@sigsegv.uk>
>
> History
> 	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0078.git/>
>
> 	r0 (2026-01-25):
> 	-  Initial draft.
>
> 	r1 (2026-01-25):
> 	-  wfix.
> 	-  Co-authored by Martin.
>
> 	r2 (2026-01-26):
> 	-  Acked-by.
> 	-  tfix
>
> Abstract
> 	The following function prototype requires an input with at least
> 	2 elements:
>
> 		void f(int a[static 2]);
>
> 	It should not use more than 2 elements, as those are not
> 	guaranteed to be available.  That is, the following function
> 	definition should be unacceptable:
>
> 		void f(int a[static 2])
> 		{
> 			a[7] = 0;
> 		}
>
> Discussion
> 	It is a de-facto standard that functions declaring a [static n]
> 	parameter require at least n elements, and don't access more
> 	than n elements.  Most programmers that don't know the fine
> 	letter of the standard would assume that.  This has its roots in
> 	the older syntax, [n], which is not acknowledged by the
> 	standard, but has been historically used to document this as
> 	part of the API.
>
> 	Without this, [static n] is only useful for optimizations, but
> 	not for writing safe code, as the specification of [static n]
> 	doesn't provide the compiler with enough information to know
> 	whether array bounds will be violated.  This makes it a terrible
> 	UB foot-gun.
>
> 	Let's change the specification to make it safe.

I don't see how the proposed wording change makes C safer, see below.


>     <snip>
>     6.7.7.4  Function declarators
> 	@@ Semantics, p7
> 	 A declaration of a parameter as "array of type"
> 	 shall be adjusted to "qualified pointer to type",
> 	 where the type qualifiers (if any)
> 	 are those specified
> 	 within the [ and ]
> 	 of the array type derivation.
> 	 If the keyword static also appears
> 	 within the [ and ]
> 	 of the array type derivation,
> 	 then for each call to the function,
> 	 the value of the corresponding actual argument
> 	 shall provide access to
> 	 the first element of an array
> 	 with at least as many elements
> 	-as specified by the size expression.
> 	+as specified by the array length expression,
> 	+and the function definition
> 	+shall not access an element
> 	+beyond the specified number of elements.

By limiting what the function definition may do, we are reducing the set
of valid programs. Won't that *increase* the level of undefined
behaviour in the language?

That will allow compilers to perform more aggressive local optimizations
(which is probably good) but I don't see how it will make things safer.
To make things safe would mean compilers changing their diagnostics, and
the prior art suggests compilers already warn on this.


Daniel.
