Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104633E0083
	for <linux-hardening@vger.kernel.org>; Sat, 13 Jun 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355866; cv=none; b=IriNYhgNGXeeQKzeDIKtCNul3E37ZF1xOzSLu5udT1AMgIYzBvRnm5MSQFCkiKDboXHK8/r/XVCUIPonXa5hesfiiT03ZOkd626pMoqQmPvCGVkaxf3jXr3mzGx8sTkRHSsvUEQus3nOU4LGI4gVQsr5Hw55BoK259bzj1ObAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355866; c=relaxed/simple;
	bh=X7OGScrPB3yY8v+4SZVfnqVCa1sJajXf6ntS0Kunqn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYxCVEg2ry2WZdx9mML9VSP/IMTOA3vDGcTUfd6x40AHcIV5oAqtfQmsgBtyYVgwkd4DcFoBob/PWnNo5xLUgDoeQYpq/05XUUFtyIXDMB8PrQRU0A8HiXBqmMnDqFKIqOLVRCRFqrnmAgV+NQmdie/mWIoBj2MqDrI/HF1hHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdgTrQux; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdgTrQux"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so6553645e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 13 Jun 2026 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355863; x=1781960663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sWTmGnPy5CRS6c/b3mIiUaSM3PjZW8cDV1skgU0XaQ=;
        b=HdgTrQuxBX0a9R0xmrm79S2dgCu1FuaEXA/I9BFzMezhBNTv/1qerlhfbLsZ9BjGEZ
         GeUd7416IKRwDogARZJGqIRdbSKIm8RrVulXYSvx4bKPyTSUYkKYd0074lpDlKZ3Unqz
         DATHvCXHN9PyNzprUgDqCRLAc2ZzDkIp8DyFHoJnqrye1SeNtGtV5OEw/uCyelL3iMvX
         OWJFoYpO8iVToVKoQnv02OUy/pHejGTB7TyWNwGHQ6vgKugC1GXxuBxomD3iutW1iVVg
         VpQnLNf6FC/6B+iFD4sfDNhyIBIjhbsic7aPVwNCGPXlCrzcME9l+OdYh+CNjftrmwvS
         lKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355863; x=1781960663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sWTmGnPy5CRS6c/b3mIiUaSM3PjZW8cDV1skgU0XaQ=;
        b=XBLKx8YUrGceiCAA2iS2KjagzqTK0faZeKHZVuGAwDjB3RIwc8o1WnixbNyx5SQvyS
         EupbgDdV7WLc/PAV57Eqts3tHLx9Ra8M1xx71F5gwMo77zYFDx7izAwHbYo8m01ktw42
         TeDp9gzTuzPqtQcPzhm250xTt+OANt8lK5yWrNu06g+fbAkVCHno7fK2NA9tWhZk9WCi
         w52YUffNAr3USZztUCFqgQzKg1hTFhDgCYVJ5LQuGpTeP/3EP/GTFhu1AUvjDfMGHDEg
         Ex2AztDT5G6d9bso4QlLi/R0PGBjDGfwyqO9vVe8Wkn5c/Zvfc36BVl5isepcfVPQsb6
         WwZw==
X-Forwarded-Encrypted: i=1; AFNElJ+dQ6ky4ArQsGYvkla820HcxMkPe9/pl5LgGBjSzdiLGYQxSGBrfCa3OuFy77Nn/Z8AV/qDnMye7vgON5Xblno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxrvzxTGX26tZNwRhfzzZV8ENm6RenYsjmXzKSxVmyxuptA2B
	DU6cSTaGpAf3rXoz7MlAdLcVNeLEBXT7TADL4lhKAhrnWwIrp0/J974=
X-Gm-Gg: Acq92OEJf1KFz0z3SRVGc6iX7bgCzDLsPHS38xLx4hV8hFXUPR3m+lCLgmL/x9arv7j
	bWQ/kfPrU/LdcrwtEzyrXf7y2g/N0QeygKp1NZE3BAwVoeHPDggLZBlcsoBfMrWDkO68S1ibAco
	H5ttY5t0MPpZsldrc9vhDNoAlE/eEzMqBiyYoPnPhU/FPJA+W4Fc/hZe1yHMEJn9Pi92HUgG/RN
	YDKkPxYD/zx3CPQphFQ49LQ+a6qJTpbpBiiCV1LBIUi8+kAaLuVc6kcZHPz9sEhVT7o/b6a90x1
	tB6GmdjD8Y5VpDR2dWB7wB5nyxHZ4ukStWyGszCIcsiSU7EfzHLiAepWjldX5hXtgl38ZINrOMr
	i0mcoMOTdZTW8x44CzNB+98GdXmBFpq6ghIHxFkG2L3Gm6fgnPRfvqc69RXMLjbnU22D8fYrsmC
	ULpAY60TI5qMfCykVFYIiJxjxT0vqnWcXtUR4vQS0Gy5AspZOk4QeJJ8vszyD66JbRNUOxFiX4b
	9AHMhwHvHIrvTn/O92QcA2TOONEtnERdrlofk+g
X-Received: by 2002:a05:600c:190b:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490ec524ed1mr86995835e9.33.1781355863112;
        Sat, 13 Jun 2026 06:04:23 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:22 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 0/2] security/keys: replace BUG() in unreachable default cases
Date: Sat, 13 Jun 2026 14:04:06 +0100
Message-ID: <20260613130408.13709-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG() in two switch default cases with proper error
returns.

Mohammed EL Kadiri (2):
  keys: request_key: replace BUG with return -EINVAL
  keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP

 security/keys/keyctl_pkey.c | 5 +++--
 security/keys/request_key.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

