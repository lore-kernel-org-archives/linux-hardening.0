Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425003655C4
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858254; cv=none; b=WAAglDNPzA2wRsnUJA5nKv3Y+dMXnF1Zrx1L1vBMN+euCA3XNhN5BaP4iULuqT5/VZMccbZ6Z3jjljsTvVyfyNIynws+NXtPxUFlLi/VMKoD/2Dg7fYtjT7iTx3jzmLcKyjTS5CtTR6FfDARbfsyFiHPmxJd+lantELy6lX3S3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858254; c=relaxed/simple;
	bh=0ty+Q6y2K4AOlKlFOiFT8i7899skXamuEaYYI+wd4D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6SrKqxf8NCTufYjJwjCR1UYZsO1Hll2LcEoGSNzXBmUeaPobLxrYHJfuOYAyKtqrLHQY0Pa6PuNzoLYm8H1+snbQN2YihRjaaNLFMKlNCVfIBqDHX0Cv+qhTJhVqiKzi9pvKAEBALTbuFDGQqyL5Z8DcU/eoR8HUTjp6fqXG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTIPckd0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTIPckd0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c132ac5ec2so21279995ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781858252; x=1782463052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7oBvsxwpB7sjLLEIxbyXWYTpyIVbexYFG53kv8U23U=;
        b=oTIPckd06QtlRvkH4OBVCEpTJmHWvMRUduzVMxxKKdCIzlyGDZJLbWsy/mPV110tqG
         IRLBWC34Yq+E3JiqNxXvQqXpEKg8g8HoCgdgtaPiqM+byWiMTGUbRqQyI+Clu+qsfXHh
         ZPv2tEPSaa9iujD0a+AfhRVh3xawxOMzdiqwUnyKC6rCAFr5fZsAp+32rdOtpir/B3dQ
         N7GkiHyYL9b86dpwmn/MDx3aR4jbuTUf5X+2YGlbQQP76v/Upxx9fBiYvv+HGgueh44q
         WziYtki7sy+vZBUF+mtlAoH3tcC8PWqDNOffE+9hmPk9+0zTM1uvzkyOd5+hs2SuJ+VC
         qgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781858252; x=1782463052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7oBvsxwpB7sjLLEIxbyXWYTpyIVbexYFG53kv8U23U=;
        b=rnytxbep7UwOfRq4hLIQLldgwquUtV/BVbzG0IKqDUdwjWCm7lzvMZ1B0aqJr5PH9i
         PvzD5E+M3JCYTLv96lsJ8ZJgLsxvB/MMCpM2i/jTPIjd1zacISvheRGevXYQEPljYYQe
         XTu9Ruw8vu13oUoM26CIyCyNkao+De7pkJvMNcLGvpE57KSQE5EywveIFo11+KQASlKk
         h3xPApkXCOtAt4WPx3J82iZaVSiUKeENONNwWMBQ1TgOBDUNnOQKEHl8KFzinkDqNbLx
         AAvq7mwWrsU4s7mpHrT3v4+r7DrHknHxcVX7gcwpVAQ0iuMqTiR4gEZLe5JbjbC2wlnS
         jFJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kUWJp39iCp0XpSMq2wNNjw7wcfn/ZQOKOAQT4Qz/gTNmDve/1vIe+WofeDIP+sTTOIBo07/e/kohS+2xlHzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wo/l8diaihdqNehXncgIJWB6+LkhrmOKvwBRR3aR1+Zn/s1t
	KfXPj/u4z2rBpL7DwPXlkCaph5JVgKAkhGKLpctyBPd73CDuR4tQkT/t
X-Gm-Gg: AfdE7ckSrMNYxf6XcUkrya6ErdrrXbOl4y7EGt/untKJpowAhPwGXWgxD1zBL3Jg7w1
	eIJbBXcfozFrMxrTMiQmBPfUeLaJ9RdpadDJhQ6o0TtlTNfDt2iCNNPz5TDs/9QK1UURCm0fQ74
	T2o5JRae57eun6zvPMjNlil99tI4RZ4+gfdh07UUc+kD96b1p3YOOEHtRcQiAUiQCcWpKI7nNj3
	MarG2Tmp2G8mVuyvaZAGsEJOAzUZV/noVHkPzFUUFvbd973Xl0XvhzV9vG92dHONKgL5NsAZ0E8
	PnFA6GboM4JG62SI40cbbXK+DYr6Ouyuz8u5+8V0ejWwzYZd0vRV+FfQ643A/6jR92o7DwGCG0M
	geZ51wEfCnjZCI1m6MGqoN5P3DmNHa4nZ57Klj4Ww22oFpo8L/RFg9pp5YPQHgaufa3/b4izcuZ
	Ve9w/aPvrfCCssEqRh4o9LQO6rbC+wht/HrBx/PGNFwaoWAw==
X-Received: by 2002:a17:903:1d0:b0:2c0:d8ee:7d66 with SMTP id d9443c01a7336-2c718f6ac02mr31636825ad.36.1781858252636;
        Fri, 19 Jun 2026 01:37:32 -0700 (PDT)
Received: from Athena ([58.146.97.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208d67cbsm16498145ad.26.2026.06.19.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 01:37:32 -0700 (PDT)
From: Harshal Chavan <harshal24.chavan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	gustavoars@kernel.org,
	harshal24.chavan@gmail.com,
	io-uring@vger.kernel.org,
	kees@kernel.org,
	krisman@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Fri, 19 Jun 2026 14:07:16 +0530
Message-ID: <20260619083716.18776-1-harshal24.chavan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026061902-clerk-common-4c84@gregkh>
References: <2026061902-clerk-common-4c84@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-06-19  7:54, Greg Kroah-Hartman wrote:
> Needs to be a name, not an email alias, and above the --- line.
>
> thanks,
>
> greg k-h

Thank you for catching this. I have updated my git config to use my real 
name and ensured the Signed-off-by is part of the actual commit message 
above the `---` line. I'll send out v4 shortly.
