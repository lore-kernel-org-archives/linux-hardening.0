Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487311474B7
	for <linux-hardening@vger.kernel.org>; Mon, 14 Oct 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942630; cv=none; b=W4hSTFpzNMjsMakN+gqb0/Yb5LgGlcn4BggMhpdmbexxpftrPzwwG1IMkGSbS+zALYShk1XkCReGaLGBYK30AQvcahvMIltBAA8O5bRPKRgP5kzBU+Qp1ZG/zSTSowbgRlysIXcUOo/rV8nOalAKIMG8hfKjKB3OOM50uby9yvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942630; c=relaxed/simple;
	bh=Bn+0tgTQ26spkOkGeU3zIn5oIOy8xE8ehmLP1HtPYdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H4+l5kuhPVDX4otrsBkiiRYMcxNXf6pG3kvrXOdM1BxkWs3jXwuqTgqcABkybTm101NLBTLKGTtLlZEafz7d+vxgaT9pwclN0hWICuduKrfFdtAedWULL2PUM3gtAd21ja5+2o1/aZiwQmFDmCU1VaALs4VPEmpmG8I7ewb65TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ea26KL9A; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ea26KL9A"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e52582d28so106676b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Oct 2024 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728942628; x=1729547428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHgAeWx2Z6u/Rr4guiu2M1wSVbBmkz71ggb4GDq4zfk=;
        b=Ea26KL9AtGCNZ5BGVBK/nx5HAK1eFUzaDZCXJqJc7durL5BbBZAiU3Z5L06KATkDGa
         v6Lc+SwVFHtMKMJ8Ig6h5cVTd65Db2OyEm2ObGXxtFow+aVU+jWK0X6l2qmUupo42JcF
         X1H9RVBRTov+sdBq3/5MdB2+DAelrnOSi/UN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942628; x=1729547428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHgAeWx2Z6u/Rr4guiu2M1wSVbBmkz71ggb4GDq4zfk=;
        b=v2FW2sYIr1HKRZAXbTWxdHaDKyAmrPlGx33wvtJWQA9E4DSOPBFbpdtIiaB5XBKWWu
         7YcYRFp0Gs1DQ8V7acY5ZgGU8M31mONpu4X4UcgSL1KZYXGW4WvZVH5wzzbq0eBYb9Ts
         DvcnSJS0Yt7EVhnlma3s2BwEpIQX6R3UgCWKmhjzToBuIvpDQR1rxWLsUFZaJifLrbsf
         nnST+LBGviAIXHcOGwP2Y+em/oyzYXHA8qjEKZ/Qxb1nxofS8cQDOs0BTTXY3W7Sjpm4
         yDc40li4xzQeOKY0Y0ml/Xf2oGXwewmjC0o5lXgMOnAVboJ/8HhMeFTiwhbfCJs06SVV
         N7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV2hvs/KVxsGFgZItwNN5HkBPbog49jCv2o3ZhjKnwCocu2GQ3MK/1ayddkz+JIjC5qhjtSZJ1tKjh6LkCcRFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1M5f1P+bmD1rBZJtVvar/U4iShdtqc9Xa+Um9O2q2sHwFpqF
	GPB9H1I1LJ1X8hylcXRmbE4TZfdA9XryCaI/teLTxT+7/zKjV6ToF7Z51RwI1A==
X-Google-Smtp-Source: AGHT+IGthjCd3HKvWtjJZwDzbVAakFkQKTTiDKfjfpQUEZRgXxs1pRU5IC3CwN8YbItLINHiJkWh6Q==
X-Received: by 2002:a05:6a21:999f:b0:1cf:46ff:973d with SMTP id adf61e73a8af0-1d8bcfa83edmr9185549637.9.1728942628504;
        Mon, 14 Oct 2024 14:50:28 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71e625b63a2sm3035501b3a.159.2024.10.14.14.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:50:28 -0700 (PDT)
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
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v2 0/1] seal system mappings
Date: Mon, 14 Oct 2024 21:50:19 +0000
Message-ID: <20241014215022.68530-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing during the life time of the process. For
complete descriptions of memory sealing, please see mseal.rst [1].

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization. These mappings
are designated as non-writable, and sealing them will prevent them
from ever becoming writeable.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [2], thus sealable.

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
been introduced to enable or disable this functionality. Note, uprobe
is always sealed and not controlled by this kernel configuration.

I tested CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS,
which doesn’t use CHECKPOINT_RESTORE.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

History:
V2:
  Seal uprobe always (Oleg Nesterov)
  Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
  Rebase to linux_main

V1:
https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

Jeff Xu (1):
  exec: seal system mappings

 .../admin-guide/kernel-parameters.txt         | 10 ++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
 fs/exec.c                                     | 53 +++++++++++++++++++
 include/linux/fs.h                            |  1 +
 kernel/events/uprobes.c                       |  2 +-
 mm/mmap.c                                     |  1 +
 security/Kconfig                              | 26 +++++++++
 7 files changed, 99 insertions(+), 3 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog

