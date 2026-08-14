Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F683546E7;
	Fri, 14 Aug 2026 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731885; cv=none; b=EWL+ReMFhtUiG/BOPG36XjN98uWYqVWYqqksN6hK0dMkLgx8cclN7iC109R7ISlbI6S5mCHQOJVj4KZlJwM7qt4bg+ao7hhjknGgsoWej8u4MQIQF0HMB8Q4Zm0qx2P701ApFEcaJgR0cpAVsfhxM/X3zxa3W/6gZUx+CuY2F/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731885; c=relaxed/simple;
	bh=vu+zfzNe1WEav0e72HiaOs0RrGg13nrgBqLNFQl29LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de5Nx0jlwxf/3G3js62Cb9OBVDW5ae+cFdJdnGSOJT+LqhsLJVV/3dFG8ls/Mm/+UFLtD6/Iff93+Cp5sJvGEPrG+p/i6Od8my88pVOz2I0lFBK750qReOSy0u0QIMEL/gGpvdzqfsXhpSAU7pYEg4/UCmzVhf2ILbkgJ5en8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3xC16AE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3xC16AE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ADD521F000E9;
	Fri, 14 Aug 2026 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786731883;
	bh=m1gghI+TDeiW059JYb2+KGqrR0PA5N3lWmxT++HB6Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B3xC16AEGuQu4TAKX96OJOZO3H7opkNjCXH2/zMfsHBZRXvjmxPeJ23y8S7pWKDnr
	 8rN/hTxh4TD8ozwWybnM6tIC+KTLs7aMfLH4NUTHHNwGF6B2650JGQ5TapzqWc89oQ
	 BGYyE+lyQ7/OXs6rSAQlvt+p3PFC1fJ0/5mDnqfdaCvyA5mxMNIN2JTaNA2sHvbo4S
	 s0Tpky85PMJR6Amf71MV3f8qDJEcFonEb0HHdtm8P6zCR7P9OmRlL2+bfKzGgB6Ky3
	 y7FWy8TPs7PbVmtY+Usf5tRz7ra2CbuWiQ/txJgua/UfGkCHiCK638lJnqEboEmIpJ
	 BNDB0nIqI0mcA==
Date: Fri, 14 Aug 2026 20:23:02 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>, nathan@kernel.org,
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Message-ID: <an9dBpYEIb4GWhAC@levanger>
Mail-Followup-To: Jaihind Yadav <jaihindy@qti.qualcomm.com>,
	Kees Cook <kees@kernel.org>, nathan@kernel.org,
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
 <202608130942.4FFA5AAB9D@keescook>
 <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>

[ Please reply interleaved,
  cp.  Documentation/process/submitting-patches.rst ]

On Fri, Aug 14, 2026 at 08:27:58AM +0000, Jaihind Yadav wrote:
> Hi Kees,
> 
>   That's a fair point.
> 
>   In my testing, the issue was observed specifically with the STACKLEAK
>   plugin path being recorded in DWARF producer strings for KBUILD_EXTMOD
>   builds via:
> 
>     -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> 
>   The motivation for this patch was to address that specific issue with
>   the smallest possible change.
> 
>   I agree the same behavior may apply to other GCC plugins when their
>   -fplugin arguments contain build-specific absolute paths. A more general
>   solution may make sense, but I wasn't sure whether disabling recorded
>   GCC switches more broadly would be desirable from a debugging
>   information perspective.

[...]
> On Thu, Aug 13, 2026 at 01:59:49PM +0530, Jaihind Yadav wrote:
> > With CONFIG_GCC_PLUGIN_STACKLEAK=y, kstack erase adds:
> >
> >   -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> >
> > For KBUILD_EXTMOD builds, recording gcc switches can embed this 
> > host/build specific plugin path into module DWARF producer strings, 
> > which trips QA checks looking for absolute path leakage.
> 
> Isn't this a problem for all Linux gcc plugins, though?
> 
> -Kees
> 
> >
> > Disable gcc switch recording only for external modules by adding 
> > -gno-record-gcc-switches to kstack-erase-cflags when KBUILD_EXTMOD is set.
> >
> > This keeps stackleak plugin instrumentation enabled while avoiding 
> > leakage of host-specific paths in external module debug metadata.
> >
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/all/20260803181217.GB1067866@ax162/
> > Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
> > ---
> >  scripts/Makefile.kstack_erase | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
> > index ee7e4ef7b892..6f31a3915d24 100644
> > --- a/scripts/Makefile.kstack_erase
> > +++ b/scripts/Makefile.kstack_erase
> > @@ -5,6 +5,7 @@ kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugi
> >  kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
> >  kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
> >  kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
> > +kstack-erase-cflags-$(if $(KBUILD_EXTMOD),y) += -gno-record-gcc-switches

As -gno-record-gcc-switches is not specific to kstack-erase, I am not
convinced that CONFIG_GCC_PLUGIN_STACKLEAK is a good switch for it.
Might it be that someone has CONFIG_GCC_PLUGIN_STACKLEAK enabled but
wants (some other) gcc switches to be recorded?


If there is a need for external kmods to to have 

  make modules KCFLAGS=-gno-record-gcc-switches

automated in kbuild, I'd rather like to see a new Kconfig symbol for
that flag (some CONFIG_EXT_MOD_NO_RECORD_GCC_SWITCHES) but a Kconfig
symbol only for external kmods feels odd to me, too.

HTH.

Kind regards,
Nicolas
