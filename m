Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036196;
	b=nszOMep6IWG0KhZfV3WQN3YrSkmIFTMPd5HlLued6Khyy0LCOLdhddRb4v0iFfDbljc0
	 tdP4+Rb9sRtEyfmf4/ZjV0u4YnlrKNPaB8G3hUalEPiLQWbAW6lWtXNnBoQDK3egtRD8U
	 V9Dq3K/6ZvtwpjT1J70fcVkFtii7EVRe8NEIvjKxYQva91wMR4eu/5x9oANSiN4sPcIBr
	 UAnYEg/ZnU5jk7Tj/B+58HHEFHzP4riNoACJJlSgTkiH3cfeDM2pOX3xnNrGdsLa1z048
	 ao9DBNKnTvGyBq8WwL/dVrMQVRWTkH02D14Rl7eaZa5XMZHAU2JN2AZoE17TpoC6rtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036196;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Y0FgIFQtxvacrqev0zCbMfAujPCpt+ydjgI/Lt3fFqI=;
	b=T5G79t4l/d27yC8HIpT0Q+62CUYh4/uwzUgqK5dx8CraIboygV8066a7UcUi0Bh4FHVJ
	 K8FNNbix6S1PQmm4dNKE4KatwEPGRCQSlVzOvGf87JJssjxfoC8C1rIT/RH/N9jyalIcp
	 xFTEgwRKr/tvRZQVh05u3tp2Sy1irnfD25BL0VZez5WimvyVl/KYDKlrV0i49D0Qi3GS2
	 9SqBeEIdBAmQBrswref2pEnj0vqqkU8CuvLr7kQFOps/9eYpksY19dwVqcGA06x/PP0VF
	 JtxsPeiE1Q2KUiHBEdoKXv03swGjWdyldK6Bb4tSgXnNYJuF3BSCRKrend+XXhsl4cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YLjIX0aC;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF3606A32E
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 07:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AF3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YLjIX0aC
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso646125a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 23:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794036195; x=1794640995;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0FgIFQtxvacrqev0zCbMfAujPCpt+ydjgI/Lt3fFqI=;
        b=TwmvmNdM4eHmkNj5IUfUPJLALA6t8DPvrba5Y8Lrh9B6euJ0nMCO7PmBG4Fl10nOtR
         2crWt97MAtmclD2twm0rXwbPDnuylPEPM/XY0eHHeWK4TV3p7bD2Mf9mPV0oTbmyg20J
         DXfBGFZHuA34vfA+bkUr7MzUwrjlKVpThKtMmx0Ix41TLqfhgI/BpeQf25qR8oszdrJM
         HkJClxkvMj+MFdBZtPQ9NY2E2NxbKKsH2oHT0Xgyqng+camkeTOABS/Lv+OS84lLYIBB
         WdbFNvbZRJdfvBIjTDqPX8hXlOA5bSxN+KJTAjvI8SXlnUKJ47+SKkdwxU+9gx/jSDlO
         zh6A==
X-Forwarded-Encrypted: i=1; AL+hErFWxic4ROGqrH/ubBHZ3TKL+3RfSVZGy5EuyOVI5wGE84c7nBk5UmdggH1VtkitYixLOgy9fXykdDiwEZ+ZS+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CyxgLl2M5pTMy34VoQG6B1vv11JOGJobITUyM6uPF76EpIfwR
	64iLZpIzWbLVB+Uqpon5TsOCBxNBudYi9IJEsRnscHP4wEP8mbI4RrrVASXGku/M97i3SlDuDfF
	nT3c4ecH7Kcv6YPhtmbH1HC5x2Ya2FA1kmlhzzN0CnTENEhJg4XsfE8J5PcaBbvak9BufU6N83k
	4yjZ/+kZgDvWAEpt3RJ/YY2HBqdGXJTcHdw/9oNwMDkZHLtNczh3msi9ByQhKz+OtLi6E4Vcdm/
	djchB6vblEpaiYwQk26/joTIJQ=
X-Gm-Gg: AYBFou1Y5M4c/JhhdDzo23z75vU2Bmac5tdbl41TqbnkAbqc1Y9o92vh1bUhL8EIGpH
	42YtbQ1VNlzz6QRVvkTVyGEHSIHTPr8rEiz53KgXT73E2nfKZ0Dq9lam9OhGc8SJXrOLnJX2FaT
	cGWGZmOIdABU/F94rKMXWZFAPjcXTbXg52rpxsZBrI1a5TsMTrvo/DtigQ2YaM8KWtAmkRBogNE
	4FZ5BnCmFbnx1j/47DMlF/0JT1mOeOE42dsIGboE/SFSQ39wBwMVUzqZm1YJZ+41yx1aReMzwr9
	HNiNAmC7qOgIYvn93YXH6Ru0ThjgxQDDiaz1vQCkJNd8RTl0h/2AsGTLAvbs63dBbw1uev0JBW1
	oaOmx9F2Cako7Ji29IfZYB0qz0+TrSxmehWpuoVhUV1jELtKCtmEnDBmojnmP2jFooincQhmvcf
	iLKSO5ZW022s0odgQ9x2wxV/6Cqzi20zkDpYzcAwI=
X-Received: by 2002:a17:90a:c10f:b0:3ae:9944:3bf0 with SMTP id 98e67ed59e1d1-3b0db6be234mr5068561a91.34.1794036194831;
        Fri, 06 Nov 2026 23:23:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1057da2c5sm1155644a91.4.2026.11.06.23.23.14
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 23:23:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c42394d1e41so129561566b.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 23:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794036192; x=1794640992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0FgIFQtxvacrqev0zCbMfAujPCpt+ydjgI/Lt3fFqI=;
        b=YLjIX0aC0YSfdvL08sHAFJJzPQGQIH7i9jcl7NArFCo/ELtfUIpKD7hM+wOC8yQBL7
         27WdolF1GOC3yl5WS6neaQA7pa8YyVENMAezfg8WUUWVr/Nyppc+O1AwPT5HRwe1NFTX
         GQFsZppRPBMhlgeTH+agaDbZGfFevvSq5YjM0=
X-Forwarded-Encrypted: i=1; AL+hErFd94yMpqxGlGwADw1WQPL2iJcNY3MSbZEIXH1lCBTqM/tiiAUgK+/JPhj74+TxEN5n/jF0opKIP6SKO0mWNDU=@vger.kernel.org
X-Received: by 2002:a17:906:d54c:b0:c29:5d41:dfe8 with SMTP id a640c23a62f3a-c4d34ca43afmr369013666b.43.1794036192728;
        Fri, 06 Nov 2026 23:23:12 -0800 (PST)
X-Received: by 2002:a17:906:d54c:b0:c29:5d41:dfe8 with SMTP id a640c23a62f3a-c4d34ca43afmr369012066b.43.1794036192265;
        Fri, 06 Nov 2026 23:23:12 -0800 (PST)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569fa54sm134100066b.58.2026.11.06.23.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 23:23:11 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: =?UTF-8?B?QW5kcsOpIEVpa21leWVy?= <dev@deq.rocks>
CC: <asahi@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>, <dberlin@dberlin.org>, <frankyl@broadcom.com>, <gustavoars@kernel.org>, <j@jannau.net>, <kees@kernel.org>, <kvalo@kernel.org>, <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <marcan@marcan.st>, <meuleman@broadcom.com>, <michael.reeves077@gmail.com>, <pieterpg@broadcom.com>, <vanhoefm@gmail.com>
Date: Sat, 07 Nov 2026 08:23:10 +0100
Message-ID: <1a1b4e3cb30.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20261106191826.4ddb997a@kait2en-mbp15-1>
References: <20261106153612.2aadef2a@kait2en-mbp15-1>
 <1a1b1ef4b20.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20261106191826.4ddb997a@kait2en-mbp15-1>
User-Agent: AquaMail/2.8.1 (build: 200801029)
Subject: Re: [PATCH 05/13] wifi: brcmfmac: Negotiate PCIe mailbox transport with firmware
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 6 november 2026 19:18:32 schreef André Eikmeyer <dev@deq.rocks>:

> On Fri, 06 Nov 2026 18:36:52 +0100
> Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
>
>> Sorry, you lost me there. What is the relation between the patch in
>> this subject and D3 ack.
>
> Hi Arend,
>
> D3_INFORM and D3_ACK are mailbox messages, and 05 changes how they are
> exchanged. Without 05 brcmfmac writes D3_INFORM to the TCM mailbox
> and our cursed Apple 4377 firmware on the 9,1 doesn't read it.
>
> That is why I mentioned the D3 ACK timeout handling patch. I
> submitted that because I was sure the firmware wouldn't send it.
> But actually the transport was broken.
>
> https://lore.kernel.org/all/20261001085308.1688049-1-dev@deq.rocks/
>
> which was superseded by Sebastian's patch here:
>
> https://lore.kernel.org/linux-wireless/20260915-brcmfmac-bcm43752-suspend-fix-v2-1-1bd84914998b@collabora.com/
>
> So probably for addressing Sebastian's issue this needs to stay
> anyways. My memory served me wrong. I just read that his device is not
> an Apple product, but his patch incidentally worked around the same
> problem. Sorry if i was causing unneccessary noise.

No problem. Thanks for helping me unclutter my head.

Regards,
Arend
>


