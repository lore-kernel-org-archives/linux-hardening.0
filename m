Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7EC2D0625
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662353; cv=none; b=fXDETk/WCHlcUakF+Ev76Zws49DLvvr2WQUK8ku2wTQknj836rnaaWcewT51CEMYpfCS/iVkS9Pm6WuGIecI6NkRNY0Ea2hJEY+vCur/tHWr5T34fXM/aevek1gvDuwjK8hK/TxP67wjgHw+ZQrHrRs2xUWDn5oI5+/YO2jbTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662353; c=relaxed/simple;
	bh=QhzJ2k5VTk18lpGhKiHeanmRclHznGzLsgFJ1qRpet8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPwbAubZuT4xBsFUNl2w8FMk2qylJ/9Y19PDEv/uZ6xfKQ2f0Mh/qNWHkaNpfXbZccwA/Nrq+JQUIVI66PtvH5La513qENAoFQ5zxXx4qVddjxKimUfPzRskX/iQmBMnr8wIqtc6jGwMUYRJVMLsLZB52eZ35GCyEuhzOAtHrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsuyVDCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsuyVDCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A09C4CEF7;
	Fri, 12 Sep 2025 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757662352;
	bh=QhzJ2k5VTk18lpGhKiHeanmRclHznGzLsgFJ1qRpet8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsuyVDCJNCJi5ULFIdT7VBtyEfBaJe60m5QBYU78b0U0yubF5U4m/dPXm8DGeL9ul
	 WUrdmFzksouHCQwQbyUFdcVM52E7b8JKM6mOqf4kHK1ZbPV0aMuAcCHqRF115Y5k3O
	 kJOgeG93uPuYPa6D6xEIT4nr3SM8gpklSCnpj1FS8H0r01oaqFwDdSCytRipoB5wwC
	 HON01lEPcbfbbPGXWCyQdTwS2arIa0pA+LYuGq7RF2SqFDVVyaGgblIYunRcZmxw3X
	 hqzf/r1B7blVtsUD8b4sU4nPktTEcW44X8cgt+Iaho8FxhcwfRgeJ4enPTUt29HbvE
	 0p8HyrXcCwXVQ==
Date: Fri, 12 Sep 2025 00:32:32 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
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
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509112321.BFBE82ABBA@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
 <202509101705.92474D66@keescook>
 <A356F147-5B23-46F6-B05E-3BDDC81A768B@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A356F147-5B23-46F6-B05E-3BDDC81A768B@oracle.com>

On Thu, Sep 11, 2025 at 03:04:01PM +0000, Qing Zhao wrote:
> 
> 
> > On Sep 10, 2025, at 23:05, Kees Cook <kees@kernel.org> wrote:
> > 
> > On Tue, Sep 09, 2025 at 06:49:22PM +0000, Qing Zhao wrote:
> >> 
> >>> On Sep 4, 2025, at 20:24, Kees Cook <kees@kernel.org> wrote:
> >>> +For indirect call sites:
> >>> +
> >>> +- Keeping indirect calls from being merged (see above) by adding a
> >>> +  wrapping type so that equality was tested based on type-id.
> >> 
> >> I still think that the additional new created wrapping type and the new assignment stmt
> >> 
> >> wrapper_tmp = (wrapper_ptr_type) fn
> >> is not necessary.
> >> 
> >> All the information can be get from function type + type-id which is attached as an attribute
> >> to the original_function_type of “fn”. 
> >> Could you explain why the wrapper type and the new temporary, new assignment is 
> >> necessary?
> > 
> > I couldn't find a way to stop merging just using the attributes. I need
> > a way to directly associated indirect call sites with the typeid.
> > 
> When determining whether two callsites should be merged, is it feasible to adding the different type_id from the
> attributes into consideration? 

This is basically what was happening in the RFC, but I kept finding new
corner cases in various passes, so it felt like whack-a-mole. Using the
wrapper appeared to solve it across the board with no special casing.

> >> Why the type-id attached as the attribute is not enough?
> > 
> > Doing the wrapping avoided needing to update multiple optimization passes
> > to check for the attribute. And it still needed a way to distinguish
> > between direct and indirect calls, so I need to wrap only the indirect
> > calls, where as the typeid attribute is for all functions for all typeid
> > needs, like preamble generation, etc.
> 
> Okay, this sounds like a reasonable justification for these additional temporaries 
> and assignment stmts. 
> One more question, are these additional temporaries and assignment stmts are
> finally eliminated by later optimizations? Any runtime overhead due to them?

Yeah, they totally vanish as far as I've been able to determine.

> >>> +/* Check if a function needs KCFI preamble generation.
> >>> +   ALL functions get preambles when -fsanitize=kcfi is enabled, regardless
> >>> +   of no_sanitize("kcfi") attribute.  */
> >> 
> >> Why no_sanitize(“kcfi”) is not considered here?
> > 
> > no_sanitize(“kcfi”) is strictly about whether call-site checking
> > is performed within the function. It is not used to mark a function as
> > not being the target of a KCFI call.
> 
> Okay, is this documented somewhere? 

Ah, whoops, no. I have added a note to the "no_sanitize" function attribute
docs for v3.

> > What is the right tool for me to run to check for these kinds of code
> > style glitches? contrib/check_GNU_style.py doesn't report anything. Oh!
> > It takes _patches_ not _files_. The .sh version specifies "patch" in the
> > help usage. Okay, I will get this all passing cleanly.
> 
> Yeah, I usually use contrib/check_GNU_style.py to cleanup the code before
> submitting the patch.

Thanks!

> >>> +/* Wrap indirect calls with KCFI type for anti-merging.  */
> >>> +static unsigned int
> >>> +kcfi_instrument (void)
> >>> +{
> >>> +  /* Process current function for call instrumentation only.
> >>> +     Type ID setting is handled by the separate IPA pass.  */
> >>> +
> >>> +  basic_block bb;
> >>> +
> >>> +  FOR_EACH_BB_FN (bb, cfun)
> >>> +    {
> >>> +      gimple_stmt_iterator gsi;
> >>> +      for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
> >>> + {
> >>> +  gimple *stmt = gsi_stmt (gsi);
> >>> +
> >>> +  if (!is_gimple_call (stmt))
> >>> +    continue;
> >>> +
> >>> +  gcall *call_stmt = as_a <gcall *> (stmt);
> >>> +
> >>> +  // Skip internal calls - we only instrument indirect calls
> >>> +  if (gimple_call_internal_p (call_stmt))
> >>> +    continue;
> >>> +
> >>> +  tree fndecl = gimple_call_fndecl (call_stmt);
> >>> +
> >>> +  // Only process indirect calls (no fndecl)
> >>> +  if (fndecl)
> >>> +    continue;
> >>> +
> >>> +  tree fn = gimple_call_fn (call_stmt);
> >>> +  if (!is_kcfi_indirect_call (fn))
> >>> +    continue;
> >>> +
> >>> +  // Get the function type to compute KCFI type ID
> >>> +  tree fn_type = gimple_call_fntype (call_stmt);
> >>> +  gcc_assert (fn_type);
> >>> +  if (TREE_CODE (fn_type) != FUNCTION_TYPE)
> >>> +    continue;
> >>> +
> >>> +  uint32_t type_id = compute_kcfi_type_id (fn_type);
> >>> +
> >>> +  // Create KCFI wrapper type for this call
> >>> +  tree wrapper_type = create_kcfi_wrapper_type (fn_type, type_id);
> >> Again, the new “type_id” has been attached as an attribute of “fn_type” here,
> > 
> > The attribute is attached during IPA. This is run before that, but as I
> > mentioned, this is the call-site handling, and the IPA pass is for
> > globally associating a type-id to the function for all other uses
> > (preambles, weak symbols, etc).
> During IPA, the typeid is attached to the function type through “set_function_kcfi_type_id” for
> each function in the callgraph. 
> 
> For each indirect callsite in the above, the routine “create_kcfi_wrapper_type” also attaches
> the typeid to the original_fn_type, and at the same time, create a new wrapper_type with a type_name
> embedding the typeid. 
> 
> So, I feel the type_id information is carried redundantly here. 

Ah! Yes, sorry, I see what you mean: the tail portion of
create_kcfi_wrapper_type! Yeah, this is kind of a oversight from
switching to the IPA pass. I was attaching the typeid to DECLs in IPA
and TYPEs in GIMPLE (create_kcfi_wrapper_type). The DECLs were used for
preambles, and the TYPEs were used for RTL expansion. I will attempt to
merge these; they should all be on the TYPE.

> > I'm open to whatever alternative is needed here. I tried to capture the
> > merging issue with gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
> 
> Might need to study a little bit here to see whether better solution is possible without
> These additional temporizes and stmts.

Thanks!

-- 
Kees Cook
