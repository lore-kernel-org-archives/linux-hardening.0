Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0782DB78C
	for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783443; cv=none; b=ZdXc1inFJHhn7JNxM631ny84oBPUFf3ozAm7iI3O+GMuAXaTPV4jdstjAsgDWb5gtlFQRLlEKveh58O7xYTZyFdEzFJ74KOPw/mx7NWZaiA+CTD4OmArNcmqj9sfpZLTJfrKRN/jVgG4F2ycjzpkXe2r3tIKW49qXo0MmNtuMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783443; c=relaxed/simple;
	bh=ytnfegl7Qybj0AzCwxpuF7iUfDDtBrbX3UJyTbFECFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SI8gSo7TbDWdRY5OH9wP3sc+Dod7g1vWykEr4QD9Fj/D9cE5dyxaj/mcD39GudgdHN/xJDOenU57GCNhbhwWnrifRzOgKswypdxcpyl+B7KBiLBPbuaAjrWFabQTTBt8+xo2eqSTq58G0i3p7x4QRcEPIZR4XIlVL8AYkzL2Hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bXPltKwO; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bXPltKwO"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a427e628a9so468014b6e.0
        for <linux-hardening@vger.kernel.org>; Sat, 11 Jul 2026 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783783441; x=1784388241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oPASv6Zq6YY/gY0oEbRpb3fd8WBXtfv+ncRCm+l0SYU=;
        b=bXPltKwORkBFdn5e6sB6/D/3ve/kjpKIGr7B6DqihDL294D8oi5Rq4hAt2VuPgT3kv
         off6Vk3hjbh3ZuyhEyqAAU/sPeLEG5YcuDp9lfVPaAqXQV7/eouonYa7ua7dYnhWPpCo
         7dCW+QMx25QNmYG6wylrMd5gAErWbyHXHxCgN14j4Tn2gWiTj5feWyAYFB6T1kQT3kox
         CQHM+8CZpRb7sKeF0jC8rZttYWGnT62fSAqrmezvH5gCD0Dyjmyw20qFjAMXq9tW4KGB
         JC77c2tOuuJXV0yfdhMgJHjb1zWr+/0rklbKC9QEVyY8ZJ+njxhNU3X3BMQhkIGK7V6X
         +xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783441; x=1784388241;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPASv6Zq6YY/gY0oEbRpb3fd8WBXtfv+ncRCm+l0SYU=;
        b=oGA/mCPP/9wiI6aEhEBYnmyP19tdM2mlUSCpIZO9qTPDN0KNzEHdFMMnQ+yez7FbM9
         viZaX+83Tz5teDHVtZYKQoGezAPNsLmtBWT3n0KhxZWjQOzL/aqXVgtz9Hpe98ugcHcZ
         WIMmsAR4ArpIFhmCWGMQeiZyPgJ+Tk3tQO7qNHiBA7DFf44TzctgZ+/LLZY27l/JUXfd
         B/MoCN7cb2a0RuAdEDgdsXturW7Rr5lZy3CY6/N/FphCeo+qRj1Xati35tM1Pa5MAh4x
         ZkWHVHItVFkMXDR+bIyiNpZiPl2LLNIxE8xXF08pW7kIlfLbrB8+48SJ/a0E2AO99Vfj
         kWLQ==
X-Forwarded-Encrypted: i=1; AFNElJ862G/NouaPGPIQzUXES7B3wsaIPTbETKXOdF1Xw9gRdmfM0yAYoJAFTFC7oc21XCJ+rw3ktTiEwYYsNeHRLEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOrV2BlZpADXNXlXq3QKWSRJPWth0cLYXIwQz7JsHZ6F+zMeD
	pqKzQ6jgoVgmu+hntnpsykdMNnVGs2Dw6xIcb/qTKFfaMuyBAz1UriTaJ/acHaOwX8k=
X-Gm-Gg: AfdE7ckLBFmlAkWT8HjEhSPJyoChorR33M6t93bW2GbJ0BaiReb/JdLsTtjzf+D9IvX
	l6USDy65Ug8uvedkaA2p/q0v67qR0JuIGl6DYi0YkxQjnTc/4reQ2Mdzn88iwOMnvfCEQ6WS7aQ
	Y0t2kfCgwn6Df8u8bJCjhnwwfIzi2v9D+/u/xBUjtTeVd96undJJMEJmORVtJY94cBCjmSad21Z
	bhBJbtT8CmsdDnGzlc6bojPulpdWHQe3lgN2QG9wMNJ9QpeQKyOj6anzyidy1EKGf9CjG6IUiCN
	Ke5BavMsEjqUIZJsxHJAReLuNGKPlpMOUDhKrlUGTv8846huFFZaKOGaj7TaPnc1b5//IqMDksd
	FmrjJvyYlnNKRqIU5EeGGJ4oooYmXP3dAbxokCfJ0Il1O3Q32Ol8bLklOx10GICLjuComl7R61i
	2b4Nq0ltpE2IGDrYofmk18cAieOfuzJiseNKXxi5yCEVqq4tPkb+szQ+K+pAp/CwM=
X-Received: by 2002:a05:6808:6903:b0:493:b6b8:c8b0 with SMTP id 5614622812f47-4a42ad7549dmr1908121b6e.14.1783783439274;
        Sat, 11 Jul 2026 08:23:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b01eefbbsm7974781b6e.13.2026.07.11.08.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:23:57 -0700 (PDT)
Message-ID: <adf66856-1cdc-4722-bc3e-549122a912bc@baylibre.com>
Date: Sat, 11 Jul 2026 10:23:56 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] New features for the AD5686 IIO driver
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 sashiko-bot@kernel.org, Maxwell Doose <m32285159@gmail.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> This is the second series of three on updating the AD5686 driver.
> 
> Initially, a big patch series was sent:
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> Then, the first patch series added fixes and cleanups:
> https://lore.kernel.org/linux-iio/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> 
> This one is introducing new features:
> - Consume optional reset and correct power supplies;
> - LDAC GPIO handling (active-low, held low when unused);
> - SPI bus sync() implementation for batching multiple transfers;
> - Triggered buffer support, leveraging LDAC and sync() to flush
>   all channel writes atomically;
> - Gain control support through the scale property.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

I made a few comments, but nothing critical, so...

Reviewed-by: David Lechner <dlechner@baylibre.com>

