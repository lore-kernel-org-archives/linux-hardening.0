Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D9339863;
	Fri, 19 Jun 2026 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901738; cv=none; b=nCft58H5o/o7edZav/dknv1rTSwYeBouwozw0iV/3bysFhvL/etq4C03aZu600OhMJYnl/Oi/8QUVyHPMjFIfvtxO4rZYBPodqASwmd+jggnX0eEMDto2HU83OuPtJ6dsshFCLK2hmtFJpLlXxnId/icttrNgD5Wv9WXn2dF1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901738; c=relaxed/simple;
	bh=WQkHaHfppY+JrioWAWRLySYBPUVgtlqEdCDTHMI44pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJP8PJENDUEHB4qn5jNIs4SIy39I5JWLctc8PzYlQVkStxTEZzJ5Ljg7q7rSeONw6Z/0mx8YGEzCSHW0TJIPHGRPSjnO1FiZb93M+kz6IE73MOzrzzJDm93/RdmLU1kDRhDDCGdPQdjNJkr/GvM8ajucF25REbPt/NsrrVmnv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcfDq0cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcfDq0cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BF1F000E9;
	Fri, 19 Jun 2026 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781901737;
	bh=YlqWhxUFSukaEQcGQE+sukpp/6vziaWKA2M2Y+DaymY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PcfDq0cqb81d8xOraR5rn6S9rzhtmb69B47R7GJHqfTvo0w/Z2UZuKB8fc8VXa1n/
	 TboTJkLtPw8qxOn/kfVPdKdtrxg8KE+fESwKPjiczBVFkp6ZLQt9YGsje/NlgUNvDO
	 eQZqRPFuOm0MNfLf+3tRBeP+8Qp+7cKG3BCR7Nd1tUF/4/U0vhO1ZNuxCkZjhjyfvF
	 i9I6nfrDQYfCoB6zMVhw2p6v7IPUHjYM3rSgUs8iPvuuEUVMLGwL09cEvoE2S9cJ5N
	 4OaUippEPlAE14A4MUnVkkO6TaZI+U3MwdhzGCD9xDEAEVSbULpxm1GBliQdQ8wI9d
	 tCDSGQereFDfw==
Date: Fri, 19 Jun 2026 13:42:16 -0700
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
Message-ID: <202606191341.05539A72B1@keescook>
References: <20260618210946.it.538-kees@kernel.org>
 <20260619093708.GT49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619093708.GT49951@noisy.programming.kicks-ass.net>

On Fri, Jun 19, 2026 at 11:37:08AM +0200, Peter Zijlstra wrote:
> This is really rather horrible. Also, now all an attacker needs to do is
> ensure cfi_kunit_handled() unconditionally returns true. IOW, no distro
> must ever have this KUNIT crap enabled.

Isn't that already true? I thought, like LKDTM, nothing ships with KUnit
built in?

-- 
Kees Cook
