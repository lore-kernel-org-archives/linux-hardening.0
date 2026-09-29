Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4D51C055;
	Tue, 29 Sep 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692162; cv=none; b=T36oxRdu6wdjOWiN4EpoRWOk7iN97/6bWtNc76qFGUdtdUAkhdbVGITeRSHLPubwNcg/OdgPKGEOCx866JG8HmhtoQwn48VJeBb6A1jDDXl5cANH5wal/oorQSRRp6e4/dqOj8ohLpRDB6q/l/9VT1Ohc3fC1vL6TM6EBR37spg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692162; c=relaxed/simple;
	bh=c7JKLLGBJ4W9natvSMtjGhRitb5bXn79UKbkKJHAr8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luHfCr92d9stbT00sH7ts0mwF1frxz5Hp+OUpKMHQ37C9beNRq4u0qTZyRzknYzUPr1pcvP4RPDKBsD16d7YH5uAUy/e/fB4GHLcI1Yt/GmYneieW5FsfpJ4Hbz18QrqRG2ci929OQ/epg9vIwUcDH/AH2b7QMx9MxMi7qyTcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WeQr6PeX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WeQr6PeX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=789D0DS4HptgG7dQNKI8879IPr8d+/FJ/fUaJM+2vMM=; b=WeQr6PeX5vTL6QlwUaf17qIUCP
	5A6fSYy2c594P12uH9psst3mUW4sm3jUuAOAdMSSN2C/G90jCi3Tb+ATZnhsAVN3lXa4UaO4K+glp
	yKVx1ewnjkG+UgLGPXtXIM95E70X4XzMR+QU3WwuwJjI+AuNz1wmm9SLFfD3fvj75X7f7FaNXnaTR
	QecTx3MrVzij+kqoahlLwZucuzCe0X2r1oHPWl2WJae17UXRf8xrl53pOeRw9c4P0iZRHJ3i/tkrq
	OnBAenTzmT9BPnBuEV/KgHXSXScWK6o2sy9BM9Lx46GZTFVcsxAdh21T7E/05y3Goj1+uqjnRqWrz
	e+mQFBNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBYpX-00000002joR-3pwt;
	Tue, 29 Sep 2026 14:29:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E42D7300446; Tue, 29 Sep 2026 16:29:14 +0200 (CEST)
Date: Tue, 29 Sep 2026 16:29:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] refcount: Use CONFIG_BUG_ON_DATA_CORRUPTION for
 UAF-related errors
Message-ID: <20260929142914.GD88198@noisy.programming.kicks-ass.net>
References: <20260812-refcount-bug-on-data-corruption-v1-1-c6da63566101@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-refcount-bug-on-data-corruption-v1-1-c6da63566101@google.com>

On Wed, Aug 12, 2026 at 08:56:38PM +0200, Jann Horn wrote:
> Some refcount issues are not necessarily associated with memory corruption,
> but REFCOUNT_ADD_UAF suggests that a UAF either just happened or is about
> to happen.
> 
> REFCOUNT_SUB_UAF is also an indicator that reference counting is wrong, and
> suggests (less strongly) that a UAF access might have happened recently.
> 
> In these cases, BUG() is appropriate if CONFIG_BUG_ON_DATA_CORRUPTION is
> set.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> MAINTAINERS specifies no specific maintainer for lib/refcount.c, but it
> does have an entry for include/linux/refcount.h, so I guess I should
> route this patch based on that.

Right, I'll stick this in tip/locking/core, where most all atomic things
go. Thanks!
