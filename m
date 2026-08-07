Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA7407CC6
	for <linux-hardening@vger.kernel.org>; Fri,  7 Aug 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130880; cv=none; b=QBaRjqgCn5iAtdAfUGlULQK+7XZ+MbL97YinuM/kkWpzponpU7xZWi0pPIlCil3nS6QUv5f23Uv3tdxNj1F5qFGNcvcft9PcYZ6c2ndq9hS2GtC92SmhK2I2dWT0+uk5iE0lZc9xhNO3qWS2ykfAU8UTqwyVLowx4S+OvaGQsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130880; c=relaxed/simple;
	bh=MBTnCq/JGXoa9PHZEbm3tfYo2ouSVU3XPtBBnxgJkek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwjF+x7idbtn+H+esZ8gMjzsWXY8cpVMJBDFduK3I3x1JOdHwU8UxyfazonnQTxDOfoD2TNkfW0yRs/6enliLAA/LOuufLgY6fvvMboE2hvvJDUxK6XWOXUMRMp9Ly0VPVyRrIGAy3FxJEen5+9os/fRMledeEYMW0NYRTNi0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykw4VPRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykw4VPRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937861F000E9;
	Fri,  7 Aug 2026 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786130877;
	bh=82Gws1MWZbWT8B91dqXS9DLRDSZ0SGPiSUJPXFCEL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ykw4VPRi8KWeQafmYDxz4qeckArxC3lly4tc8+YRXuF0dPy2cNt9Yq+cen4hJZomA
	 xKg8BPYNeEwvmpjmzhefFlZVhNXwCWRZaC/MYak6Tt+GpgETP6aAD7/cXV02pzZt8a
	 XrCPqRor5CJIv/J1dRSsmYKBiES1R7B1nzKrq6tTnRA/qd6ZgOYFmbPPq/aiJksKH2
	 9/IO5jApN1jqo5LxFROLSl2xxID6QonoeH58YH9JDg8qt/ZinWy9Qw01kCTesbvJ7J
	 ilhsnauBrVsBc90PVxYkyOcEU5btTcKzlKmxfodJxOk1xAK8vymvyXIJRe+Vcg8pSD
	 k7b/bNLUOai0Q==
Date: Fri, 7 Aug 2026 12:27:57 -0700
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
Message-ID: <202608071224.12B27D08C@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-2-kees@kernel.org>
 <CALvbMcDwYgJNo=qeZY1m+zAutURc7rfRCaW960DDjbRAOKUZ+w@mail.gmail.com>
 <202607151337.31D0828D0@keescook>
 <202607151619.201AF99A@keescook>
 <CALvbMcB_pdM83JQg_F91yq2FfGWjkLynrckm6wgLdJfCDfArjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcB_pdM83JQg_F91yq2FfGWjkLynrckm6wgLdJfCDfArjQ@mail.gmail.com>

On Thu, Jul 23, 2026 at 06:28:16PM -0700, Andrea Pinski wrote:
> On Wed, Jul 15, 2026 at 4:32 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Jul 15, 2026 at 03:34:09PM -0700, Kees Cook wrote:
> > > On Sat, Jun 27, 2026 at 03:57:36PM -0700, Andrea Pinski wrote:
> > > > On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> > > > > [...]
> > > > > +/* KCFI label counter, incremented by KCFI insn emission.  */
> > > > > +static int kcfi_labelno = 0;
> > > >
> > > > I am not 100% sure if this needs a GTY marker or not. I suspect no
> > > > because we should not have emitted assembly code yet.
> > >
> > > If this moves with kcfi_next_labelno into final, I think it's okay
> > > without GTY?
> >
> > This is an int, so GC shouldn't be an issue.
> 
> GTY is used for PCH also and not just GC. This is why I question the
> need for the GTY marker. A GTY marker on an int is to make sure that
> it is restored from the PCH.
> Maybe you can add a couple of PCH testcases to make sure it is working
> correctly.

Ah, gotcha. Yeah, this doesn't appear to be an issue for PCH since it's
used during output only. Regardless, I've added pch tests now as well.

> > > > > +      type_id = (uint32_t) TREE_INT_CST_LOW (value);
> > > > > +    }
> > > > > +  else
> > > > > +    {
> > > > > +      type_id = compute_kcfi_type_id (fn_type);
> > > > > +
> > > > > +      tree type_id_tree = build_int_cst (unsigned_type_node, type_id);
> > > > > +      tree attr = build_tree_list (kcfi_type_id_attr, type_id_tree);
> > > > > +
> > > > > +      TYPE_ATTRIBUTES (fn_type) = chainon (TYPE_ATTRIBUTES (fn_type), attr);
> > > > > +    }
> > > >
> > > > Instead of an attribute there must be a better way of doing this.
> > > > Maybe a hashset instead.
> > >
> > > Perhaps? I will go examine this vs LTO, etc.
> >
> > Tracking this with lifetime tied to the fndecl is going to be more pain
> > from what I can find. The attribute is stable and doesn't cause problems
> > for LTO: I've tested with 2 TUs, and this all appears to happen
> > post-merge? Anyway, if there is something I've missed here, I'm happy to
> > find a new solution, but I can't induce any problems so far.
> 
> So maybe we add a field for FUNCTION_TYPE for this instead of an
> attribute. But that requires extra code for streaming the LTO and
> such. But it will reduce the overall overhead in general.

Okay, I've replaced the attribute with a hashset, which you'd suggested
before. This keeps the mapping entirely within kcfi.cc, and doesn't
bloat the FUNCTION_TYPE object with a new field that would only be used
for kcfi.

I'll get v15 sent shortly. :) Thanks!

-Kees

-- 
Kees Cook
