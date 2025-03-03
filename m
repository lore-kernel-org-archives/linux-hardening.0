Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05941F03FD;
	Mon,  3 Mar 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023405; cv=none; b=byE1XggSixOqp0zV3fPoSacl4nRelCPL/iyNRzVt+jP7V0xYewqhSQu+gctL8P9KUQO7CCX4C1bZc47Zlzc3Kx817vILAIv3tYZkem1kIKnM7DRXEHBaSBcFPGqaUoa8dzjQmehdNn5t3nwXdfnPAu9l5Y/0Ac/HoFUgqlcaL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023405; c=relaxed/simple;
	bh=uweCvlyD1Kz0PfsbJ4rmLentL9Z/1N5rqM4K9ou/BOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXqIjvg/lhnYPfjcbNqDr3qcJg/sDYYS3Z0qsUOuxaqRZ5CySrswgS7j5HiE+cDZ/TZ1OVVbZrSPDfPgIbI4YTyR5pN++6lEThnlL7VxWs9p7q5Pwy3j9QLw4v7ArUc2bcqAfnNJE6CLIDkZch+hn+cDwLfXxlmeW1GKlZJqf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEN+x6vV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEN+x6vV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AECC4CED6;
	Mon,  3 Mar 2025 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023405;
	bh=uweCvlyD1Kz0PfsbJ4rmLentL9Z/1N5rqM4K9ou/BOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEN+x6vV2g4r/5LJGJAPjrbAb4/afVgw/tkKuWN0q2bTHAV+y7zexvepRP3gbShaW
	 GjiSqqfbsm0D2OvFNTMrOuHuPYp6qzfARg0+7hWjwFL9z68urn0Wt0kKCf6w4SeFBp
	 ge6uLzVHkmkIEZCPX9yA8K8NdXK+No17U8Q0yHbzUoP7IaBGXTEd1eP7hWpriVT71C
	 cvbbbbdXd7pEJ//CIaUMbuPQ7eBEPxuAs7LACYdrcZl3hIdaoLGRJLzDydC2PeDqTF
	 fQ81GMpHhOT8OHEqtGoHxMkN4q09E6g0WSfGh7ELRT46mkKWiPJ0fAWfiRTulO3KY5
	 F9mTdQ0r/SoaA==
Date: Mon, 3 Mar 2025 09:36:42 -0800
From: Kees Cook <kees@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] compiler.h: Introduce __must_be_noncstr()
Message-ID: <202503030936.E7B8B4F3E@keescook>
References: <20250228174130.it.875-kees@kernel.org>
 <SN6PR02MB4157CA61D04CD12D7CED5E1DD4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157CA61D04CD12D7CED5E1DD4CF2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sat, Mar 01, 2025 at 05:46:24AM +0000, Michael Kelley wrote:
> From: Kees Cook <kees@kernel.org> Sent: Friday, February 28, 2025 9:42 AM
> > 
> > In preparation for adding more type checking to the memtostr/strtomem*()
> > helpers, introduce the ability to check for the "nonstring" attribute.
> > This is the reverse of what was added to strscpy*() in commit 559048d156ff
> > ("string: Check for "nonstring" attribute on strscpy() arguments").
> > 
> > Note that __annotated() must be explicitly tested for, as GCC added
> > __builtin_has_attribute() after it added the "nonstring" attribute. Do
> > so here to avoid the !__annotated() test triggering build failures
> > when __builtin_has_attribute() was missing but __nonstring was defined.
> > (I've opted to squash this fix into this patch so we don't end up with
> > a possible bisection target that would leave the kernel unbuildable.)
> > 
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Reported-by: Michael Kelley <mhklinux@outlook.com>
> > Closes: https://lore.kernel.org/all/adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com/ 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  include/linux/compiler.h       | 18 +++++++++++++++++-
> >  include/linux/compiler_types.h |  9 ++++++---
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 200fd3c5bc70..d5201464c5e6 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -206,9 +206,25 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  #define __must_be_byte_array(a)
> > 	__BUILD_BUG_ON_ZERO_MSG(!__is_byte_array(a), \
> >  							"must be byte array")
> > 
> > +/*
> > + * If the "nonstring" attribute isn't available, we have to return true
> > + * so the __must_*() checks pass when "nonstring" isn't supported.
> > + */
> > +#if __has_attribute(__nonstring__) && defined(__annotated)
> > +#define __is_cstr(a)		(!__annotated(a, nonstring))
> > +#define __is_noncstr(a)		(__annotated(a, nonstring))
> > +#else
> > +#define __is_cstr(a)		(true)
> > +#define __is_noncstr(a)		(true)
> > +#endif
> > +
> >  /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
> >  #define __must_be_cstr(p) \
> > -	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-
> > terminated)")
> > +	__BUILD_BUG_ON_ZERO_MSG(!__is_cstr(p), \
> > +				"must be C-string (NUL-terminated)")
> > +#define __must_be_noncstr(p) \
> > +	__BUILD_BUG_ON_ZERO_MSG(!__is_noncstr(p), \
> > +				"must be non-C-string (not NUL-terminated)")
> > 
> >  #endif /* __KERNEL__ */
> > 
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 981cc3d7e3aa..f59393464ea7 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -446,11 +446,14 @@ struct ftrace_likely_data {
> >  #define __member_size(p)	__builtin_object_size(p, 1)
> >  #endif
> > 
> > -/* Determine if an attribute has been applied to a variable. */
> > +/*
> > + * Determine if an attribute has been applied to a variable.
> > + * Using __annotated needs to check for __annotated being available,
> > + * or negative tests may fail when annotation cannot be checked. For
> > + * example, see the definition of __is_cstr().
> > + */
> >  #if __has_builtin(__builtin_has_attribute)
> >  #define __annotated(var, attr)	__builtin_has_attribute(var, attr)
> > -#else
> > -#define __annotated(var, attr)	(false)
> >  #endif
> > 
> >  /*
> > --
> > 2.34.1
> > 
> 
> Compile tested on x86 with gcc 9.4.0, and it resolves the compile
> problem I was originally seeing with linux-next-20250226.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>

Great! Thanks for testing this. :)

-- 
Kees Cook
