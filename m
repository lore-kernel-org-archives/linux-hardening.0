Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F71E47CC
	for <linux-hardening@vger.kernel.org>; Sun, 21 Sep 2025 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472490; cv=none; b=TQbK/ww4azWRn/T62qn1wPKDuN+8P9ndxtEFLQZV5tZoP41vnhkyN12XoBqBqEcP2UfYwps1VHHNWyIZN/gN8UHSu04Dpx9kGzmNO5P8y1gL/Hdr+myazV1udhodMf0tO3zNw4c4L3nXrnPy6oeJTBmAUhfAvwDhwbGUd7lbBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472490; c=relaxed/simple;
	bh=77rmfH2+36RF3m4h8R4ZPYEVfeF61BXV0wsWEEOish0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cEZd+1tZz1G4b+TGtihnlvngfzLrPDYT3pFbXfm9D1yi00BsoNXmx2Vh89eCWGTV7RiV1dYZXK2oaKKtzNp8o9UCg4e454HZX15g1oCndabfUHC2fKq2d16tJRXPCjLLID0lDSNdagLlig996gFWXh9ub6Nvb34yJcy0nonv2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=BoUUb58L; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="BoUUb58L"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B6FAB240027
	for <linux-hardening@vger.kernel.org>; Sun, 21 Sep 2025 18:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1758472479; bh=8BNHeNkmB7QvFsiJjJvL4UFVSn8BRJCK12XbcrTGhL0=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=BoUUb58LslUUa4cCfMJWWF9Emdv/qwmZp6Vm6NActKevh9gfoqrL879/2wptJmjkn
	 jlSsBjc/D7gDru2PcdpviFs3KXN2/fE/FwOaKX/vbNfuTAAHFmcVwmNsGyvmWZV7en
	 akCwmkgktUKPLUokY1asqfGk2r1x9TLwoolPWnrDSPaiG14d9DxPAUOahDIORpFuPj
	 /hJEHWK2N5t3qcCyZOA1s5ZEHprWH6Ymi+dLwHTur5LzOrveLoLxi+RKuJnEbTuqjC
	 dZjlerfr59pFW4tcvTSkQR9NIKOtDViKnNodVamDT6eEDaeRf2DWWtC2kSEBAYjiY5
	 Qxt1ffiilGL9A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cVBfR1pRRz9rxK;
	Sun, 21 Sep 2025 18:34:39 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Sep 2025 16:34:39 +0000
From: csfore@posteo.net
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Remove =?UTF-8?Q?TODO=5Fverify=5Fil=20fo?=
 =?UTF-8?Q?r=20GCC=20=3E=3D=20=31=36?=
In-Reply-To: <20250920234519.work.915-kees@kernel.org>
References: <20250920234519.work.915-kees@kernel.org>
Message-ID: <7197a8084bece89e3eabeaded3a2741f@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit



On 2025-09-20 19:45, Kees Cook wrote:
> GCC now runs TODO_verify_il automatically[1], so it is no longer 
> exposed to
> plugins. Only use the flag on GCC < 16.
> 
> Suggested-by: Christopher Fore <csfore@posteo.net>
> Link:
> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> How about like this, so it'll still work on GCC <16?

Sounds good to me!

-Christopher

> [...]
