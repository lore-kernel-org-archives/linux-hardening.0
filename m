Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392936;
	b=ndZhCBOOKRpuMaB6vdetTdWdHDruNGs5gsLTm5+S76hyAzxcdCwkFhXuZk+FTH6xVMO7
	 VpQGgqvuNg7ih1r8+U/5DV/8hTRPI08TGHgx8CCLNwVnUj+LKFfsir5kR9kLBji7XklQL
	 TXSF19DyTV6fYAoLfV03LgmPXWrOdXHemwkRcOD+JKw6M1fFKMMAo28U/q7stHjpNJ7F5
	 HCAOA36j1ubmmAxvCycHXgKGtqLqllFZgGp34Y1rteHWzEv7Tc7Ab0QKsbbzzHuGtM48k
	 7UbUvbeY62tsJi5dSdvfvl77LY7HeQIaxD8McM8bWubHSz4Z/xo3lnMRdpSrYlgbebA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=S0n6tEIf6xgoVedt+MafTEKXaK+IsDQRgSWIh9QwpkE=;
	b=y3Z9iLMHgaJRMTjPOA3BSHKGmHkv32ppAouCoy4xF9xzENGEwRRKUvX0I2eLvIzCcF/h
	 Qq3+KOORjNFYy2ie6SOJadqTJC4dxqvhUJLTkRAf5jbusnoMhc9IBPwihJ0WevnN/preM
	 mQBQ1DNScFEDPs+bWjAogL7zDpGWynDOsQg8WqJ9A27pmEziUfLRIJhLj/6M/br+39w1D
	 wF5eGp8tMo26agZaIUnI1N79T2lZFAkh/3gQRKGEtbBWUN4C9mG4iOlSKUh2AX0CrWhLE
	 qyX/R+JrR4mRKknnTfan9a9edZ55cS5wDpG7HlQ7gssdwejWPe9n3zYwU8iX2RQpbBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PjW39RcL;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07D606A331
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 10:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A07D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PjW39RcL
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so2225874f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794392934; x=1794997734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0n6tEIf6xgoVedt+MafTEKXaK+IsDQRgSWIh9QwpkE=;
        b=PjW39RcLxzoGvtaKcQYDQP2va3T9aZKhVStCO4PitYqiXI92QH4v+JUentad+6tFcX
         c+UIVPyEMpkFJVvDxgUAmsb9V+25vMtzatHC5XpytY7COKz5m6B2DKxs61dzKDdx5q1C
         IB84sEugGeoLpsKYMjMfSHutuS8Fxg0BDRCbW8oRrNGJ9I9TiLf+yVdiU50A3uGbJxqv
         jTc6W1XJX0b/KWLV4qVe++Ze3WSf/bx7y7BXZWYq/cpGiYtnpIx7WeoFZVUy8LjUBMmz
         ohQRcTYEJQ7qB7CjNPxVVAHw95KNReLbkn0GknrUihsDOgV1LQnP4SGx6bLlmuX26UZU
         Qr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794392934; x=1794997734;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0n6tEIf6xgoVedt+MafTEKXaK+IsDQRgSWIh9QwpkE=;
        b=OWoX7V3E9pmB9k1rkp5oJX9Rhujp5k7gexUqLGUevKoXPyUtb6XVl/SpPcdhK4/Tfz
         N/Jash5xFJnbePcBGyiYIW5iKWfjPwLaatvLSxU+kw4uMRPLtdUeUjWRuFHpXpde4lyz
         esVIE1UHJqD4bs+dAkkxfFxKQ5/9/Tet4aAVplO9BTykHt9HmkxGY7LuVVlFVzdRl8wI
         FPfs9zW+OUZ6SZm/Y/hwDIhRMi+PZaMeibItPVva538dab8l3z1NxRdvfYCTzghkKVVZ
         kRvS3bX2cK26shWJ61oZziXw4YXERBKRpI9MGDDTOtM20swbQo+cdoy0mDUGYx5KFZe9
         m+OQ==
X-Forwarded-Encrypted: i=1; AL+hErH37OFWOWKRPW1YlN7ybFTqlu8hqWjCXBCDDLvBcXmK4Bs5RdUoETcVO60GJJDOwWc1LYZSU6sJNMwPi+wdClM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z3eMRwPVGIqbMGl5fE+WN56kPMRGuyTkXTRdo52ge/OzvzTqb
	eMtQwhTZsBgIRbo2Mu7P5JLELMUq+tviOYFkD1n5y8edQaCS3kWNYyQs
X-Gm-Gg: AYBFou3RG7DLhE7CTxEP+MUkcdCYGR6ehKosby0PnY42LiwRzaVoRsE/YYvQO4UJDQY
	PEXB402yhTguyNlRpD5p7A7kJQxiIbIMC4ph4GKYag3q0brR8EDOlk6SAbxLBEUwO8iNARss6J4
	ow1gzuF4ooQX+vIPraN7WMZzARqmQJlCjtIJJCMn9rAxqXApYWJaAUJSXVMsKX8SEF7AiCxHvLd
	Y1DnfYHpCCKqROq8j4NX4YCemW7BUGvfesu2tYYjqzM7kH6T/5BsrZD6Sr/6OqcQFYzzeQ1mmq+
	KTMg7QE9lRFKZFZmBByVeSRL4bvxNbADaXhZS55E6AaukLh8wwNlLD+sQhoxPYidiWMXptxvjaJ
	l2vcd3f9oGjXgarnHNlmLRkFvHDwShnOdA5YBnnR/r2xNFq3bT/xveJm+NAO/fFizhzhMyx9sS4
	H5KEtnwxK0R09s/9qoysbb16AjZPnIeW3N7uFjcB66Rl2A9ut74hUGVj3LJhedE3MUL4UKu+R1s
	H+QHP35h43IJqnyF9ZKgj13LJIl+KZQdwartwBnEkFzh3N82jbHKOKgBjt0yrbzyjVr2IoKxSfT
	Veh6w8zHl86/TicYTVFgNSR+U2y37EwVSZwMCzv4PgA/N5ZFSRoASIc2f1rJmlgQXL0Dc518vVX
	4KmVc+k8=
X-Received: by 2002:a05:6000:2201:b0:48e:5cd4:aa60 with SMTP id ffacd0b85a97d-499c9dad952mr3537266f8f.42.1794392933785;
        Wed, 11 Nov 2026 02:28:53 -0800 (PST)
Received: from [192.168.68.73] (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm10342588f8f.10.2026.11.11.02.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 02:28:53 -0800 (PST)
Message-ID: <a64e2fa1-6670-4018-80b8-b6856709ad5f@gmail.com>
Date: Wed, 11 Nov 2026 11:28:52 +0100
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
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
To: Kees Cook <kees@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, wenst@chromium.org,
 angelogioacchino.delregno@collabora.com
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
 <87bj7yw9e2.wl-tiwai@suse.de>
 <87FF4A7B-853C-466A-AB01-2D9137DEE6CC@kernel.org>
 <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <EAAF07EF-6B11-4EA5-A5AF-A7787CA2F196@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 06:59, Kees Cook wrote:
> 
> 
> On November 10, 2026 9:50:08 PM PST, Kees Cook <kees@kernel.org> wrote:
> 
> For example, what keeps snd_soc_rtd_add_component() from overflowing that array? If you want to protect the array, add another member, say max_component, and use that for the counter, which gets set at allocation time and protects the array from indexing beyond the actual allocation size.
> 
> 

Hello Kees,

Mark has already applied the fix to for-7.4 (d00ba321499c). I agree that
your proposal is far better, but the applied patch was meant as the
minimal change to fix the regression.

On your question about what keeps snd_soc_rtd_add_component() from
overflowing the array: nothing, and it already seems possible today.

From an LLM-assisted review of the code: the platform loop in
snd_soc_add_pcm_runtime() adds every component that matches the platform
dai_link_component, while components[] has one entry per
platform. On mt8173, for example, the AFE registers three components on the
same device and the front-end links use it as platform, so four components go
into three entries. The extra store has gone unnoticed in the slab slack, but
with max_components as the counter UBSAN_BOUNDS would report it.

I can't work on a follow-up. If someone picks it up, components[] probably
needs to be sized by the matching components before the counter is switched to
max_components.

Emanuele


