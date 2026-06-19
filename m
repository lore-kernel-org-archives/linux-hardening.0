Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34D3321C2
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854826; cv=none; b=rsSSgpl3awI07Yuck3/bsjhC1lc/6onH/GHUc0+g82irFM0Isqz7EfXhl4i9Eda6Zt3N1X2kxJiAbGrJYuQTBv0aFFbVrvTbesxhaUoyn6ZyCl13ZZepxGN0dQwb269+xLhRMWgNJ6OiIL03wK40Bbc0R5WsGsZAV54kKI45Yzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854826; c=relaxed/simple;
	bh=2Qsm7oOOrR36fFL8O1zr2PwgV7uJ+NhGTXCp/hPxneg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3v/UwWGCNi3GlxzWGf9J4JAAU74aWNCE2mpLVF8d/2ujbQtoTC5UQZzOknziHUJdZEvWzkW4hYepVfc1uy25gaGODtSue6Qt/obO7+3NqchDshTD3rtiDVDCauArMnDYbuNjv2Dfb/XbJy7BenyGOTYjxUtZw93hU44kyaGqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHElcIwv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHElcIwv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1057427a91.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781854825; x=1782459625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8IoIRgPFus0dtAjx1VIV2D6Zb5vLDM4e0T5cbfAtys=;
        b=qHElcIwvelE2WF0B6fksaKuU3/ZKXYAsyjV2jpxUl/YAsx+TCMrLkmvpkzGEAHEq6B
         fiQb3mtrdaksHagik3VdrLG5etilCWX3To8n0KE2jwLHdJnNpbVLywB1VRAR5HUhn/IC
         OapyedOvwfYWc3H9/qezkuBWmXeeKoaq4L7/a/+WSD4kOhtwGo7TWTXIZPl4WFEKUMaG
         oBCsY6ZMtEPVQQtEGocqHUGghbhAxnsrh2UwNwxIXyZuBH8VskurEz9yZkkGmudSglLC
         UKvyKJIlRkmGSMuBGe706fSn0q2LjfNZsJl/cTbzkSQq1WXCUmjeA4O/df5NqvbEyvC9
         3c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854825; x=1782459625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8IoIRgPFus0dtAjx1VIV2D6Zb5vLDM4e0T5cbfAtys=;
        b=IfUcFlqaIWu1jIT5A5nI/+UTGyn8iRCikx/JpK1sM3QCZaE8WYepHDFTLjKTWtRGjP
         Rwf748iCSrEZ6swbaJ3fCHBrgfAtAeEzin4BzxnzTYr6F7V4Me90v6vNgUrLqOe1BvoL
         C9sVHO3l7mM9k9TYCjSbyQKeZnwQ4SoQMgzjFzuHQrxKZKjr7ZLyxz/NVHT3AQFw8CeR
         Kx+YQgt79rA06K/ENXtAf83VuqPJDm8r6yMmKCAXjVA6XTDD2+5fENXdpbJnD+bEcgT5
         rUyZWkcUj7hvk2z+Y/GBvsQzYQeVmoXtkZWKvKFM/G0qLU2TbgzgEHfbkvqF3CztdA8J
         GmHA==
X-Forwarded-Encrypted: i=1; AFNElJ8/FJoPlXn1Przr7zJ+UEeBu4figOJgNj+SRUNTk/uyv7G/rQO5RxTpSJtR+K6vA9d/yR08RSCHrjC6/CmqneE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WnV+qD2fulN1tI0vyEzpJOjdb7PB/x4ehZBMEO75y6GvjsRB
	7IvxP0JyKB4pWlJbU4JAjN7brhOQTYv1OicHolNRaeR3mgWFpmN7zL6M
X-Gm-Gg: AfdE7clNGwpAaI0JjLQpzyAsm5qTsWrD6XQfUXWTqB63FKXxfhO4ZQYxdEO6y6/uTWH
	ZthevZEpHBkLNCTmBHKvOrUKiCwuqPRgrAeszHXnz36xyfdwBldQeumFiu4QXxCUNRmKArledm9
	xo0eV0xdtKVx7inDpz2m8QImzxaaihP3vILNCNik3gI95XqdABceDBh6xV2D89AyJjxgnkXzOjp
	J0uv83v0jvxWBBEkvWrh/3Ay9rL9pg05bVTeCdTUNP1+0mbHFuXdl1krgjTn7s7HYZ64292LxqX
	mSavQRKz2MwYABRNIHyXbO8cz2LDPNHmg178VyxDCyD4nUANl/IUY9XBrzTzHE8SsmEOhIh7cN/
	tT72SCrkEMckqJs23X9YU1MGuRLWiNmu25UdRB+a1sShAzq9JJm/JWSr16DGutS1KpPVJNP1VAe
	kxIkCMpRh/dgmwAtrG0aSfUNPyJMP+CepqPlEp7a4vdD5dUQ==
X-Received: by 2002:a17:902:f54e:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2c718ca5fcbmr31211805ad.9.1781854824925;
        Fri, 19 Jun 2026 00:40:24 -0700 (PDT)
Received: from Athena ([58.146.97.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c720c0ec80sm14754875ad.76.2026.06.19.00.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:40:24 -0700 (PDT)
From: harshal24-chavan <harshal24.chavan@gmail.com>
To: krisman@kernel.org
Cc: axboe@kernel.dk,
	gustavoars@kernel.org,
	harshal24.chavan@gmail.com,
	io-uring@vger.kernel.org,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Fri, 19 Jun 2026 13:10:11 +0530
Message-ID: <20260619074011.15289-1-harshal24.chavan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87a4ssyey0.fsf@mailhost.krisman.be>
References: <87a4ssyey0.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/17/26 18:33, Gabriel Krisman Bertazi wrote:
> IIUC, the IORING_REGISTER_DST_REPLACE exists for backward compatibility,
> since originally the buffer cloning would fail if existing elements were
> already there.  It is kind of superflous in a new operation but I suppose
> it is here to mirror the semantics of io_clone_buffers, which is ok, but
> then...
>
> This free should at least be gated on ctx->file_table->data.nr.  We are
> always replacing the ->file_table if it was initialized, so it is a bit
> more logical to check the table directly.

Agreed. In v3, I have gated the io_free_file_tables() call directly on 
ctx->file_table.data.nr as suggested.

> > +	/* not allowed unless REPLACE is set */
> > +	if (!(clone_arg.flags & IORING_REGISTER_DST_REPLACE) &&
> > +	    ctx->file_table.data.nr)
> > +		return -EBUSY;
> This check is duplicated in io_clone_files.

I have removed this duplicate check from the parent function in v3.

> > +	src_ctx = file->private_data;
> > +	if (src_ctx != ctx) {
> Shouldn't we just fail if ctx == src_ctx ?

Yes, I have updated this to explicitly fail with -EINVAL 
if ctx == src_ctx to prevent self-cloning in v3. Thanks for catching this.

> > +		/* Prevent cross-process hijacking */
> > +		if (src_ctx->submitter_task &&
> > +		    src_ctx->submitter_task != current) {
> > +			ret = -EEXIST;
> > +			goto out;
> Is limiting the feature to the submitter_task necessary to safely copy
> the table even if the lock is held?  The use-case for this feature would
> be setting up a single ring with its file table and then replicating it
> on other threads, on the common model of one-ring per thread. This check
> limits it.

I have entirely removed the submitter_task check in v3.
