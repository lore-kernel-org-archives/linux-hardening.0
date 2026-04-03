Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E433C19E;
	Fri,  3 Apr 2026 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241036; cv=none; b=jAg4LugCXlqx/C3l75lYyjQYmVO8S48aqf5/YjbGgLZSz4jJ4tLxeuPJjrjra5ExMphNaAdwINMucUETwMPXVURGu47j6ayHjHO0XnNmbTRZFHJ7747QMKYE1fa9d/RXDl/mOO1xtNERfgzpURt9B2+8zSd0ukqHkvQsc5/yI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241036; c=relaxed/simple;
	bh=ZxDxHuRXsUksBWz4VNVFLZCmFXgaegcpougScwFOAy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O3bED+hey0DxNDnVKMMzxhTtaPDk0WNE49t5hwP7DPgj5im19oeqkPuKzydHLENOU/mqN0AJiCJxuwCCGv7sTboCBHOjF96eqbCJ+uT9YS1lfracDnpZtePSzyP3T3xAVKvqFX0Ui3V/THbAxIDVmnLFg1EbxtCy20IYEoBM4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux+tH3IC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux+tH3IC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BFEC4CEF7;
	Fri,  3 Apr 2026 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775241036;
	bh=ZxDxHuRXsUksBWz4VNVFLZCmFXgaegcpougScwFOAy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ux+tH3ICNYp/eOEhmiKgPme9HUPekC/USQXOK626zkVNzEBRu1Mw1LwxuYmhGas5j
	 c2HZwVND0rpqDuOuDEvJRCrctASGeoEv97V3vcUZeOA23ln6UCBaMixQUYTfCdEHb/
	 aeVOtg0NAzi6/iD8qhv9LjM3CXO3lPixhmmqk2NHBJCwjX+PDZ/kS3dDwwpfj51oXa
	 lJWuM6Nb5A/3I0qEStkLpSVXtbolJAMVd2hero8GmE0dxawiIX/WJrlM4I7NyGgVBp
	 xguMmO18cPUfwQ1d6H9JDNgdDUB0iAMdlGKozhnl2m+9TJSApAlNUzpARIkq6fn6X4
	 AbiaEopINPwzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE923809A14;
	Fri,  3 Apr 2026 18:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/8] riscv: optimize string functions and add kunit
 tests
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177524101803.1406513.15222599050806931246.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 18:30:18 +0000
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
In-Reply-To: <20260130025018.172925-1-jiangfeng@kylinos.cn>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
 kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, herbert@gondor.apana.org.au,
 samuel.holland@sifive.com, ajones@ventanamicro.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
 linusw@kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Fri, 30 Jan 2026 10:50:10 +0800 you wrote:
> This series provides optimized implementations of strnlen(), strchr(),
> and strrchr() for the RISC-V architecture. The strnlen() implementation
> is derived from the existing optimized strlen(). For strchr() and
> strrchr(), the current versions use simple byte-by-byte assembly logic,
> which will serve as a baseline for future Zbb-based optimizations.
> 
> The patch series is organized into three parts:
> 1. Correctness Testing: The first three patches add KUnit test cases
>    for strlen(), strnlen(), and strrchr() to ensure the baseline and
>    optimized versions are functionally correct.
> 2. Benchmarking Tool: Patches 4 and 5 extend string_kunit to include
>    performance measurement capabilities, allowing for comparative
>    analysis within the KUnit environment.
> 3. Architectural Optimizations: The final three patches introduce the
>    RISC-V specific assembly implementations.
> 
> [...]

Here is the summary with links:
  - [v7,1/8] lib/string_kunit: add correctness test for strlen()
    https://git.kernel.org/riscv/c/abd6819bbf5b
  - [v7,2/8] lib/string_kunit: add correctness test for strnlen()
    https://git.kernel.org/riscv/c/31a361f466a2
  - [v7,3/8] lib/string_kunit: add correctness test for strrchr()
    https://git.kernel.org/riscv/c/68768cdba710
  - [v7,4/8] lib/string_kunit: add performance benchmark for strlen()
    https://git.kernel.org/riscv/c/54a7a0ca4b60
  - [v7,5/8] lib/string_kunit: extend benchmarks to strnlen() and chr searches
    https://git.kernel.org/riscv/c/d52a2222768b
  - [v7,6/8] riscv: lib: add strnlen() implementation
    https://git.kernel.org/riscv/c/018ffd93d25f
  - [v7,7/8] riscv: lib: add strchr() implementation
    https://git.kernel.org/riscv/c/bf74efe28f7c
  - [v7,8/8] riscv: lib: add strrchr() implementation
    https://git.kernel.org/riscv/c/3dcf058583a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


