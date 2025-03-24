Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7B42A82
	for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829347; cv=none; b=jwWMjo7SY2Lgcut2SI3+eKLzgJcGUGpkf9DPGNrE8gsxwNMM385zIN3pKYnqrg4DON4S5kHWAmpPoo1HpusE6y79xeomMGDVtMdL8FugeQ12hVdCLn5Ue1gnWjEPwHt84G4t3xbvQJOD/BBHUKIH1HUjOZNax+BiQyAFSTa41DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829347; c=relaxed/simple;
	bh=7krJqYCz8WIH35/L2XLHi9sBJcyD56V5/AFLAep0E18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyN2L430HHvZdE9+RrAWK4JNiRn8l/DGTkDEucbL9RAgk2fMkXrGf6lEaAlE4jgoIR1pDPMXDskFSXEqSq/shGeCeqaeq1IwP39mvcLFxDjvE6iGGICoEvuDS6XDZlvz0squMX7ydjBedZAQUTzZLN0CRccs7DMB3IVUZZ8buvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X5j/pmX9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5j/pmX9"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e68e0290a2so812349a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742829342; x=1743434142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAq9D67rCaNY4Dbk7a/YAfJWGHwZAcO9A1V0CY/OFqM=;
        b=X5j/pmX9qpKfuz7B3np18TzfkHX9Qn5jEJ1Iff6tT4y4S8o4B3McWiyY61ZQYAGHOJ
         Oxq2yXd4A2p4/EQTOZT75Jb8N7I9wHC60tOpPTOr7cOv+/x7mwBmNXBGuD5l2kn2zst/
         zP6lWT0Vb+lecoHhYHvDWoZ5pbJ9h1eNbitMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829342; x=1743434142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAq9D67rCaNY4Dbk7a/YAfJWGHwZAcO9A1V0CY/OFqM=;
        b=OYA4t8NJETngHDI/oI7g6XeFVcR0namxpxtieahdJ1HO9OJKbupmqt+EmkD1uXAKej
         TurN7hbC4lYhKQ2sOSN2l74pPftD2N2e38MXuZhhc1E103+ybbtmuZO1jHAChlxUL2si
         y//y6YZOyff7t6nffA4ygdKuGyHypA5I4FMF8DMW8NU68BAVxLH7d9PAdgbBpsLraZTS
         JtMRAXG6GWJNzTpNebcoIR+haYgqXzAS+NeKVXA7B/wCduU1nq2DWWrlJrIwwlBz9rvq
         DAiMP3iFg+Z2XpSlnQcFKu5q4veRsDhXnAzDb+LK80vat2E+3kYsjxU17TulcEwY6eYj
         V1oA==
X-Forwarded-Encrypted: i=1; AJvYcCXwiHpYcDua0RJTWUr0Z8hKnY+IGtsr3RzkKWltCd93xaQxs749L8MJNysg8uK/ISP3r66EJCqmwLybPN0vS/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJ6CQXqGydRY9Dmvv91igllfw35kCg4JKT8beK6criVuwqN28
	sOFQA0Q0OglzhY7hTJ+693ycxu5miF6F/bHGJ+935RufhMffgKkeFpcqS1Wp2Q==
X-Gm-Gg: ASbGncs0Vl3DsiczDW59pJAuntAFMKa3A/G/2MIhcgu17sxz9X7DdLQ56z9oBYxcA0u
	FdcOk+0NuBbPvBXZ3Ql3wcj1DDNZxRWkCMHSmkHOTC5utKqTq8sR0A7jwM6g89SctkjLmg+WeyK
	qWQDgznB46LBQadgPz+8TnFL4i1ZmxviD+txzLx/mFkvDlroqFcHTvlwH9S35v+jNa+CkCbVjN6
	JIvLv/22h9xS6qlol2jQGxjMlIpU2VL8qeFR3+DD9JZ4VlCypCVfOO7pBLysQqqAgAoZ2b9vwV+
	/Tkhx/IgkK1O1GwfVoNI2eHFb8pqauV7k9O+78wMRdoBvD4JRRyGkKfsKCkzktIwMADRwWa0RD2
	Fyj52gckQ/qE=
X-Google-Smtp-Source: AGHT+IE0tQ4KGObc7tnv+GKNK9/sAqlB4q6I80xl+wAZ7VZUM0C6XX5TU58LRjAEfezFe381AVPaTw==
X-Received: by 2002:a17:907:9688:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-ac3f2429d9bmr497517866b.5.1742829341884;
        Mon, 24 Mar 2025 08:15:41 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d39basm689698466b.44.2025.03.24.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:15:41 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	edumazet@google.com,
	geert@linux-m68k.org,
	gor@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	m-malladi@ti.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 0/1] mseal sysmap: add arch-support txt
Date: Mon, 24 Mar 2025 15:15:36 +0000
Message-ID: <20250324151537.1106542-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

History:

V3:
 - add arc/csky/m68k/nios2/xtensa (Geert Uytterhoeven)

V2:
   https://lore.kernel.org/all/20250321032627.4147562-1-jeffxu@google.com/
 - add hexagon,microblaze,openrisc,sh as N/A (Geert Uytterhoeven)

V1:
  https://lore.kernel.org/all/20250313000623.3192896-1-jeffxu@google.com/


Jeff Xu (1):
  mseal sysmap: add arch-support txt

 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

-- 
2.49.0.395.g12beb8f557-goog

