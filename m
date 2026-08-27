Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F02BD00C
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 05:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807027; cv=none; b=BLO/FLmvNICr5OzWZD34cf9tTQ1oIs9d3+knOHWV2ScgF2yuCCwAqcr7Y0HgOVuZ2iQJ8lIDoYsOBLOIkVxFsk0WifCSpwtW69KjXQd3nP7sSRBl5SZkBl3lQV72Eg9g9X/Cj2eWpYOnVDxFTNHDi6Zj69htW9bgYZEoPaYaN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807027; c=relaxed/simple;
	bh=1lvwgnhtKneqd1V4/yrh5NirsAyf1dToguwRBWAgvTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ8rh/U8+LnXQeiwfF7mm3G6ewX1SVJLoG8nNvQ48in5wMOCbDrACJaJ4xuZrIM76QCLhjazL8qxtilnimnzQ/4cZp0VCaDp3ZdEp9jY2EUQne7cT3LR2PHZ4XDL4uknOpXnJe9HIjCdEw1sZrXUJYBZGsXMk72uGlvgOkRuA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF6wrO78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF6wrO78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9284E1F000E9;
	Thu, 27 Aug 2026 05:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807025;
	bh=Hl2M0NFvamO0ktk9oSngedOa1zWC9V2JNQmNFz11uOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JF6wrO78VbhImi4gr7VCZeO+tCEbqg28VlRBdm4jeQZ3lKe3ronjX0cr2wr/SEilt
	 uIUeTdeOrpK3RJ20/xfuoUq/FRGrIka1mIjb/HlL8ztLuI8PzrPD6mU5f4vSqOflmF
	 TaohAA2whHuTtu6sQRRAZ0qsRkErIp3Sw8b2nZsmdOQZp2h/ReZ5+XnXjpUfT81XlM
	 yTxwLaono0tkxViVKcehkreBknpac9wGQ/DotrPtPCSTMOaLF40utEi3lOQaJxJUI9
	 gbYm+nIfRP/dfomyDdJN8GM3Zc07wRJb9d8psAO5zqaOXV66AjXhMz5dK459nTnaKw
	 3/TCLjicOYoSA==
Date: Wed, 26 Aug 2026 22:03:45 -0700
From: Kees Cook <kees@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
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
	Osterlund Sebastian <sebastian.osterlund@intel.com>,
	Constable Scott D <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <202608262159.ED2BB32C4B@keescook>
References: <20260825235748.i.456-kees@kernel.org>
 <20260825235759.3379064-4-kees@kernel.org>
 <CAFULd4ZKxXdw0gk5RHfihOBHJmcs15Y-uLFHcQUp_JMg58RyrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZKxXdw0gk5RHfihOBHJmcs15Y-uLFHcQUp_JMg58RyrA@mail.gmail.com>

On Wed, Aug 26, 2026 at 10:57:44AM +0200, Uros Bizjak wrote:
> On Wed, Aug 26, 2026 at 1:59 AM Kees Cook <kees@kernel.org> wrote:
[...]
> > +/* Apply x86-64 specific masking to KCFI type ID.  TYPE_ID is the 32-bit
> > +   KCFI type identifier to potentially mask.  Returns the type ID with
> > +   x86-64 specific adjustments to avoid embedding ENDBR instruction
> > +   sequences in the type identifier values.  */
> > +
> > +static uint32_t
> > +ix86_kcfi_mask_type_id (uint32_t type_id)
> > +{
> > +  /* Avoid embedding ENDBR instructions in KCFI type IDs.
> > +     ENDBR64: 0xfa1e0ff3, ENDBR32: 0xfb1e0ff3
> > +     If the type ID matches either instruction encoding, increment by 1.  */
> > +  if (type_id == 0xfa1e0ff3U || type_id == 0xfb1e0ff3U)
> 
> This should use the ix86_endbr_immediate_operand predicate. Exactly
> one target dependent immediate (0xfa1... for TARGET_64BIT and 0xfb1
> for TARGET_32BIT) should be avoided only with flag_cf_protection &
> CF_BRANCH. All this is handled in the predicate.

Ah yeah. Hmm, I double checked, and Clang doesn't gate this on
-fcf-protection nor arch, which means we have a potential ABI mismatch if
I change that logic in GCC's version of this.

If this is really important, I could look at making Clang check for the
flag/arch too, though honestly, I haven't even been able to generate a
collision with these values either, so the whole thing is theoretical...

I could improve the comment to note the ABI perhaps?

-- 
Kees Cook
