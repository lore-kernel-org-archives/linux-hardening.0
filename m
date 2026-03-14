Received: from hannover.ccc.de (ep.leitstelle511.net [80.147.51.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175B1A6802;
	Sat, 14 Mar 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.147.51.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773496812; cv=none; b=Q6NFwmuTG4kYHjkGYizyVIdISSosdjSVWCyvVUGC60bL9hK+VkOnEyl9uipKcgMsx1PDq3kxzo7xS0RBb8xCV3qIZdtsJWa5b/st7ApowKqn98Ua6thjxTOAk8aG5QMT9rTPHJyrV8TlKzwbHgg9j7Fz9sw/+LO/FkLp6fgjj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773496812; c=relaxed/simple;
	bh=nPOPUSdC/nJsQIvKVXSQeqWbLPrynjhbKzviV8XPYB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOsNanY/1xu7vlyAQ8f+GRGaESY0EZXZhAQP/ceISxJaqzFVH8YvHYF6zsVpG+KycrK/gZyeA+Lpn/NKHeIhe5jkVdjdrXsQghmr9h7ag+ielCTmd0VOvAQS8pPhD0oHlFHFcBgjQSzWI5sxSoO2MrLLCBehCkuP00GuJbb49c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hannover.ccc.de; spf=pass smtp.mailfrom=hannover.ccc.de; dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b=hpaIzyPB; arc=none smtp.client-ip=80.147.51.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b="hpaIzyPB"
Received: from spatz.zoo (pool-213.162.156.104.dynamic.wobline-ip.de [213.162.156.104])
	by hannover.ccc.de (Postfix) with ESMTPSA id 23E8C20D5D;
	Sat, 14 Mar 2026 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hannover.ccc.de;
	s=ds; t=1773496248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjFZ9E4yiiL534rj7We03jiXtSfhm1D/S7YnxMWAsmE=;
	b=hpaIzyPBwjHspLfDidoY4RvLpek2VDjiuxQauBujmAHWn6819LGo3EZ52htGa5rdHEamlk
	91Jll0YmtlSWUlAoEHdyhMjrw/LJsPOwWnFptquLsvUukiJBBMY1B2XkDpxJJInALLO5lq
	HNqvGZTPhMONTWNU+oBwVXkkXvVpQKQ=
Received: from ingo by spatz.zoo with local (Exim 4.99.1)
	(envelope-from <ingo@spatz.zoo>)
	id 1w1POA-00000000h2E-3OIk;
	Sat, 14 Mar 2026 14:50:46 +0100
Date: Sat, 14 Mar 2026 14:50:46 +0100
From: Ingo Saitz <ingo@hannover.ccc.de>
To: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Build error in next-20260223 gcc-plugins/latent_entropy_plugin.so
Message-ID: <abVntmj9O7uXnES2@spatz.zoo>
References: <4051116.1771996801@turing-police>
 <202602242333.24E5CB214@keescook>
 <4147110.1772032451@turing-police>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4147110.1772032451@turing-police>

I get the same error with

    gcc (Debian 16-20260308-1) 16.0.1 20260308 (experimental) [trunk r16-7949-g6c5de6335f5]

It seems gcc removed the CONST_CAST macros in gcc-16. CONST_CAST_TREE
got removed in commit c3d96ff, CONST_CAST in commit 458c792.

    https://github.com/gcc-mirror/gcc/commit/c3d96ff9e916c02584aa081f03ab999292efbb50
    https://github.com/gcc-mirror/gcc/commit/458c7926d48959abcb2c1adaa22458e27459a551

So this does not seem to be a gcc bug, but the CONST_CAST macros being
gone for good.

I attached a quick patch to get the kernel build with the current gcc-16
development version, but it still needs to be guarded against different
gcc versions.

    Ingo
-- 
const_cast<long double>(Λ)
