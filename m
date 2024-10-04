Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FF155C8A
	for <linux-hardening@vger.kernel.org>; Fri,  4 Oct 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059523; cv=none; b=nmZdqRjnBRsen1rpdQGqWqc8A8biev19YD2SMLdY9lrZkuRQcrJ7+wgo0m01VkSsXMAYstUwWsTfutqSkKRSdypdHhupvl93MVWmoic0QwrVRYUESDOSZD5IZIFtu8xoYJPkUb4c5Xkx6fb0G35QjCM//HEcZ6SA7qviNAg+WYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059523; c=relaxed/simple;
	bh=sBj7fTJoQaZYxklmzS3W4vzzZjdBvQS/D7Q3yJhEUYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYVRaZZG6Vkmegeox45TY2zstBLiFiIAEEGxQ8TORiyAKDQzKVFowD1UJVLkqTi0OPfNJOiYF7LiHysCEFQ7SIebR/Q/8bkF6C75VbT9+Xoav4q6gF5Jt22eXb+oZJol5oyKj5wZjRsS4+Bzy5B6TEhewjtK98NOfEMkKO0eZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G3iHADMx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G3iHADMx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b533c6865so2131015ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 04 Oct 2024 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728059521; x=1728664321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K60b0HU9ftXyJtge8qd284Y8viY6O8DUlfpDN9STjVM=;
        b=G3iHADMx83xrnbpKDkaz8RmodhKhdpA83XgTyAgXGX1Ojva1ntISNIUSkyQ6pYv1CG
         aa0315KZUx1fHBc/TwX7m1jqJrfVvDdYnDA1+Ck4nD7CFh233WUexay/K0BrhsVkePiN
         hEOw+SnVaWAcXaArtxMV7BoytJ4G3WPuKvD5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059521; x=1728664321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K60b0HU9ftXyJtge8qd284Y8viY6O8DUlfpDN9STjVM=;
        b=auYKb27a21ccSPoVYm4DkvWmRiwCAeXqtl0FkzGKW9Adw2sTx6WE7yCk0XCyxdikO2
         ImYpz1b3OD87Bd2dqu6qjjuYPzqNEsT+21XvyOcBP5/x3+7dZ8qLz2ybla2WTF+8vHqz
         Qne9rf4KD7jTNCGKFsYV/+oYA5xbiXvIo1IGi4Nb3/tIh/NV6nT2h49C7TISkybmHYaJ
         bvSieH3TH+hfCoE11/VQqmUxqAr3bXFvxd0nDL16QtO4MJnBi+nuH+Jd5j+I5odZUNT/
         uFZwwFYw9QAgXmUV+kDJ22rokZ0BGXZcwxeH4NtodRYf2S2aaihybciV3SOqI3ch6zJq
         wmpg==
X-Forwarded-Encrypted: i=1; AJvYcCW7WZ7qQkTvGaybgH2giDR6hPVN6g95PjW9ox+d5wBL0f5tEHm0U7l2qfKfcHG4o9jpzdHDC1YESNdTIfLAap4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4kTstMAg+fUfYKSwP3w43LndWi5wECJeSwtskmX3/9DEdxMb
	FDms4m8e5xFi+8PeKecXaLeTd+vnFg5CG3Cr4OgCG52eereDzRrDk+368foQeg==
X-Google-Smtp-Source: AGHT+IFSrVTmBEuZDVkZdKrrQvLg1DhltJ6h+f4mR5YU4xMyntpg8h23nyzBrsG074u46Uhkd92ffg==
X-Received: by 2002:a17:903:32cc:b0:206:9f2e:1029 with SMTP id d9443c01a7336-20bfdf72cd1mr18918805ad.2.1728059521290;
        Fri, 04 Oct 2024 09:32:01 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e20b0f6380sm100765a91.40.2024.10.04.09.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:32:00 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	mike.kravetz@oracle.com,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	hch@lst.de,
	peterx@redhat.com,
	hca@linux.ibm.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	nathan_lynch@mentor.com,
	dsafonov@virtuozzo.com,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@google.com>
Subject: [RFC PATCH v1 0/1] seal system mappings
Date: Fri,  4 Oct 2024 16:31:54 +0000
Message-ID: <20241004163155.3493183-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing during the life time of the process.

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization. These mappings
are designated as non-writable, and sealing them will prevent them
from ever becoming writeable.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [1], thus sealable.

The vdso, vvar, sigpage, and uprobe mappings all invoke the
_install_special_mapping() function. As no other mappings utilize this
function, it is logical to incorporate sealing logic within
_install_special_mapping(). This approach avoids the necessity of
modifying code across various architecture-specific implementations.

The vsyscall mapping, which has its own initialization function, is
sealed in the XONLY case, it seems to be the most common and secure
case of using vsyscall.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the mapping of vdso, vvar, and sigpage during restore
operations. Consequently, this feature cannot be universally enabled
across all systems. To address this, a kernel configuration option has
been introduced to enable or disable this functionality. I tested
CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn’t use
CHECKPOINT_RESTORE, to verify the sealing works.

[1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

Jeff Xu (1):
  exec: seal system mappings

 .../admin-guide/kernel-parameters.txt         |  9 ++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
 fs/exec.c                                     | 53 +++++++++++++++++++
 include/linux/fs.h                            |  1 +
 mm/mmap.c                                     |  1 +
 security/Kconfig                              | 26 +++++++++
 6 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog

