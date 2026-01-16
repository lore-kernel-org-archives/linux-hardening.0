Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F23112B3;
	Fri, 16 Jan 2026 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602377; cv=none; b=FzA5kNwaiscuqDzxH078tOGlOqppf2EmwLPsEiGJTHAPyFU9izMuFXk88NjgMUy5fZmZvTGo7/7clrjB+EjwP6cz+7E8zsfLcCsTkgGjTCy1hwlc2SHhtb10dqInoTwK1YtuJednSI6hqGyAaEzuiAcKzdL8kUqvAxPQxThqmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602377; c=relaxed/simple;
	bh=sTqxyKJH3dKWiBCmSsY7BEKWO7OsyS9PV0hMch6t1Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHDodzDHWob1u0leHeZN/WH1s0W3gG/2Au4OONoywQ4Sx3A5XL933Sb5n+bEORDKIL8v7cG/DoPTvGV+wtsVzLiq6oCd4UG40BSoAK3d9H542ZxIdCnppL0y9N4KP58kP9FoqGOQgQAgFJl1Q0dW8v/EFH3x98f0c12dfp7cmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OSzgW685; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OSzgW685"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cqzynFcQlXe5/Wecs/VcKZv8//Jyd8VZTPHid+9Oq/4=; b=OSzgW6857rdTK/n1xP6KtlYGv7
	6fI1O/0P3T6XvpMO4W0ngAfNtVHpNeavEbg96tLljIsfUHXf9sZGof9+B6cKnYyk1DM5o6yuWuCWc
	Mkm4k81N2vu5kpR5M/Y5RQ+pqIm0GT6ufhZ+Mpdql0Wcw20gV0FvADKjkuVVH5ZyTpllgFflmikRf
	ho9a1dOgGW/zjc3C137uJKei1E7k/56+Z5tYX4gbHGQWeztzWCds/pTsu80gyjGIpaKBmCR6ze4XE
	XSUxyWgyF0LCsRd0Sj3Vly4s3CVgavOX8SLlZaeJBH2P3Nj4HjmPP1UoqZeUo3G5V4iYovqO5Ev+E
	Krx1fWmA==;
Received: from [177.76.153.93] (helo=[192.168.1.53])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vgsGa-006KxH-L9; Fri, 16 Jan 2026 23:26:04 +0100
Message-ID: <0ebc75a7-b804-05d0-383f-9d542b14824e@igalia.com>
Date: Fri, 16 Jan 2026 19:26:01 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: pstore: Remove L: entry
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260116005631.work.387-kees@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260116005631.work.387-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2026 21:56, Kees Cook wrote:
> A lot of SoC series end up getting CCed to the hardening list due to
> their mention of "pstore" in device tree or similar, and this noise isn't
> worth making sure I don't lose pstore patches by having them show up in
> the hardening patchwork. ;) I can use better email filters instead!
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc731d37c8fe..02c2cb7accb8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20961,7 +20961,6 @@ PSTORE FILESYSTEM
>  M:	Kees Cook <kees@kernel.org>
>  R:	Tony Luck <tony.luck@intel.com>
>  R:	Guilherme G. Piccoli <gpiccoli@igalia.com>
> -L:	linux-hardening@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
>  F:	Documentation/admin-guide/pstore-blk.rst


Just want to explicitly thank you for that! Indeed, I think this might
improve a lot the signal-to-noise of pstore patches =)
