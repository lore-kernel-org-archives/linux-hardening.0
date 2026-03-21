Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1B38BF6C
	for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103306; cv=none; b=q7yAag8p0ulmQfHE0lQirbPsu6OkVCUiTaW7Fv2ZS4jRCKfsEmCu7rmFDtXQSczE2lpKJFucqFhCK2UDQANiIt9EwjRmVvPuO8gmzsmqfZI2dUYQdaar7g9tc9NHak2u246SaEd9P2L5cYdxEXjF4vl1L3J+6afCV0TCbcGjQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103306; c=relaxed/simple;
	bh=Ljm9lHSWHJuvEOaPyKMhOHXf0fTCsJ/D9lwyKKoju7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTKYRDS9IyQ4M3wdDXuJQcnOTZ4nUPtP743hd4GlaLXtG2Dc1ISAMlg6IXzxRLeYoN5NModuaXkD7syfix3Wekiws3VE6jo3jUkT7XdoHicm9s5TWkbS0/5ySVNeynJ65huIuW8csbOftwLKIY9/4e2WNrp93MTXKp/NL+vVgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D/3B61aJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D/3B61aJ"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-46701f2077cso2867969b6e.0
        for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774103304; x=1774708104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGeFtEcePrRuGM6CVPtSo2iuVcZXXricGsZQ7tQ5chQ=;
        b=D/3B61aJ8a8WPzCw5ztDzz0FSJUiv/Qr9mA2lG235GydGFjAmzb1xZQeGuOxmxFYxx
         9g/O2OMTTMLLOaKS+Kkl7Mxi4zlKIngC2tIdx3fTsn56oaaaUMAFWhVEse+CmNAoWJWE
         n7rDD3EUYIA0GnTI+duQdSCQ06hHgD4Fdy+ptJC7B6EXwcDPmeS16DnBsXzBiewmKmkq
         RXCcD9a9Z1fvapboemM+kMRBzjQ3uikJbGtTP1jVe+LvytJSy9Z4QxfJ2DBOYzmkyUP4
         vcOYFMkkxoA5qQhsKyiK/HutQhxhEhM1LFAEqTtQCY3/6mJb4T+wRZNryQ/Yg/A6ytIL
         yjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774103304; x=1774708104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGeFtEcePrRuGM6CVPtSo2iuVcZXXricGsZQ7tQ5chQ=;
        b=aqhocEXXwbuGlM9AWRRUq/6FTG0Mk+B1jjit2RgeMHe0wWCsUqIK3i82GMDtBXjOgj
         d1MU2whe1nZ/oq4NTcHXHXo0BxsSUA/dpRoc5WR3l+2kzDOTc8fW91ZZhqeKEpoVP9hg
         0QM5TxbuQAl8J4Ir8OUmr3HnyLdhmeORr023IgkeP8LXSWWdoGmM6tvQD91twqpmoR05
         BASz0/vpbUuHHYuJyEhKEA/gnAfD0pTXx9wFqZG2fLyJuHTj9RDdRujPyjW4BJUi+DA3
         hJ5ZdgsNq8vK6Q/rYvbJFhl7RBJsFGZwWo7H5HpegB/rOUlPZctgx8KuAh8q+dR9PEIo
         infg==
X-Forwarded-Encrypted: i=1; AJvYcCUVvXhN1V2ee/J81Xtp43cU2LF3a61VLWLzbuwh2Br2NcYEvprRzeJtHhFdupwh0mU8X23ZkCc7LfuwvSuFWrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMJ5RTQqGtP5Eu/N+659vQ+LROlKcwXp09cRd/4hEOmdocYAU
	pnSmZuwX72XrphxNzjRN/yO1Yi11+vEBqtjeiF158MeXM8aQH8/XMIMKSbi1JU92JNM=
X-Gm-Gg: ATEYQzy8204mbR2sK5Le0i0TUqguC+AyRTZF7sCxoEUzD8i2lnQltUi5F/XX6nQEyJS
	h0zSfvo8XCLsq1QV9YWpez2q/XtnDXNc95R3/ZQ7p/ketc6/U9HtYmmP/CfcXb8mH0VYxUzbJTh
	zEGKr5T2g91/rIV97/9RZ1z1Ds7SYlJIrS3QKxF9/Psk1066NMpWoFNLkCJPdTpL46R9RIkcYC3
	W2BZuaTABlpFfCQfJgnXTvSbGYmmud9grjNXvNd53hHwIi/FB/fABvaIPX8qgWPbgTeD5UpkoSv
	kpd95Gd7eS4QaSuVULwG2mmGRg7tM7ivVkj7BZMXzh5QBMQqImXF85otXArjAvhsGW6m42HqeQS
	D5Nh2yfJRkh9j3+tyGDD0IsTok5MUYx9ikQ0SXTWzDuLvukPR6hZ0SMMS2iLe6Zbe01Wp7SoFbM
	NYQJwBfYuya8NdBfiu+6wxXBMBHryZ4FnR/TiTGGxqwphXGiPJMNW7reQYFGUW0QFRf7VD8ZEB/
	qFfWt4t7A==
X-Received: by 2002:a05:6808:a607:10b0:467:f56b:5267 with SMTP id 5614622812f47-467f56b6c30mr1978974b6e.10.1774103304390;
        Sat, 21 Mar 2026 07:28:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddf9d4sm4797944fac.16.2026.03.21.07.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 07:28:23 -0700 (PDT)
Message-ID: <12bb0db8-e8a3-4e08-89e9-db9a1348bea3@kernel.dk>
Date: Sat, 21 Mar 2026 08:28:21 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: Replace pp_buf with struct seq_buf
To: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Stefan Haberland
 <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Richard Russon (FlatCap)" <ldm@flatcap.org>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-hardening@vger.kernel.org
References: <20260321004840.work.670-kees@kernel.org>
 <D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/26 6:08 AM, Josh Law wrote:
> Reviewed-by: Josh Law <objecting@objecting.org>

Please don't quote 1000 lines just to add that, that's somewhat annoying
in terms of scrolling to find wtf was said, and it's hugely wasteful.
Prune your replies.

-- 
Jens Axboe
