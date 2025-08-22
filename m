Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1927AC2A
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852428; cv=none; b=l6SxW/mJjKvz82s8LLhsC50AhteExdgXZuf2a/dmseJHi6ldDuavNXLQ4tWasYIFSDi3iQRiw4acgPZSt0BfzjXjTHjha22vcsrZNkNPnn5VfWI5xCxFZ26qmJStyYB9NFBfxegdGHqo1eUvDrJ19iu4HGK11uxvoDYjuGVXq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852428; c=relaxed/simple;
	bh=Ojlq3DElZ5BsJCyagHfjW8YN6s5fJrnY+4DhieFaKGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgwUlJDjtUibjJlG0VZaZM8UquXEk06um1gCUV6glS4IcKDXHQMCoOFRFEAR9eU3UXPk0XcArGMRP06bMctr0j1CYOLRZ/TSc+d7AT6fqEIobEQkktPnVBzPi95xcmzkVlVqMVEaLtANSq4Z53Hz3eMQgipfxj48DuA1SDJTXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh1iQ3Bc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh1iQ3Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4191AC4CEF1;
	Fri, 22 Aug 2025 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755852428;
	bh=Ojlq3DElZ5BsJCyagHfjW8YN6s5fJrnY+4DhieFaKGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dh1iQ3Bchvd8CGxBNVw1YaVkdNbgnS1MQXuDuGXpabCpTsbu16D420E1Yb8VxQXv5
	 KhVzz+ODMaRZUrGo3USPk/8NPKxP7wZnVib+nNatrRAIx0MjVBorqs1B+NKmRr369U
	 5Uro/0APCv64uOB7EHTJa0EXIZBf21xOD1M+V/2xreof64P6ZdOC9Ix0jGwTcLa9jV
	 w/JjH5XRznqIajUaqz5Cjkl1chXFyBoQElcGSq5JFh88IQxTGv1UeJkCyqqpK33fyN
	 /YGUb1+euzjM9i5L7LuOoGzmJ7XLYKFZ/qx+0CeAqKWu+xUD1fskKQBN4FWyHLJ95z
	 Wzfv7uzklqQxw==
Date: Fri, 22 Aug 2025 01:47:07 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Pinski <pinskia@gmail.com>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Qing Zhao <qing.zhao@oracle.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
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
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202508220139.49831A70FF@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <CA+=Sn1koTTQaXDnAVWtVU6ACWwhD08NR5nDJO236Pmcoi2X9qA@mail.gmail.com>
 <20250822075115.GE3419281@noisy.programming.kicks-ass.net>
 <20250822082420.GB1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822082420.GB1386988@noisy.programming.kicks-ass.net>

On Fri, Aug 22, 2025 at 10:24:20AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 22, 2025 at 09:51:15AM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 21, 2025 at 02:22:30AM -0700, Andrew Pinski wrote:
> > > On Thu, Aug 21, 2025, 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> > > >
> > > > > > +/* Compute KCFI type ID for a function declaration or function type
> > > > > > (internal) */
> > > > > > +static uint32_t
> > > > > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > > > > +{
> > > > > > +  if (!fntype_or_fndecl)
> > > > > > +    return 0;
> > > > > > +
> > > > > > +  const char *canonical_name = mangle_function_type
> > > > (fntype_or_fndecl);
> > > > > > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> > > > > >
> > > > >
> > > > > Now I am curious why this needs to be a mangled function name? Since the
> > > > > function in C the symbol is just its name.
> > > > > Is there documentation that says the hash needs to be based on all of the
> > > > > function arguments types?
> > > >
> > > > The whole point of kCFI is to limit the targets of indirect calls to
> > > > functions of the same signature. The actual function name is immaterial.
> > > >
> > > 
> > > 
> > > So then just hash the function argument types. It only needs to be
> > > consistent for the objects that are compiled together right?
> > 
> > Function argument and return; but yes that could be done. Ideally the
> > kCFI implementation would be compatible between compilers. Specifically
> > rust is based on llvm and therefore generates kCFI that is compatible
> > with clang. Being able to mix GCC and rust code (as the kernel does)
> > would be nice.
> 
> FWIW, Kees, for this to actually work, we need this
> CFI_ICALL_NORMALIZE_INTEGERS thing supported. Rust gets really upset
> about LP64's whole 'long' vs 'long long' trainwreck :/
> 
> That is the -fsanitize-cfi-icall-experimental-normalize-integers
> argument for clang (omg so long).

Yup! I forgot to include my "TODO" list in the RFC. It is:

 * -fsanitize-cfi-icall-experimental-normalize-integers (but this option
   needs a better name if it's going to be supported in GCC too for Rust
   compat)

 * -fsanitize-kcfi-arity
   https://clang.llvm.org/docs/ControlFlowIntegrity.html#fsanitize-kcfi-arity

 * cfi_salt function attribute
   https://clang.llvm.org/docs/AttributeReference.html#cfi-salt
   https://github.com/llvm/llvm-project/commit/aa4805a09052c1b6298718eeb6d30c33dd0d695f

-Kees

-- 
Kees Cook
