Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF13DC4BC;
	Mon,  5 Oct 2026 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235550; cv=none; b=KCVGLpqt5+O+kRMqLvULEsHK2Z5qC46ji5tfmTmT/HjyN9upDyiw3pfRHCelFR+W2Iar/xc6UwaZ9qy4cu9jm+ZDwVRgjYWCdlzWpPFHMh7NYxmLpmT3S7gyEvi4uC/F98ecTQyWDGRe8T3DjHqVWqANOdNleOHwV6qmk7xoK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235550; c=relaxed/simple;
	bh=oWoI7KU51zem5IclY14yT1yhw3LIz47deEPyi4Qi3cE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YJKbJOonLYdrNPz3Egayk5lMtRgs6qKhg2YS6Xw/O1EVMKkusCdZ1qaDlWNlLw4wvJN08JYoRIGrXWkI1JEMc/Xvpr3b1bzr3V0RGT1/ytB+R1CRp93HH9XpO+jxtYipgJ64ENhAvHlQB8zYOhJFQd/FH5ShMjtnJ7qJEyVx20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTyoFfQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTyoFfQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EED1F00893;
	Mon,  5 Oct 2026 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235549;
	bh=NVtCSF04+5hQftrDStv64+G8kBj0wfQzjaUvoe2fK1M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CTyoFfQMxyRDu8dCRnxTUJFOMYpC/a1QO3xq/5eVia+1aL2iHETv7cMP1XKR8g4/H
	 Z4wccSaPxEcAJe50sBlpO5v4HW41usqLzGov0Q0NgJ97RurCKMZ4Nb3CM0zOZc885R
	 Y910QwMtvj2CjHOv79IDntEKLj6s5D+r5okw0OLFbrExd6AJHdcnR2+bLn69uXJyv+
	 EDIK5A8LXdW0PWAZ+kTRwoc+ArD4Tnwx7aiNqnXWD9DjR3EEyuziKxAMFmJyot61gC
	 Sl0mKQpfw7DV7O1Bw0cqSqBn16I0dSRco8xjftzUADN6BEfvSOT9cPrA/ncq9/dyQC
	 +b18/ZEMed0uw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id ABC7E198003A;
	Mon,  5 Oct 2026 17:25:46 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 05 Oct 2026 17:25:46 -0400
X-ME-Sender: <xms:2BXEak90g0Y2gyHWeyFmRp1Df0-iIO2rP0B5FXQ6CalaZu5ot50A4g>
    <xme:2BXEanhT2rbLSIDCEIqmIcgC2Z85mXieEz_KNcWf1hfeeJSzun8YeqKsOYdzlMPzB
    tvt37kmd8Wbvv5ZydmCxS-IsPwhWwc7wGx4a061bdHjmkuFeJDXo5GC>
X-ME-Proxy-Cause: dmFkZTFYRYK7kCIdTUdiTrNjDf+K1m4N+n/n7BpfpOY/qFXuim304FuhNPbM9hfWJR3s0y
    v7AZ+ywbG3UH2scS8AH+M0BvWEO5jr4Fq05tizrbLM206uLlpSKcHFjjh6Fol5a/Ad6k8A
    BvytjI72RlVdjPc0h+tOvENrJQKR+WzEKigCkg6koAtBAYI/6hWKZEU2rKwuy61o0JJFw8
    UN4T1G4Br4BvSr/S9EFpiAEabmc2rBSxBQUVnLjKrkph5KD6elP72eWsOJYASh0X0yOy4Y
    GII4gzUasYApQH6tS+I+R7qhwuWHoR/H5yWA4eAlQ/yEiYkUXstYyRbFXrNkltmlXbFDMW
    5Ez36r3DmZSv5Q+HDXOYsTL58jV9fT5ESYmINJOe2bKjIVLB8UZtR38KxwKPYgfPEFtl0+
    G9oqZkSXRPMC4qr20RGDOfT75ZW4+GPU2Vvln9eHIXL0CoYJVACxPWTrgIn1+SEpjOOyYp
    lCJGib/AF3mO8vAroxWagcrjq7mhxPYgBDIXb5v5fIPLj6hhpVzDvFin8n4EsGU9TFrqhz
    ZTyPEG3969fLxIigtZNEFzMMc00Bo7md6mzEUXS3naL7D0xYhfTGavM1KMtdlqNDV0vRNw
    Au7p0PGH606Tk4qgNRthbFB9olSr9F3B/yMbGE9PqrvpCOPuX5zESzWN6eug
X-ME-Proxy: <xmx:2hXEavu9ic04Ng2petmdVSC2GvXWSAT1WuVpBybw4ByZTGYjCzVAvw>
    <xmx:2hXEaq167pjSLZPl8reQhiwYFT-EOf6KjkRpencLhiCemRBD_W0MuQ>
    <xmx:2hXEao5JBCoWivkhw0Rio8XM8uNmWEENEIKO1WvINu-fdfYuEIeYMA>
    <xmx:2hXEapUJOMxK2BtDYT4M9rj9Ikld3WQ3qXKdeHa9uEdmWecBL5tPbA>
    <xmx:2hXEaoj3_uvdGJs_VK2sqb79Q6Jfj-hJbMYJJRtA-AYdINwrsQ6aPTxX>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0506DF80093; Mon,  5 Oct 2026 17:25:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 23:25:22 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Bill Wendling" <morbo@google.com>, "Kees Cook" <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Mark Brown" <broonie@kernel.org>,
 "Marco Elver" <elver@google.com>, alan.maguire@oracle.com,
 namjain@linux.microsoft.com, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <3176a197-baf8-4e5f-96a0-8c79d32a168c@app.fastmail.com>
In-Reply-To: <20261005192052.2589382-1-morbo@google.com>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261005192052.2589382-1-morbo@google.com>
Subject: Re: [PATCH v3] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, 5 Oct 2026, at 21:20, Bill Wendling wrote:
> Code that runs outside the kernel proper, such as the EFI stub, gets
> nothing out of the counted_by annotations: the bounds checks they feed
> (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
>
> The annotations can also break the build. A __counted_by_ptr() that
> names a member declared after the pointer needs Clang's
> '-fexperimental-late-parse-attributes', which the top-level Makefile
> adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
> not get that flag, so it fails as soon as such a struct is pulled in
> through a common header.
>
> Overriding the __counted_by_ptr macro from a Makefile doesn't work:
> 'compiler_types.h' is pulled in with '-include', which is processed
> after all -D/-U options, so it re-establishes the definitions. Follow
> the '__NO_FORTIFY' precedent instead: let a build define
> '__NO_COUNTED_BY_PTR' to turn the corresponding annotation into a no-op.
>
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we need it.
> v3: Add the version to the Subject line.
> ---
>  include/linux/compiler_types.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h 
> b/include/linux/compiler_types.h
> index c5921f139007..8bde6798b4ec 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -387,8 +387,13 @@ struct ftrace_likely_data {
>   *
>   *   gcc: 
> https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
>   * clang: 
> https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-by-or-null-sized-by-sized-by-or-null
> + *
> + * Code that runs outside the kernel proper (e.g. the EFI stub) can 
> define
> + * __NO_COUNTED_BY_PTR to drop the annotation. Such code may also lack 
> the flag
> + * Clang needs to parse a reference to a later-declared member
> + * (-fexperimental-late-parse-attributes).
>   */
> -#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> +#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) && 
> !defined(__NO_COUNTED_BY_PTR)
>  #define 
> __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
>  #else
>  #define __counted_by_ptr(member)

Apologies, I may have been unclear.

What I would like to see here is something like

#ifndef __NO_COUNTED_BY
#define __counted_by(member)  __attribute__((....))
#define __counted_by_ptr(member)  __attribute__((....))
#else
#define __counted_by(member)
#define __counted_by_ptr(member)
#endif
