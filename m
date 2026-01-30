Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13836403F;
	Fri, 30 Jan 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794499; cv=none; b=DTMzVE8/WMKRuZh/82OMHHTKQ6gJmeBQgDzaX4N6Yp6C5WN/ZtY3wk4DNnP+ZpCn9WxNyK4k0n0sD3lsSSXfHdrYvKbhS1yGRAXr6ZU9QKhQxZnKFO0dXHzehCSo6nq6GekNrZIdAfnsvXBTrXVhHRlxGDGYZ7XQecxjxkCqZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794499; c=relaxed/simple;
	bh=8v38Q7y1AW8X9FCs70T/p5dLlx+upDIcVQGemOeQ3n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8zWBMVR4FnGf2BgCfeugPgZ5mXBtRk0auDPc+NAVYWPw4/shAJm6RRV/w6WSx7ITdLiws4Z5RC2Pug1ZSTL4GwlglzGaPZXITBgUxb7CUrVxSyb54dZrInc5KdoUxZUQ0MwmDH21o//WGX9g41pw+l37u1m1cQlf4j3dlU42uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTToV4h2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTToV4h2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F0DC4CEF7;
	Fri, 30 Jan 2026 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794499;
	bh=8v38Q7y1AW8X9FCs70T/p5dLlx+upDIcVQGemOeQ3n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTToV4h2Z4IwrBeV+5CDYrZWTkQdsuiBKmx2qD04KZUx6VAOJCnaJ5vUXwz8sgxJ9
	 GZFfT7t8sYnK2X6yByfMCysNGQvP1epPPjy09umI/HiQiLD0O4APeadOvNXk0NGPEp
	 Z9K4UG0vlTb5/UftewnhGcrNBI4ypyeFxqpPI6776t2lD8uTlOQKmS3Y4RXtpu3wPA
	 AOEPVlgo/f7ZCh2KuQauiqXy81Fs1umG6cu18yHJI1MaExFyHJTQhF4E0C/8hzmMIY
	 333jRxNhsutH1gaJIxWGo7Gc1bUnizmCxtelGeQ++EP6LaxBoApSgQJALKgvvzUZ5j
	 aD6Udh8Lo9XMg==
Date: Fri, 30 Jan 2026 09:34:58 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
	linusw@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 3/8] lib/string_kunit: add correctness test for
 strrchr()
Message-ID: <202601300934.B3376DB2@keescook>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <20260130025018.172925-4-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025018.172925-4-jiangfeng@kylinos.cn>

On Fri, Jan 30, 2026 at 10:50:13AM +0800, Feng Jiang wrote:
> Add a KUnit test for strrchr() to verify correctness across
> different string lengths and memory alignments. Use vmalloc()
> to place the NUL character at the page boundary to ensure
> over-reads are detected.
> 
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
