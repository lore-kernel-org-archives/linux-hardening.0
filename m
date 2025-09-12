Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707A32143F
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689840; cv=none; b=mJzXCJjQjDDaW+kYUxJTkERU8d9f90DTw3ZaSbF9+ydqVp0ZyHZMnknXO2lKi9YV7yVazH8+t+rlABpBvzXkK3Q90jLXwTSSF0TIBxFZqx1ovDp4hBbJqbUk4fQO6eu4LG9VGvnxbvta8TX4XPwye9iomEoMiVQ2jyM1JFt+8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689840; c=relaxed/simple;
	bh=lBamo/mRxiUtCBdbmIZyVniV6pvujs45sCbA4KFEQzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEHfKxCvYRnSEDbRETjtmqp776r3vcYQgT6fQ1NMAKpcsdD/hHG4qCxtzhoPeuVOFrMoPVLgjl36bjz9qZx8FwgYR7uW1LK4TyzBXIDifN7fsw87Fdgw3iRkhApCMmZnicLazQcgfQKtAZdkkg+1cB/8kn9aiFvCPM/MXi6oG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fAOMROtg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAOMROtg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60504bf8so19144497b3.2
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689836; x=1758294636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ds8gslyRhEA90VqYYB6jUYRwIuKnqG3r9jdtCHu7D4=;
        b=fAOMROtg/82tIva9GG3Qq7B1/Xo0+WLG/MAQv4jrJm8l+dpu/m7w88+hJOQUjbEBCE
         Q/c6F7hcNX4R6eSvQuECiTJ/TwZ5ordlY296OA611EL10F6Q1XB+2shpcmNX1wJysvwv
         NOh0HeeJrlREnwXJPTUTPDanh1+wbk5RqHQ26uU6u2xA9a2cR+CzZhb7PNYnsb0MizPk
         vfA0nSyqNet2mhTreKSt6W/pq1aHgIboBGbT4SMlpCiDS1qWyPIW2mSg10P7JSnWUfnN
         dgEWo/RJpZfZ7WXd2RPHPcUbUJGClDGaXmF6kF1cvaXdV1OhTMqaB58W9YZMg4944Pzp
         7LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689836; x=1758294636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ds8gslyRhEA90VqYYB6jUYRwIuKnqG3r9jdtCHu7D4=;
        b=p12cRHWv+gSNvXpGhOjmxBCo+DAiYPVWCahhXpkK7cOpw70uAiF2yHv1B/d6yTBS5U
         DZoz+hhyZ1dSXmOEddL0RFBeR7jn6pMj9wgtBX+ZolUUM+GfOd4N17NhnRwNkJP9IltQ
         Ig0IikQEueGh9UN9F83zTjfpHl12YUrKUlghvJtxzp4HxYGa3eFDUzx94EG931pAWGWu
         H7irqj1yEl86aFV49NXs7sB1g4MmDrLAw6o9nFiy2I/h+25qJ/DF/UfFaPRLRUYJdksy
         1WvW/11AUcekDFi+KL+gcdUGzq1xMxvwzRDEaiMjRkcge5MMG30/4B9xP4Um1YBz6jFe
         VhCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgyOLdCij3UxapUkMd4LNSROfnSL1lWhJ5CWX/C1G17+7MTC008u5Lbdh6t1j5XjVsxUXSlVOBfteuL8GMqw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBBNgZR+iAFZwF3aUQN6NWd0HiSyxQK2Gg1xkUF4cTiDEX1gm
	ITKtB7TIYyIhbls2+//IUqDfXCE0H88eGLi+w5QLDr9B5A2ROcmXG7FxhpNoBh3MJCQ=
X-Gm-Gg: ASbGncsiLiXMBm1MlbVQ2wkzEVmPiaFhIz7emDomQ6kEyflZ4mqEFT2zWIHuth9Bjkv
	D+txi2fJ68Y0T9zNaZ/3xRBby+klUHXtVB+vn+qZm85gA93y3fa0MZtmA51uO2Gp0XpTcZrXkIz
	Aon7iTmU8e/kSpJ3MV759JDfS7SwI9kD9mGPEqqIXRWu/FdRUmOfiS9Su6kM03m9Ke5Fm2QQln2
	0CoYahxcCqL5dGmoQtRTYHP77moI6/jTrOudeJCXJtKt/qQ8KBXom7NNiJFup6mS0qksDNA8yQD
	f2gQzqCDZd/p9cdriZt0P9YfHpihkV95BW8CieLy0AFPRRyJOysMnJP3eiNqFpUu/xAeoTaN9t4
	wd0ZLM47wag8D6YA1KDxdHtoFQZ7on4Gcew==
X-Google-Smtp-Source: AGHT+IGUk5zUSgxh+r2dAU6fmhsNlb1RTWa2J7nuwDb4l4jA+t4jqiomYFBGdZGHaaNJrIZspvEapA==
X-Received: by 2002:a05:690c:7286:b0:725:dc12:3004 with SMTP id 00721157ae682-73063d589abmr33964367b3.22.1757689836260;
        Fri, 12 Sep 2025 08:10:36 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:36 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 09/16] genirq/irqdesc: Have nr_irqs as non-static
Date: Fri, 12 Sep 2025 18:08:48 +0300
Message-ID: <20250912150855.2901211-10-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_irqs is required for debugging the kernel, and needs to be
accessible for kmemdump into vmcoreinfo.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5..6c3c8c4687fd 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -139,7 +139,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc_smp_init(desc, node, affinity);
 }
 
-static unsigned int nr_irqs = NR_IRQS;
+unsigned int nr_irqs = NR_IRQS;
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.
-- 
2.43.0

