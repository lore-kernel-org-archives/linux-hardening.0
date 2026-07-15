Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B42384CCA
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784158361; cv=none; b=Q+zfkCsRKSHQjDI/u4y1XfUoN5sdAgzoI46DVCkDMuEgZwJhnLt6Ja5i/geZgQzD05frIqed9Pn3mtJ1Kn34VtUvz9sebh8chyHCEg/zDyy0oJaHdjUb/deEbsFglNXxd/ZjivVzAEeLGlEPwp4ZCuwqbp7OvRDGUn5JQjJK+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784158361; c=relaxed/simple;
	bh=/JZBDCe1+WS2ki3o1/eS91m0OJOpQgyCSg6sckmKQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCDSoCln3iElZY9kIvvwYOWWbj4Sx95N4aI+K0lof6mMiQ4nhZXFQeMyJe8dPi0IH2ZdwqxyrqTYQSe463viLzXIXhWSLZJ6n/ffRM+AI0518GEFad0CoQU0yDEQGKtBnWI20rJ83D2JCLqqTxxixxQfS0Z10cgcTjD4Fdp/m88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Org58WaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Org58WaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCDF1F000E9;
	Wed, 15 Jul 2026 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784158360;
	bh=edYQ12MYTvZyyHJFpZZqYsEKdJxDYHRAc4MHPD5lci0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Org58WaYja31LUTkIDdPmHx+CHv1a9Yr1CBMaqZrN/KiKOJpGVIhat+BYldN+IZOA
	 F0UXF+a1g+JnDdR9mZzDy2Uk+J1tK9sH6a0JAUYWo8Uh7NSwpVPlResC+HXlytqW2z
	 RSTh0J9VgQ8TEcM15p0KJdUEYzPRcHKbVd0OQlz1w/D3HGfcxtkafysML7LdtL4q3D
	 tDFT7FqVK3koCPflUgaV070NFW8AyahQRqQ6YjZtwH3Wow5Nt60i16ObUGCQZgXIgZ
	 o41wAVoa5R2OlszHewQyOk6jKpT9FPFn6I4OlvUlDIjDCgNDnSzjVAlgKq+P6QtPti
	 5ocX9WLp/Vd+A==
Date: Wed, 15 Jul 2026 16:32:39 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
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
Subject: Re: [PATCH v13 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202607151619.201AF99A@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-2-kees@kernel.org>
 <CALvbMcDwYgJNo=qeZY1m+zAutURc7rfRCaW960DDjbRAOKUZ+w@mail.gmail.com>
 <202607151337.31D0828D0@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202607151337.31D0828D0@keescook>

On Wed, Jul 15, 2026 at 03:34:09PM -0700, Kees Cook wrote:
> On Sat, Jun 27, 2026 at 03:57:36PM -0700, Andrea Pinski wrote:
> > On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> > > [...]
> > > +/* KCFI label counter, incremented by KCFI insn emission.  */
> > > +static int kcfi_labelno = 0;
> > 
> > I am not 100% sure if this needs a GTY marker or not. I suspect no
> > because we should not have emitted assembly code yet.
> 
> If this moves with kcfi_next_labelno into final, I think it's okay
> without GTY?

This is an int, so GC shouldn't be an issue.

> > > +      type_id = (uint32_t) TREE_INT_CST_LOW (value);
> > > +    }
> > > +  else
> > > +    {
> > > +      type_id = compute_kcfi_type_id (fn_type);
> > > +
> > > +      tree type_id_tree = build_int_cst (unsigned_type_node, type_id);
> > > +      tree attr = build_tree_list (kcfi_type_id_attr, type_id_tree);
> > > +
> > > +      TYPE_ATTRIBUTES (fn_type) = chainon (TYPE_ATTRIBUTES (fn_type), attr);
> > > +    }
> > 
> > Instead of an attribute there must be a better way of doing this.
> > Maybe a hashset instead.
> 
> Perhaps? I will go examine this vs LTO, etc.

Tracking this with lifetime tied to the fndecl is going to be more pain
from what I can find. The attribute is stable and doesn't cause problems
for LTO: I've tested with 2 TUs, and this all appears to happen
post-merge? Anyway, if there is something I've missed here, I'm happy to
find a new solution, but I can't induce any problems so far.

> > > [...]
> > > +  /* Emit .type directive.  */
> > > +  ASM_OUTPUT_TYPE_DIRECTIVE (asm_file, cfi_symbol_name.c_str (), "function");
> > > +  ASM_OUTPUT_LABEL (asm_file, cfi_symbol_name.c_str ());
> > > +
> > > +  /* Emit any needed alignment padding NOPs using target's NOP template.  */
> > > +  for (int i = 0; i < kcfi_alignment_padding_nops; i++)
> > > +    output_asm_insn (kcfi_nop, NULL);
> > I think you need to calculate kcfi_nop each time you call this
> > function. Instead of caching it. For GC reasons.
> 
> Uh, do I have to? This seems wasteful: the nop is generated frequently.
> Should kcfi_nop gain GTY instead? I will take a closer look at this.

So, while I could go full GTY, I opted for xstrdup instead. I've
rearranged things here now, and indeed, LTO created some issues.
Upstream Linux doesn't have GCC LTO support (there are trees but no one
has been pushing for it), so I hadn't tested this area at all. I've
added some limited LTO testing now.

-Kees

-- 
Kees Cook
