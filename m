Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA583CC7EB
	for <linux-hardening@vger.kernel.org>; Wed,  9 Sep 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990524; cv=none; b=TtiiXJQccsbbO34cua2SOOiWDxkgvbLgR49woOT6cJOUdPU2Qr6SMLFeUNUV5eAUV6P9rcxKhFDOSpvTNp2e7uUK9KEV4Mp2Q8xdWVJFb635+yHEOubeGP4yObEvUM5hX7EDKQjTUhM9kjILpA2YPUwy2H3+5JWReEl4q7EfhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990524; c=relaxed/simple;
	bh=SSTwEHCWAc+P5g44mSyZbT9L1Ie47uSnjWAmoKDqiVw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=DaRsqMiRZxzty/sAqygrRRiHLVulflK9pzBc7IBbbPSorRIJwEWTDFfhc1xzlitRHN1eGg+iglzMAxp7hK02HI4c2pyHO5hwm+KcaWV57q95QQr+spUHbQYmJfCbYervVemKvJPnVsqCb9DJ+5yECkuBh+JiftSsmpHQRV2EU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bcyArZYq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bcyArZYq"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90e8e70fa02so67871696d6.3
        for <linux-hardening@vger.kernel.org>; Wed, 09 Sep 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788990517; x=1789595317; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWlaXXsiZZ3hxWAJkSJI84Lovlcl0MiT9GyGYtm/owE=;
        b=bcyArZYqhEec8abeb/GPGfpTZ3GKiWJE631k4CpaFSKMfgxO3nw/KamJHwAYzPuLxS
         w1NYiGJAI8lJ4l4BdPWvJTu+D/2l40le9cFNi2goniJJjZBc6hibiR30Ww2bSBVL9o0E
         O+nOhfgE60RLjaKC0t+JeSmiNo3Mayg6xu0GWdy7mIwsFuQRFcqGl0vEsmcLomAUSP1T
         nE0l7OkYARftuYFLI/iqE1L0suwKjBXdA4/ZOjoI8rNX4tPDHWZAGXuZMshQuSZA5QH6
         xEAPFqCjaMULxsYFaeojsumQZIO6D4ml8SzpMqlmajhrJzaa7+7nGTOUrqEVteBb6MZL
         xsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990517; x=1789595317;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWlaXXsiZZ3hxWAJkSJI84Lovlcl0MiT9GyGYtm/owE=;
        b=Z06ypMOyR23ee8qUpRtP7uFMGfiock+0D4pqZqiYOiH1RRPaOMV6NlkOvb9HoqvngE
         aVBVxQ6CVwVmntSaFWNLdeVf8uJKlX+CSQMyAVVJKVmNp7QuUNU5GpwXh85e3rSjolfk
         rmrFuFJUYcEY7C17wntvovKgdZY9TZd5f0ep1WOe3o1X6abQxDujrd9UCRDKjCu2kGg4
         /IVOl2BVe5xQBk4257WVKZ4oqU290JwZ00ZHleba5dMnxq9whlXeldmim3C+Y99I4kFL
         1/IscIfdfvbIvjgunBNeyWiaJcyJ8mmj4MLgeCmqHrD33nWxxfJ6On00cmi0IU4vYwlX
         0SlA==
X-Forwarded-Encrypted: i=1; AKwUvBxc9TEth2RabAj2QmSIN3xRxc4qnGDmsqyaqtgM72qS4ayoonO5z4DlJ0g1Boxsw27k+L4LHBYKc/YVPzdNc2M=@vger.kernel.org
X-Gm-Message-State: AFuF++khri9OjKVIjfX7hE0Cjk7uQNtDUaYrjM0TIarUP9diLVJqAQ1+
	UcJuf5fsISFsx4G24t5dSRgedwLh3NJbwugoFn3zX00DWUSDfZnZbRIpAB5wpBvMdbqm0BOI9SW
	4LCd/yw==
X-Gm-Gg: AYBFou3X+7ImX+9Lhe0pnHdMvKqDx8sGkaQSSSgB+dlWMej+TtaSbd+/7WafKLeQUcU
	9OfMYN3VgzxzCsYWGGNjhw8ri9FlUSJ/9PbO6n+GwYDIRV5HCPQvTv+is0O0f1oXr2WbDWIzl6i
	YKPiJBCh0PLaIOY/vxSvhd9lsBbzpxrqBUCtJ4QUj13eEQ7P2G7HHML4YCtcqrEmauLLvUwlpHs
	myjIqAsClGrhF5GCbESFKAGhj4ViUbNsmWn9sisF0gnBysIyCRwZpOYDysMbBP+wbduJoX3eANO
	4+HPLHPxrp4hX8naa+A52Pq1hVWZeip1FoTzeYQIDqdBjXLYdmqYFhSrJ2181cnDxh3PqcnvRYc
	whGv6MSAjssXR1QODiGC1rYtNUtxRMxjRCVYRlYs2EmTa8Usy0vls71T4pEn8Oq/AUlfOoyf+7G
	HfuAXfvKSrfodjSt9f47mERLbdtKD634X8WRUujonxm5S5uKwVe3I/JT7D/GdXiC8arzrCuQzyA
	Q+y8UZaac7xPtZcJog5wqVfV9D6wbL0rOFp1GggAwLhhGBhpTJlKupor1kwjaMa3WKWliQFhQgB
X-Received: by 2002:a0c:f00e:0:b0:90e:9361:d035 with SMTP id 6a1803df08f44-9103ef8d87fmr444413406d6.21.1788990517405;
        Wed, 09 Sep 2026 14:48:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91203ca1063sm2439906d6.5.2026.09.09.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:48:35 -0700 (PDT)
Date: Wed, 09 Sep 2026 17:48:34 -0400
Message-ID: <5b09aa12a73fa955c49a4499dea6866d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260909_1743/pstg-lib:20260909_1550/pstg-pwork:20260909_1743
From: Paul Moore <paul@paul-moore.com>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Serge Hallyn <serge@hallyn.com>, Vlastimil Babka <vbabka@kernel.org>, Kees Cook <kees@kernel.org>, linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: Re: [PATCH v2] cred: prevent slab cache merging for cred_jar
References: <20260611070054.6550-1-med08elkadiri@gmail.com>
In-Reply-To: <20260611070054.6550-1-med08elkadiri@gmail.com>

On Jun 11, 2026 Mohammed EL Kadiri <med08elkadiri@gmail.com> wrote:
> 
> Add SLAB_NO_MERGE to cred_jar to ensure struct cred objects get
> dedicated slab pages, preventing the allocator from merging this
> cache with other similarly-sized caches. This is a hardening measure
> to provide type isolation for credential objects.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
> Changes in v2:
>   - Collected Reviewed-by tag from Kees Cook.
>   - No code changes from v1.
> 
>  kernel/cred.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks!

--
paul-moore.com
