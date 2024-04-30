Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D0127B68;
	Tue, 30 Apr 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468906; cv=none; b=WYdKxHnbmVWtA5HphW/pGQwXF36az++V/rmjkhnOqUsUeh2aUr21uX1FagXMnD7tF/7T0mqzGK3Pf0WxaughC9e4/Pk9neVpomW8/4BIMi4L8t84Z2TUFTVv2BpJudE6j4YbwBdmaCxu4AUlXAc/h4oodXAI7Afk6mjGqtsQROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468906; c=relaxed/simple;
	bh=TdZNueaaPKLCguGskYeGbsKIkL8BHJVTSoWgSzU9fJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3st94ESGZE1jAdpawcvEaoY3ufMgw5RhIgBBhwx/7wNx9HLup4aFKE0d4DqiYA2zqhjE1dXHaaJui0wRGOyn+EjShAlgXTHhrKMTxM91UyoSIQK9m9gV1ReKszfP8o2HRHS+oUASevOtknGD62mz0LeHx6urtuFzLwnk6E9mKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DzD4eUtc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DzD4eUtc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bHkTSQnGuEaomY/gWdm3ngyCLQOoVPGkYgrv4PBOIGs=; b=DzD4eUtcf8dJCc0qMaoSFOZzI2
	9fKRjdp2FjnOVJYF70fF+0yOb5bx6/Aee66eQcrH8aJo3ykyg4XA7lIDg4Cr100P48sv3zckiG7/o
	4LajJN1NX9hTsvzyyJPQLkg4kCLMGjxRk3f1ks4mpm2tRlECRkGnWjXAjN/BstK30FJejr0G1phAC
	2osHNcyYnNEgHogICgVFOqb1qXicXSgvDpswTImy9O/GV9oCkeBWfb7MMR5BFk4oSkMBOFF/J0M7W
	ZKSDmvLCwJxVfbmrJ00mzF6YJxfbxv7fXXc983QOIxCtO/jZAIH0bV3eeXo82JEj7sJ7fqEc8cDqN
	sUojJiBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1jgC-0000000EUWI-2fQc;
	Tue, 30 Apr 2024 09:21:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4F726300684; Tue, 30 Apr 2024 11:21:40 +0200 (CEST)
Date: Tue, 30 Apr 2024 11:21:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <20240430092140.GE40213@noisy.programming.kicks-ass.net>
References: <20240426222940.work.884-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426222940.work.884-kees@kernel.org>

On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:

> - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
>   it isn't as secure as straight KCFI.)

Oi ?
