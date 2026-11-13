Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583227;
	b=sxrMg5UmClVYG2QMmnvJQcsSwkmKuoKMuwdHeG+7q7uwDPgnyKRIPs3zlofqKBGxP+yL
	 EFF1iRueimVKqoXt3IdRwOwbI+hlKPXVmW/nHcD9iDS7jtPUvyng1HI3QJMwa43lrFPXo
	 ZL6JqmXQa8c4T7/yoK4Vv7W3kkQDKcEfooJquS1Ha0kqqSraLLLXtqJTFrw5oHYSoJpXm
	 +X+y4ll69p0r/AMrtL6jdP7dz+IPJzpiuyZbOVx5SdhSvD+ajGRZ8ScdN6Lx505CHV5lp
	 wLkKAtNtwPX9Z/9l++JwhcSayZkckvRJuehRCOuLat1riGB0VRLWjd5t5C7oVmtHCPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
	b=NzvqdA5N/CABAfT30pCpYOmlku2S46oD1KcLiuEW9odrz44VsS1BcQBpUBlaMfr/LlAa
	 fT4qIi3xqXSo8m+TzMJR5iZc634BNOvU4kArgncsb6rr11WmomILlh97kEOmNx/hBU0N4
	 j47rwjep0nCdDBRf2AnN6bHUw8Nx8wexLZT0pQkfGRiYWgTEdqY2B1FyJTEMSIqN6NGOD
	 XtFA2I66cAFKWxfVMlE/2Ivnfazmcrgz4aAYxuPTv5x2ObClB0pdYjvIYn+jlARA93dU/
	 FA3R99pAbzx/KmLch22th5wbmXo82ZrtUOKCVHa7JI5/qwI5HX2uRCHNsIhTfvJavkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NnjU6d5V;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FC606A891
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 565FC606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NnjU6d5V
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-716b58a4365so1222678eaf.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794583225; x=1795188025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
        b=NnjU6d5VxM7A0+O4guD0V8fANOGIUq+iGf3jiYWrUO8W0bs9Y90UbrZhLlkWFpHJW2
         r+BfTji7EQkDUffbPgCw3SB3lRIl66kt/GBWpF5/sBULa1TCVPuFwubp16ZHonT1+mMY
         U77t3R3OpIp33QNWWn6UJmgljvsaCZP2yA7MYTykh/Kw+QxN/OrOZVjiNDi4z4RAHXPV
         i8dDuP3eRItU4MQ5XYXc/HdVjf9q1UqhxPAb1IXs5p4aVzMacS7F71GMeae5upCHZR3Q
         MriSbLqAcPOe9sNMQHZqwn5MW80lzKIYQ9bjbvMBq6tu0sz9R8TTHe2r/VreYnkKPPq/
         i/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583225; x=1795188025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
        b=NmC0YOMXk7mVQ7JbSdOmkbIkG35MrcOf+QjlQgZ7OTBIOWsIT7RZvsgB7DGFeXHtkn
         +FRvaIWt716KotN3fkKVIj0IBEGezgJxlvzusSN4ntSdBBYkKNqDrn5AUtpm3LlhqTX8
         Bxq61LUYRJjpkNtLVnV/cuYwltjSZPAvIb6J402cHZ315iTlf4rudUWKmKLFR1LQ1eIF
         do7r09uVf6X2Lel+Kf9/FL+Qj+uJk0RQrSeTFJujhzL5hAbGOKeC/pMb2HsZ4zl42zrF
         qRhscYUvxgTiAW9Oxw+Ey+LlM/r/wtKyV0JUS3tINl48Zj/4HdFLjOZbIpaei4420LK/
         f4Ww==
X-Forwarded-Encrypted: i=1; AL+hErGDtXjNhgWYHOLLc1EAwrO1iTpTWhE7mQYm0NjGN93SWdA+y5cqh/Yb7CAvO/gt8qbxJOjdhut40zIEi+8xwrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bjGdpibu4BTnay5I1IDA6vTosigqTEBKCNdb7EtJcDLfJp1bu
	kh4JLwpBDUJdSCFEovTEFh0amNDH41bTLDzf8iB8Z8zOaBzQ9ldngWX2NdcXC6FeukQ=
X-Gm-Gg: AYBFou3FRSESF6xRCo1lPZ/6a7JVS1o44q52Z774jJjbRK/34YGDuhs/HgEz79VpZco
	6aU6XBV4hkfxf7Ts8sznmG5qYqhf3ho2Ic+gBoJS1isLWB1oyLF/JZnXR8n9KVNaq1QA9DixVg/
	bewDxQYgN7ruvmPeuCWv3g/sBUoeoWM/twNC605qMpsnL2hmdPQiwW87pitbZbSysp25N6zVNmr
	y6DjYCQ9faVhH/Cvaf5jsnpxdxcfAOjfCMR+xv4FcJhL4JYbTfDgcg6wwfWE+Wfgo3y9HLAkWqJ
	uiQE2GblRg1i70wE9U0uhSNaprlsibiUEcrSyiJq9ADxjke02f6Iuw9AoK1xi8xGVTQdR8mtBlt
	/6AhrJCJziBW5AYbuppiLFZfW78lwEvF9ONHGEyQrDgCTQTPI5XQvERkX3LsZ09HDPfKyUvgQsZ
	n5fUyaMdOunmMr+R1Ci2VpGPpks/CrC0CnRn77V6xgQul/nKsAYBbasNF2rpH1wy7Ntl3zmoLWo
	nTT0YvQ/DSzy6iEj5OPIe3vPYobQTcZdvYAOFutVu62fKzL1Ad4C5HPRdcoJ89xuIFAW0tSV1vT
	2o7aprRVklXGdPjzZS8pWufjno2m8mP+aPlR681D12I6yeCteJi8c+l+7TTOoQbyCfn+lRl+CdX
	XmIc=
X-Received: by 2002:a05:6820:55c6:20b0:6d9:e2f3:9b51 with SMTP id 006d021491bc7-71ab5084396mr1064228eaf.66.1794583225149;
        Fri, 13 Nov 2026 07:20:25 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fb76:8640:983b:6899? ([2600:8803:e7e4:500:fb76:8640:983b:6899])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4338765sm2019311eaf.14.2026.11.13.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:20:24 -0800 (PST)
Message-ID: <06f0a178-5d98-4c6c-b596-c0eba8ae9234@baylibre.com>
Date: Fri, 13 Nov 2026 09:20:23 -0600
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
Subject: Re: [PATCH] spi: axi-spi-engine: Start the program length at zero
To: Kees Cook <kees@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-hardening@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261113065508.i.606-kees@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261113065508.i.606-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 12:55 AM, Kees Cook wrote:
> spi_engine_optimize_message() allocates the program with kzalloc_flex(),
> which sets the __counted_by() counter "length" to the allocated size when
> the compiler supports __builtin_counted_by_ref(). The program is then
> filled by spi_engine_program_add_cmd(), which increments "length" and
> stores at length - 1, expecting it to start at zero as it did when the
> program came from kzalloc().
> 
> Reset "length" after the allocation, since it is a "usage" counter, not
> a "total allocation" counter.
> 
> Build tested ARCH=x86_64 defconfig with CONFIG_SPI_AXI_SPI_ENGINE=m and
> W=1, with GCC 16.2.0.
> 
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Closes: https://lore.kernel.org/all/20261112025252.71375-1-dennis@ausil.us/
> Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

>  drivers/spi/spi-axi-spi-engine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index ead5b295e680..9cfee409f15c 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -818,6 +818,8 @@ static int spi_engine_optimize_message(struct spi_message *msg)
>  	p = kzalloc_flex(*p, instructions, p_dry.length + 1);
>  	if (!p)
>  		return -ENOMEM;
> +	/* spi_engine_program_add_cmd() counts the instructions as it adds them. */
> +	p->length = 0;
>  
>  	spi_engine_compile_message(msg, false, p);
>  

