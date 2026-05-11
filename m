Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB873A8756
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532065; cv=none; b=YB7vfHHegsoyvZNJd8SVxoIXT/WQ1SClLyz6mr8w9Q0zblV12Tvtr072l0+0gepOt0m/ILBMBUzEvtAfVs1BQ+eJoK7ayPmwsnQtTTaNmLr69MDegbpczdkrnQRoeDxj87JeQBTJP++irS4+Jry2+G5JKqWUY8B541CKyazolps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532065; c=relaxed/simple;
	bh=u1V8iehSXepv4Y+johTcqyCQLf3jLPWNgISabYhtCfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6DwYZ5Yso/CJJLLizjxIhIHZwQN9H+jWi8eBG67iPkFXryRMJ6bk2tese6JVgg7+9pbsdLMI83oLtu5jmRXcCdOYkR1SOif5/uBbZuU/GOqbhthcpAlFXO0FdRINn5/Uz6JWlOg9Ca9ekkwT89MQaohVCSpC0vozQia6Oymn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPttTshJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPttTshJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DE0C2BCC9;
	Mon, 11 May 2026 20:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778532064;
	bh=u1V8iehSXepv4Y+johTcqyCQLf3jLPWNgISabYhtCfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPttTshJlZQtskc1ZkhMasTB1U5SEwQMIB44tuD+RXxaGWHXyy/qCNn3D+oH1+wX4
	 IAlIVGmCvCeAVBnFG3ufwyI3NLkztXhzoLdP2+akhxEsLDnMQ/XmPLErzgLTd/Frtx
	 8c2qO5qqmFdGYY6SFtipqziPjOlU+CQXnEIY1VyirpQ8lnu4ADuXCWjPCfx9qnCzzK
	 NVGI7IK1oue8BxOTjod8uV1VKmjJC0LcxLXNf/sXa/fj2rn4SFEDYRm5BUl3JsyELR
	 zi8ehNqS6QsgWR0NYekgwFSqx24rhB5ZUrJmqtXcZY+31Kvvuqlldgc4Wyj6dAmAxw
	 oNFtWCbB/EHSg==
Date: Mon, 11 May 2026 13:41:04 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Uros Bizjak <ubizjak@gmail.com>, Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v11 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202605111337.62C81472F5@keescook>
References: <20260511194847.faster.180-kees@kernel.org>
 <20260511194902.701280-1-kees@kernel.org>
 <62bf9b04fa4eaac6912a0ffd1c4a5114afb5df7d.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bf9b04fa4eaac6912a0ffd1c4a5114afb5df7d.camel@tugraz.at>

On Mon, May 11, 2026 at 10:08:06PM +0200, Martin Uecker wrote:
> Am Montag, dem 11.05.2026 um 12:48 -0700 schrieb Kees Cook:
> > To support the KCFI typeid and future type-based allocators, which need
> > to convert unique types into unique 32-bit values, add a mangling system
> > based on the Itanium C++ mangling ABI, adapted for C types. Introduce
> > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
> > testing and debugging (to see the human-readable mangling form). Add
> > tests for typeinfo validation and error handling.
> > 
> > This ABI needs to match what is used by LLVM Rust (which matches the Clang
> > ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel builds.
> > Instead of inventing a new ABI, all use the existing Itanium C++ mangling
> > which matches KCFI's needs.
> > 
> > An important aspect of the C++ typeinfo behavior that is retained here
> > is that typedefs are treated as pass-through except when the underlying
> > type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
> > distinction between those typedefs and typedefs used to provide _aliases_
> > (u8, uint16_t).
> > 
> > In the future, an additional "strict mode" builtin helper pair could
> > also be added to follow strict ISO C type equivalency instead of the
> > existing typeinfo used here, but that is out of scope for this patch.
> 
> Note that ISO C would require *less* strict rules, so the current
> mangling would reject compliant code.
> 
> These ABI issues were recently discussed also on the rust side.
> 
> I now worry that it might actually be a mistake to enshrine
> the wrong rules into the ABI, creating language interoperability
> issues which might then plague us for years.

Well, this matches what we've already created (and have been using for
years) on the Clang side. I'm happy to rename this to whatever you want
to avoid confusion, but I don't really want to change the rules of this
ABI. I'd rather get it working as-is, and then if we want to make
mangling changes, do that simultaneously between GCC and Clang.

And this is totally do-able, e.g. I've already created the transition
path on the Clang side for changing the hashing algo. For KCFI, we don't
need to worry about cross-ABI-version compatibility: the kernel is built
as one binary, effectively. We just need to worry about GCC/Clang
compatibilities given the Rust side of things.

-Kees

-- 
Kees Cook
