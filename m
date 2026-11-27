Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790138;
	b=UtR2AMajM2s7NfqYlJCeEsLhXvUK67uUrrWUm8rk0D/w5Z6ot8CqP/NYd621AICD3SA/
	 U3lz+SYHM0XFHQEl6waZ+xaTlvwmId8BKcWHVGKQM19vHBPZWoerYsBm0t4jtW/hRnks1
	 djO6mIVIkDSFMPUlG0ox/0jEJUIF8s/w6QdmlmhA209krxzmUIrJBqaM9qzv6/nlX1QmI
	 cGG6ujM4hT7I8PCtchII88p6S/Ej5cIv2mVyKEQeN6I5tW8oJsu+DRz2EXpDvrHcsebwZ
	 CvZsdJxnki9yjU6ovppw8C0o1qOcAswsvPk8GeDYNFDrSib8i+FgNKcSuuMgYZBqQJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
	b=fuheSbbgZDSD6czvnOQKIV/fSG3ohPAtYMxvEHp793r4AEhuOTHf2sCOFi08UxO78YRi
	 XYNgBufaaMZqd2Eo/YCekvBq6PvN8LaoEGLWIqs4LY1jBcxih7JBDSo6PNmjYJUNCWXvy
	 Xp1SncZyXKY2Sg8VyixJjge80j80w53692wvTUspQuKt78vVa7EjuSh4Os1Phge0r2U/A
	 KWmC5j6ARAdaqB3lG6bbScv7d7tn8b9t+1kuECmE5sg5vF8/9F4OVTzoH2su0xNKIt0fO
	 y+tskWLHmJzTTxSeDYy0dCBwYvaBU0IR+TMflN2wbSvZsE0i4rI9G711K6RhZUbCMyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxYQVVVm;
	arc=none smtp.remote-ip=74.125.224.137
Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91ED606A31C
	for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 14:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxYQVVVm
Received: by mail-yx2-f9.google.com with SMTP id 00721157ae682-8b343763c6eso9019147b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795790137; x=1796394937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
        b=PxYQVVVmOW3QTmnUGPn/8uXuLs5v4r8yVSS3T/M3GF2IsTX5jt4Nbh8H7ACddJ2jt2
         sYlu+5hx2ke6hDAaS5ELDKTx9oDWWXKf0Xx7w1AEpSzL9qY3UcL8IukZL1Lpvpg6jprA
         0nXF2LeidTFzmh2+cLVnwlFdTMS5jXC22NVlvhUL9BLe+wvmOFiA/0VehHoBpUnKrRMo
         FsI86FZf6QaVF9RfOqx+DHHPrSXJqATdlsFkcU4iPiSTu+e4wcQXRNPJnMk3IdRkKF8T
         ay2mGRYiqrJUCXFlzNHU1ozd/s7msf5nn1yAirhd7IxMikw63n2fNrWGC11qVGHImfdK
         iVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790137; x=1796394937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
        b=L4nCAtdvDJuVJHlFTS25hakg/L+qcJ+ubqjCNsQ8utC4dlN4IQtmp8eXHrfiHsUtRz
         GOpbxPG8Ky/wVjh9JCV3SP6pHnmeXCm50WJNJ5aN7l++o8m8MFkPXbRvJqsvhaKkE3IE
         Lx/24lxKyVd0//t5akpfAIe82kOrmBvem4OYzwOWV1q088vw1p+tNDeJr0y5KzSSdKVQ
         7nQcQDIyI7PiVamBVnlkU5RDIMYfG5dnMX27jQIUxAOhwwgP52r7kHlLCMXhZTeX892S
         scNiqypoBgIjTbIsWtFotd/7rR5/0YZ6iqozDiekFeEnD68CTVDgrou/P6Kdc+eYpKri
         nNyw==
X-Forwarded-Encrypted: i=1; AL+hErGMSAp+6eOdwh8DKuQ09stUggbtJqnWnX+B2mihG5KbLqpSqIOjl0alk3M0Ec7xvO2XchnwZUW3D8464yi9h6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8psuFtGhH/Hp/o6xlEpbzZO06zm59b5/I/DCi4HL6G6rYjY6+5
	ez6HEbQYTFei4W3xdJBkafEL8LjIOnSGDOvdFD9pc+6YMoVmDuMlFqAE
X-Gm-Gg: AZFdTZdGw+D4bnIf/WcEB/U889ou/QFLqShWXoU3aKsanCjtEHYNV8UndQycDPrMMdK
	PQOdQtpL8+J8zxAR6hS7+brfF2Q7Zp/dl/j/5aC36jjlTIjn7pRVnaHib/AEiGZLbax39JX+YF+
	EfD4I1uKVEaSRBBR1VJt8gqWnHkw7Fr6AmTnWZvqHFW/pHU5eBAmScdB5xnztqxL4JZjP/Jd63/
	GMsBwQJs1e3ZxzsJwk7vcr9wBA5b5asU1GnMMRIx+4YYZCDCxSzsbRdu1+aUFMWVohmAIuyHo2f
	Z0qrvhAIWV9Scc3b6S+xW56dtfJdfUc9d1snEX9Cc6O2X8nbZ9O0AOqnkNRrZuAPFEe7U2yIOOu
	HaDEed5yOXtNS28JBHIDbSEhpqWYhZz7QdgDoX4uycx1R99mQmCVvGSWFhIHkbcuORe7WDCNaQ6
	t3PhQIwDjYR7ls8YZYigfP4vRWLF5y2LtEmTF6JK36dA651XFTUpzl9LLAMGfRqUXFXti0vTC99
	Qo/xa4A/lNdtTGVgdFs6zxv/iv1Raq8Jka9py+AGHrgpbmZCGqvgzbQrkK0CMQxXGvFjz2yzUWe
	idGulPJzt5EVgeHvybQa2bv32XSeOw1ARNBddqp0k423+S1gbczi/kcDJg==
X-Received: by 2002:a05:690c:c04:b0:8b4:c8c5:6b11 with SMTP id 00721157ae682-8b5204f087fmr129405847b3.36.1795790136722;
        Fri, 27 Nov 2026 06:35:36 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b59a06f3e9sm1537207b3.25.2026.11.27.06.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 06:35:36 -0800 (PST)
Message-ID: <17a445a0-16ef-452e-a174-5bb09940d3fc@gmail.com>
Date: Fri, 27 Nov 2026 09:35:35 -0500
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
Subject: Re: [PATCH v7 09/14] nvme: allow to pass in key description as dhchap
 secret
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 09:12, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
[ ... ]
> -     }
> +     } else
> +             count = sysfs_emit(buf, "%s\n", key->description);
>       up_read(&key->sem);

In my reply to the v6 cover letter (Nov 25), I asked that a read of
dhchap_secret returns the key serial. I would like to change that
request.

libnvme reads dhchap_secret and passes the value back on the next
connect. A serial in dhchap_secret would change what existing user
space gets from this attribute. Showing the description, as v7 does,
is fine there: the kernel accepts it on connect.

Could v8 add the serial as separate, read-only attributes instead,
kxchap_key_serial and kxchap_ctrl_key_serial ("%08x", like tls_key)?
NVMe Base 2.4 renamed DH-HMAC-CHAP to KX-HMAC-CHAP, so new attributes
could use the new name. libnvme can then use the serial, and it can
tell from the presence of the attribute whether the kernel supports
keyring keys. Today it cannot, because dhchap_secret= takes all forms.

[ ... ]
> diff --git a/drivers/nvme/target/configfs.c
b/drivers/nvme/target/configfs.c
[ ... ]
> +             } else
> +                     ret = scnprintf(page, PAGE_SIZE,
> +                                     "%s\n", key->description);
>               up_read(&key->sem);

The same for the nvmet configfs attributes dhchap_key and
dhchap_ctrl_key: keep them as they are, and add read-only
kxchap_key_serial and kxchap_ctrl_key_serial next to them.

Martin
