Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1564A8F;
	Fri, 22 Nov 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303208; cv=none; b=I8KoAULkK53LHSYO61mzEiqHsj0mdJd4WAmGLRmIrz/KF/2ggNIwgos+VYq9pkkIOcgjK/aTk+GYuo94egMduysGQdgaK6Ckgps8D5OqsbP3k6YzXk4Hx4zC9QABKv17J5uzPbCtQSyi3KdXqZiADQGqoZLrHtfLb0v+70ohZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303208; c=relaxed/simple;
	bh=IJqKO61TM9XP2RmB8ANgFC19LG4p96drIqNmJtPdHyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkIBSlA4VYJC2YyHZvHBXBCTUKk3vorg4ADPOwqoa5rMWc9F53kBWyPJFYFRhV3TZDVIRfqAcGJbfACTRPRnuf5UHPaA1kfN4IHez/4AWasIkjwgn6quJVtR88bVRaaU319ZMbofHS7UlzlaveQJ+mk7b698DKTbtcHJgwClbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEiUXj89; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEiUXj89"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfaa02c716so3150584a12.3;
        Fri, 22 Nov 2024 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732303206; x=1732908006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmPHZq7NvbuC3A6VuT/FeDUicgcVWod/bDQW4ILw5hM=;
        b=SEiUXj89nEBtsqNdI+GnhVbQr/8FVSBsfWodkym62OhLsj6drtnPhcktgGgw8czLpM
         YalvnAsTGVCqr5LprR/yJr463u3zzsvTbDvfKctMcGOgsj+gbPTdKCy7RfuqibuFm58H
         WVSsCdyhvIaMUavi1fKqje4aU0c5XkCPSRFESGNDtp4YHFA+Uvl/0v5q0ANB+ftyOg3M
         1R/lLHLifjZ4nrsPKnj2OmrVoaYDl0J4iSzNUtddCqpMWtTxwq+tSi4ym67tccGOME4n
         1L+ywpGmon4GWq4j9P75EyO67E/V4vTJK0ldF/KuzNons9VnUXrRItaQ588f8vK0a7G0
         iOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303206; x=1732908006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmPHZq7NvbuC3A6VuT/FeDUicgcVWod/bDQW4ILw5hM=;
        b=tARJWxotBMUCHSMZ79V1/qo4KDR23lKSDZJmDyHCKO5C8X+kzWhqc2nh8bwOvBCs91
         m0KwbeTkigqgxOSYNaYIsHxsPQ1E6bFY6BCA4PhrMVdDT5L2uXPEeoo7mfOFHNsn62yk
         3DYpF2Mvipwm00XAhUMlRME83zGvFSyhhBXut0/lxcsUypiTWzJaBbPanKrFV1TZpzHX
         KKZt9Tw+qyCetWorE/Zp9xA9dB+4aiyb5m2CekchP5snDW8BkWMDqAjyGDm66aD3Lwll
         4EUwwPp637XPprGuT8lkq/rJQQaUdlXl/Ng9LbueHdjUTXg4iW2z4w6NSHGopRuI9bPY
         ObNw==
X-Forwarded-Encrypted: i=1; AJvYcCVNN8KGTgKzbXlNpj1nrEGiSb27BZlMXVG4fiZD1nvqSgzrUnOBOhaejDEw+dogXD4u0G3A/HzBVP/8P5luExQ=@vger.kernel.org, AJvYcCXhe1T+dwXT1ZijZdC7J0FQ5SeHDNbATVtc8MZt5hN3nkdnOBDzdqT9I5v44Eufj1naLGG5CF7JEJwmSicr@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIqgQWD9xBa0elnhdA7S+XPht95kOmpXZ/6/kVEBhWoW1Qr1L
	9xsN+jxRplIoDI6qSo+Q5C08R0u61uYeBcqWOVxtDxXNV2H2M01cuAK7CVHPAO31VPA2rQFF0fQ
	thSgMei0DhaegEM5d0cwh3/QoXbZxXYWbbMspYw==
X-Gm-Gg: ASbGnctORCa3dyiwI87ngq0ABWSPbSg5Tl0o6jhvkv01eeJlfw5oCCTQbPUAy/YOtTA
	nEgcIdhbPcnhyPYtJz6LLtYFHrurIlGpt
X-Google-Smtp-Source: AGHT+IFXiqfnLVQ8D0j59J/GYxw4kf+YeOP932hoVzW/jRsfs6HEsvVxld6iWnpKMdecPrGAqrHYjlrI0xQ6I7taMUY=
X-Received: by 2002:a17:907:7812:b0:a9e:d7e3:ccae with SMTP id
 a640c23a62f3a-aa5099389d8mr369578766b.16.1732303205427; Fri, 22 Nov 2024
 11:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org> <Zz4vzSRcdjvWNIgK@kbusch-mbp>
 <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com>
 <Zz6q85eMTko7P-Y3@kbusch-mbp> <CAOZ5it3xiMwD4_HsgXR_7-ERTzoS+FG3W5Og4sKtgthFA7HsVQ@mail.gmail.com>
 <Zz92l2gxYtK4SUC_@kbusch-mbp.dhcp.thefacebook.com> <CAOZ5it0LKViPsOJrfLXmB-zk1OGWhKT6XMrj03etV-MA8-HOkQ@mail.gmail.com>
In-Reply-To: <CAOZ5it0LKViPsOJrfLXmB-zk1OGWhKT6XMrj03etV-MA8-HOkQ@mail.gmail.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 22 Nov 2024 12:19:52 -0700
Message-ID: <CAOZ5it0L7D3sXpZkGVatvj1df_VUFWCX27aKgCkbK8T=1G1H9g@mail.gmail.com>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem. corruption
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ll go ahead and prepare a V3 patch series with the following upda=
tes:

- Using an xarray for vaddr-to-block translations, which improves the
performance of free operations.
- Removing the minimum DMA block size constraint, as it is no longer necess=
ary.

Let me know if there are any additional suggestions or concerns to
address before submission.

Thanks,

Brian

On Thu, Nov 21, 2024 at 12:07=E2=80=AFPM Brian Johannesmeyer
<bjohannesmeyer@gmail.com> wrote:
>
> On Thu, Nov 21, 2024 at 11:06=E2=80=AFAM Keith Busch <kbusch@kernel.org> =
wrote:
> > If you have the time, could you compare with using xarray instead?
>
> Sure. Good idea.
>
> **With the submitted patches applied AND using an xarray for
> vaddr-to-block translations:**
> ```
> dmapool test: size:16   align:16   blocks:8192 time:37954
> dmapool test: size:64   align:64   blocks:8192 time:40036
> dmapool test: size:256  align:256  blocks:8192 time:41942
> dmapool test: size:1024 align:1024 blocks:2048 time:10964
> dmapool test: size:4096 align:4096 blocks:1024 time:6101
> dmapool test: size:68   align:32   blocks:8192 time:41307
> ```
>
> The xarray approach shows a slight improvement in performance compared
> to the maple tree approach.
>
> FWIW, I implemented the two with slightly different semantics:
> - In the maple tree implementation, I saved the `block`'s entire
> `vaddr` range, allowing any `vaddr` within the `block` to be passed to
> `dma_pool_free()`.
> - In the xarray implementation, I saved only the `block's` base
> `vaddr`, requiring `dma_pool_free()` to be called with the exact
> `vaddr` returned by `dma_pool_alloc()`. This aligns with the DMA pool
> API documentation, which specifies that the `vaddr` returned by
> `dma_pool_alloc()` should be passed to `dma_pool_free()`.
>
> Let me know if you'd like further adjustments.
>
> Thanks,
>
> Brian Johannesmeyer
