Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBF2DCBF8
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224366; cv=none; b=rECJA6HkO1Z9NIGHYRCbC1IbeteRD248NOWnUOAHQXynflGcMmZujC8hwwwTw73+LeiarNKC6PG/XYLMzyuLJSHLddMubrz7v8Rome/u8WFAamXAWGoGL7GJVJVx8zwlQFAQxoKKF1NBXNdWDkKimVOEdq5pf6tNZ4QgGoLOi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224366; c=relaxed/simple;
	bh=7oEsFUnAHSFqSDNE6cVVgbdW+KOgh4D4GBm1+zwNK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFu/G9/6a+7KAy1qgc7Rd0/7hIZktua8q+Z/pN/ZKvamobjauIpfyAjVN78e790a8hXqqT1kb8JpWc6Rv9p6OyqnrapMC4HcKPpyVLFHTA62lsH4dsyU7MK1blEsEVxq9NCjQKEODcN04w3HjL+3m2J/YqqLSxQuGrTX/91b7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM4v5uEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM4v5uEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC0C4CEE7;
	Thu, 18 Sep 2025 19:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224366;
	bh=7oEsFUnAHSFqSDNE6cVVgbdW+KOgh4D4GBm1+zwNK94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vM4v5uEbCxukeJHiR3QoMkjkKuq+OVau7apCKsuAld/oMjKpAylB+/qEKIE53PxCg
	 rAkiQL5UJK0p1EadI9+5KraBSlQdIwiXdNUaRARLPN8fBXcEKluh9FlhOk6RTobm/X
	 TlgUcKpaoFixNSzLZ2VrOprwvMAFGWt6Z/8uM0xqeadieJbaFLS3Qr6YgfxG8AJnow
	 05oxnmnWGGD7e5WhAloUfz4dfwOox4DVerYfjvECyiBOyPfvvpR21/dC8oH2fYrmI0
	 wT5fxdUSXULbtCcb44YB7I4kYwd/htslocL11g1MhCuT+TjinUzqlk+owMiTHS+ceP
	 aqRNPJM5xIcPg==
Date: Thu, 18 Sep 2025 12:39:25 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
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
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509181229.FF689207B@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-2-kees@kernel.org>
 <6F94A091-6948-4220-A972-236055C2440A@oracle.com>
 <202509171307.DC9740ABAB@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509171307.DC9740ABAB@keescook>

On Wed, Sep 17, 2025 at 02:09:54PM -0700, Kees Cook wrote:
> On Wed, Sep 17, 2025 at 01:42:32PM +0000, Qing Zhao wrote:
> > > On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> > > +- Keep indirect calls from being merged (see earlier example) by
> > > +  checking the KCFI insn's typeid for equality.
> > 
> > Is this resolved by the following code:
> > 
> > rtlanal.cc
> > index 63a1d08c46cf..5016fe93ccac 100644
> > --- a/gcc/rtlanal.cc
> > +++ b/gcc/rtlanal.cc
> > @@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
> >     case IF_THEN_ELSE:
> >       return reg_overlap_mentioned_p (x, body);
> > 
> > +    case KCFI:
> > +      /* For KCFI wrapper, check both the wrapped call and the type ID.  */
> > +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
> > +      || reg_overlap_mentioned_p (x, XEXP (body, 1)));
> > +
> 
> The above is needed for accurate register "liveness" checking. When the
> above code is removed, the kcfi-move-preservation.c regression test
> fails (since it doesn't see the clobbers).
> 
> AFAICT, simply making it a new type of RTL (the DEF_RTL_EXPR), made it
> unmergeable. I assume this is because whatever was doing the call
> merging was looking strictly for "CALL" types, but I honestly don't know
> where that was happening.

Okay, I've found this. The pass that merged the regression test's calls
is jump2. Specifically, the jump2 pass calls old_insns_match_p() which
compares instruction patterns using rtx_equal_p(), and that is doing it
naturally based on the RTL expression, i.e. matching RTL codes for KCFI,
and then matching format (KCFI defines itself as "ee" format, i.e. 2
expressions):

  code = GET_CODE (x);
  /* Rtx's of different codes cannot be equal.  */
  if (code != GET_CODE (y))
    return false;
...
  fmt = GET_RTX_FORMAT (code);
  for (i = GET_RTX_LENGTH (code) - 1; i >= 0; i--)
    {
      switch (fmt[i])
        {
...
        case 'e':
          if (!rtx_equal_p (XEXP (x, i), XEXP (y, i), cb))
            return false;
          break;

So if it's the same call and the same typeid, it'll get merged, otherwise
it won't. And I've validated this now with an addition to the regression
test. It now makes 3 calls, once with typeid A, and then 2 calls with
typeid B, and the typeid B calls get merged.

So there was no special handling for CALL, it's just that CALL didn't have
the typeid associated with it, and KCFI does. RTL working as intended. ;)

(But my new mystery is why my new KCFI matching typeid merging happens
on all backend _except_ arm... I will investigate that.)

-Kees

-- 
Kees Cook
