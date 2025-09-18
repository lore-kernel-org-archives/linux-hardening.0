Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFC288C35
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223237; cv=none; b=iN+DCXTI/Rk1x4o3dOlfRyIrBJ+uYM/L8mbhBF9fmx7M215q7a4eqT8n8iLghY1KXGRkRlba0lBPQONaQem7cJXEhoETG1s9TLnc/tgecrtgK1Y37SUQndy+hT6KDT6Tw9r9nvvh4MlXRev8z0ZAy5/ogtMPi1/WwDwvD304wPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223237; c=relaxed/simple;
	bh=BkhjC9v5agGrweHClSOJlURKBn10yPBW8/UlI04xT3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/Mjzx/jNswFYTv2bS2jyWUkRurjhE761SqSs5vI/T2cPAtS7J6TZB3DQjDW666UJnaC8+WXXjgEzdER3SuOv3CGojTRWsEKyuXRTtHRVuznRFCgM3PW7qBk+t0muLn8unNb9WpzR8cHLZOjajeN1zhFNEttXVfvL06xEN25lwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX/0PBvZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX/0PBvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8A7C4CEE7;
	Thu, 18 Sep 2025 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223237;
	bh=BkhjC9v5agGrweHClSOJlURKBn10yPBW8/UlI04xT3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eX/0PBvZ/o7mKHRhGKUKLVYEcY73a/pw2mYAuKEN1M1w0evNLS35hN4/tTFvf3wiP
	 R7QgoGSbtuZpJXyJDOCiFYU7BEVBgNKUP/LOKMKP84c7zU1UkRzERj8f859cda3jRi
	 /YIwMgsr1L9BmIgMN+Znc9P5xt3FxN7M5ctSyPxKaccJrd6ZE0eAW9qZvHhPpUK+Pg
	 tExnuGlkkNliXJL6DNxXKFiGqfynf+ACBW83UOs76ukndrixR4xxJhJ0xKzstPEHGo
	 OxJzbd65TJn8e27QVi+sDbXxsXUaw3NaSP+DuzYA28eOfaTKJwSqfADPaWHCn+h2Hg
	 Y5Py+3MZDAlfg==
Date: Thu, 18 Sep 2025 12:20:36 -0700
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
Message-ID: <202509181218.FA966DA8F0@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-2-kees@kernel.org>
 <6F94A091-6948-4220-A972-236055C2440A@oracle.com>
 <202509171307.DC9740ABAB@keescook>
 <306E5909-C77F-415E-A2F4-6FAE3E5740DB@oracle.com>
 <202509181112.B39B490E@keescook>
 <1F77CFF9-9105-4F3A-A7AC-E3A0D2E95162@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1F77CFF9-9105-4F3A-A7AC-E3A0D2E95162@oracle.com>

On Thu, Sep 18, 2025 at 06:48:03PM +0000, Qing Zhao wrote:
> 
> 
> > On Sep 18, 2025, at 14:20, Kees Cook <kees@kernel.org> wrote:
> > 
> >>>>> +- External functions that are address-taken have a weak __kcfi_typeid_$func
> >>>>> +  symbol added with the typeid value available so that the typeid can be
> >>>>> +  referenced from assembly linkages, etc, where the typeid values cannot be
> >>>>> +  calculated (i.e where C type information is missing):
> >>>>> +
> >>>>> +    .weak   __kcfi_typeid_$func
> >>>>> +    .set    __kcfi_typeid_$func, $typeid
> >>>>> +
> >>>> 
> >>>> From my previous understanding, the above weak symbol is emitted for external functions
> >>>> that are address-taken AND does not have a definition in the compilation. So the weak symbols
> >>>> Is emitted at the declaration site of the external function, is this true?
> >>>> 
> >>>> If so, could you please clarify this in the above?
> >>> 
> >>> Yes, this happens via assemble_external_real, which can be called under
> >>> a few conditions in gcc/varasm.cc.
> >> 
> >> Okay. Please clarify this in the design doc.
> > 
> > I mention it later in the "behavioral" section:
> > 
> > - assemble_external_real calls kcfi_emit_typeid_symbol to add the
> >  __kcfi_typeid_$func symbols.
> > 
> > I had left off implementation details (i.e. "called from
> > assemble_external_real") in the "constraints" section. How would you
> > like this arranged?
> 
> The original arrangement is good. -:)
> 
> I guess that I didn’t make myself clear in the beginning, the following is a modified version of 
> your previous paragraph:
> 
> +- An external function that is address-taken but does not have a definition has
> +  a weak __kcfi_typeid_$func symbol added at the declaration site. This weak
> +  symbol has  the typeid value available so that the typeid can be
> +  referenced from assembly linkages, etc, where the typeid values cannot be
> +  calculated (i.e where C type information is missing):
> +
> +    .weak   __kcfi_typeid_$func
> +    .set    __kcfi_typeid_$func, $typeid
> +
> 
> Is the above the correct understanding? 

Ah! I see, yes, that's correct. I will update it. :)

> 
> >>> 
> >>>>> +static uint32_t
> >>>>> +kcfi_get_type_id (tree fn_type)
> >>>>> +{
> >>>>> +  uint32_t type_id;
> >>>>> +
> >>>>> +  /* Cache the attribute identifier.  */
> >>>>> +  if (!kcfi_type_id_attr)
> >>>>> +    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
> >>>>> +
> >>>>> +  tree attr = lookup_attribute (IDENTIFIER_POINTER (kcfi_type_id_attr),
> >>>>> + TYPE_ATTRIBUTES (fn_type));
> >>>> 
> >>>> The above can be simplified as:
> >>>> +  tree attr = lookup_attribute (“kcfi_type_id”, TYPE_ATTRIBUTES (fn_type));
> >>> 
> >>> Ugh, I totally misunderstood the examples I saw of this. I thought they
> >>> were caching the string lookup, but now that I look more closely, I see:
> >>> 
> >>> #define IDENTIFIER_POINTER(NODE) \
> >>> ((const char *) IDENTIFIER_NODE_CHECK (NODE)->identifier.id.str)
> >>> 
> >>> it's just returning the string!
> >>> 
> >>> I will throw away the "caching" I was doing. I thought it would actually
> >>> look up the attribute using the tree returned by get_identifier, but I
> >>> see there is no overloaded lookup_attribute that takes a tree argument.
> >>> 
> >>> *face palm*
> >> 
> >> -:)
> > 
> > Okay, so I tried to remove this and remembered that it's actually cached
> > not for lookup_attribute, but for build_tree_list call case:
> > 
> >      tree attr = build_tree_list (kcfi_type_id_attr, type_id_tree);
> > 
> >      TYPE_ATTRIBUTES (fn_type) = chainon (TYPE_ATTRIBUTES (fn_type), attr);
> > 
> > For _that_, I need a "tree" argument. So instead of building it each
> > time, I have it built already, and I can get at its string for
> > lookup_attribute too. So I think this code is good as-is.
> 
> Right, the kcfi_type_id_attr is still needed for the purpose of new type_id attribute.
> 
> But, for the following
> 
> > +  tree attr = lookup_attribute (IDENTIFIER_POINTER (kcfi_type_id_attr),
> > + TYPE_ATTRIBUTES (fn_type));
> 
> The above can be simplified as:
> +  tree attr = lookup_attribute (“kcfi_type_id”, TYPE_ATTRIBUTES (fn_type));
> 
> No need to call IDENTIFIER_POINTER (kcfi_type_id_attr) as the first argument for the above call.
> 
> Hope this is clear.

Right, I did this because it seemed weird to me to open-code the same
literal string twice.

-- 
Kees Cook
