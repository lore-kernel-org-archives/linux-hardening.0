Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EB16F0CA;
	Wed, 20 Nov 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732139950; cv=none; b=gUoytCnLeHsrOhGm/blmZAcNv/vOQhFYPThKxRITefx1HZIAE4JwLRQPVgeJzRX6+NflQru6dLSLheLPBbFOH3OLzx1jjNhQlCmdQh4AGDZV1aRiM+lcpnSdWy+SPnxaPqIQhJIi67fF3hqfUUn+WrOucnuHQmJQRjGCoLwz0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732139950; c=relaxed/simple;
	bh=vbCM/2Crg2zyuKNynG1p9LGYZ5isHcDZ8DKVO65fTCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evhu4mpFICFuOmni3YjR9RnNo98zpRuPRjLtBe2/i+QqCU74HMwOaiGOxuur3AhWc6lcjsZ9EtH3Zd+68njDT7MNGBPc/qBLOcK8qRDTfS+K5e286i5E8vlbEC7/5fUQLIfsOlNgZN9LFu2FiScCuir4M1CENYo9TrmeVU9TC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVItJtUo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVItJtUo"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso33424966b.3;
        Wed, 20 Nov 2024 13:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732139947; x=1732744747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Faap3VyEdC3wzioh+4CPsVXtj2eSEp6gz0ge1phVFWk=;
        b=mVItJtUofZyG229SqIlJU4nBLhh2uRPchX1e0CFfsnmtuB7rwwg8utKZC7I3dEeuI8
         o7EiHt6uIxx94KZv24GBgJzE/lo+0COZ7XpeQayFkgwZqFhPZ35D+XcigA05/GtgIwYP
         O9R3owDiiIMCnewuxq4Uzsg2MFOKI/GehmAwbGR1gPEvmIVfwa97wDl3+FILxWM/v6aN
         mFrriNyVoS2NHBWhxuEh2sPGkq3E1xuuTgiNIXMbVf6rWGiMsAacEknFmdd4IgJ1gf7A
         iUkWc/oDnuhozNOxVwOd7ceJ7YfTLscbG/JB3KNF7fCFtapD2Jwg7QxTsc0RNwMHePRO
         gHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732139947; x=1732744747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Faap3VyEdC3wzioh+4CPsVXtj2eSEp6gz0ge1phVFWk=;
        b=o35bUhHXMsWF34R5GPr3iEWuxLL40GSiTnFxwTPBaRHSOzB1q+X/A2AZcFb+3bq8EL
         RIdS/talQpKcnE86JqRX7CPRHqkoIrF6Tw225YyAtA6/iKm97j77/IgltJokhP6rkGfl
         J4BiECqXmP1a3vD63Xs3FNGPn9HkSJ02wW4PgYKSMEORnSrhgow/lQFEYZYJ7fVEVAxS
         QUKoDq6/+QlGJoNKPTdzOmH61jtFmFDuI/Cca6WqUuv+RvFh+AdfNEkJZVusGWZAILmf
         q2fvn9q0PwzqVp/jenvxwtQCyhSGZ4vJJVuTpkEIzAGv27kSmuKaPE1hcq+6FR47c2fr
         DpsA==
X-Forwarded-Encrypted: i=1; AJvYcCU72a+pMUBv0Nwk7CW8UHJDvkQ4Q4hdynaSGSPG8T8ZLQTE3bU2D2i/jQ7wZmGBgpOg9oDOzHH5ED97z9I7rJU=@vger.kernel.org, AJvYcCUON/gkdFyKLR5TgD/5kzl+zdz5YiKre+ETbpiDmK+z29LhqtNnME4u44iS0pG53O0vH0Zd17LUZNQc6dJ/@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiH0g1Decqd7BILjxDU7/ZYliYi9yU6UA7DXFux1Fx/wXl7vo
	aS4p+3yrmtoFnp3qsv3DHAqhFITpzgrtYEYaK5Nm4uGRr5OUQBAeB/dOu17PVKHvjoUKjSYOCVN
	nxSDPPQ8OR9l7Oee4wbZ1qGbPQ/qixN0U28cadw==
X-Gm-Gg: ASbGncsJbsSCXUnFTdnYIhX4EeUq7jwa2ICmC+UymRUC2DuQC5CAPOJFnNz4DUa8JvI
	msyXRhhQgOjEYARGLyackGs7D5Bym7jGy
X-Google-Smtp-Source: AGHT+IHluJPs2mffu5jOBAkShUEdZ9UhfbGkDRkJHNXVm15+4lFadUuU35lLsiKlOViUyZuNr1PrJYnEFbJa5qxoxEc=
X-Received: by 2002:a17:907:a4b:b0:a99:eedd:6466 with SMTP id
 a640c23a62f3a-aa4dd552290mr466855366b.19.1732139946936; Wed, 20 Nov 2024
 13:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org> <Zz4vzSRcdjvWNIgK@kbusch-mbp>
In-Reply-To: <Zz4vzSRcdjvWNIgK@kbusch-mbp>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Wed, 20 Nov 2024 14:58:54 -0700
Message-ID: <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem. corruption
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

> You should probably Cc Keith as the person who most recently did major
> work on the dmpool code and might still remember how it works.

Thank you for adding him, and apologies for not including him initially.

> The intrusive list was overlayed in the freed blocks for spatial
> optimizations. If you're moving these field outside of it (I'll have to
> review the patch on lore), you can probably relax the minimum dma block
> size too since we don't need to hold the data structure information in
> it.

I see. AFAICT, relaxing the minimum DMA block size would just mean
removing these lines from `dma_pool_create()`:
```
    if (size < sizeof(struct dma_block))
        size = sizeof(struct dma_block);
```

> Could you rerun your tests without DMAPOOL_DEBUG enabled? That's the
> more interesting kernel setup for performance comparisions.

Sure, that makes sense. Here are the results with DMAPOOL_DEBUG disabled:

**Without the patches applied:**
```
dmapool test: size:16   align:16   blocks:8192 time:11860
dmapool test: size:64   align:64   blocks:8192 time:11951
dmapool test: size:256  align:256  blocks:8192 time:12287
dmapool test: size:1024 align:1024 blocks:2048 time:3134
dmapool test: size:4096 align:4096 blocks:1024 time:1686
dmapool test: size:68   align:32   blocks:8192 time:12050
```

**With the patches applied:**
```
dmapool test: size:16   align:16   blocks:8192 time:34432
dmapool test: size:64   align:64   blocks:8192 time:62262
dmapool test: size:256  align:256  blocks:8192 time:238137
dmapool test: size:1024 align:1024 blocks:2048 time:61386
dmapool test: size:4096 align:4096 blocks:1024 time:75342
dmapool test: size:68   align:32   blocks:8192 time:88243
```

These results are consistent across multiple runs. It seems that with
DMAPOOL_DEBUG disabled, the patches introduce a significant
performance hit. Let me know if you have any suggestions or further
tests you'd like me to run.

Thanks,

Brian Johannesmeyer
