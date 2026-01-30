Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF237756E;
	Fri, 30 Jan 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794657; cv=none; b=En3gy41GYFgEaNq5kWiVEu+vF4nN+Wrpi3v6peuVdyX0czx9NL5Xtz3PtD3sQyAaiTHuBigc4qg9Vxw9CeSCEhXHKx9KLL7u5lqxq2Rskbc9/Yi6AfiFkTAPHGRmjtapfscre/PeDMTwxgv9rb5KAEaqlfLOAraiI8dkom1N3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794657; c=relaxed/simple;
	bh=EURabUMH4lsCb1dCSFQMp+VQOndKCUfb9vC/+CetiwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNJ8LrJBXb+n9WHH7745TuSnSeEd4jmlirgYHLblUFNQkNjpooNrJMQ2nSUf1N0ggrYh1rD8zop1r2jT6hSuyb1mPgPGZwa5oPO3nHnIY5WdWocgmvlgcjFTGkRteQPMHvxCr1yfU19Sco0OC01eLaZOprUxfJl0GonqQ8gC5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKhWxTeb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKhWxTeb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652EEC4CEF7;
	Fri, 30 Jan 2026 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794657;
	bh=EURabUMH4lsCb1dCSFQMp+VQOndKCUfb9vC/+CetiwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKhWxTebYFBkWgr87V7M7d4jVbTl1IAC6z1KCKRbehsB8H2Cu6GdKiye5y2Nsf0QY
	 0AvuBrImpkjujpGczBynZQCGYIX2amIpiR3ZwYlyUwyd49v/jU6THnPDGaJYWF2Eud
	 Y7IOjEhhBXYYMJh1n7clB59Tz4g4tOnqhnBSPyuYm+FgHQpcu1NJZgPAMG9UJ/tREg
	 dQI4bF8rjtBu/xkicrEwvUFSXn2fYHRWsoWPkPvvVKpj8zIz/RhWwTuKi1+HhCraxZ
	 OFXwEh1EkhK/5DbA4csUmtu26oXBNwqICJi2Qinz/+xqjpFirVY2jUIcHV28tyRfDq
	 eTVQQkifEXX6A==
Date: Fri, 30 Jan 2026 09:37:36 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
	linusw@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/8] riscv: optimize string functions and add kunit
 tests
Message-ID: <202601300936.6EDA32E96@keescook>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025018.172925-1-jiangfeng@kylinos.cn>

On Fri, Jan 30, 2026 at 10:50:10AM +0800, Feng Jiang wrote:
> This series provides optimized implementations of strnlen(), strchr(),
> and strrchr() for the RISC-V architecture. The strnlen() implementation
> is derived from the existing optimized strlen(). For strchr() and
> strrchr(), the current versions use simple byte-by-byte assembly logic,
> which will serve as a baseline for future Zbb-based optimizations.

I'm happy with the Kunit elements here, so unless Andy has other
feedback, please feel free to take this via the riscv tree. (Or if riscv
maintainers would prefer, I can take it via string.)

Thanks for working on this!

-Kees

-- 
Kees Cook
