Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCB3A16BC;
	Fri, 21 Aug 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343964; cv=none; b=eCafyJDXR2ciSy22lmPePi3CtCtFhp0dCcPZdkb6b7A5awPMm28MPON96Geob6jNnGBxrVnqSUSR1jRspG1JElEUclSHc7DfDHf2IVXscN8fLqnxURGPG4yobFW3049iTjcv99OoWv8QATg/XVxVMPmQnW8wej3aQhBQbtfRT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343964; c=relaxed/simple;
	bh=2PioAhecL387m/i4/N1rfwNSB//nT+ce04hbehkjF1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC+S1W4/M+dzCJmHVDKiu9OWLl2MdSJpDAT/UxG0IP9eEivuoj9gIx34UafW3b9Av2usY88iuc4MuS56ARKQzio/xRVE77JCGn1HD6SYp4sf1svBF7QJ7+qo7uRPtrH+3X+oS/XvUyfsJdmHqNZO/C4OYVViA4Jn2Q70EjEVocA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NosmJLww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NosmJLww"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4B2761F01559;
	Fri, 21 Aug 2026 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343961;
	bh=rnrVivgWRYHdZwOF5bKzXlao47K/VKzxzftXq658NTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NosmJLwwObu1FeaLJzu+UmaBEj7n32p29qYerHf3/uVGiOyrABOPDKsJXZHWEav73
	 mHYrLzt0uA2qitpP/kCy0+ibJ8NoeCNe1abcECj4UXXyHYv95faHnnMSiy4dXgImCH
	 waRVTOVQ1FCGFD46VWosQs9pQK41l6huNY8HgQugtHh7cAPD6Y90U/AQTGmLDS/WTv
	 OwXwAoidVH05IKlGl1hkKJ5UFAAeoVwVaprcuBPJCu2iqkgbcxx3UQbYVox5B6CSXM
	 my2z4zJ44l/w7E5G8D63c4EScFw736nV8BOUK2ZL5najR0eEqq50Jm1FiHvI1HYicd
	 hG5XBciUyOsqg==
Date: Fri, 21 Aug 2026 21:52:28 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ferran Duarri <ferran.duarri@me.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: ubsan: skip UBSAN for external modules by default
Message-ID: <aoisfLPgD33M0sRt@levanger>
Mail-Followup-To: Nathan Chancellor <nathan@kernel.org>,
	Ferran Duarri <ferran.duarri@me.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
References: <20260820190200.203185-1-ferran.duarri@me.com>
 <20260821190701.GA3030879@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821190701.GA3030879@ax162>

On Fri, Aug 21, 2026 at 12:07:01PM -0700, Nathan Chancellor wrote:
> + Kees and linux-hardening@ for visibility
> 
> On Thu, Aug 20, 2026 at 09:01:58PM +0200, Ferran Duarri wrote:
> > External modules built with KBUILD_EXTMOD set inherit UBSAN sanitizer
> > flags from the kernel's KBUILD_CFLAGS because is-kernel-object is 'y'
> > for any obj-m object. This silently breaks third-party modules whose
> > source code (e.g. VMware vmnet/vmmon) triggers UBSAN UB checks at
> > runtime, causing packet-forwarding failures and VM instability while
> > the module itself loads successfully.
> > 
> > Make UBSAN opt-in for external modules: skip the is-kernel-object 'y'
> > fallback when KBUILD_EXTMOD is set. External modules that explicitly
> > need UBSAN can still opt in by setting UBSAN_SANITIZE := y.
> > 
> > In-kernel module builds are not affected.
> > Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
> 
> I am open to other opinions but I am not inclined to apply this change.
> If an external module has issues with these checks, it should either be
> fixed or 'UBSAN_SANITIZE := n' can be added to the module's Makefile,
> rather than making the default worse for everyone else, especially given
> the importance of UBSAN_BOUNDS for avoiding out of bounds accesses and
> writes.

Yes, I second that.

-- 
Nicolas
