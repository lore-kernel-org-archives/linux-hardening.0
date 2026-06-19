Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E383B47F7;
	Fri, 19 Jun 2026 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901885; cv=none; b=PIpTw9OBrlwlVz5ozvddrNy/v2/xbRNQc1lxkMPUPd6UyevkIkOLo0QcF0cDSiVvrr9F8YDLa1vYp4wU2cSpz+QPiAx6VBmMJic5wfEpQFlBqYa8+PQXSZjZp8W2cqua5Dp9W+W7Lw6WaBN13DCPSTV2Nk1MKGQkYwKXZkZ8YuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901885; c=relaxed/simple;
	bh=2jril4KeJrTQM24Hmd2uC907CVKp7jfFjW0p+tpc5oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7LxCtgnN608DaFke389X/LMh/WwlzydwFtX1c6oNRD8e3ESo/hgK3aG+5jprF5DAg8lLDf7a+M+gBdlAPd7hRa5mcJbrrOnB8/HqoTSb0ELLl9zlaGXdH4Lnt+9Lpnczd20IIe8v6jXvLoTj3Nb/uN/d5nch6qz4uEVb8wrPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncVh11bZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncVh11bZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0E91F000E9;
	Fri, 19 Jun 2026 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781901883;
	bh=iELUcuNWKnAwsW6mb3dN+ryU/Yr6v0Ot/6JU8zvQzOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ncVh11bZHBSaNDkuKzqkIxrWX2FJgwK8VXZsoHV9GCVgSkLeE/Ph2tKIukWLo+Vfg
	 sCsEnO7a7FnjncFAgy0gtZuwN/lNkzlgHFPd30L+dXRXAt3KOQPVjzdP3R++2sBWvR
	 DhhLsiBewDrClue5yaif8pBF4ytrQMFnmkjBhEPkk7VIdFQlk6j51O3Z5JNOjlMCH1
	 ZEav/lAkS85zlupTZEXfvq2LIeTp9Jyb7Fyj/iUhtZKb8Arrhiw44L3hPtBcTN9WmR
	 N5zEJWFoBzYIGGE43HoUK4cHuH1ocYG9uX8xsvOIZcW2f3iku5Zo9f0X/9HptsHaDt
	 ypNy5nueCepfQ==
Date: Fri, 19 Jun 2026 13:44:43 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	llvm@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kunit: cfi: Add test for kCFI indirect-call type
 checks
Message-ID: <202606191342.E2B47A5@keescook>
References: <20260618210946.it.538-kees@kernel.org>
 <20260619093708.GT49951@noisy.programming.kicks-ass.net>
 <20260619095129.GE49529@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619095129.GE49529@noisy.programming.kicks-ass.net>

On Fri, Jun 19, 2026 at 11:51:29AM +0200, Peter Zijlstra wrote:
> > This is really rather horrible. Also, now all an attacker needs to do is
> > ensure cfi_kunit_handled() unconditionally returns true. IOW, no distro
> > must ever have this KUNIT crap enabled.
> 
> Also, if this lives, the check should at least trip the cfi_warn path,
> being completely silent is terrible.

If anyone actually ships kunit in production, then no, I will NAK my own
patch. ;) In that case I will go back to a version I never sent, which
uses Kunit's try/catch Oops checker (which doesn't work on riscv). I
only did it this way (similar to the fortify kunit testing) so I could
get riscv coverage.

-- 
Kees Cook
