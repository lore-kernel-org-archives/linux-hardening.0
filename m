Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA09285056;
	Fri, 30 Jan 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794491; cv=none; b=qexq4VJ2aywC3/2tDTukaboHE3KIjESU8TUTp25zjZOdDDIaEDx2835a0I5XgfTPe77dU+l+aEDeTDcqsoJCwWM1Xx0w5tiHkKsgL7cq5lgfqmuOXS6ALcqKnBhQEfv1GTUojXTbekKKfk6GBRV1V0oa3z5/VZ4fp52qCy7LGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794491; c=relaxed/simple;
	bh=1TKfjAm12XOvM0K5C6eA86Bn9vgJw3DhIQ7HuUKNHo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8nC9synvOE5rPz+SuUQP13veul64QX2HhyKILrttgujQ85Edg2SLku2E5Rhi0PKHkYzbc1ziGJK6dkkhEqGEBFL8QpTZBkv5vmei+DbhNasd7y42tGVkK1BGY6l1Drar0UGcduMjt2msQ/Awpb1XLpOBrGYdXlRO75H0odGf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS/G2kgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS/G2kgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C5BC16AAE;
	Fri, 30 Jan 2026 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794490;
	bh=1TKfjAm12XOvM0K5C6eA86Bn9vgJw3DhIQ7HuUKNHo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS/G2kgWqt4OEfQ2Wi9NTQkrSFfXvXT9o/ZRT9grSwMLe01WfLW+aK7UJTCRcc84t
	 2FekKoQgLwAC6x69Zv5d/4qvQRCO0Yrv5Dk45i4jVNLjDDQjMnLAdaT9yFWsHkuO3Y
	 taFJ0t2aWBsz+BWYy3aRaX0SYR56xx95EFZ8vqkhv9PvVXMH5fx4JVelgyj++vBDo9
	 lyrUNFjMeourtGFfaWTgzrQy6jAnDAgDvW7SbddBEZ0OJGM3cpzKkoajGxHVWsRntR
	 3gykFSbFcmummwoPqGER3bH0bLZGe6QoriQ3irijXyPEkOWadiEvPLOZa27Gky1xm0
	 pHR0vt611eNnA==
Date: Fri, 30 Jan 2026 09:34:50 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
	linusw@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 2/8] lib/string_kunit: add correctness test for
 strnlen()
Message-ID: <202601300934.A203EB29F1@keescook>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <20260130025018.172925-3-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025018.172925-3-jiangfeng@kylinos.cn>

On Fri, Jan 30, 2026 at 10:50:12AM +0800, Feng Jiang wrote:
> Add a KUnit test for strnlen() to verify correctness across
> different string lengths and memory alignments. Use vmalloc()
> to place the NUL character at the page boundary to ensure
> over-reads are detected.
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
