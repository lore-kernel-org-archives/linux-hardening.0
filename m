Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F253126DA;
	Sat, 28 Mar 2026 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734523; cv=none; b=MA89IMBNq0p8Gq1Q51vvbyvTImiCHkCl56wFvvZVnKVtZcTuSH31st2kOpVlFlrm6K025ft85auMYlqpbFy0TBorWPytL+8URvikPfemUBxSjTfKURVKY825+/rDxhB0oJzrjEmCUK9dzsjsLqEcAxlzdoidSMTLxdOTqpwZ2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734523; c=relaxed/simple;
	bh=WdcLOf3svQq0pbGjMCHTBHUm48SYKu/F1/YYKI5rUoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY2qZfmmDis+c8802B4uQ3O1idDasd3VYZP3cjKPaQlfcUY06pgOx5KrYWIgSRGqk6aXVaJBfFJI+wgBczMtbVKbBH7HKHt2FYTtV6frIsH2oK0Hjz3i2+mZjRyy3+SD0OOgV98SJFWa6vgQhzsQkhNXI8ZZ0D8R82Da0wo+Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r3OIk9Ld; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r3OIk9Ld"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qSKGCd7VWbHRigvx+F48Ja5jjh+fhWpoJ8zcbIAmliw=; b=r3OIk9LddPfhU9aX0rOSHlJo0s
	e/oieOqkR5VWTN8/ziTimwAlGha/njcpBCBU8QPuKm+VldP91p2nNaCDwQBYn8vmBJMpkYbeatTfj
	Fa20YjaHNHc3OdcyjoI1dMUQpy61yR9m1TRgWP8IKb0iPA36Zsi2u7BrDMSA1rjwbXiPQdJZIy2OS
	Bi34ayB/qGSS3j4OoKNwR555t+I8OX0VUCvmPudA64u5LUGIlfiOC8ninAff7rfcyDs3LQ/2dEsPv
	NkgpxWRB3c+QvRCjPi3mjoWQJSW/gZGvYSpPpAYJGkfN8TNbxXHnHqVa8e5dFJP/8csJYovFVcqvC
	fFf+nv3Q==;
Received: from [179.93.13.238] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w6bWI-007hxG-M2; Sat, 28 Mar 2026 22:48:38 +0100
Message-ID: <0766e8e2-0781-d452-62cd-51c27a2f2c0d@igalia.com>
Date: Sat, 28 Mar 2026 18:48:35 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore/ftrace: Keep ftrace module parameter and debugfs
 switch in sync
Content-Language: en-US
To: kees@kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=
 <u.kleine-koenig@baylibre.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20260301192704.1263589-1-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20260301192704.1263589-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/03/2026 16:26, Guilherme G. Piccoli wrote:
> Commit a5d05b07961a ("pstore/ftrace: Allow immediate recording")
> introduced a kernel parameter to enable early-boot collection for
> ftrace frontend. But then, if we enable the debugfs later, the
> parameter remains set as N. This is not a biggie, things work fine;
> but at the same time, why not have both in sync if possible, right?
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Hi folks, gentle ping about this trivial patch - any thoughts?
Thanks in advance,


Guilherme
