Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4F376BC5
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469724; cv=none; b=F8j4RupwRlLFowCWRXAE1tdpW4YlXM+wFg4SJTO29si/UvEB6LX65gRUBKn6aVHsmjqT2wKeSowvvTyNcQix1NTrdw5qV+e0iVAB0DWZ7zroPzF1fKGm1U+B/AA0yf727/SC7QAZnO/vLvOv1pwotHzfdmHRIYoco7UrPdG9Cq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469724; c=relaxed/simple;
	bh=VDqZJnwf2GmCanjTjVfbgnaJYQJazv4Jy+C4YIq1Wjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ez3zxfEGCDm+yll4bJ2dsRa+NpE4jTpVYtqGdGEAvIVI8jNBq+aIbpDIleqluSOBa6BIPMEHP7A/CLwgxtmNtke1UgZBO3IjliYsq89PyACAaghUnb6JZ96um7M6/hkce0jLnoqxZZPDkZj/fK7D07CM3Eqb8PLVLjd+KGJMHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPmj/02O; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPmj/02O"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bcd730e090so1572555ad.2
        for <linux-hardening@vger.kernel.org>; Sun, 10 May 2026 20:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778469722; x=1779074522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LE/4+F+CsUsIVKFjtrPVESM23HnQEEdghZta/8JF8Ek=;
        b=SPmj/02OPIWDPmm8VNtr/MqVhYAnDPIN+OILRiEmAg+w62/Es66m6dr9euefJlayjo
         s4NjIJN2mKX5X9nfWSfbCL02tKTUC7bDSaQYGwat/OfmrwoCi1KAg8R4AdovCI+lT/rY
         Fj3ZDLqRfgVS3oNUdvL52OrsuXwedGm1mVaqmEquW8qiOsWy3T0wIv9ZiavBo5fUNH8Z
         oL+wiqCqxZ1QB/nczTkq+TsKqVpyW2oLtXxmu91477SSghJCMSzbxSPxcLTdzDiQAiIF
         QT85P1Ppx0caiVs/jw/i7O3Yh7BNEf9VQ5Uld+TBSS3ASvlVPBgerhzit2Dt0QebcbWl
         YBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778469722; x=1779074522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE/4+F+CsUsIVKFjtrPVESM23HnQEEdghZta/8JF8Ek=;
        b=Z45NG0gjOwGraC/IL4yjHlluJ5sfclbBz9n7Oej6NRUVmY2LKuVYHTIcGSzY4aLEM6
         SBd6Pokc5XE3VQ3N+thgGyIFYkJHZPgZTcDQyGu5q61j6eLQjgnSvLsSoEgRZ0UrP3lH
         ZMVQg2vlnDOmeJYxnVvVZsRRrkD5spc44kT/YTfLpVX+tb9bsEJAUSDcIbXCBMj7e644
         aUv1nHUnKUCQyQogGUbkGCkC0gfmh1kyThUiVHiPREC47YQAEic39UsbQKz00sOGCLfu
         977I9Fs93jVc2BVEh5a7/sdbgt+TjNOCyWgSolGFlzsFnJjGaOCqCNJZ0SReGKd45mMZ
         BjGw==
X-Forwarded-Encrypted: i=1; AFNElJ8CVjkboLHqj368ViwQPIIO7fkbmYIsvVfUhx8uWSyRE5luag0Mx6rBVT5Kzc+KZ6RokkSzDVP3hHjU+hoyIP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgwqNHQQPQs3uFVsBGwgtYTp575h+1CTLuZyNez2L6/NU0N2w
	hhR9uBWp4uKej6si7LeFMIKNTBHeNKMg9mJSIiXpfTutP5/OHgDr9+Uq
X-Gm-Gg: Acq92OHgH3vbxmOJXfrNtxd3pGShNn0woeHrZkg4neq0cI0tEvimiNXv9AhoNSsPrFL
	K66j7S6IhaTMLogk7o/RvLzDbLXucDQf3sV6c+T4ellF4AseA2EnmU1QYwGTIRW48psKO4NDa+F
	h6jifaYynf6o3IA6dZ7HRyVdF8dUigc7Kk5Iz1NKkJSfSpZkaNVb4u8n0eZ1r867iHMjC0xhhwS
	Rd5MilfjcIfLe+k93VS6RoRhJel6H6wIvnb67JDzEmOXoivB8IRmZcriENoM2zacm+Pc9D5eO5r
	xca13XvMHKXtJQgETkMEF6f248Qh9OsCQ9NY0zokJaBdM7EK0NsvaANqTWXqwIYzMf3UZfUJyIF
	vCl5limESZPZr4ZVTvFXGLcPmHkYKuGNWBh2hLl+OBUzvhYjb6NQIDRCvMZn/nwyabInXKmG7xC
	ICk1XTqWTvzz17Nu8uOxBnxETjDyEIWDXm4CP++1+Dke3wUNCzLN6m/6xizf0zLLvvYpy0RBTUi
	K4o/CseTcMTKdke2Jgb1UWyjuBYz7whvbZA0qkR15sDrQ==
X-Received: by 2002:a17:903:1ab0:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2ba7a34b378mr246513525ad.33.1778469722390;
        Sun, 10 May 2026 20:22:02 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm89856955ad.15.2026.05.10.20.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 20:22:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)),
	kvm-riscv@lists.infradead.org (open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] RISC-V: KVM: Use flexible array for APLIC IRQ state
Date: Sun, 10 May 2026 20:21:44 -0700
Message-ID: <20260511032144.361520-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the per-source APLIC IRQ state in the APLIC allocation instead
of allocating it separately.

This ties the IRQ state lifetime directly to the APLIC state, removes a
separate allocation failure path, and lets __counted_by() describe the
array bounds.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/riscv/kvm/aia_aplic.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index 3464f3351df7..748107c347d9 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -35,7 +35,7 @@ struct aplic {
 
 	u32 nr_irqs;
 	u32 nr_words;
-	struct aplic_irq *irqs;
+	struct aplic_irq irqs[] __counted_by(nr_irqs);
 };
 
 static u32 aplic_read_sourcecfg(struct aplic *aplic, u32 irq)
@@ -581,7 +581,7 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
 		return 0;
 
 	/* Allocate APLIC global state */
-	aplic = kzalloc_obj(*aplic);
+	aplic = kzalloc_flex(*aplic, irqs, kvm->arch.aia.nr_sources + 1);
 	if (!aplic)
 		return -ENOMEM;
 	kvm->arch.aia.aplic_state = aplic;
@@ -589,11 +589,6 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
 	/* Setup APLIC IRQs */
 	aplic->nr_irqs = kvm->arch.aia.nr_sources + 1;
 	aplic->nr_words = DIV_ROUND_UP(aplic->nr_irqs, 32);
-	aplic->irqs = kzalloc_objs(*aplic->irqs, aplic->nr_irqs);
-	if (!aplic->irqs) {
-		ret = -ENOMEM;
-		goto fail_free_aplic;
-	}
 	for (i = 0; i < aplic->nr_irqs; i++)
 		raw_spin_lock_init(&aplic->irqs[i].lock);
 
@@ -606,7 +601,7 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
 				      &aplic->iodev);
 	mutex_unlock(&kvm->slots_lock);
 	if (ret)
-		goto fail_free_aplic_irqs;
+		goto fail_free_aplic;
 
 	/* Setup default IRQ routing */
 	ret = kvm_riscv_setup_default_irq_routing(kvm, aplic->nr_irqs);
@@ -619,8 +614,6 @@ int kvm_riscv_aia_aplic_init(struct kvm *kvm)
 	mutex_lock(&kvm->slots_lock);
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &aplic->iodev);
 	mutex_unlock(&kvm->slots_lock);
-fail_free_aplic_irqs:
-	kfree(aplic->irqs);
 fail_free_aplic:
 	kvm->arch.aia.aplic_state = NULL;
 	kfree(aplic);
@@ -638,8 +631,6 @@ void kvm_riscv_aia_aplic_cleanup(struct kvm *kvm)
 	kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &aplic->iodev);
 	mutex_unlock(&kvm->slots_lock);
 
-	kfree(aplic->irqs);
-
 	kvm->arch.aia.aplic_state = NULL;
 	kfree(aplic);
 }
-- 
2.54.0

