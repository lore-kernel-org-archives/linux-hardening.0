Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DAB640
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925482; cv=none; b=oQZgnmTIOVGST+h028+HPfgS4iVrDHqemWMKjnPRRabM0Ojh+cOgZvsvgBgvdr7C0XbxO3E1KFTiGdwiq3ImA16jb1gIuU5QrJudXU3U1gsznyQqNaWOvTkuqCuFrKgMFaD8jCRqvSM2+O8PNtvPmfBfFzavM3TKX1wSSwnidCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925482; c=relaxed/simple;
	bh=gi2Eyb39ugsuBL/Vvb1+jnM4k6e8OGUawUyCmcwqN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bghVPHcxZurOC1N1LKy8AVruhLnd/bMgpbC8R7aMKGVKYwdqVpdTXSgjCe1+oZZJMFQKAMrZ+ST3o7Wt5I0I4LKhX9g7asc8Bwv1Y/QaLmkpS95jlhnqLYK5O9rvsmpIGPmrZIJ2Is7D1vv8J6m2JV9NzlXX8mA0G7Dy2KTuquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikLMbRaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikLMbRaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4F71F000E9;
	Sat, 20 Jun 2026 03:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781925481;
	bh=PUnmYPATOMeIBRaezIXFeeMslLQd4yH+DDdZJu9NWm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikLMbRaOAlu3iwWjw6Yif0wPUQuiAnllq/OriH1xDz4GOuhk2evBu8O0vrVFFUoe6
	 l7j3JKMfahU4Wgc2RlfAYrivOA0AfpIxqQlH1BwS7nqEKp5peMtfT/aj9eZhDRRFpu
	 9i5p0aG++UMVWo/gSknE3OVLdxsWuJFyGaZM/44ooGsXaXVsE03RzdGAjZNmT29tpK
	 yPMgaqZvTWtJMXRPSXwGg0pPbMhrH2w+l7Qwtw9UDZK6adERqN1u1f4oQw4uFty4Jv
	 LQX+oEP/5pUfvjrQyIpKV7F2hXsNVP5QQaVUmANYe70sMWK1NuESDv0MV4SfDGpUVY
	 iAo48vQVcZ2uA==
Date: Fri, 19 Jun 2026 20:18:01 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] c: handle .ACCESS_WITH_SIZE in build_unary_op for
 !/+/- [PR125604]
Message-ID: <202606192017.EEACA7B@keescook>
References: <20260618195646.it.067-kees@kernel.org>
 <202606181328.ABB25F969C@keescook>
 <c4217b162310997b0a64603219543cc00ffa2227.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4217b162310997b0a64603219543cc00ffa2227.camel@tugraz.at>

On Fri, Jun 19, 2026 at 11:36:10PM +0200, Martin Uecker wrote:
> Am Donnerstag, dem 18.06.2026 um 13:29 -0700 schrieb Kees Cook:
> > On Thu, Jun 18, 2026 at 12:56:51PM -0700, Kees Cook wrote:
> > > Unwrap the .ACCESS_WITH_SIZE call at the top of build_unary_op via
> > > get_ref_from_access_with_size.  These unary operators consume the
> > > pointer rvalue rather than the pointed-to data, so the bounds-checking
> > > wrapper is not load-bearing here.  The assertion is retained: after
> > > the unwrap it documents the post-condition the rest of the function
> > > relies on.
> > 
> > BTW, I don't have commit access, so if this patch looks good, I still
> > need someone to commit for me. :)
> 
> I committed it.

Yay! Thank you. :)

-- 
Kees Cook
