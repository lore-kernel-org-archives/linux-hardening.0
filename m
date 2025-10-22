Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C012F83D8
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163550; cv=none; b=sOzW/4f/BQuxLUuMYmc8q7+bSGRRbKwhVAhZC4We6H92lamPkY8Kk86eLRTLZVFqwcHRqUM1F/Vu0DEXZ6sLtRgOWfXynQON7dO3BDzmW68bWBRQ9rOX7E7JO3yygUW2kjqWXPLejL/pDkEB201vgCrVhkbSFl1v/V9puHer5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163550; c=relaxed/simple;
	bh=S1LiUzRVaADEKUnGpzULJLtqU+nrAwYs59I22H4xJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUMG75ReZ8TH3syJtTjDja0eyI3GbDkq7ohSBaQCE2sqFdtsXMGdi3mybOk1eFIEHrRqB9/6HC4btNE+D2+c2uaEROoenQHLgPNGCKarth8bHuRA0g54NAMUzB9G9pngNZeSrxWQibu29VN9N/AYC5L8jDldOi4Ls4AWiQf2lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKShQ167; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKShQ167"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F5C4CEE7;
	Wed, 22 Oct 2025 20:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761163549;
	bh=S1LiUzRVaADEKUnGpzULJLtqU+nrAwYs59I22H4xJoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKShQ167pKoMw6lBcvbWAaFirLmIdVeyTi/p1pu3Y462xhhoSSS2P3Ql9rbEWS5tZ
	 wpiXdhABSKwz8svuSTXbag7jyovL25hG9EFBjAGzDTYsa+W6MJnIc/972p2UHyni2r
	 mXpRmoc45txDxho/UzCl9xnjQZYiG4RQZG8RSchp5k4eOssv/FHLzRhtBXyC04KEt/
	 8kyab1bY1Y4iGnOCDnkUOVxWOgSzf/+mnBSbFtxdV6W7EctntftQKR2JoH39kFNW9/
	 Jj5AQ588qcQbOc/TkUWWZSTJPXjiiGLhu+ENBR0iyecV3s6rQOkgivMEv4DL68YEXC
	 /o3UjWHbJodPg==
Date: Wed, 22 Oct 2025 13:05:49 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
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
Subject: Re: [PATCH v5 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202510221253.D6B51F950@keescook>
References: <20251022181345.do.256-kees@kernel.org>
 <20251022182243.72085-5-kees@kernel.org>
 <CALvbMcBkGA_SpdskoABCYj2_9r=9SebgPa2fs5pWzLoNY5dbOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcBkGA_SpdskoABCYj2_9r=9SebgPa2fs5pWzLoNY5dbOg@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:33:18PM -0700, Andrew Pinski wrote:
> On Wed, Oct 22, 2025 at 11:27 AM Kees Cook <kees@kernel.org> wrote:
> [...]
> > @@ -11847,6 +11848,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx cookie, bool sibcall)
> >
> >    call = gen_rtx_CALL (VOIDmode, mem, const0_rtx);
> >
> > +  /* Only indirect calls need KCFI instrumentation.  */
> > +  bool is_direct_call = SYMBOL_REF_P (XEXP (mem, 0));
> > +  rtx kcfi_type_rtx = is_direct_call ? NULL_RTX
> > +    : kcfi_get_type_id_for_expanding_gimple_call ();
> 
> I don't like kcfi_get_type_id_for_expanding_gimple_call call.
> Does it make better sense to create a few new optabs for the kfci call
> instead and pass this down instead of having this call?

Unless I'm misunderstanding how optabs work, I don't want to use
that here. To use an optab, I think I'd need to create a separate
"define_expand" RTL pattern for kcfi calls. I found this to be infeasible
(I tried it somewhere back in around v2), as the calling conventions
for most architectures are extraordinarily complex, and I'd have to
duplicate all of that logic for kcfi expansion. Instead, I have KCFI
just happen in late expansion, which seems the best fit.

Just so I can understand better, why don't you like it? I assume it's
the fact that we're basically in RTL and that function ends up reaching
back up to GIMPLE? This seemed like a layering violation to me too, but
I noticed that it's not uncommon for expansion code to use
currently_expanding_gimple_stmt, so as a result it didn't end up seeming
unreasonable to also use it for KCFI (it is, as it turns out, exactly
what's needed at that moment in the expansion: "give me the kcfi
typeid").

Obviously, I could be missing something here, so if you see a way to do
this better, I am happy to do so. :)

-Kees

-- 
Kees Cook
