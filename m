Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B43DD52C
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037832; cv=none; b=jrWebmQ4cv1zXttxg+/Hk0o9nBALjBiRvjYnA6Q+WZ4pqeXrTixss4K9/DdfjRvXYGtghuobksDbname/2S/vD+FPrZYIYkeisjbmvUGdKkiDgM1a3QPYO1WK2Sg8VcfRoxsecpZB1yZQDRtWNai24PUTqkh/Dt0SaeuSLgSFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037832; c=relaxed/simple;
	bh=L47v1qYcYUJeT2CaqpGyEU8mGhhYz5fMVzs69xNtNCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP1Ts+dnwhdTB+5a6D8maM6kqYHYc+iwD8ytrjTN728sWBLz2U9M5XaE4RPubJ4TpxpnqcUrvDmR4mqULy5C13XJ0zLZHxsgx3fbmaab53rIC5J8z1oMbNfGr2lfd5MVSm56Mc8flYSvtOHNQF2eudbQw2FQD8GMiDcs57fK8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbtKx9JI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbtKx9JI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772CDC2BCB0;
	Wed,  1 Apr 2026 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775037832;
	bh=L47v1qYcYUJeT2CaqpGyEU8mGhhYz5fMVzs69xNtNCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbtKx9JID1o8Afdksqhd51oIWlCK09+RbBMr4J36pVRCnxUfPkqOF/IHN9+vndjOP
	 NwYQZ2ng/y26oqDKDqtB3oXYoxuM6FhDF4mf5WM7VyycrBcgq0AfA9+89rLlT5Hf2K
	 q0k5z4XWER9GEoMx0YOrDNitlkTou5yScn+rrgqVqjS12kd+OGm2TdNNunNPz5gtRo
	 /TZRz7e91iolCyyQhuBzhQ+TOh+KzHeUlckDXIve8xdvWxyAC3diys9psf6WCVwooy
	 QcrhG25aU4jP9piqjA6wK2yuIcJsgXfjv/3WICqJujTwvStzxlfpD95LSu3IlX6MeN
	 LnWf7DCItGzpA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-hardening@vger.kernel.org,
	mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v8] arm64: Use static call trampolines when kCFI is enabled
Date: Wed,  1 Apr 2026 11:03:43 +0100
Message-ID: <177503506493.2514486.12265333685036392947.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331110422.301901-2-ardb+git@google.com>
References: <20260331110422.301901-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 13:04:23 +0200, Ard Biesheuvel wrote:
> Implement arm64 support for the 'unoptimized' static call variety, which
> routes all calls through a trampoline that performs a tail call to the
> chosen function, and wire it up for use when kCFI is enabled. This works
> around an issue with kCFI and generic static calls, where the prototypes
> of default handlers such as __static_call_nop() and __static_call_ret0()
> don't match the expected prototype of the call site, resulting in kCFI
> false positives [0].
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Use static call trampolines when kCFI is enabled
      https://git.kernel.org/arm64/c/e70c2335f889

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
