Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5B3596E4
	for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824539; cv=none; b=Kd91hruynZwA4AuMAhw+cj8GD/vBo42qGewSm2lAEPBXjWWkFjHoRb+B8oHVyXLGvJT9SEojRq4ZwEIndv8lrt2LXndmtawNqVPSutwM8etFGCkSNpaFyFPhv0ugY3Q+onNMu/T54fyRwL2S78LIXXiVYXvNihtBznOTdMPFFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824539; c=relaxed/simple;
	bh=xm2Bk0tp2/dYXXAn7n3eVAFPnJF+Lc6bvpH8padRGcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tcns5YfHLxfDopT80RiUmHxvNll2w/rfEfuJGXF2rbYFFGA9oln0uAWRDUtlF0Ls70g3tqWDzOKb/iPqykd2fdpHvP3qIU5q6GtCbtYndRYdvqD6/rBjO51EFNlASSkOOFi2DTuPQZWNeBvqyaWwXogq0UUw33XdiD1Y2LEKHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bDaDpHod; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDaDpHod"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so25358915e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 19 Jan 2026 04:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824534; x=1769429334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylfAjxpOUxlcbMBmHFNtPCkWSO4scZYP0qkSe//RiXk=;
        b=bDaDpHodg/dQSlTPwJwQ/1Bnrq4HBx7QlMrWdmEsnWmBdzegxiG3yE4xqYTgxQSwvO
         45BCEmuTONx4/vZLL/STWc9WIP2MYa7w+JfvMW+0mJWX5r9/5cp8771wZ7itYIy1GefE
         6UUK826AWUcFoMhGwrBjs0AU5eYUACNiNpdVy6h7OwHbblnDWkszvQ2AGkRl/q20FLVt
         ++ytKO4VPUe7ILrfLaKGlKSWYltcpatk4z4U+nuegNb3Jx+fxlNNABpA5mtQ294z56HN
         hTqFe1tOeHoYaJh39mgxCTgEfZuF/dKb7TGSQBO0N9JMZGabGatsw2ePu9h9i5SyL4QD
         0rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824534; x=1769429334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylfAjxpOUxlcbMBmHFNtPCkWSO4scZYP0qkSe//RiXk=;
        b=cHDgesKJVretWtC352IaBkZye/kdCsbxWn2xMTYHFs1R8nX9MOBNRBp9LW87VXdzz7
         8ZU1oRRYQO7s6YWLRxmAiyiKu//mjg3wEChjoBCysVVRkFkXIQv2E2xqaA23BBaVb3fn
         dSBM2MlXDLciuud1DgCMA9dUkGc39JTE5xwuQkmfDu3hR/UT6CGwQelLE4TH0vLpbJ/d
         lSIvHEjFtqLqb595tN7BM57iY37x0Tu3GS62cNSRJBoKSxriRh6xenRst6rMh7qZsj7N
         gEAct43keLznTK9nSO7lzIUNHiJj9mlmuabw3c7dV8iqc4PtypGDB+0Pb627IJ6lvjwp
         bjcA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sqa8mTQMmqIUqekUATpv1+wSjKmWVKlisQ7mfIOQRkp9jtQzskiYPRMiWNJSxHPwUUJMc14y8wJGulfMm1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya38kaIlgSXVukgl5+mKXkWTTwrjvL9PMtVejXy6WscUm1kNGe
	TtIFeW2mDtpEhuQICbD6ZfP+d4HmDE5Fakpw2/RqXM1mX1cLmVJ4LV2B6A7jVfya7cE=
X-Gm-Gg: AY/fxX5YekI06aCn2V/yXqOZ3w5cesdEGVV1kBMQKQ9CtWb8ZcLT6hbqIf3iGFbkoe0
	A1WBp5W78+q2JOsPFZn56v//IFtsI4STwvQ93gKfutrLOBD6ttUybUR+tweL7cYuSYRIJ+jDvP7
	EJ2eUGuTzStbb2MtIvZvwWpddxwUvqoy5YC2btv2oFq928/iDtaINt8TJC6z57BMGwAd17zEzBX
	tQgU91YcNws7h0mkgKdCXwflYV8gkXRkOQXaAbHzyiVfU1cmwZrN3/J7Pmv3Jzz9wapUQzW+gh4
	hq9BQ1fO9isPD8X+9nWN2o8d0xS36p7aHzi8hwlojDvWURZbZSnwpgMb4D9ua37xnfT5T671fAI
	jE+2RUAODcz3gwA5MJele7f+ucxHF0GuMWvYDE12ob8DQCosgNmhP9Uet2cWCQ5v4MqW8X1lGsS
	1kLQ8lmnE3z1tjqLfTgnY251US6eM2blPx1hwmNFn2LReKYxZZO0BC7C3eMtpXYxh7fmzogZ8Ko
	V2Rs5ga
X-Received: by 2002:a05:600c:1c28:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4801eb109e0mr130549215e9.28.1768824534313;
        Mon, 19 Jan 2026 04:08:54 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:53 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 19 Jan 2026 12:08:48 +0000
Subject: [PATCH v2 2/7] firmware: samsung: acpm: Add TMU protocol support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-acpm-tmu-v2-2-e02a834f04c6@linaro.org>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=11506;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=xm2Bk0tp2/dYXXAn7n3eVAFPnJF+Lc6bvpH8padRGcg=;
 b=rK0SJyctMob1vdqVS1D3IM9jdQOu7BrB06o+UuhUxD6Fa9dPj+HX2X3tOmK6b3Z9riwIfmBH8
 25iPEkXpzD/Ccb0PKShVmQz+ixWvGYzX5PWtpZj5zVaHXf8pMfbSn/E
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Thermal Management Unit (TMU) on the Google GS101 SoC is managed
through a hybrid model shared between the kernel and the Alive Clock
and Power Manager (ACPM) firmware.

Add the protocol helpers required to communicate with the ACPM for
thermal operations, including initialization, threshold configuration,
temperature reading, and system suspend/resume handshakes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/Makefile                  |   1 +
 drivers/firmware/samsung/exynos-acpm-tmu.c         | 212 +++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm-tmu.h         |  33 ++++
 drivers/firmware/samsung/exynos-acpm.c             |  12 ++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  24 +++
 5 files changed, 282 insertions(+)

diff --git a/drivers/firmware/samsung/Makefile b/drivers/firmware/samsung/Makefile
index 80d4f89b33a9558b68c9083da675c70ec3d05f19..5a6f72bececfd98ba5af37d1d65fed48a3d8f912 100644
--- a/drivers/firmware/samsung/Makefile
+++ b/drivers/firmware/samsung/Makefile
@@ -3,4 +3,5 @@
 acpm-protocol-objs			:= exynos-acpm.o
 acpm-protocol-objs			+= exynos-acpm-pmic.o
 acpm-protocol-objs			+= exynos-acpm-dvfs.o
+acpm-protocol-objs			+= exynos-acpm-tmu.o
 obj-$(CONFIG_EXYNOS_ACPM_PROTOCOL)	+= acpm-protocol.o
diff --git a/drivers/firmware/samsung/exynos-acpm-tmu.c b/drivers/firmware/samsung/exynos-acpm-tmu.c
new file mode 100644
index 0000000000000000000000000000000000000000..7ec4b48074eb8b4e569b39d4bb5963d887aa9521
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm-tmu.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/ktime.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "exynos-acpm.h"
+#include "exynos-acpm-tmu.h"
+
+/* IPC Request Types */
+#define ACPM_TMU_INIT		0x01
+#define ACPM_TMU_READ_TEMP	0x02
+#define ACPM_TMU_SUSPEND	0x04
+#define ACPM_TMU_RESUME		0x10
+#define ACPM_TMU_THRESHOLD	0x11
+#define ACPM_TMU_INTEN		0x12
+#define ACPM_TMU_CONTROL	0x13
+#define ACPM_TMU_IRQ_CLEAR	0x14
+#define ACPM_TMU_HYSTERESIS	0x16
+
+#define ACPM_TMU_TX_DATA_LEN	8
+#define ACPM_TMU_RX_DATA_LEN	7
+
+struct acpm_tmu_tx {
+	u16 ctx;
+	u16 fw_use;
+	u8 type;
+	u8 rsvd0;
+	u8 tzid;
+	u8 rsvd1;
+	u8 data[ACPM_TMU_TX_DATA_LEN];
+} __packed;
+
+struct acpm_tmu_rx {
+	u16 ctx;
+	u16 fw_use;
+	u8 type;
+	s8 ret;
+	u8 tzid;
+	s8 temp;
+	u8 rsvd;
+	u8 data[ACPM_TMU_RX_DATA_LEN];
+} __packed;
+
+union acpm_tmu_msg {
+	u32 data[4];
+	struct acpm_tmu_tx tx;
+	struct acpm_tmu_rx rx;
+} __packed;
+
+static void acpm_tmu_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
+			      unsigned int acpm_chan_id)
+{
+	xfer->acpm_chan_id = acpm_chan_id;
+	xfer->txd = cmd;
+	xfer->txlen = cmdlen;
+	xfer->rxd = cmd;
+	xfer->rxlen = cmdlen;
+}
+
+int acpm_tmu_init(const struct acpm_handle *handle, unsigned int acpm_chan_id)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+
+	msg.tx.type = ACPM_TMU_INIT;
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_read_temp(const struct acpm_handle *handle,
+		       unsigned int acpm_chan_id, u8 tz, int *temp)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int ret;
+
+	msg.tx.type = ACPM_TMU_READ_TEMP;
+	msg.tx.tzid = tz;
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	ret = acpm_do_xfer(handle, &xfer);
+	if (ret)
+		return ret;
+
+	*temp = msg.rx.temp;
+
+	return 0;
+}
+
+int acpm_tmu_set_threshold(const struct acpm_handle *handle,
+			   unsigned int acpm_chan_id, u8 tz,
+			   const u8 temperature[8], size_t tlen)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int i;
+
+	if (tlen > ACPM_TMU_TX_DATA_LEN)
+		return -EINVAL;
+
+	msg.tx.type = ACPM_TMU_THRESHOLD;
+	msg.tx.tzid = tz;
+
+	for (i = 0; i < tlen; i++)
+		msg.tx.data[i] = temperature[i];
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_set_hysteresis(const struct acpm_handle *handle,
+			    unsigned int acpm_chan_id, u8 tz,
+			    const u8 hysteresis[8], size_t hlen)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+	int i;
+
+	if (hlen > ACPM_TMU_TX_DATA_LEN)
+		return -EINVAL;
+
+	msg.tx.type = ACPM_TMU_HYSTERESIS;
+	msg.tx.tzid = tz;
+
+	for (i = 0; i < hlen; i++)
+		msg.tx.data[i] = hysteresis[i];
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_set_interrupt_enable(const struct acpm_handle *handle,
+				  unsigned int acpm_chan_id, u8 tz, u8 inten)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+
+	msg.tx.type = ACPM_TMU_INTEN;
+	msg.tx.tzid = tz;
+	msg.tx.data[0] = inten;
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_tz_control(const struct acpm_handle *handle,
+			unsigned int acpm_chan_id, u8 tz, bool enable)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+
+	msg.tx.type = ACPM_TMU_CONTROL;
+	msg.tx.tzid = tz;
+	msg.tx.data[0] = enable ? 1 : 0;
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_clear_tz_irq(const struct acpm_handle *handle,
+			  unsigned int acpm_chan_id, u8 tz)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+
+	msg.tx.type = ACPM_TMU_IRQ_CLEAR;
+	msg.tx.tzid = tz;
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_suspend(const struct acpm_handle *handle,
+		     unsigned int acpm_chan_id)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+
+	msg.tx.type = ACPM_TMU_SUSPEND;
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
+
+int acpm_tmu_resume(const struct acpm_handle *handle, unsigned int acpm_chan_id)
+{
+	union acpm_tmu_msg msg = {0};
+	struct acpm_xfer xfer;
+
+	msg.tx.type = ACPM_TMU_RESUME;
+
+	acpm_tmu_set_xfer(&xfer, msg.data, sizeof(msg.data), acpm_chan_id);
+
+	return acpm_do_xfer(handle, &xfer);
+}
diff --git a/drivers/firmware/samsung/exynos-acpm-tmu.h b/drivers/firmware/samsung/exynos-acpm-tmu.h
new file mode 100644
index 0000000000000000000000000000000000000000..f1a1ac21736d52bea0ad2a7cb3b280201fa74ffe
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm-tmu.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+#ifndef __EXYNOS_ACPM_TMU_H__
+#define __EXYNOS_ACPM_TMU_H__
+
+#include <linux/types.h>
+
+struct acpm_handle;
+
+int acpm_tmu_init(const struct acpm_handle *handle, unsigned int acpm_chan_id);
+int acpm_tmu_read_temp(const struct acpm_handle *handle,
+		       unsigned int acpm_chan_id, u8 tz, int *temp);
+int acpm_tmu_set_threshold(const struct acpm_handle *handle,
+			   unsigned int acpm_chan_id, u8 tz,
+			   const u8 temperature[8], size_t tlen);
+int acpm_tmu_set_hysteresis(const struct acpm_handle *handle,
+			    unsigned int acpm_chan_id, u8 tz,
+			    const u8 hysteresis[8], size_t hlen);
+int acpm_tmu_set_interrupt_enable(const struct acpm_handle *handle,
+				  unsigned int acpm_chan_id, u8 tz, u8 inten);
+int acpm_tmu_tz_control(const struct acpm_handle *handle,
+			unsigned int acpm_chan_id, u8 tz, bool enable);
+int acpm_tmu_clear_tz_irq(const struct acpm_handle *handle,
+			  unsigned int acpm_chan_id, u8 tz);
+int acpm_tmu_suspend(const struct acpm_handle *handle,
+		     unsigned int acpm_chan_id);
+int acpm_tmu_resume(const struct acpm_handle *handle,
+		    unsigned int acpm_chan_id);
+#endif /* __EXYNOS_ACPM_TMU_H__ */
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 0cb269c7046015d4c5fe5731ba0d61d48dcaeee1..cc045370f4b0dc6ccea99e3c2d6f86a43b2e9671 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -31,6 +31,7 @@
 #include "exynos-acpm.h"
 #include "exynos-acpm-dvfs.h"
 #include "exynos-acpm-pmic.h"
+#include "exynos-acpm-tmu.h"
 
 #define ACPM_PROTOCOL_SEQNUM		GENMASK(21, 16)
 
@@ -595,6 +596,7 @@ static void acpm_setup_ops(struct acpm_info *acpm)
 {
 	struct acpm_dvfs_ops *dvfs_ops = &acpm->handle.ops.dvfs_ops;
 	struct acpm_pmic_ops *pmic_ops = &acpm->handle.ops.pmic_ops;
+	struct acpm_tmu_ops *tmu_ops = &acpm->handle.ops.tmu;
 
 	dvfs_ops->set_rate = acpm_dvfs_set_rate;
 	dvfs_ops->get_rate = acpm_dvfs_get_rate;
@@ -604,6 +606,16 @@ static void acpm_setup_ops(struct acpm_info *acpm)
 	pmic_ops->write_reg = acpm_pmic_write_reg;
 	pmic_ops->bulk_write = acpm_pmic_bulk_write;
 	pmic_ops->update_reg = acpm_pmic_update_reg;
+
+	tmu_ops->init = acpm_tmu_init;
+	tmu_ops->read_temp = acpm_tmu_read_temp;
+	tmu_ops->set_threshold = acpm_tmu_set_threshold;
+	tmu_ops->set_hysteresis = acpm_tmu_set_hysteresis;
+	tmu_ops->set_interrupt_enable = acpm_tmu_set_interrupt_enable;
+	tmu_ops->tz_control = acpm_tmu_tz_control;
+	tmu_ops->clear_tz_irq = acpm_tmu_clear_tz_irq;
+	tmu_ops->suspend = acpm_tmu_suspend;
+	tmu_ops->resume = acpm_tmu_resume;
 }
 
 static void acpm_clk_pdev_unregister(void *data)
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 2091da965a5ad238b5e16c567a72fe88fafe6095..43d41e11ad2eb985e27a918ce3f9e9ac15a194ee 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -40,9 +40,33 @@ struct acpm_pmic_ops {
 			  u8 value, u8 mask);
 };
 
+struct acpm_tmu_ops {
+	int (*init)(const struct acpm_handle *handle,
+		    unsigned int acpm_chan_id);
+	int (*read_temp)(const struct acpm_handle *handle,
+			 unsigned int acpm_chan_id, u8 tz, int *temp);
+	int (*set_threshold)(const struct acpm_handle *handle,
+			     unsigned int acpm_chan_id, u8 tz,
+			     const u8 temperature[8], size_t tlen);
+	int (*set_hysteresis)(const struct acpm_handle *handle,
+			      unsigned int acpm_chan_id, u8 tz,
+			      const u8 hysteresis[8], size_t hlen);
+	int (*set_interrupt_enable)(const struct acpm_handle *handle,
+				    unsigned int acpm_chan_id, u8 tz, u8 inten);
+	int (*tz_control)(const struct acpm_handle *handle,
+			  unsigned int acpm_chan_id, u8 tz, bool enable);
+	int (*clear_tz_irq)(const struct acpm_handle *handle,
+			    unsigned int acpm_chan_id, u8 tz);
+	int (*suspend)(const struct acpm_handle *handle,
+		       unsigned int acpm_chan_id);
+	int (*resume)(const struct acpm_handle *handle,
+		      unsigned int acpm_chan_id);
+};
+
 struct acpm_ops {
 	struct acpm_dvfs_ops dvfs_ops;
 	struct acpm_pmic_ops pmic_ops;
+	struct acpm_tmu_ops tmu;
 };
 
 /**

-- 
2.52.0.457.g6b5491de43-goog

