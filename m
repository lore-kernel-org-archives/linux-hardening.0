Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44517253B56
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047184; cv=none; b=UKKXXD0sc5pz3HahaZoNyJhkttZyb8+BKapLBlv6NNQ5EGLA15W4Ah6DYAifTcZ8Fp3ON3IykI07ayPwFRKMFnX1XJRAufWJFz/SAzx7iTIz6DyxdTan4rrJ+FSZPR1hWW5+OFXUqjRpIe5wRdl640BeGEjapybyWnAVWmIRYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047184; c=relaxed/simple;
	bh=/KCV+k19D/ZEilHrdhSH00/mLdriTfar57/idijqgys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbPRvsGd5vxCuL2s6YKWF1vFPLcjV7qz0Bb1xOVL64tW0PZj3h4oh0FhHAeZFmni4F4h0Ni+I/5kVxrvDuJeBG5b9g5UUu8PjjeYqVnWxXCvqrLJw8NSGHAh6jKW/SH7yk7/hkQh2i7lKgh2/GmI4Odf8t6bTrbseFKnn5tEsg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icWx/CAD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icWx/CAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otJF277m8loBQ1n+65+voNXR2haFn/JCnsEQVYJTyYs=;
	b=icWx/CADSqh0fALqyCvNEGXbd4fwuz3yrv0zB3dU4/PPVChPmWvGK/R0dZWkXy86WoK1rs
	FvhW/vzsLeQTSrIIn326gHgNxsBLN7/oeeuMYFn8pJUt6dvKgll+WejSErBSx+0QQ8Mknh
	baIgmbKqYU6Nq4oK5OoPIJX/F2U5Yk0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-C64szBcENQGLYe0u3vFJoA-1; Mon,
 07 Apr 2025 13:32:55 -0400
X-MC-Unique: C64szBcENQGLYe0u3vFJoA-1
X-Mimecast-MFC-AGG-ID: C64szBcENQGLYe0u3vFJoA_1744047173
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE3D21956050;
	Mon,  7 Apr 2025 17:32:52 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 636A21956094;
	Mon,  7 Apr 2025 17:32:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 19/28] dpll: zl3073x: Implement input pin selection in manual mode
Date: Mon,  7 Apr 2025 19:31:49 +0200
Message-ID: <20250407173149.1010216-10-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Implement input pin state setting if the DPLL is running in manual mode.
The driver indicates manual mode if the DPLL mode is one of ref-lock,
forced-holdover, freerun and NCO (numerically controlled oscillator).

Use these modes to implement input pin state change between connected
and disconnected states. When the user set the particular pin as
connected the driver marks this input pin as forced reference and
switches the DPLL mode to ref-lock. When the use set the pin as
disconnected the driver switches the DPLL to freerun or forced holdover
mode. The switch to holdover mode is done if the DPLL has holdover
capability (e.g is currently locked with holdover acquired).

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 114 +++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index cf2cdd6dec263..ad2a8d383daaf 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -274,6 +274,68 @@ zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
  *
  * Return 0 in case of success or negative value otherwise.
  */
+static int
+zl3073x_dpll_selected_ref_set(struct zl3073x_dpll *zldpll, u8 ref)
+{
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 mode, mode_refsel;
+	int rc;
+
+	mode = zldpll->refsel_mode;
+
+	switch (mode) {
+	case DPLL_MODE_REFSEL_MODE_REFLOCK: /* Manual mode with ref selected */
+		if (ref == ZL3073X_REF_NONE) {
+			switch (zldpll->lock_status) {
+			case DPLL_LOCK_STATUS_LOCKED_HO_ACQ:
+			case DPLL_LOCK_STATUS_HOLDOVER:
+				/* Switch to forced holdover */
+				mode = DPLL_MODE_REFSEL_MODE_HOLDOVER;
+				break;
+			default:
+				/* Switch to freerun */
+				mode = DPLL_MODE_REFSEL_MODE_FREERUN;
+				break;
+			}
+			/* Keep selected reference */
+			ref = zldpll->forced_ref;
+		} else if (ref == zldpll->forced_ref) {
+			/* No register update - same mode and same ref */
+			return 0;
+		}
+		break;
+	case DPLL_MODE_REFSEL_MODE_FREERUN: /* Manual mode without no ref */
+	case DPLL_MODE_REFSEL_MODE_HOLDOVER:
+		if (ref == ZL3073X_REF_NONE)
+			/* No register update - keep current mode */
+			return 0;
+
+		/* Switch to reflock mode and update ref selection */
+		mode = DPLL_MODE_REFSEL_MODE_REFLOCK;
+		break;
+	default:
+		/* For other modes like automatic or NCO ref cannot be selected
+		 * manually
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	/* Build mode_refsel value */
+	mode_refsel = FIELD_PREP(DPLL_MODE_REFSEL_MODE, mode) |
+		      FIELD_PREP(DPLL_MODE_REFSEL_REF, ref);
+
+	/* Update dpll_mode_refsel register */
+	rc = zl3073x_write_dpll_mode_refsel(zldev, zldpll->id, mode_refsel);
+	if (rc)
+		return rc;
+
+	/* Store new mode and forced reference */
+	zldpll->refsel_mode = mode;
+	zldpll->forced_ref = ref;
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 {
@@ -396,6 +458,48 @@ zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	return 0;
 }
 
+static int
+zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 enum dpll_pin_state state,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 new_ref;
+	int rc;
+
+	switch (zldpll->refsel_mode) {
+	case DPLL_MODE_REFSEL_MODE_REFLOCK:
+	case DPLL_MODE_REFSEL_MODE_FREERUN:
+	case DPLL_MODE_REFSEL_MODE_HOLDOVER:
+		if (state == DPLL_PIN_STATE_CONNECTED) {
+			/* Choose the pin as new selected reference */
+			new_ref = zl3073x_dpll_pin_index_get(pin);
+		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			/* No reference */
+			new_ref = ZL3073X_REF_NONE;
+		} else {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Invalid pin state for manual mode");
+			return -EINVAL;
+		}
+
+		rc = zl3073x_dpll_selected_ref_set(zldpll, new_ref);
+		break;
+	default:
+		/* In other modes we cannot change input reference */
+		NL_SET_ERR_MSG(extack,
+			       "Pin state cannot be changed in current mode");
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -472,6 +576,7 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
+	.state_on_dpll_set = zl3073x_dpll_input_pin_state_on_dpll_set,
 };
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
@@ -627,11 +732,14 @@ zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
 	if (!pin_info)
 		return ERR_PTR(-ENOMEM);
 
-	/* Set default pin type */
-	if (zl3073x_dpll_is_input_pin(pin))
+	/* Set default pin type and capabilities */
+	if (zl3073x_dpll_is_input_pin(pin)) {
 		pin_info->props.type = DPLL_PIN_TYPE_EXT;
-	else
+		pin_info->props.capabilities =
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	} else {
 		pin_info->props.type = DPLL_PIN_TYPE_GNSS;
+	}
 
 	pin_info->props.phase_range.min = S32_MIN;
 	pin_info->props.phase_range.max = S32_MAX;
-- 
2.48.1

