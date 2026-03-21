Received: from hannover.ccc.de (ep.leitstelle511.net [80.147.51.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97730F95C;
	Sat, 21 Mar 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.147.51.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774095933; cv=none; b=o01z8drXcuRGOBB+hjSgGHu4b67zrf2kttJCYT+2/zHPue4T1wnrgY2E7Wk6jsn/nS7ipLaFyK6if2vUBmybpxqexJ+wIPHVWeBaGV/+UAZW/Mr8KaLjuvRcIbgN/qhk7/fSgnMLKOB9/1CxTzoyEvdxGYDRxnJVqv/smfaHeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774095933; c=relaxed/simple;
	bh=vrtjFq6kXsEB79Lbn3rMW+IA8stMFsuitOT1F9V1Xjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1pPzuyo1Ha4I+oNbvXOoh/jLsVrCgiZOeprbXiOIjDfpzZdAP2CZO9sV3fxG6ELgPiJdnDI2lhY24lxRZhWsxdZLpMScrKB0e3DpYwD8m8a8odpB0Fle9RD2W2CmvsYyT2ipLCYoGQJPhhwyMarbfaxyoZOckg8Qz2r9AFyJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hannover.ccc.de; spf=pass smtp.mailfrom=hannover.ccc.de; dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b=CUncUOOt; arc=none smtp.client-ip=80.147.51.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b="CUncUOOt"
Received: from spatz.zoo (pool-213.162.154.0.dynamic.wobline-ip.de [213.162.154.0])
	by hannover.ccc.de (Postfix) with ESMTPSA id 75A6821859;
	Sat, 21 Mar 2026 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hannover.ccc.de;
	s=ds; t=1774095916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0pPSxCbJowZkLcfAqS3fAYr7V2z+aaA0vfb1al8/uY=;
	b=CUncUOOt8obGAChDxdZt/97kXmgZrStuEgv6RWIVnLkLopztt1Q6pnrXYhdBzDcpUX/f3P
	Aw+UYFclDYqoVKg4RolYExhr3MBafRF/IE2+M4D1sNhpgOCidIJ5jGan5afSq7yiVHCHfp
	Qczno6QaMiPoWKTzVHVXkHNCUeSlIbE=
Received: from ingo by spatz.zoo with local (Exim 4.99.1)
	(envelope-from <ingo@spatz.zoo>)
	id 1w3vOE-0000000097l-39mZ;
	Sat, 21 Mar 2026 13:25:14 +0100
Date: Sat, 21 Mar 2026 13:25:14 +0100
From: Ingo Saitz <ingo@hannover.ccc.de>
To: Kees Cook <kees@kernel.org>
Cc: Ingo Saitz <ingo@hannover.ccc.de>,
	Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Build error in next-20260223 gcc-plugins/latent_entropy_plugin.so
Message-ID: <ab6OKoay0OWkywjK@spatz.zoo>
References: <4051116.1771996801@turing-police>
 <202602242333.24E5CB214@keescook>
 <4147110.1772032451@turing-police>
 <abVntmj9O7uXnES2@spatz.zoo>
 <abV0OEcoN6H_QZEP@spatz.zoo>
 <202603201220.8E538CC1@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202603201220.8E538CC1@keescook>

On Fri, Mar 20, 2026 at 12:23:10PM -0700, Kees Cook wrote:
> Thanks for this!
> 
> Should CONST_CAST_TREE be explicitly defined instead, to match
> CONST_CAST_GIMPLE in the this header file? It seems weird to have one of
> two done this way: we should either do both or neither (CONST_CAST_GIMPLE
> is only used in the header file too).

My first idea was to simplay guard this depending on the gcc version,
since the CONST_CAST_TREE type changed from (union tree_node *) to tree.
But the typedef union tree_node *tree (in gcc source: gcc/coretypes.h)
is already there in gcc-8, and const_cast is an old c++ feature.

> Is const_cast<gimple> and const_cast<tree> valid back through GCC 8
> (earliest Linux-supported GCC)?

I successfully compiled and booted linux 6.19.8 with my patch applied
with gcc-8 (Debian 8.3.0-7) 8.3.0, so it think this patch does work with
all supported gcc versions and a guard is not needed indeed.

I tried to minimize the changes, since I don't really know how gcc
plugins actually work. But changing CONST_CAST_GIMPLE to
const_cast<gimple>, too, should not fail since that's now a simple text
replacement.

    Ingo
-- 
const_cast<long double>(Λ)
