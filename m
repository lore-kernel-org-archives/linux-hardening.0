Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366440;
	b=bv6RKelojTnPQIma8XzYutqNzV6kxd5kWV/ceUqF+qpvXHXQlh8G9SQCT3Mir2b4wRcs
	 mfnow3z78znNeglLuhCYdIUgj0OXM0U1UeO0UZAkdD+sKWBNqYTn5lBbicM9tOKIwqf3D
	 4xBMAMCCH3Vrt5o2Drjaa/ghUB//D4VKfuvQ82yLTxRgWY0QVGvLCcfeJPvCGefZixFho
	 ixoEccDUfgXaVYS5xuuBBhNlkgI3c5iPRBsFIyvjr7hIrr6qZyoTLCP8jYxfRA67VTCUw
	 Zn/dBd8d5w2Fus016hJRocyecTMQBbUag2mMt5ZwEho3HVfZyScZXxDblmm+GSlqo/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5QQB/zl+ns/aEZiAq2k5y3MnGVp0J7ISkxT4POasMWE=;
	b=bCvMkKtwXZQyPNWCfkWqAwDCNnPH9YaeXm3cYzeoN1TxdeaXYZk5t0j81vOfulcOUGdk
	 UyOgGVWxiGQfl/sCf0kGNpSamRjnpO7aR7aeeWinoBEBnmzgmbBIbLXA2nikWurO91tly
	 4HRabIvW+51SEnVL1KHC4EcTdv1VOLN0lAHeE1hb0XbGR1R4R8w+U+2oZMXqYNPc3ssZy
	 QVY3m1yzy/vbDgFcVnWyIyeYdfyyn0x65uaYhMvbovGwHC9iODTcU/L418lVBSmjdOnzd
	 WPDtuu7DHIKbb1aS8hwO9s7PnKvDJa6JOSpPe/FHynd113tnMLRaWCOxyhoMWku+P5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e56FUdgG;
	arc=none smtp.remote-ip=74.125.231.72
Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0700606A324
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 03:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0700606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e56FUdgG
Received: by mail-oa2-f8.google.com with SMTP id 586e51a60fabf-4adade2ee63so589310fac.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 19:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366439; x=1794971239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QQB/zl+ns/aEZiAq2k5y3MnGVp0J7ISkxT4POasMWE=;
        b=e56FUdgGsEKYl1Kqx3ObrvBbDAlwQ9Q8aHhTrJnGOs5DLITNBVk36Z3HCbLnRtlb7M
         Dd6N3liklod9yAVSXLbogiHPSve8y9RroeL/QI2pHn+wsaeOLUY8hZkezNbl5NBGrSsW
         ZkSfjcFfi6QbLafbCEgd9qLWyufAVsdbRpJbM0MqAzCvGaMp1rJ7RkaaivL7i8dfJO3J
         q+FFivwf7ffqFtCYbrkBeXcEs4iSR9OSzmELX/2e5DoRDLhqCtcM9/TS3R1CMmj2JhwY
         mGaODyeZKs5Q4XuDrVzfDtTtMNQqs+2I3usFFbJdeB5DZukcSsNABr7sNykk04R2/Nba
         m/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366439; x=1794971239;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QQB/zl+ns/aEZiAq2k5y3MnGVp0J7ISkxT4POasMWE=;
        b=kQrSqga4g1WO4pQH4fjnO/eFS1YCiCHmJzapOwMpAsVdEWV5MLdP7yUK5EuXZm1jmY
         WGVAlNf7roBW/zVhk82xubuwrCryjm4uQeXzm9BOyFiOVJ0Pya9SJ9MT4QaJ9femg4yd
         U/dEnxC4ESYVQ4IQkzsa+92Ex8gmGLZ6lgABSOg0cyIpken/HDpPkt+jfGgIyW4rIbQ8
         bBOlF7LYhoRuGzzkNjbnr3AZ8A1JPgXZ+V/RnKBHLUWptNHsXEyA3VsVyVyWt7CrBluL
         kHEtchwH6urLiC6YnROw97v0/XqSBNMuizSuEM/M83P9ttgQDOGQTBPTSBvqdLxVmOAn
         dpqQ==
X-Forwarded-Encrypted: i=1; AL+hErHKYvJ9bLZ+ZwEjRw8W/9J8H16pNUKAPeYHs2MBbczmD/kKcdur7uOoydUn4/Z1QCvP22NDvtUMQqQoPCydv2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/usCQy/GweHRDIQTz3ROLPLIe1xfdgoP8yBLZ/iuYe0TCVlvHC
	XK6+VpID+jCYLEQajji/fnvmfSc1siCCS4QDriKVgDf7wqSeU0R/qse8
X-Gm-Gg: AYBFou1qGvwjlPYJoBJtFZOX+hhWDmkr27fZKv4XccftSvcBnGhv/4V2a721xDqCIpn
	EEoiT8syURb5IGDyo3VupedkCt4iQQvd+I0jMYgdCK6/zdrWMovvXG7Fe9GgwhRUQAhBxtjQOX7
	gWoerBGvE2PRk+DCYUSai/tRDchkhOc/zRceYoyVoQnfIiJ9JLHUImcFR+2qnLqqEctYSTQgtrw
	5VXKzAU8FhEhDCldcoQkEA/WGw+KjE0SzdF705XDgwJh6BGDiYwQMPm4Y+zjGZwLJOcAXziIFl8
	T2ZTVEqck2bMZd9740+PY1Et1LdtmSoaP35vtzCnq6W6rzWqYnNGpFOkxdme0Jes7gIyx90TD08
	F/POPQrjWqx1ZfJJeKLhFRIvglmaqVqjU20/SMgNrr6TNLwwN5JWwDTb/7f0jVOrhro0aQYcTSx
	xj4z/dAAHMWuK74aM8W2fjGlmJa20g3baH/HImqGn0MKO6hk2vMbrB6560PQ1NgvPJtZrJirDkw
	4AFYJtq34lTSJBomhk1JtMm+NYWxIuRUpLUnu8WtA9sf8CuYQIKoMARFpyaHvi2oWiQYn1Syrz2
	M3teATub2UumqaEzYVZ+kWIi2wN1Spfw7dkxZ4CTs4bVqvr/vHyk+o7LW9/3LvlaJlo=
X-Received: by 2002:a05:6871:e406:b0:4ad:9471:aaf9 with SMTP id 586e51a60fabf-4ae46d0a820mr1035744fac.62.1794366438834;
        Tue, 10 Nov 2026 19:07:18 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae23095c5csm2712810fac.16.2026.11.10.19.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 19:07:17 -0800 (PST)
Message-ID: <2eb7d236-5fc8-4a38-9a30-d45e6cb1c1ef@gmail.com>
Date: Tue, 10 Nov 2026 21:07:15 -0600
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-core: start the runtime's component count at
 zero
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees+treewide@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20261110-rbrue-asoc-rtd-num-components-v1-1-fa0c9e0cb361@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261110-rbrue-asoc-rtd-num-components-v1-1-fa0c9e0cb361@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 7:18 PM, Ryan Brue wrote:
> Since commit 4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to
> the devm_kmalloc_obj() family"), soc_new_pcm_runtime() allocates the
> runtime with devm_kzalloc_flex(). Since components[] is
> __counted_by(num_components), that also sets num_components to the array's
> capacity, but snd_soc_rtd_add_component() treats num_components as the
> number of components added so far and appends after it.
>
> Every component is therefore written past the end of the allocation, and
> for_each_rtd_components() stops at the first, still NULL, entry, so a
> link's components are never found. On an MT8173 board the RT5514 link's
> init can no longer route to the codec's AMICL widget and the card fails
> to register:
>
>    mt8173-mt6391 sound: ASoC: Failed to add route Int Mic -> AMICL(*)
>    RT5514 Codec: ASoC error (-19): at snd_soc_link_init() on RT5514 Codec
>
> Reset the count after the allocation.

Please disregard this, I didn't see Emanuele's fix for the same bug in 
for-7.4 as d00ba321499c ("ASoC: soc-core: reset rtd->num_components 
after allocation").

Apologies,
Ryan
