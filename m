Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A383BCD31
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701824; cv=none; b=I8Xdn+ur6AGuUPrf0ebT5y0PlngIW0EGJLG5NOdwDzr18ElVTO63O2bBf1jX3L/Lye7HAUy0aCaw8DZFpc6P284klCSFtwyID/rCemOqyj/hSLCh4XN8vbsxH05lrtForFX5MgxVGkGiflzGwETBVgKx5/pZkPR2cB5dAu+lcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701824; c=relaxed/simple;
	bh=CHpjOmj0nzXlN9T3ZA7w5cTCGyZautFsyUzA50goyeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epRpYpvC/kHrIXjrZ8aqAjwUAArMcf65YkuWlp+hwKM+mWZeFVQY4k73qzOTBOAlw4/mb5McxnJBSBOYmtMrDyJiHD8WWiK5f5mzYlE01i+kBYgJKAEFDtt8UjDrIqUVTGUBJ7D6HwFm/NwYOGcNMm76uzsJiIOiBpRF6Pmo1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9lCT4w3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9lCT4w3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8419ab3a297so2564391b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781701822; x=1782306622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t59PWFHJyhJPrhG4yxJtzulsV5BlqsFtV0EzJW4vR/E=;
        b=E9lCT4w3b/hmRcacDv/+vSKEjE11WQWIjjfVDc7rX+Hci+wNXu0FjWkJExiZroQo7z
         JZEPvXd/HMJGfNpL86m4kttR12v2mOteTnvaklrXafu9YNqaJqU2RWvZLpsyohm8uUho
         GpUIBDxbz9S+mbYeVxnOrm+dwhxnbVpgYTtQHSygJ958WpPUpTeJuyesideqYF/dv0jp
         oTF0W91cIa1a5PzXwBZOTSmBF8hLzaiHJXZ3VGh9KIkpCl7XBNNoldYy1pje7UZzE3fV
         RlvrS3Mm4RcPfFIOloUgeKB+b2kneakbP97nTlSJX59eFzQ8Th0+idHwyeBNFe+Bkk1y
         eAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701822; x=1782306622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t59PWFHJyhJPrhG4yxJtzulsV5BlqsFtV0EzJW4vR/E=;
        b=MHKNBjmDOjFz/+S34bvQ6+NEkaPgP7v2weIfoJBumVIGkJsrHOabXt5kv1sRgkp4OX
         RIigVC3fgmsBYyPeLiNsdDF6R+1JTVP6a84bTrfWbPuk/PB8IlZ89rjck3ZHLerFqldE
         e6ZCoVHUtUunJwsnbEddrlvtRrREvkjCbxBEbXPk+FSDvvaAdh6YDd0tbwpHHTpOhdaF
         fiLOMtCjt+SeH6ky2rrSDDwm8o36eFdaX6Wwh7OFYrC8e9RwngxFEgM4tPzr9mneP+pw
         zwGixG+xIPjke4aff0A7TuuudV3Uu2+7kB/B9KfojnHFz33ETwLywcn0NK8yZIeU/qbt
         OzFw==
X-Forwarded-Encrypted: i=1; AFNElJ+UcIWi10znJqcw79V4fH4vEK4z8Z13dtV/WQ8yXLnfbLM0ceLj3ZfYVdJYMLe9sLT9IwIRw8/wQ1Vnzg2dhOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybms/+2kzqM+66IKXuZpFPIyp+5asTlqHASGnm5byDcWC0F1NA
	a+UUEU/7qNxTPNwWM9Qbzmhag776gDFruQYnVgPlUVO01PHJv0aamgPZ
X-Gm-Gg: Acq92OH5TmGphTnir0JEkegQkYd6bB/+9w9qMWoPl7yczzBU21GfVIG2TCWSP3dRgV6
	yOKQYt2TsgedQdrwfgl4q3LgmnP31MKefwmKKba/pxqCyPvQwxBgVCMBlsmOvOvqeYrWSig+0Yy
	FnbMOkSTkIpYxEbVanA0pOVxj/lDa0uwgKf88O9Z4WkSyf3TeUmv4sBBVELf/vYh284bhl/9UgY
	E8rv20M16U0BQUkpcxIcj7Xw6nGYUTRQ7RaGrB2yNyMGU33/fvuCWpkAis8xdkIY2lTsP3ts6db
	HafbAczQDDB+6VK6HCwPhlJOSIyAgk6Rh413Ls7HbmF4M351IShWz+/G8iwRFsdodJ3cjyktC1i
	Kjr7GMbjyKmj2OJfyN0fCCyNVRII03xKwSjChQvnaWoCRa57cQgv4S71s21GJHB1uMJM9lt+xn+
	0ZuT3YdwHwU0T/DbqZ7f3V18GKMlTi4ZX1q0u7pr4=
X-Received: by 2002:a05:6a21:a81:b0:3b4:bdd5:2f8 with SMTP id adf61e73a8af0-3b8b7cd6681mr4444974637.38.1781701822431;
        Wed, 17 Jun 2026 06:10:22 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.148.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8893894debsm1085376a12.7.2026.06.17.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:10:21 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Wed, 17 Jun 2026 13:10:13 +0000
Message-ID: <20260617131013.64188-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This looks like a lot of heavily LLM-assisted effort. Please review the
relevant documentation, starting here:
   https://docs.kernel.org/process/submitting-patches.html#using-assisted-by

==> I partly agree. The code and bug analysis are done manually.
LLM use was the out of tree test harness and lightly polishing
the commit message. None of the submitted code is generated.
If you'd prefer, I can reword the changelog in my own words or
add an Assisted-by tag ?

V1         was a simple clamp
v2/V3      was a simple locking mechanism which is pretty straight forward.
V4         bounce buffer, modelled on gpiolib-cdev (acknowledged in patch)
V5 and V6  entirely your review comments (__free, scoped_guard,
           kfifo_out_spinlocked, __guarded_by, context analysis)


I feel the testing strategy is pretty questionable. Any invariant
violation is possible with that type of meddling.

==> The underlying bug is a kfifo SPSC contract violation. My intent with the
test wasn't to simulate the race itself, but to reconstruct the post race state
specifically where (in - out) exceeds the buffer size and show it causes a
usercopy overflow in the unpatched code, handled safely after the fix.

==> I take your point that forcing that state can itself produce violations that
wouldn't occur naturally. Since the bug is provable from the source but hard to
trigger on demand, I'd rather ask what validation you'd accept here?

I was interested in whether you drove the interrupt sequence via
emulated hardware. I asked because upstream qemu doesn't currently
support the snoop device.

==> My apologies for the confusion, I mixed up things. I have not driven the
interrupt sequence in emulation; as you noted, upstream QEMU doesn't model the
snoop device. I've described the actual hardware context below.

In v3 you said:
   The issue was observed on physical AST2600 (dual-core Cortex-A7)
   in production under heavy POST code traffic during concurrent
   userspace reads.
   https://lore.kernel.org/all/20260527175939.2939714-1-karthiproffesional@gmail.com/
Is this true? What platform did you test with?

==> Yes, the underlying failure is real. It was observed on an AST2600-based
production BMC running a vendor BSP kernel under continuous host reboot
cycles. Because that platform can't currently be brought up on pure
mainline without substantial out-of-tree board support, I have not run
this exact mainline patch on the physical silicon, observed under the
BSP kernel, not yet verified as the mainline patch. I should have made
that distinction clear earlier in the thread.

==> If there's a way you'd consider valid for validating a fix like this
without a full mainline bring up on the SoC, such as a targeted kfifo unit
test, or something else you'd accept.I'd appreciate the pointer and I'll
do that.
