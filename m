Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DDD2857EF
	for <linux-hardening@vger.kernel.org>; Thu, 24 Apr 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509690; cv=none; b=HUuLJZ51EzpBS7ptYExYPi7w078Kx4VL6wNgJedQEobIDZPvpmKfuhKBVJD107O7djNhhnOLTY3MSaqL+s1/3njHVP4ZvI3apTnNkTcmfHomTbcFoJkNDdYFXt6K24nmOkcOn86fsg/nIlCspwahjECsZ5gY1kT8uivKV4ZgGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509690; c=relaxed/simple;
	bh=VbNtbJeW4BrMkVekszIIgLbdze/dqYoIsKnrVR8zkCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liwqyVacwg0ZxLKtEi540QHP4FA6mOOhFssaCR1bGuw8riBG3tTKhi/fe7WH0793s9Cwdt7zDTY0jNoTxxrqDvQ+AxEFh0V/o3YVJa3K91A9+7D+YK/HpXf9QiZvhqfj/D9/jBN4VLSVXFXLXavD+YMs0sPBt3EFUsL5Gjsic5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmbDRUQU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmbDRUQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9v3NRb5yZUKzU/ZWtoQyWFO+dN/xrgQOBGuYWHOvnK4=;
	b=GmbDRUQUaHYwy6kjl2kUu+BozsYJVr9Z9V7Y6CmXZ2vFUzpb1KpcPyS42bVBfKiKunkYA4
	DoUOcSL8jFhNgKhH4ofoc+/AB5cRiPPIWt67G7pMIPGG7uoj69PlZpFAwkclyEvrVDf1s5
	5j/5FpQqwD0fQ+rrzK78PRdOCm6QFaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-Ky0akV1qPOuZfxJwKHMsGQ-1; Thu,
 24 Apr 2025 11:48:03 -0400
X-MC-Unique: Ky0akV1qPOuZfxJwKHMsGQ-1
X-Mimecast-MFC-AGG-ID: Ky0akV1qPOuZfxJwKHMsGQ_1745509680
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5A09195608B;
	Thu, 24 Apr 2025 15:48:00 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01D1D19560AB;
	Thu, 24 Apr 2025 15:47:55 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v4 6/8] mfd: zl3073x: Fetch invariants during probe
Date: Thu, 24 Apr 2025 17:47:20 +0200
Message-ID: <20250424154722.534284-7-ivecera@redhat.com>
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Several configuration parameters will remain constant at runtime,
so we can load them during probe to avoid excessive reads from
the hardware.

These parameters will be frequently accessed by the DPLL sub-device
driver (in follow-up series), and later by the PHC/PTP sub-device
driver.

Read the following parameters from the device during probe and store
them for later use:

* frequencies of the synthesizers and their associated DPLL channels
* enablement and type (single-ended or differential) of input pins
* associated synthesizers, signal format, and enablement status of
  outputs

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3->v4:
* adjusted for new mailbox API
v2->v3:
* dropped usage of macros for generating helper functions
v1->v2:
* fixed and added inline documentation
---
 drivers/mfd/zl3073x-core.c  | 200 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-regs.h  |  17 +++
 include/linux/mfd/zl3073x.h | 144 ++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 4f7c915f17980..b6058de04f954 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -6,6 +6,7 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -715,6 +716,200 @@ static void zl3073x_devlink_unregister(void *ptr)
 	devlink_unregister(ptr);
 }
 
+/**
+ * zl3073x_input_state_fetch - get input state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: input pin index to fetch state for
+ *
+ * Function fetches information for the given input reference that are
+ * invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_input_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_input *input;
+	struct zl3073x_mb_ref ref;
+	int rc;
+
+	input = &zldev->input[index];
+
+	/* If the input is differential then the configuration for N-pin
+	 * reference is ignored and P-pin config is used for both.
+	 */
+	if (zl3073x_is_n_pin(index) &&
+	    zl3073x_input_is_diff(zldev, index - 1)) {
+		input->enabled = zl3073x_input_is_enabled(zldev, index - 1);
+		input->diff = true;
+
+		return 0;
+	}
+
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_ref_read(zldev, index, ZL3073X_MB_REF_CONFIG, &ref);
+	if (rc)
+		return rc;
+
+	input->enabled = FIELD_GET(ZL_REF_CONFIG_ENABLE, ref.config);
+	input->diff = FIELD_GET(ZL_REF_CONFIG_DIFF_EN, ref.config);
+
+	dev_dbg(zldev->dev, "INPUT%u is %s and configured as %s\n", index,
+		input->enabled ? "enabled" : "disabled",
+		input->diff ? "differential" : "single-ended");
+
+	return rc;
+}
+
+/**
+ * zl3073x_output_state_fetch - get output state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: output index to fetch state for
+ *
+ * Function fetches information for the given output (not output pin)
+ * that are invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_output_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_output *output;
+	struct zl3073x_mb_output mb;
+	u8 output_ctrl;
+	int rc;
+
+	output = &zldev->output[index];
+
+	/* Read output control register */
+	rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_CTRL(index), &output_ctrl);
+	if (rc)
+		return rc;
+
+	/* Store info about output enablement and synthesizer the output
+	 * is connected to.
+	 */
+	output->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
+	output->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
+
+	dev_dbg(zldev->dev, "OUTPUT%u is %s, connected to SYNTH%u\n",
+		index, output->enabled ? "enabled" : "disabled", output->synth);
+
+	/* Read output config mailbox */
+	rc = zl3073x_mb_output_read(zldev, index, ZL3073X_MB_OUTPUT_MODE, &mb);
+	if (rc)
+		return rc;
+
+	/* Extract and store output signal format */
+	output->signal_format = FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT,
+					  mb.mode);
+
+	dev_dbg(zldev->dev, "OUTPUT%u has signal format 0x%02x\n", index,
+		output->signal_format);
+
+	return rc;
+}
+
+/**
+ * zl3073x_synth_state_fetch - get synth state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: synth index to fetch state for
+ *
+ * Function fetches information for the given synthesizer that are
+ * invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_mb_synth mb;
+	u8 synth_ctrl;
+	int rc;
+
+	/* Read synth control register */
+	rc = zl3073x_read_reg(zldev, ZL_REG_SYNTH_CTRL(index), &synth_ctrl);
+	if (rc)
+		return rc;
+
+	/* Extract and store DPLL channel the synth is driven by */
+	zldev->synth[index].dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL,
+					     synth_ctrl);
+
+	dev_dbg(zldev->dev, "SYNTH%u is connected to DPLL%u\n", index,
+		zldev->synth[index].dpll);
+
+	/* Read synth configuration into mailbox */
+	rc = zl3073x_mb_synth_read(zldev, index,
+				   ZL3073X_MB_SYNTH_FREQ_BASE	|
+				   ZL3073X_MB_SYNTH_FREQ_MULT	|
+				   ZL3073X_MB_SYNTH_FREQ_M	|
+				   ZL3073X_MB_SYNTH_FREQ_N, &mb);
+	if (rc)
+		return rc;
+
+	/* The output frequency is determined by the following formula:
+	 * base * multiplier * numerator / denominator
+	 */
+
+	/* Check denominator for zero to avoid div by 0 */
+	if (!mb.freq_n) {
+		dev_err(zldev->dev,
+			"Zero divisor for SYNTH%u retrieved from device\n",
+			index);
+		return -EINVAL;
+	}
+
+	/* Compute and store synth frequency */
+	zldev->synth[index].freq = mul_u64_u32_div(mul_u32_u32(mb.freq_base,
+							       mb.freq_mult),
+						   mb.freq_m, mb.freq_n);
+
+	dev_dbg(zldev->dev, "SYNTH%u frequency: %llu Hz\n", index,
+		zldev->synth[index].freq);
+
+	return rc;
+}
+
+static int
+zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
+{
+	int rc;
+	u8 i;
+
+	for (i = 0; i < ZL3073X_NUM_INPUTS; i++) {
+		rc = zl3073x_input_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch input state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
+	for (i = 0; i < ZL3073X_NUM_SYNTHS; i++) {
+		rc = zl3073x_synth_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch synth state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
+	for (i = 0; i < ZL3073X_NUM_OUTPUTS; i++) {
+		rc = zl3073x_output_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch output state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
+	return rc;
+}
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -769,6 +964,11 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Fetch device state */
+	rc = zl3073x_dev_state_fetch(zldev);
+	if (rc)
+		return rc;
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/drivers/mfd/zl3073x-regs.h b/drivers/mfd/zl3073x-regs.h
index a19f04c813cc6..daac6703d9d1c 100644
--- a/drivers/mfd/zl3073x-regs.h
+++ b/drivers/mfd/zl3073x-regs.h
@@ -71,6 +71,23 @@
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
 #define ZL_REG_CUSTOM_CONFIG_VER		ZL_REG(0, 0x07, 4)
 
+/***********************************
+ * Register Page 9, Synth and Output
+ ***********************************/
+
+#define ZL_REG_SYNTH_CTRL(_idx)						\
+	ZL_REG_IDX(_idx, 9, 0x00, 1, ZL3073X_NUM_SYNTHS, 1)
+#define ZL_SYNTH_CTRL_EN			BIT(0)
+#define ZL_SYNTH_CTRL_DPLL_SEL			GENMASK(6, 4)
+
+#define ZL_REG_OUTPUT_CTRL(_idx)					\
+	ZL_REG_IDX(_idx, 9, 0x28, 1, ZL3073X_NUM_OUTPUTS, 1)
+#define ZL_OUTPUT_CTRL_EN			BIT(0)
+#define ZL_OUTPUT_CTRL_STOP			BIT(1)
+#define ZL_OUTPUT_CTRL_STOP_HIGH		BIT(2)
+#define ZL_OUTPUT_CTRL_STOP_HZ			BIT(3)
+#define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
+
 /*******************************
  * Register Page 10, Ref Mailbox
  *******************************/
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 352cd0f2f64a4..43171246093f2 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -15,14 +15,54 @@ struct regmap;
 #define ZL3073X_NUM_OUTPUTS	10
 #define ZL3073X_NUM_SYNTHS	5
 
+/**
+ * struct zl3073x_input - input invariant info
+ * @enabled: input is enabled or disabled
+ * @diff: true if input is differential
+ */
+struct zl3073x_input {
+	bool	enabled;
+	bool	diff;
+};
+
+/**
+ * struct zl3073x_output - output invariant info
+ * @enabled: output is enabled or disabled
+ * @synth: synthesizer the output is connected to
+ * @signal_format: output signal format
+ */
+struct zl3073x_output {
+	bool	enabled;
+	u8	synth;
+	u8	signal_format;
+};
+
+/**
+ * struct zl3073x_synth - synthesizer invariant info
+ * @freq: synthesizer frequency
+ * @dpll: ID of DPLL the synthesizer is driven by
+ */
+struct zl3073x_synth {
+	u64	freq;
+	u8	dpll;
+};
+
 /**
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
+ * @input: array of inputs' invariants
+ * @output: array of outputs' invariants
+ * @synth: array of synthesizers' invariants
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
+
+	/* Invariants */
+	struct zl3073x_input	input[ZL3073X_NUM_INPUTS];
+	struct zl3073x_output	output[ZL3073X_NUM_OUTPUTS];
+	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
 };
 
 /*************************
@@ -159,4 +199,108 @@ int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
 int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
 			   struct zl3073x_mb_synth *mb);
 
+static inline
+bool zl3073x_is_n_pin(u8 index)
+{
+	/* P-pins indices are even while N-pins are odd */
+	return index & 1;
+}
+
+static inline
+bool zl3073x_is_p_pin(u8 index)
+{
+	return !zl3073x_is_n_pin(index);
+}
+
+/**
+ * zl3073x_input_is_diff - check if the given input ref is differential
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if input is differential, false if input is single-ended
+ */
+static inline
+bool zl3073x_input_is_diff(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->input[index].diff;
+}
+
+/**
+ * zl3073x_input_is_enabled - check if the given input ref is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: input index
+ *
+ * Return: true if input is enabled, false if input is disabled
+ */
+static inline
+bool zl3073x_input_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->input[index].enabled;
+}
+
+/**
+ * zl3073x_output_is_enabled - check if the given output is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if output is enabled, false if output is disabled
+ */
+static inline
+u8 zl3073x_output_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].enabled;
+}
+
+/**
+ * zl3073x_output_signal_format_get - get output signal format
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: signal format of given output
+ */
+static inline
+u8 zl3073x_output_signal_format_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].signal_format;
+}
+
+/**
+ * zl3073x_output_synth_get - get synth connected to given output
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: index of synth connected to given output.
+ */
+static inline
+u8 zl3073x_output_synth_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].synth;
+}
+
+/**
+ * zl3073x_synth_dpll_get - get DPLL ID the synth is driven by
+ * @zldev: pointer to zl3073x device
+ * @index: synth index
+ *
+ * Return: ID of DPLL the given synthetizer is driven by
+ */
+static inline
+u64 zl3073x_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].dpll;
+}
+
+/**
+ * zl3073x_synth_freq_get - get synth current freq
+ * @zldev: pointer to zl3073x device
+ * @index: synth index
+ *
+ * Return: frequency of given synthetizer
+ */
+static inline
+u64 zl3073x_synth_freq_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].freq;
+}
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.49.0

