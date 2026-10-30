Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793387204;
	b=mN2H+XNNbQqde+VvT7MUietKkHW3Q6QUi+5kqGI1Vrb9x3clh9GYl29aUnD94anLqgEa
	 S5VED8LcGJYAvEO7hmYN86oPeDdiRpVnKcWxvyhwweY6pkJ4HQZTh/ULU/LBD6pKGmQCX
	 iY7HJepcI/rvORl7e56eN5Gd+mx2zDPm6UNGDzNybv9yjBOsdHADqXIR3j28HIPLiUPjr
	 BzgB0CDUJESFinYqwDrJa0qp+F23nqB1Eo6VHAjLQeUwK8tcVTjlQ1HmVcZJemGAv/ukS
	 /60jNE6IFXqPWx2w1M8db5YHShw+ss0r8P1iB86GhlNbEt5/SdwUGMY2ON110y7oLDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793387204;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=igS9NIjqOfUuXPFoRBs4EfzR/DCNQe96++qaiu7rMb4=;
	b=3Vz7wsBMG7d/64z8HY5OaZ0rnX2EuHoQ7POKnn6M1NPcm4wpKyqS1+/N4Y77qRwd7jVc
	 mXV9vx2xtmoWJ7s397p6BJ8e2iHoL+UIli2E4Bhwr08vz02f+t31JldJhpNw7nJeRAZSS
	 0rG1oV47Exl42kelLtYqPAKgqDnlWK79miNZ8rvWtgFxuaFbsRlKRuiGNBi1xslibl6sp
	 Y0dyMcXxeXl/5bcIbOv3TLHtkju92NNbo1jYlNZLVT0lReHLfovJ+rWQSkwlapyjTPZkI
	 ezyT1rR6wTkjRmQCj7e8PQ8HO0dp5jB62H0ctpTcyyff5nEfCr3qGxJ7K1OF6Lc19Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfSY0Ojr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C73606A31A;
	Fri, 30 Oct 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QfSY0Ojr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E15A1F0093A;
	Fri, 30 Oct 2026 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793387203;
	bh=igS9NIjqOfUuXPFoRBs4EfzR/DCNQe96++qaiu7rMb4=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=QfSY0Ojr0sFQ1mFwZ2i26Xl2HA22T+mXqL3M25S7YrxJpnAO2ggABcqyFicaxFtL5
	 JupaOvol2LGHtrNAcjAbAhcq91KVQmaS/CCPOrbZ0e5KvqhGAzywTXEkm+1FwqFHS1
	 dY7rMdcWR8gafaSOh6UPVCS2hX5A9QurMlS0vibQ/WPpBajdhAj1uQ9DBm6DhCqpb/
	 QKMW/5nB2hoboY9GTQmkknjL0kjc1UzBjEw2f1urX7xORD0kXXNKDwkqnr0jmDAFdr
	 lze/2kkPdbL69MzdXIFExw7KId6jkHEKMAtjkywVenlRlUGWqdnVt4gzQF7X/YdzHe
	 wQ8ZxxFX7aCiQ==
Date: Fri, 30 Oct 2026 12:06:43 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <202610301206.5E80A3396A@keescook>
References: <20261029053250.i.220-kees@kernel.org>
 <auMwo_T_FsZp5UsB@devuan>
 <20261029091845.21464a1a@gandalf.local.home>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029091845.21464a1a@gandalf.local.home>

On Thu, Oct 29, 2026 at 09:18:45AM -0400, Steven Rostedt wrote:
> Hmm, I was thinking that this should first check if the string is already
> terminated with a nul byte. Why add another one if it is?

Oh, ew, yes. Fixing...

-- 
Kees Cook
