Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726132;
	b=SCGzjbn8rJaz1T6Pq4WYIyzV22VshuBOV0qo1wZgpOh1eXm8FcgCoZpuIASrs0weoqaF
	 g1zWB/vbiL3r0FDHifguKZCOV9XHD9ObWiip5QMMN0Qgkfpnu7VpYEBEctGMkjAyDeMPz
	 6rYjBAXlzdQL21XF35QBd3d6v4fSOaSU1yAlDJq+KtF8Ry28X4+KQmgeRF0UJTEl0JD+x
	 lndaY+vWsqmLy+Ia5hqs6tcaOtMzC9ECL/W0rkME6czmrKNV1/F66cNh/Szh2AWR8y+xX
	 nJQlb0cBvfx2WDyQ2juECj5ls3o7NX3vwT35h78VWKR2TDz8gyklQQTgYUgMfDG5X/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=WlvaTcb4vTukTns5YClT9/RRVqSRloX/GzQ0iNm2R4A=;
	b=TLKJFGoKWgxBtbj3K6xcEnfLO6N2ZEG7mq7D45x+dX/GUhjKynD2MoFWzz70rPU1VULZ
	 U5WuhYCCkun73yvFGURMizusuNfmJLpCh5+JzGRQ180IPD9J9ndluxalqjVX0eDjv+q7A
	 DL1NbiR8Zm8VITU7voE+U+fXT6VbO+eaeLEG5FBw1mp+SEp/HZzH6qtGeclDp3hww5+5k
	 DT/xtipigjP0u895SMnbv8aWemIbVQtsmRiwEC9cHkAw7GOfkFOnJba75NgoVVmcJ+Su/
	 LGkTCogDmntFtdqQ2+AR/wkTdFUtNSulJG1fB7G+4Y8DkZL863mOZ6M+kZQMZf03YQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5VT5x22;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A6606A327
	for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 07:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5A6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5VT5x22
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1370652eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726131; x=1795330931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WlvaTcb4vTukTns5YClT9/RRVqSRloX/GzQ0iNm2R4A=;
        b=T5VT5x22hAvEetbfMecA5QGtPWcaor6wWjOcqgkDwWOu/4+5R526HOiSKJfl7GZg76
         PEoBu9NaR17qx0nHrxX27wL5iS6kOTIsnFQDGpRi5a0jNSkJpG2Bzl8CZMPxjDRU6lR2
         y6fYb1wZRtUOUpTBvb7e1XQrJ0xtOll+4UOhxhZaG1M2w4wIfH/n5IeSl/jbRPcoQmZ9
         uQ8+DdyJWhrG/QATWjuuWrLuyet34UJf3CrXkXXYXjL2xpYroFoQsYC6pgrVZ6448pF/
         Yjkwk911G91vu0ZHwM0RzJizQ+bj/kgTpr6iYjpP1k0cI7fw11dzirBZMme6qmF+3YEz
         pV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726131; x=1795330931;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlvaTcb4vTukTns5YClT9/RRVqSRloX/GzQ0iNm2R4A=;
        b=i6RRAyDjaLklrnGO4ZcA2m/u40lDf4+wEnSwxv0M9n2xnRpdoHBG9XZrBIO1vOMaz3
         yPzjy3H/GK+V69KMEMCZVTc1usUiFPQjuXVBChYmsXuJUzlVktrBfXSaKjbpQK2HRNGb
         ctsBue/SP/lfqgsjwqDyD8bYgDU/xtYoih/ehKOOZ3UvOFl4zyjM3Yx2WgAAaTi5abxO
         vLkqBc3MGlocNkQ9nNaDEHBaF99DH6MCgMtHLm5M3K9huf5u7I3QdwIEZaDXbPP8zFk+
         oixHEciyHL4l26XPwgjcSDzKEduk93SP5RsyLLxFhWzmKFNEN7T9RFO80mFBStxYHdHC
         nEpg==
X-Forwarded-Encrypted: i=1; AL+hErG7yvO3iANhQdyj3yfHs0TUsNktJ9tXAI6QVV24CuN2HCXf4l3+1xeePdIYVdQCCFXXWaNwOqHEd5jOFz5N0Bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z97s47sm8ARhNY6OdT9TRDnFvxvmHLCryRtgD558N8U78lfxrgt
	wZ6pzW+1HFavodgr34875g0O5cNGYrYOMcNrGueACD63QXVpSvVEoXjy
X-Gm-Gg: AYBFou2vTsD+Zy+zhRl7gHgd0rYj/JZz1SBTEsuCGtHZ933CU5esR5url6RUK0e6XUL
	lk2MDY0Co05OkuIP9HHAbxPW+X8jTRlCEYZS8NTmB5fw5oIPeM6wPoN5nog5q59QiWP74ZkLwV7
	vyWyVjnFJY48Xcy3zZo3gAelQRQLKyqlnaFmoVCU2XBYj32pFWMnNr4rHeSr8UGIn45tfg7NkhQ
	aF+1AKFA4Ip/yR0gsDkDunbzrC1/ldg1okSuPpKfnbOURLi+kuttDATcbIyRVZzw+np5xmZdN9K
	YGUUCR65gqMrj2/P2enaQdIAXOmOneAr4wkn56/NyO72HQYXfIwdDfjKDUrtgPG2arKvvaOXHpq
	hHXzr99tkDYt6oTKVWi96AtlKcIzCdu+FLiQ5cj04EScR3x3LVhdqpGk42zzUwvueudPVDM3HGU
	zk6YmZukrHVSXBx1soxR7uKQV4Hk1uwi0aMBSWKB7mFiKIZj/6fmYEeBeloIXG9UkgiV62XZTKR
	kwPaPfZlcXWO+3YIEA1A/PjgoqUE7umR5SOdp8lgRLGGO2qmRnp9S16lh4XwT+emvRpq7Ns5we9
	juulZ2/s3wFOfcUZRVg7srK9ZxA=
X-Received: by 2002:a05:693c:88c3:10b0:36e:4aaf:6c7b with SMTP id 5a478bee46e88-3796740c786mr6920484eec.39.1794726131042;
        Sat, 14 Nov 2026 23:02:11 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm40284667eec.21.2026.11.14.23.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:02:09 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alejandro Colomar <alx@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
 alx+linux-hardening@kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling
 <mikey@neuling.org>, Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] powerpc: Fix off-by-one bug
In-Reply-To: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
Date: Sun, 15 Nov 2026 11:17:37 +0530
Message-ID: <5wxy8x3a.ritesh.list@gmail.com>
References: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Alejandro Colomar <alx@kernel.org> writes:

> From the surrounding similar calls, the intention seems obvious: this
> seems intended to check for a prefix.
>

Could be, however the existing code is not functionally wrong either.

I agree it would have been nicer if all three were consistent. However,
x86 handles the same parameters with exact matches, so if anything "auto"
is the one doing the right thing here :)

But making "on"/"off" exact matches on powerpc now could change
behaviour for someone passing e.g. "offline" today, so I'd rather leave
those alone too.

> However, I do not understand this code, so take my reading with a grain
> of salt.
>
> Fixes: a048a07d7f453 ("powerpc/64s: Add support for a store forwarding barrier at kernel entry/exit")

IMHO, I don't think this patch fixes anything functional. So, I don't
think it will be correct to call this as: "Fix off-by-one bug" or 
add fixes tag to it.
And so, I would suggest, we leave leave today's code as is, based on the
previous reasoning.

> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>
> I found this while looking into replacing this code with calls to
> strprefix().
>

For your conversion, I think, we should keep today's behaviour as is.
Maybe streq() for "auto" and strprefix() for "on" and "off", which means
there is is nothing to change or fix.

-ritesh

