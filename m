Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76319263F44
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586466; cv=none; b=cRR53bT5GsfG8/5snbIfNgxcihjU/xbYQUlhGIK3+4kwHMlrr+yecXSOduYwvbRjWJZKMT3vz9kQ68JvcjaJpw4ou2i6LCi1pdKjsB9lEoJwf6pLm91sie5unF7FfdiLrcCFtKRw9/QjIrxKt0hutNNv4ruq3qZUhCULbSY5sdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586466; c=relaxed/simple;
	bh=DGuMJIWsm6jjz3crrcedfBxNadbe0NtXekfSHQ6hBa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCmWCcwCYJDSjd4gsImFYseqv5sYQQfvkilnyLJLjYWVNpZGhNq8/IPLaIny8cbUYG/YjZYdXz1DsHaXw9yrbj3mtfK7SW0zBiE2VFKODjh6mqRlg0+Zb4H0XwdSXdVKRe1CBD5lAzWAuH/IpbktGr0N6qjHwQVGKVZFJsPPd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sg6NVL8A; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg6NVL8A"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83178c0f29cso967088b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777586465; x=1778191265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=on4wGCNRG/3dGd8H0dOw4sp7+EFiVE63Q4rGGK8QJkg=;
        b=sg6NVL8AiHHJ8oBrlQlfoEFMxVj2sSqUEgOjUI8gApvG8/beKdkdsvN/8XCuL9GTWR
         JUQ/u8FAO/EFkQeXGBV8ZLwB/EvuIGvKMLnlJ4jMTtVVEhuWtCjnm85LL5Wdmpndwsm4
         uhpDvYXK+YNmiz67xpCzqSoTy1+WX62Z3Sfdotc0UFyYD2FVRbzXofEr7E9Aw/wj1jsI
         kcYX4rj9+j/ACKEmZSFLgG+7tOaiLNx8Ba1R5GfUrQjp4HAdAmoxMHEjzakXxzzzuQgL
         bhBdJSEi0g8bLWrE2157dP5ur83ab3UYUj5OTmUr1AFYRgXT+J9wQeqDdr9oea2YBk1a
         Pwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586465; x=1778191265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on4wGCNRG/3dGd8H0dOw4sp7+EFiVE63Q4rGGK8QJkg=;
        b=UvB0nDtiqIfETQA31oWElePtz5rLzqzqJrAKhtsZspkiDcbYux4u3RMdSqyc/aZwFu
         2pPAi8Y5WUMuVnaBRaTugE1gl+l/EkdVjD+s45RozE5TALRvIbYuA0NXbO/fKcMyiHX7
         k6k6pRtEdozRSbiTN84KTmP7HKZ0FAk6wLMhlgXi5+EI2fBVN9X9iWAYcPDU43Lay2ev
         9ehLXjU6z01r2gO35WqVRydh/PBSNgdYawMJDsueByILCbKgrjfHPTEqcJICI5eiyZX3
         tFkTqeqK2ZPfK0tYYQloOZo4EX444r1Ywj6jByjLh6FdExXZaWUlN/51I2W7KX/CN3Bg
         t6og==
X-Forwarded-Encrypted: i=1; AFNElJ8S6jQV392DBGfVavwBPSQ2AkYqMBqXv38/T2w86mQKIj4T1o2EHU6PdUc530vytBvnjof8tVCRuCd1S7Pnb40=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrlg3PcRrjJe0p8us+CwDWffP8js0wIgaLlhrB3/wmT7rRcgdK
	fySa9Atvvb6vgqn/2oiYEbDQ3ae5rzLrjUO5oLzWBEeQspusSmJqXJGv
X-Gm-Gg: AeBDies6T+bWSjM4OzwwE/oXm+xBMDrJnbnLjCPOIcryGlmXVfe6fkfCVCIIsv7PvV9
	sC68z3eRffuyJzoc6SdKSJnnTK1JhHed9QQ5hZUePug59EG7CGoykxGcAtS0ETsR05mOablhaQr
	0y+G/rEFN2E+GIMNhBZYYCRQp4iRN63CpCdCJFgXDBR28NhIR9Mc4hG/OPLId97dqhW7pZKP7Qr
	MRoEh+GvV7f0ShFX/wCGbXQwKH/U75qHD+Ji9al88HMtGoljVoYSkU2wLjEVKNScL0w301Az/Vd
	DNtK0zb6BnFsn36VPQnf5O+eYDaGUgob1SJdQrwlylnGU46C15zy21uzTaLhWU2Zn3FpNlajjRM
	8zIwEroRQbUoMwpaBxzQUtjV0cg4szmticVC+p1BF1agpVOtWgOTiUTUHphtZB/+9V3SRUavv0O
	bGsA4LGwtt/fXGQmhqBzGX4SoOyIy30lch8lIS1CU/RL4i2SOWzYaT9WA19qXabTuf19NQIeuIn
	q+FKuvtqcf8mnZdV24sLX1wf6tnSzcgvWai4PGuQVSovg==
X-Received: by 2002:a05:6a00:b86:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-834fdbe66c0mr5734416b3a.29.1777586464256;
        Thu, 30 Apr 2026 15:01:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad7873sm614130b3a.38.2026.04.30.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 15:01:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-edac@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 0/2] EDAC/device: simplify allocation
Date: Thu, 30 Apr 2026 15:00:44 -0700
Message-ID: <20260430220046.72371-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a single allocation to remove a bunch of kfree calls.

Rosen Penev (2):
  EDAC/device: simplify info allocation
  EDAC/device: 3 to 1 allocations in edac_dev_feat_ctx

 drivers/edac/edac_device.c | 63 +++++++++++++-------------------------
 drivers/edac/edac_device.h |  4 +--
 include/linux/edac.h       |  2 +-
 3 files changed, 24 insertions(+), 45 deletions(-)

--
2.54.0

