Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442147D92B
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120048; cv=pass; b=oId3byyvZ9fEz/yPVEp+SUBgeFJF7/sarBj6ItqGCOP+1wK3j+0wRLwFfW7SN01/D4dbSJIktN/QxPIIyFFye3mGW8hE4XIvOFewFvOZkgtlGKd60f850aw4sMtOIJmmO67RnSfuv+Rty42ls6xvdUihkSms/BPPPhVACj3tyoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120048; c=relaxed/simple;
	bh=em1N3E/WTG6TYKt1hKLZLg4BVzT79CC6h9GgUGkGOTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDsg11/ZQkL2Zgu8YmMcuErwEwY8Mo5URsBpvk7VQV6EoxlskDTEqVFilvEHhZb5lAz0ENKpHKPpfTmnUo+lpjIhefU1DV/9lJJArx1OYUz8q4QvYPLoyFnG3Eikcqi2vHnyWNr4Is07MmBSH+TAX5BNC7SkAPNTscr/ZLzmpls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrSF4oP4; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrSF4oP4"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e1a9d9105so1511496a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 05:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784120047; cv=none;
        d=google.com; s=arc-20260327;
        b=L59AxZs4ycUNp00OVFiP8n+FCwarDlNvyUcAd0Yb2OF3tC9PBZ5Snim4RKOPWF6tv9
         COLR8DQb46PxSB4/CegFn3YAlmvFsxg1g0Z+h3s6aBDaGBfGHR2zvt1PUR9rfwW9KkrD
         fKH0yzT9kPC12GI1jZQWB1yTpI+RQc4pB5NMCBb+/yoyInQZ7V+/QPKeB0CCyihEupb6
         yiu+u8EHACNmuT6Gugin/yhD8bWMW9mqnSkd4kqAiynD39cyVjWZIgdODGH2Sajt8awr
         2eQ98rv3gjetWpoWfVgWBQGJye9Fao1/9JtTaKnKny7p0MyOaRvZLVcFT+rIg+N3X6Tg
         7nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=em1N3E/WTG6TYKt1hKLZLg4BVzT79CC6h9GgUGkGOTQ=;
        fh=D4AuURJYyRePAqaAojGeShAlqoMjvcCa+Q0efcDrDhc=;
        b=Bb5Zr0e3ECFoYCCauiN6GOGe2wV7EprWqjTSnx434UOkHfNlB7LjkHWmIXBj38Jyi7
         I9FkGZuCSkNefIRZYPf0ZK5O1VHVJnj4cUT062vGEzr65Vgi0kE1OFKVCD0fgqh4PqW3
         NHP9Jhk7oa0wH23beGMZjyuI/IiQIEXrQku/l+8iMC1sW2+DERTZSBxaKt2lGIze4dYe
         l2laCwLRrQmoxPp9Uh+VJIxFjnz+Me9N9DjXVqBRkkWofybVKSDj2Tu8nDi9gYXW1F+m
         qQui92ka3iW6I+ttTdDFYCtW1Ayckl87FbvcxVmDk8DCylOtUHowThVQd+PcCx63Vtoe
         pW/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120047; x=1784724847; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=em1N3E/WTG6TYKt1hKLZLg4BVzT79CC6h9GgUGkGOTQ=;
        b=qrSF4oP4bcrvEBynZseumGXxggZV3Btn/fY3AvyQcVu2G5gmxDCdc7sQRddO+nw7VS
         P+iSQlQSPUJBFEFyt2n2Ddoqmv3Be8p6asRfFOg9X5rHcuHwgwP9oCtEBt2C25eVrztb
         t4Ob4l3NxgUopgeMk6MYwvRpGsNL1DSUwEuZ03RFWsVmpxMH5gLqMj2ZztOw5O+SAKi3
         Nz+WZsSBPCLfgPKhlxjWmio2skwky5cHDTswCZ2Z/2J97A+G5lCqYTO87RqHLfCfJRhQ
         7sgcfLmNAOjKDpbIDyGLa4IxfPjFmYuqBwjyfoQoIcBuCqjjEEDhvx9aEOE5/830UY6N
         XP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120047; x=1784724847;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=em1N3E/WTG6TYKt1hKLZLg4BVzT79CC6h9GgUGkGOTQ=;
        b=pDJNxH3Ac20KNFhEgScDR03CPVddkNFPtG1zZPd4zywA1WrCywZh3H7ou6UunRaAz9
         /7sp1m9PIcAYhOZM7Si1jMeukayGlUZZVV5N62Sz/raIaHf56Mpj0rfPVKPKbO0JADII
         LqsaINvwbXbQhQZPAWj/4KyG+4i5k7d80eh/Iss7kta0m/bJ835if+Xe+HSn2M/zZXFo
         RTyJ93ml8e/pq68TXgUAocI/lQfbBrUHh9+USHkNAqY6jpGLTjGtEq8lh+p8Dtj6eMLm
         +2fop8ssdwwgq+r1mDqq3o0mN5O+S8Sg4SgB0eqYA283Wpzdpf3Z8V1f+ygGUhZnzn0O
         vFgA==
X-Forwarded-Encrypted: i=1; AHgh+RoscXZaoXNastOZFcnSSD+aixrbTIC223JjR1BlGhiBiJjBdvAZGEvxOVzmrlC0YPlkARCKAoguxteb5L4zKeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFpa2iILe0cL+rtv04gsbC7CRjdM9/25Jez+ukJ6mY+YBch9H
	h+1jtfr80MUF7rktiaBBTIB8fmcoxaVUsD6GKyOeHwCQNbH+rqKPc7EqHFRyAn2yxHa1uSIWFz/
	cY82XXKHlPggp2DtrqOwi1XEedpOwQJg=
X-Gm-Gg: AfdE7ckaLJGS67dp1dETK+ohCIO44hemIKGmSpT4mQv4/Cb0G7yRRVOvwfzfw8ZE+Tc
	+xt1UgIIHdULMgDDAvIGQZXym1g2uWblHmWNCNTA2rvxBHodWifPGXgWmxO4amMvnOv4xMEgaPv
	LvEcpZ8pM5j+m4rLZFZbvIl0+zMVSqDzxN1peNwRUIdtZx+rQvOupvlNM4Krl2XQUu4zSMK0v6I
	vQFdIJGdMcgCDNpJB9IK7fhIpai989YEMHw7i9aebinZUkXFQJ8ObVgYn1GRZTjSxrAzBWDcfxg
	t2m8yI4pMR1rh6m9LotiaT6n13eZ1Q==
X-Received: by 2002:a17:90b:1652:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-38e2a0c33c5mr2314053a91.26.1784120046938; Wed, 15 Jul 2026
 05:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624073921.11037-1-harshal24.chavan@gmail.com>
 <20260624124019.4521-1-harshal24.chavan@gmail.com> <87fr2auzq3.fsf@mailhost.krisman.be>
 <CADCAkb6wuR7vT3chfFtBL0qma+gx-2mJM7v+JJLS00W3oyb5dg@mail.gmail.com>
In-Reply-To: <CADCAkb6wuR7vT3chfFtBL0qma+gx-2mJM7v+JJLS00W3oyb5dg@mail.gmail.com>
From: Harshal Chavan <harshal24.chavan@gmail.com>
Date: Wed, 15 Jul 2026 18:23:55 +0530
X-Gm-Features: AUfX_mx4Pt1vuEloSH-b7zneRHe1DCEtLnRCsohGnflYfyu-JmuWdQPLSoehD6c
Message-ID: <CADCAkb63_kAa0b09GAQApBqi9-oUR03beQajkSMKL6Q4bkpWWg@mail.gmail.com>
Subject: Re: [PATCH v6] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, gustavoars@kernel.org, 
	io-uring@vger.kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jens,
Just a gentle ping on this patch. Gabriel has reviewed the recent
changes, and asked me to wait for your review, so we can batch it with
your review of the overall approach.
Thanks,
Harshal
