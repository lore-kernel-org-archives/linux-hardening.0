Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF536404F;
	Fri, 30 Jan 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794483; cv=none; b=JD3OqYO2Wcw2IiEIoS2nDpDQun8JM/SHCtKAAZjpHoVc9i+/olZWkaMkkgRkEGVqOSsNYxtcMWQeKZhrAtc3uGa3UwEOTN7IcieiBas2D6jt0c855hDXEiGL+298uymI45UrLzCdkev6ci+mK5jJqikjPlZ6GCfTiJyWDT0db1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794483; c=relaxed/simple;
	bh=x25+ZfEQbzsm0yMDiYSBy02gtq3nzHW/g57iJTgC8dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcKHB1l2GuDwW6ZZCeupQGUkOzmlO2URZbRrfhj0y8Yjh79VwM33plxGMTpm20WixipoiXo2RCykR+9qTU+jv5iAdZBtn4eneQWfTpZGod//vQbtAylUrtTg3fPLUxjwM2L3pP6e218RF7S6ilnSeF25lOJkWXyCDYE8AuG5JT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYNOs0yJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYNOs0yJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8B6C116D0;
	Fri, 30 Jan 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794482;
	bh=x25+ZfEQbzsm0yMDiYSBy02gtq3nzHW/g57iJTgC8dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYNOs0yJD5q1aPU7ES7QDn/iuLkhNQCSK1/POKwci4Tq4PNt29b633/1dLaBtLobj
	 /Vgj/5rfHOnvvbpudhVbzP+D4KgwSjkMA5uPxSRyyyRpiEiKekIRMV9R/XAvrCpVkm
	 VXiGbrGK12ZwrZ1Ikx+WiRKu4FtbvJM0hsXKotqaVzKwMPSiLRgUPw8j6q1272IKYQ
	 xeFpOETN0pfwQuUKhrgI/d+CdcunScydoApRukF8ZHhj8S/2PZjY+NzAPteuRQ7I6F
	 942Zl7R6CjtvSru5HyLkv6HJMMgBTI5K8IfzE2uoRoNwI5UMR8xmxXEJZHNLC/s6nX
	 QhsdBA0pbcLQw==
Date: Fri, 30 Jan 2026 09:34:42 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
	linusw@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/8] lib/string_kunit: add correctness test for
 strlen()
Message-ID: <202601300934.62F91F79@keescook>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <20260130025018.172925-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025018.172925-2-jiangfeng@kylinos.cn>

On Fri, Jan 30, 2026 at 10:50:11AM +0800, Feng Jiang wrote:
> Add a KUnit test for strlen() to verify correctness across
> different string lengths and memory alignments. Use vmalloc()
> to place the NUL character at the page boundary to ensure
> over-reads are detected.
> 
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
