Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986622;
	b=B0+Gocq/u1UuON/W+qj7lefevCQJ3jqcuzoYSzXP1RbH3cNyTJMYN8OB/kZxnT42HY42
	 8gb+P/xzD7TRIUc/bgvGx7loGt3KPJCWK/4Trfjl47MDdO18bjZJICYwU5de0YgFZht+h
	 b/hPWGwoPjneHeZ+QzQ03OLS6JJPCF0PbIzegcf/WKA3RNJv9kvFIusGpV8GeDOf7F/gF
	 acdJpNUNWjG2Fgy4lDrGUfkCJfE420JzQjQHIpwAYGOzzkahEDj+RJkYCm/qoZzLwPj7E
	 Tiv/mecyX22/BoK0s6haloj7DjX39iEg7wpsy7UfELO1Oa0YaTeCikqpuz38gFuoXSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986622;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:CC:Date:Message-ID:In-Reply-To:
	 References:User-Agent:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=YYev/NC+kvw4uKd6ceqPEumrLblYo4RG50oIiemWCCg=;
	b=TSAF+OZOKTBKLR1/fI8v31xD5sm9fDpruUZd3sTJzH8egCZvkYCuVRk6jRmCws1s+xjD
	 SkgR8yQ6kR8MBQRKHIEJyUMjz9KUdUaXZzotfQuK03CNkmwsyvp6r7Wb4UK6k15Nfa63C
	 GkzgrFM8ygfJcakKmkARZ7XC6/03MWo7shTvhJJmi54ln9GESCZWf3aps4cyKvPfa9COy
	 es6qe4m81X/JWCTfQmLG0MZQYnmleU1K/6TFG4ACwCNHI1mFwenf0kV6JVapaEj2vxNw7
	 KgI4JLusku8G+P6Gc3x9yF4s34tNqNnfA6I9R8QsX96fxTXknEaNefrBHNKxSDNDCug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UjLMT01q;
	arc=none smtp.remote-ip=74.125.82.97
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A4606A32C
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E02A4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UjLMT01q
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1276266c88.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 09:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986621; x=1794591421;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYev/NC+kvw4uKd6ceqPEumrLblYo4RG50oIiemWCCg=;
        b=Aw47o5C0VVkrMSa+EpqbS91Z7hG3FVfDDwtBIhXWxsalLZqvKGYa/LV1OHX137Xv2R
         fdR3MaBTHxdpQnx5h6pJcIUlbiBXadxCPdLLX0035eMAirVSm2Pkatpv5d5l1uOuUZro
         uz9uCh5cQf1UQ7Lyu2lH9YSLweXXv7Pm0rxMuKJaaAUF9MYIzmcQ9EcCKQq2ueeOvR9E
         tBhaFG8zQDITH6OU3SoawFuc7Gxn+GgG6F6DljbFwdhKiWFljRgoIaaxsJ610AuoXsrT
         2RE8KFtEfUekbnnmpfWGo+tiIijaywPT2F9u2/JkkRZim4UzvjljOEsSg5x7G4MqQKya
         jnaA==
X-Forwarded-Encrypted: i=1; AKwUvBxsfApEdSy8xwqVh5/Qve35pMJYthy721QWNY1xJNCoo+JrfNlD3UxjO0vFhK6XGY49utRp0/RSSOjGjMACDnE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CDKri3ikoWD3lYk2Eh6yty3+HUAaUV+Q2EReTRfSAv5lUU8+i
	kXqpGQHYZ5BR5o4YPc+sYYlwpuAvR6uHWzjlgrYTi60rjp4RvoNVvhQR4SD4EHiHrLbLHEEjkyM
	ea6JDSf9WGFjeL/ZvqOwQwS3S6nq94CBR9X35ntBe1Qc/9H8n1OGKBUjYvwuZ0u+p0etcnIGMHm
	m02901SYlm3NQZ3TvyIydcwGvKN/mx7pEnaue7qO29tR/GqYHR5dDGaC9D4Dac805cNA2Kty62d
	5Wmdeep9m4EKj0GYdoxDP1b7UZ41w==
X-Gm-Gg: AYBFou2aPin0+vZABG0laj9usU1hEToDQPwpS+YNQqJvqwWc2OG7M/0XpUwnTa+9MV0
	CHUhOSnNjdAE0Ui5a40+vBBrZ76N9IU49eHQE1jiuG4lgmC1GxjiV4tRen25zDxgooIwJfzKTAJ
	l6uNJx0k4pyK+8L4ovHV2hnSLvdwc/irB5uUOHNEulI/h9iQ72FNBO3XF0U1I3grbinHGXhZMgB
	UwDoaJkoCjkdckUV0uBUAE8sks0Xf6qy7gQOFjqNzGBbqGIZZwW7SkM4fptYkksFcXkC0cLrp2S
	+rOouFLsxs2BCuUS+XEFUgb2EzUsyd1xUYUvCQvZcvxbFpkSWAteILLa6JDDcsA8cTQHUcpbVGn
	o4nXXgokdJtEqUTU7v5MJv9JKFlf3v2cXMHPDVusNQL7g0QFYmRtVjADObQB9G/bq2Ooavtd5Oz
	hYZ2dWhonDxnHFNH79rvYGHhi4tV+dJ7yX826tz0w=
X-Received: by 2002:a05:7022:1608:b0:1b2:3a68:f18f with SMTP id a92af1059eb24-1b25d32b2femr3555830c88.22.1793986620714;
        Fri, 06 Nov 2026 09:37:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1b25e48e0aasm80131c88.3.2026.11.06.09.36.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:37:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1bc2e62d5so1138130a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 09:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793986618; x=1794591418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYev/NC+kvw4uKd6ceqPEumrLblYo4RG50oIiemWCCg=;
        b=UjLMT01qgb5jh+U/1zOPAzsFWt+OBveBifEUvMto4uDWtCuU7rDkfZCxzXXpGRjkN4
         /UIO/JnVYQ86vF7NM6XFAwqonebR9Ki6QvvwVR23qxFPu5c5l4GhyZRoHjsxDcjSi0BK
         ORJeC2oBZ4UJHbC2vmY8PsLw0+pCdRgP4nj50=
X-Forwarded-Encrypted: i=1; AL+hErGDZsKPGLvs9BLKOF/W6dELsdSwgtj15LfQQwp07yqEkxZD4wGxaYxIu7S73krV9vbb03lpqjyDb22gdcXgKzQ=@vger.kernel.org
X-Received: by 2002:a05:6402:2b92:b0:6b5:90d9:70a with SMTP id 4fb4d7f45d1cf-6b5977c1176mr2516053a12.15.1793986617823;
        Fri, 06 Nov 2026 09:36:57 -0800 (PST)
X-Received: by 2002:a05:6402:2b92:b0:6b5:90d9:70a with SMTP id 4fb4d7f45d1cf-6b5977c1176mr2516038a12.15.1793986617494;
        Fri, 06 Nov 2026 09:36:57 -0800 (PST)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ad2d0bsm919103a12.10.2026.11.06.09.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:36:54 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: =?UTF-8?B?QW5kcsOpIEVpa21leWVy?= <dev@deq.rocks>
CC: <asahi@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>, <dberlin@dberlin.org>, <frankyl@broadcom.com>, <gustavoars@kernel.org>, <j@jannau.net>, <kees@kernel.org>, <kvalo@kernel.org>, <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <marcan@marcan.st>, <meuleman@broadcom.com>, <michael.reeves077@gmail.com>, <pieterpg@broadcom.com>, <vanhoefm@gmail.com>
Date: Fri, 06 Nov 2026 18:36:52 +0100
Message-ID: <1a1b1ef4b20.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20261106153612.2aadef2a@kait2en-mbp15-1>
References: <20261106153612.2aadef2a@kait2en-mbp15-1>
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

Op 6 november 2026 15:36:19 schreef André Eikmeyer <dev@deq.rocks>:

> Hi Michael,
>
> I tested 01, 04 and 05 on a T2 Macbook Air 9,1 (BCM4377/4). IIRC should be
> the same chip as on T2 Macbook 15,4.
>
> Arend, with the patch we get D3 ACK on s2idle and s3. So this basically
> renders the D3 ACK WoWL workaround patch obsolete, you recently acked.
> So it will suspend now without refusing d3cold transition, but BT is still
> dead on resume, which is a separate issue. Just mentioning...

Sorry, you lost me there. What is the relation between the patch in this 
subject and D3 ack.

Regards,
Arend


