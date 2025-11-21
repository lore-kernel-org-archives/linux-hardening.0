Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D6730E830;
	Fri, 21 Nov 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763767531; cv=none; b=nSvn84ggHV8Qf/XTFbvZ7F6uCCach7ueFjumUMP6JRs81bZU2aUnuzTMSzoxhNTIhKbxFvXdpXIHIN7z/fmstaQDbc6jWeCP6M2McHMXDLtdYhOzPbhX9Ph0Uf38q/+BRqUK3WOEIjfTwcCoMi0ywHvQHOV0T2pii2ngxHca83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763767531; c=relaxed/simple;
	bh=DeIy4nTOVUhoKGECoJ4Ka0U0L5wQJ/YDvfV1MGby84s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKRFIERujsJ28Ea0WhREZmpcEQjgJZz2OiBApbHcY9R1BGAb/X4zTsBv56hbFOL2IPnX2KTUQSPFYAGW0GYWZR8uTcUkfFfkwavYQytwZWfsTqoGwuSO8Nw0W1sM5QGBlhlXt+9tS4SBpVMUILkWOMCn7UadResIrPSGm6oMVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJMY0mRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJMY0mRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A1EC4CEF1;
	Fri, 21 Nov 2025 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763767531;
	bh=DeIy4nTOVUhoKGECoJ4Ka0U0L5wQJ/YDvfV1MGby84s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJMY0mRrfXv1zBwavr/5I9GFXHU6C/ewTO0LkeM5fO3podLvHhtPojXww990A3VrG
	 BrCT2bF25VAaIlmTi1wIx59QcKZbUKbMK6BBVSdYmSQMErSPZn0EIqR2k5+Z7TEykh
	 hRx6Qkl3NwoPKe5c0nCIAYvJBoZ2TNNABvcQEORLPFimYuRhmN+70I/wbGCX2iOi57
	 7i+aDatAqXZIy7rNvXrC++ZW6nPWBwH5yiND5RJgfYC+uqzegDR4OfP7nIRlbKXplp
	 x1+k3mIlpS/Ojmdn/tA3xwPUb0/wo6ii1G5PgV10XjP7oqhzuk77JHBSrKERDC382M
	 nOF5Z/N9C8EWA==
Date: Fri, 21 Nov 2025 15:25:30 -0800
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] Add __counted_by_ptr macro
Message-ID: <202511211517.539CD58@keescook>
References: <20251121193957.1655580-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121193957.1655580-1-morbo@google.com>

On Fri, Nov 21, 2025 at 07:39:42PM +0000, Bill Wendling wrote:
> These patches add the __counted_by_ptr macro and then uses it in
> mm/memblock.h. The name of the __counted_by_ptr attribute is the same as
> __counted_by, but two different macros are needed, because of feature
> skew in GCC and clang. Once the minmum versions of the compilers support
> 'counted_by' on both flexible array members and pointers in structs,
> this macro will become obsolete.
> 
> Bill Wendling (2):
>   Compiler Attributes: Add __counted_by_ptr macro
>   memblock: annotate struct memblock_type with __counted_by_ptr

Based on this[1] thread, I think we'll need to wait for GCC and Clang to
release with the "void *" support first, and then push the counted_by up
to that version to cover flexible arrays, pointers, and void *.

-Kees

[1] https://lore.kernel.org/lkml/20251021095447.GL3245006@noisy.programming.kicks-ass.net/

-Kees

-- 
Kees Cook
