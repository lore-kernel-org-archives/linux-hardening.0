Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE0223324
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765593018; cv=none; b=mDBh4IbPo3IQrop6ZEzypl3YDBSOylqzWVwmEDW+9qYi2ljlejahUIxETWw2TcKy496qyzF511zaBl6EUSEuLpmZsNUGp4BIu+744G4jAdsOAF/jQEObcuevW9X7JWPf9ZCxIXGf1N98bIy9nq7B9G25THOxf47UR7qeP9e7xjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765593018; c=relaxed/simple;
	bh=plGV2E1TrMujnirMQg/rh+JN5ilbZGGF2F+AIxuNVFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU1jUO/R6oAYoTd2EU1z9i94QsPGBglobGdVXdKDydl+Xy+P2EYSorWxNhFHILDGN0+XbT+2B92dmkkp1WnzWGSJhzdHhJ1P7pJCdMO+VY9vOcCD7Vz/ZrtuBdK9Utk4GkWRZuLultRO1yoCuti0X9J8zCTz0MTsfWMrsrDq8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt9tOGX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt9tOGX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E95C4CEF1;
	Sat, 13 Dec 2025 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765593018;
	bh=plGV2E1TrMujnirMQg/rh+JN5ilbZGGF2F+AIxuNVFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dt9tOGX91sxsMIqGeLT/XTSZYVW3dMtn7C2JrJIcBrcm4zxCbHuH8ChBHm+o0L/A9
	 yU3T2Lh7oEOUi58s3WBjYMCszDagbJkEXBfExVtM7XA5YO5B/VT1tMV+mXkQXcqQdx
	 v329Qs8FQEfOxAhcSCMUbUSq22cL2Q5XpBDKDwKvTHUBcgzPxGHyJQ1moZXGHTlMX4
	 Pjb5Y3pg4cS22w7n4gICCwbpdeRK7r8mdbV9aThvvudOMVViZLB7i1PxzEbrRTBHv3
	 sU7EBtjebtVfj9a4F4ejHuKqTarxB3Rl3p4YuWooJPBMdGsZtBoHe2Ha0OeiEn9/gJ
	 PD9VhddiGTwTw==
Date: Fri, 12 Dec 2025 18:30:17 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
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
Subject: Re: [PATCH v9 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202512121756.68957E18@keescook>
References: <20251210022025.harder.803-kees@kernel.org>
 <20251210022035.331892-2-kees@kernel.org>
 <CALvbMcAd-03ZtYKBCecUKGLfna+kNe4TgYqkV80sVNQ+J-M-7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcAd-03ZtYKBCecUKGLfna+kNe4TgYqkV80sVNQ+J-M-7A@mail.gmail.com>

On Tue, Dec 09, 2025 at 08:00:28PM -0800, Andrew Pinski wrote:
> On Tue, Dec 9, 2025 at 6:24 PM Kees Cook <kees@kernel.org> wrote:
> [...]
> > diff --git a/gcc/rtl.def b/gcc/rtl.def
> > index 15ae7d10fcc1..af643d187b95 100644
> > --- a/gcc/rtl.def
> > +++ b/gcc/rtl.def
> > @@ -318,6 +318,12 @@ DEF_RTL_EXPR(CLOBBER, "clobber", "e", RTX_EXTRA)
> >
> >  DEF_RTL_EXPR(CALL, "call", "ee", RTX_EXTRA)
> >
> > +/* KCFI wrapper for call expressions.
> > +   Operand 0 is the call expression.
> > +   Operand 1 is the KCFI type ID (const_int).  */
> > +
> > +DEF_RTL_EXPR(KCFI, "kcfi", "ee", RTX_EXTRA)
> 
> You don't document this new rtl in doc/rtl.texi.
> Also I think it would be better if it was:
> DEF_RTL_EXPR(KCFI, "kcfi", "ei", RTX_EXTRA)
> 
> So you don't need an extra indirection to the KCFI type ID. You can
> just access it like `XUINT (kcficall, 2)`.
> const_int seems too heavy weight for this.
> I assume it fits in `unsigned int`.

I can't figure out how to do the RTL matching when it's not a const_int
expr. For stand-alone stuff ("match_dup") I think I see it, but that seems
to be for stand-alone hard-coded values? Specifically what I can't figure
out is how to change the .md pattern matching with match_operand which
expects RTX operands, to something else. Format specifier i stores a raw
integer, not an RTX, so it can't be matched with match_operand. This
also breaks define_subst, which also seems to require patterns using
match_operand.

As always, I'm open to alternatives, but right now I don't see how to
do this with "ei".

> > +    case KCFI:
> > +      /* For KCFI wrapper, check both the wrapped call and the type ID.  */
> > +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
> > +             || reg_overlap_mentioned_p (x, XEXP (body, 1)));
> 
> Isn't the type ID always a const_int if so then you don't need to
> check if reg_overlap_mentioned_p here.

True, yes. I've adjusted this now. I wasn't sure if I needed this to check
the const_int value too, but testing seems to suggest I didn't need that
part.


-Kees

-- 
Kees Cook
