Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FD33438F;
	Fri, 30 Jan 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794543; cv=none; b=q1OFzfLh6cXg0wCjDwrdALJ+6cMhfXkrBj8ppKdK6owQ/lxlnPp8jy1HtTS216OyhCOQwtJ/G3+3aCpbGrnTpxz7/NO3QhuSJ9WtKoW8xxBSFaZCPtORaVxqaYAgKApFJ71WHZsb7aSjotN6lvrsXyr+KCv+jb2U+hRR1j46fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794543; c=relaxed/simple;
	bh=SaKj55VrR/smiJVBKISLVoRbusDRomzjDLiskxpkDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVKct+LP/WjR+1yzun5FJ3bQln/YtCT3QdPo9Ih2MSh4ZX9hapRL5M+7vuFEJoiprLTErOa0PHNPIYcseGFS2/U4/sPvg4dZzQ5WMQ58B7A7ysT8YlluD2FZAhFMOBWufY/0zSLQXV4/xrT9KwWhrDIEizeV2nrXU2NnuqbCRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfXH9/Uv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfXH9/Uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC211C4CEF7;
	Fri, 30 Jan 2026 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769794542;
	bh=SaKj55VrR/smiJVBKISLVoRbusDRomzjDLiskxpkDm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfXH9/Uv3HtBEGAGHWNXsF6NHtgm5u8iE0FN9iqCUrIi+p4l/ihsqU1flCKGsbw0Y
	 2DwhAS+FIXF1WmEbkSSOf8KjEtuZnm1m+IRNNChnSOV4BWVRoicxMaWJrkBzQiuXd8
	 EFyg77AcJxsdd4ROjmqBjTF0nzXXDVVAAEYVH8DZyKesGTCDTETkrqvApCpPtAbgkB
	 53vFkyWBftzoI4gkCeRQJcvsJ4L9coMC/WB2E12pF0v07yhyt+gd+xtALdmzc+jfRz
	 6Lx1M/ERkb9W6F5NMgvMiYBncHWKodAdM5odbzExM8KuJYGBGT0yhJus/AXsD0xBrq
	 kcsnYBHoIpybQ==
Date: Fri, 30 Jan 2026 09:35:42 -0800
From: Kees Cook <kees@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	akpm@linux-foundation.org, andy@kernel.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, herbert@gondor.apana.org.au,
	samuel.holland@sifive.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com, nathan@kernel.org,
	linusw@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 4/8] lib/string_kunit: add performance benchmark for
 strlen()
Message-ID: <202601300935.1473FDF851@keescook>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <20260130025018.172925-5-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025018.172925-5-jiangfeng@kylinos.cn>

On Fri, Jan 30, 2026 at 10:50:14AM +0800, Feng Jiang wrote:
> Introduce a benchmarking framework to the string_kunit test suite to
> measure the execution efficiency of string functions.
> 
> The implementation is inspired by crc_benchmark(), measuring throughput
> (MB/s) and latency (ns/call) across a range of string lengths. It
> includes a warm-up phase, disables preemption during measurement, and
> uses a fixed seed for reproducible results.
> 
> This framework allows for comparing different implementations (e.g.,
> generic C vs. architecture-optimized assembly) within the KUnit
> environment.
> 
> Initially, provide a benchmark for strlen().
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
