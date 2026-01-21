Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CA44CAEC
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980303; cv=none; b=MC9gUQ8IUPlnimkoDtxy3V6BCzWRai6SCkAzNJtdQx4i13IxfD0s997h0k3UqTdG8Ml5Cow2djrGlFUCavts18XSBE6gHV4Gcs5nOZ8YLqP8O9mscrpb0TvafGYAX3o0YdD5iqhsm2zQPG7GJRKEVrQugxao/WK0yeejHl2J/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980303; c=relaxed/simple;
	bh=XxESfXtP1UxhRcdzYWCY7uAdi9grgPxkwc9/eOzYRX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRgP0SQEkBk3ZnTFaU4bBFAfM1ji+CgBputvx+gZJjRaP8bVcMPBTkHzXNN32TYsWH4jcrHmzCJwcTTOY2BLmtL9rtjtl0N7MSU+mO04Dcx3CraqatWmRiFFFlf3ImoET91MDWEmU5FaU1JXAcmPs1I5b2+lNTDXjY96RKdOvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4diKZR+; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4diKZR+"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6f85470b6so3689323eec.1
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 23:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768980299; x=1769585099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd7TVVWwSVOrQ+WPeeZgk4vcwRxKlZMNBlvPshOCml4=;
        b=f4diKZR+FC08WFXXIL1t75JhnzxFGBDnNiA7hA4kPDUCXMIv8B+IclSCWDQoH57lGV
         7gWxsU4DH42NGAYLqF7hH6IyeTuYZ6XtYmzc+EZLdNF4u/+bb11NLCzA4KSwx3JpiAPm
         0ifJOvUlncDyB6gLNRjXxLGCjDILEsSdzYSfFrJp5oD7AQq8Ua50vW7XBorQClRSr/zU
         MkdCBu06vXGsHcjoGDO0GyXfQah6/Se+S/f6G9hHWlzP8164YeKNlAeCNkbcthWBlpZf
         OJnPR4Wf1sG9oYPHLOuTtj/mpUQFvAWZH0Q62341vgYZ3Q+iJlbUowwC5GUJWX6CQ1m+
         W+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768980299; x=1769585099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xd7TVVWwSVOrQ+WPeeZgk4vcwRxKlZMNBlvPshOCml4=;
        b=xLAVlyUOR6pyRQMoTAmUiwhepzV8H1EkfQ2XCcHboD4FtEuqOop50w2OWW9WVTNYnX
         Htj67VbOME4R7XdUCg3FQhwQkFvUcJqwlOvgrajgVJqZPvF666HKzhjrm/yKaNrkCb/O
         H8St2tOXP44If9PBTv3SFud+o8FMZa1C+PSxJMWZP4ExPgadgNakv3ejf6zsUI3aRD6U
         Z+pJwdERIH7feRjpZRE3AfAcrrGjU9tmQ1iKAIDH1mpUBCIJrqxh99Qri71YkgKgKx9b
         NEMTEDy7WcY/oY3FmqTCbesbJUKMUANRVVIkl/rBUOghTWD034NlUPJ2oi/D5RF7/aog
         UKKA==
X-Forwarded-Encrypted: i=1; AJvYcCWJXgtn8CkWBmKpJcOARzmUOSpDulTdOe2vHnqd7Nq1djLFAbPxQ+BM1WXKMwShaBnw1a+HgHGFxRrkyGvdJjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHSPeO0ICe+17Uk/zaNIVxlqgDbDiddPYUK1a6h3EOcXS/VITv
	0E4gTlgcxY62mpdK2nYdi3bKWDBmuObCIBiBUL5Q31nAFGDB6hF+LMdP
X-Gm-Gg: AZuq6aJ6XAga78pwPLfkbB2TZQdtgcIvwBPVutIF+ec7AaOveluzSuwRYw+KNhSk6ga
	6vKEZTIwJSlBnJonOEINPBrVW3kQBo7mlvfgkmjx4SgJ6ko/V+9TjBebKNIp61QiueShYXm2t77
	rYAqmMyQ2XVbBWgtB0GMWhf3wdzP4M0TVbvstzfvyBtvaJMK7WK9nWGQH/kPOgRnBOIqDI7Lm6n
	jhpY6wuW+jD/iwZlq4VVbAoNGJISR6mL2ahYlwDiEqtIvF/QDVPqI0X9pc02lazz8z/EjV/TaEo
	srmzbbOv6j2l1nHAemYLtRhqwG21yxA03z3Qeoi2Xx10nAFN0JtTokh+GL5dBK2onbSl3M8g06z
	SULXezydkzFEBcRKq8nJXqolQt5ISy4fO6lzNPlD7SKZdicdZZBNpQycg9/NSNp4=
X-Received: by 2002:a05:7301:658a:b0:2b6:affb:e02d with SMTP id 5a478bee46e88-2b6fdc7cba6mr2904960eec.28.1768980298950;
        Tue, 20 Jan 2026 23:24:58 -0800 (PST)
Received: from gmail.com ([2a09:bac1:19e0:20::4:33f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d4324f5sm2724899eec.8.2026.01.20.23.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:24:58 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	kees@kernel.org,
	andy@kernel.org,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	ardb@kernel.org,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	ajones@ventanamicro.com,
	linus.walleij@linaro.org,
	nathan@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 6/8] riscv: lib: add strnlen implementation
Date: Wed, 21 Jan 2026 15:24:38 +0800
Message-ID: <20260121072438.6646-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120065852.166857-7-jiangfeng@kylinos.cn>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn> <20260120065852.166857-7-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Jan 2026 14:58:50 +0800, Feng Jiang wrote:
> diff --git a/arch/riscv/lib/strnlen.S b/arch/riscv/lib/strnlen.S

Branches that test maxlen can be replaced with Zbb minu instruction.
(see below)

> +	/*
> +	 * Returns
> +	 *   a0 - String length
> +	 *
> +	 * Parameters
> +	 *   a0 - String to measure
> +	 *   a1 - Max length of string
> +	 *
> +	 * Clobbers
> +	 *   t0, t1, t2, t3, t4
> +	 */
> +
> +	/* If maxlen is 0, return 0. */
> +	beqz	a1, 3f
> +
> +	/* Number of irrelevant bytes in the first word. */
> +	andi	t2, a0, SZREG-1
> +
> +	/* Align pointer. */
> +	andi	t0, a0, -SZREG
> +
> +	li	t3, SZREG
> +	sub	t3, t3, t2
> +	slli	t2, t2, 3
> +
> +	/* Aligned boundary. */
> +	add	t4, a0, a1
> +	andi	t4, t4, -SZREG
> +
> +	/* Get the first word.  */
> +	REG_L	t1, 0(t0)
> +
> +	/*
> +	 * Shift away the partial data we loaded to remove the irrelevant bytes
> +	 * preceding the string with the effect of adding NUL bytes at the
> +	 * end of the string's first word.
> +	 */
> +	SHIFT	t1, t1, t2
> +
> +	/* Convert non-NUL into 0xff and NUL into 0x00. */
> +	orc.b	t1, t1
> +
> +	/* Convert non-NUL into 0x00 and NUL into 0xff. */
> +	not	t1, t1
> +
> +	/*
> +	 * Search for the first set bit (corresponding to a NUL byte in the
> +	 * original chunk).
> +	 */
> +	CZ	t1, t1
> +
> +	/*
> +	 * The first chunk is special: compare against the number
> +	 * of valid bytes in this chunk.
> +	 */
> +	srli	a0, t1, 3
> +
> +	/* Limit the result by maxlen. */
> +	bleu	a1, a0, 3f

minu	a0, a0, a1

> +
> +	bgtu	t3, a0, 2f
> +
> +	/* Prepare for the word comparison loop. */
> +	addi	t2, t0, SZREG
> +	li	t3, -1
> +
> +	/*
> +	 * Our critical loop is 4 instructions and processes data in
> +	 * 4 byte or 8 byte chunks.
> +	 */
> +	.p2align 3
> +1:
> +	REG_L	t1, SZREG(t0)
> +	addi	t0, t0, SZREG
> +	orc.b	t1, t1
> +	bgeu	t0, t4, 4f
> +	beq	t1, t3, 1b
> +4:
> +	not	t1, t1
> +	CZ	t1, t1
> +	srli	t1, t1, 3
> +
> +	/* Get number of processed bytes. */
> +	sub	t2, t0, t2
> +
> +	/* Add number of characters in the first word.  */
> +	add	a0, a0, t2
> +
> +	/* Add number of characters in the last word.  */
> +	add	a0, a0, t1
> +
> +	/* Ensure the final result does not exceed maxlen. */
> +	bgeu	a0, a1, 3f

minu	a0, a0, a1

> +2:
> +	ret
> +3:
> +	mv	a0, a1
> +	ret
> +
> +.option pop

--
Qingfang
