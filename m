Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8C14B96A
	for <linux-hardening@vger.kernel.org>; Wed, 21 Aug 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257793; cv=none; b=OPCdPzXx9gHuAqRsNYXsaE9rmdK/6bMYOmaB2xqe30MYqFvsSqehM+b/xD8VkBrBOTNBGW2pndMPPzJFqtJXiPyj9Rln4cSsHRtXNo73Gz1BwzWO3to57Lwd3kYKA0yVEfL0lRhRMCHzaY/a4h/ln3fyVMVSY11E3F4m5p1592U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257793; c=relaxed/simple;
	bh=+2F3YQaCGLitcTbNdWyuZTbsn8oeYp3wyShw7o+4Dfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2oFTTf+x3xukih0AZ6hXPtkqcjddVsWKTNBIXrVX7MYN0VNUrfYhdEg1HBo+x3oEKfEJYjulJ67/vSFXGkun45PBVMVpkfSoyw0/PcI92T3FVLlUKLnvtKCU8wIDgNaC/WgjVD+IiLhNEW8YmZ+TOlCLTErx8LQZUb3Nu3wwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Dntg5lUS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Dntg5lUS"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533446e53b5so190836e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Aug 2024 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724257790; x=1724862590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQiMkF2LHLJ8ofvZ2BWlH/LDX2/cHbFn/G18VRaMIA0=;
        b=Dntg5lUSgD1wAJz+cQ0HICy+qFPjL26LwdcYD0DNIwJMeefaTInW2LCnWEIEI2mz74
         R/S645kfbW3SbXEtXOeI+BHv7L+eznTVFKj4Xraf0JSnCiXRJYE+WdNZfkJGRMCkHjuM
         KYRyCyQ5MwAyrLgZqeHKf8oDmgN1owmaKxgUEdArrAykAil5dOealcVWSzp1O9FgI5aM
         fJBQT0wlAWx7lMkE9VCvjVJfwB2NvjQ7LSGwZizs2ldvTIchDAnM+MyK3Eht9/2T3u3s
         YGuUVEzhG7oXvvRHjqi9ncCIjvPQeecT5uKHd/bg5poF2ncRBRV2pMaFEdG0l0PgyjOP
         AZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257790; x=1724862590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQiMkF2LHLJ8ofvZ2BWlH/LDX2/cHbFn/G18VRaMIA0=;
        b=SHM8Z0R9EeFH/Ad2cQzuJWaavAGOXAnlSW/JddbEdUtqmJzS8mplDtOCbcsapXP6/y
         S7GaA3uuyra3ywEegJtIo/HxoGBrn83NOw9Useiyra52/PZHME+qXYz4M78PcpJiFedc
         mGNDJMb5Du8VpIspZDjoZBTkVgAzn1rIEzFhtUx/Tln22dOF8N8rwVxmoW6qO7+rAXju
         PCZwEnM3qVksolEXG7uxKdAYbsWJR768oxTVal47pUHly3qwLu5l3cz2JM6NNq2kDZh7
         EQf0HHbJQotF2Mvy795QV1S7He4eRcmtKk1yD9TFjE2lCgPN1ZYokP2/da6eh997Yusz
         vBuA==
X-Forwarded-Encrypted: i=1; AJvYcCVyMHnhPegpEsl5G5xCfs4gUXB1acbGY2EapukRD33kCXyUTlBDxNjaliu48PNCzMGaaWFl4zlpirg7svU1mJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3fPUOqtVZ1wQYqi40hWXlgpvIeDFyHjly8ZCRhGAVY3yu2eSD
	BDLCW1Z1Fb1K8ff0PHvQ5eM39ICIDnAr96cYtJDA44xQJcYQOvMj+Ma2dGJolEs=
X-Google-Smtp-Source: AGHT+IFHDSmUWk0dq5DuUAdcENAjlQn2DZw21ZX5ZsRsgXG0sXCieYPYQNvWnKVi23rjGRAUfxcBeA==
X-Received: by 2002:a05:6512:b99:b0:52f:c438:883c with SMTP id 2adb3069b0e04-5334854a5cemr1026987e87.1.1724257789262;
        Wed, 21 Aug 2024 09:29:49 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8678ae3ee8sm105515666b.25.2024.08.21.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:29:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bcachefs: Annotate struct bucket_array with __counted_by()
Date: Wed, 21 Aug 2024 18:29:22 +0200
Message-ID: <20240821162921.86767-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
bucket to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/buckets_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/buckets_types.h b/fs/bcachefs/buckets_types.h
index c9698cdf866f..a19460a1bb7c 100644
--- a/fs/bcachefs/buckets_types.h
+++ b/fs/bcachefs/buckets_types.h
@@ -24,7 +24,7 @@ struct bucket_array {
 	u16			first_bucket;
 	size_t			nbuckets;
 	size_t			nbuckets_minus_first;
-	struct bucket		b[];
+	struct bucket		b[] __counted_by(nbuckets);
 };
 
 struct bucket_gens {
-- 
2.46.0

