Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59221C17D
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811743; cv=none; b=dnEy5mjgwtRm4k917MEfTJjOrxZRSEWY+P9kvzSX+jPAuLa6TJ9cClXDLmdOvsWnLJun6CB9LeRbbZAfZbHt4BFqmj3FpMbrDk60bLlnYY2eQlBuQPviEGFwavM+eOiuIcmNB/DrDmc89NMc9vTkDb9jTC6i9Lgs0GGD8B6RW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811743; c=relaxed/simple;
	bh=RUAJ5fYvCz+NxoGs/jxYtPLMp8G/D4pjz1NEnzm4L5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/EkBaieZ2hRfyQhqDyF40mWMIu0LF2Cc4p+sM0XHmFAfuPi05VCeq+Jo+qH5XG8btek1zn72H5AmaMGnegGEcvfrSJoxuGOQwub8U1MvAC6SuXFka0qIFkX0YkYXHaTbElKmh3/+1kZPTUtp7U5SaT11TBkdffWGsso78O7Ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQrUNBOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQrUNBOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB50CC4CEEB;
	Thu, 21 Aug 2025 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755811742;
	bh=RUAJ5fYvCz+NxoGs/jxYtPLMp8G/D4pjz1NEnzm4L5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQrUNBOK2Jtq4jMz2kl3cKJbPXa4XX+TXLX/381YYOk1HZ/AWfCqkOUKXPCbe+zvn
	 xcBQCGrED8V6q//94hdBYikITmsP4nKnYaOzsfUEc0ZD2B2Vvz1gWzjLyx3aNGA7GN
	 JgGaMlNubXm+bG7PUGNev3e1ntc3u1WL6diel7IzMeHzJZN5ICfSnUZoE0z/M9Wvx2
	 qgRwJI3j8KS1W2wbsPBBsGhaANkbepqPmVBw8C7HRh1Ew1GuyEkbq2LlGOKTW+gmQO
	 yG4c93E1LmSYD3PE3Knj8ZnVCfAbjpIISYaDrfZbjv/2fci2YcWRf8aib5ZU5ZLXFo
	 aBH/JV6a6Rgrw==
Date: Thu, 21 Aug 2025 14:29:02 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Message-ID: <202508211258.8DEE293@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>

On Thu, Aug 21, 2025 at 07:14:31PM +0000, Qing Zhao wrote:
> 
> 
> > On Aug 21, 2025, at 12:16, Kees Cook <kees@kernel.org> wrote:
> > 
> > 
> >>> +  else if (TREE_CODE (fntype_or_fndecl) == FUNCTION_DECL)
> >>> +    {
> >>> +      tree fndecl = fntype_or_fndecl;
> >>> +      tree base_fntype = TREE_TYPE (fndecl);
> >>> +
> >>> +      /* For FUNCTION_DECL, build a synthetic function type using
> >>> DECL_ARGUMENTS
> >>> +        if available to preserve typedef information.  */
> >>> 
> >> 
> >> Why do the building? Seems like you could just do that work here. Also
> >> doesn't FUNCTION_DECL's type have exactly what you need?
> > 
> > I need the function prototype in three places:
> > 
> > - address-taken extern functions
> > - function preambles
> > - indirect call sites
> > 
> 
> A little confused with the above:
> 
> From my understanding, 
> 
> 1. At each indirect call sites, we should generate the checking code to 
>      A. load the hashed precomputed typeid from the callee’s preamble 
>      B. compare it with the precomputed typeid for this call site
> 
>     So, we need the function prototype of  the indirect call site to compute the typeid for this call site.

Correct.

> 2. For every “address-taken” function, we should generate the function
>     preamble, in which the precomputed typeid for this function is stored. 
> 
>     So, we need the function prototype of  this function to compute the typeid for this function. 
> 
> The above 2 should cover all the KCFI ABIs. 

For non-static functions, we cannot know if other compilation units may
make indirect calls to a given function, so those functions must always
have their kcfi preamble added. For static functions, if they are
address-taken by the current compilation unit, then they must get a kcfi
preamble added.

> What I was confused is, why “address-taken external function” and “function preambles” are separated items? 
> For the function preambles, shall we generate for all the functions? Or only for address-taken functions in
> the compilation? 

The other case is emitting the __ckfi_typeid_FUNC weak symbols, which is
used for link-time resolution with non-C code (i.e. raw .S assembly)
which doesn't have access to the C type system to calculate the hashes
on its own, and needs to have a way to build its own kcfi preambles. This
is how Linux constructs its assembly function entry points:

#ifndef __CFI_TYPE
#define __CFI_TYPE(name)                                \
        .4byte __kcfi_typeid_##name
#endif

#define SYM_TYPED_ENTRY(name, linkage, align...)        \
        linkage(name) ASM_NL                            \
        align ASM_NL                                    \
        __CFI_TYPE(name) ASM_NL                         \
        name:

That way all the asm functions can be be indirect call targets without
knowing the hash value (which will be filled in at link time).

> > At indirect call sites (during the early GIMPLE pass), I had a
> > FUNCTION_TYPE available that still had the full typedef information,
> > and I could use it fine.
> 
> > For the other two, it's later on and the
> > TREE_TYPE(fndecl)'s FUNCTION_TYPE had lost the typedef information (which
> > I need to be able to examine in cases where the typedef name was needed
> > for the mangling vs looking at the underlying types).
> 
> Then why not also compute the typeid for the function preamble during early GIMPLE phase 
> the same as the indirect call sites when all the typedef information is available? 

I assume I just didn't see how yet. :) I wasn't able to identify nor
store the typeid for function definitions that ultimately end up getting
.s file output. For example, down in ix86_asm_output_function_label(),
I have the decl (but it's way late):

ix86_asm_output_function_label (FILE *out_file, const char *fname,
                                tree decl)

I couldn't figure out how to find these during the GIMPLE pass. Oh,
perhaps I can do this with an IPA pass? That should let me walk all
functions including externs. I'll give it a try...

-- 
Kees Cook
