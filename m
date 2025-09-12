Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE2253939
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658060; cv=none; b=SfMrPzlYDceSlR4w/DzubS+Tn7RQF9xBPl66lyMSE0VB8yJyJV2nfY22ydiyDuA9f8dLm73xaMglr30wGkQqz7BR7gZsO9SLYYLlUBcSjS++K3ZarCvW1Yj+vtmzXHSXKk2x80wzMzpdo6PDw3CdAOlXD7JMyNsPvTQO65aARqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658060; c=relaxed/simple;
	bh=m8xVWYpYdzWr5yACgRan8GbW0RIwsDDTd5K8A39lMDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4aT4eMX0l9UFWe/jwRPMYcIUuVguCSNihW3R31eDV53HVfoyk18RKBpDomD7aBL+KdBKjXP+1kL+f35V+vjE27CkcNPWMB5gOBaJZBugipxIZaq3PPGA1KvECUip2yR9Qfj4a+Xf+5GjfuhAOVdhjd7A0wC2XUNhasTycSvhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSXE+bou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSXE+bou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8065EC4CEF4;
	Fri, 12 Sep 2025 06:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757658059;
	bh=m8xVWYpYdzWr5yACgRan8GbW0RIwsDDTd5K8A39lMDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSXE+bouQmwRaM/62KSRGHZ23Nn3fdpm7mplbCy1z9CXv6qpVFPUIsssFZkzgxs1v
	 HHDz01vzNJaKzaaObgx3zmC7kz46umqAd5+ocCo7oDK05KlvIbbSm6FLYzzJPA9tJW
	 +4LNgfMG2LyeK+CVQfBbOQmkRl7UzndlwqZk+Qj55DoYy5NTwm8yWJW9aUn1YarAUv
	 QeyIrTy13LcVBWQsyWS/Oo7XGi2ClL6KPfcs2Zl76//iw8T+egZAdHaLgLX+hvHMj1
	 SHYkXKnXoKqfSV577sUlaZvU2iozoBSCWxLH1uNqpB0sBsl9+FA792XAbKWn0DAwob
	 sAsV+RlSVPTFw==
Date: Thu, 11 Sep 2025 23:20:59 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
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
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509112320.33247B0@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
 <202509101705.92474D66@keescook>
 <20250911072935.GW3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911072935.GW3245006@noisy.programming.kicks-ass.net>

On Thu, Sep 11, 2025 at 09:29:35AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 10, 2025 at 08:05:11PM -0700, Kees Cook wrote:
> 
> > > > +/* Check if a function needs KCFI preamble generation.
> > > > +   ALL functions get preambles when -fsanitize=kcfi is enabled, regardless
> > > > +   of no_sanitize("kcfi") attribute.  */
> > > 
> > > Why no_sanitize(“kcfi”) is not considered here?
> > 
> > no_sanitize(“kcfi”) is strictly about whether call-site checking
> > is performed within the function. It is not used to mark a function as
> > not being the target of a KCFI call.
> 
> I'll once again argue that __attribute__((nocf_check)) (aka. __noendbr)
> should have that effect.
> 
> If there is no ENDBR, then no amount of kCFI preamble will make the
> function (indirectly) callable.

Oh yeah, sure! I've added this for v3 now.

-- 
Kees Cook
