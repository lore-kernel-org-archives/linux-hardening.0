Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744021ABCD
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047205; cv=none; b=qzHuLJOV9OvOq0ZuGmEsVJJgmf5VfyjAiT9QwkIB8z/9uBKd6EjmJNaJVl54w5179nwT1061ySS1J5wQ7oT73wAqpdWychor+ETmwq69DdWtii0ExYCJUsaANMpOfHN/rkipFUxC16fDtCCi+Mq0cEkYVrQLxkpuZdwzQ/VUNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047205; c=relaxed/simple;
	bh=S64LLOv+phJ1sh/gyAltMslCWxzcy05FWJrzVexjXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA1llYTHpb3wawj/mNGLDZ00uDXciz1PzYVV4jbMqtI+UBdk4rrsY5I9BAc8mcGSxeU0nLO2PAXNcG46CkUpxTY1OIdPdFN/KW7e/6Ceqkdn/3gXj4C+nYJheplcxC4WN0hAAzrQiXYOnPA9tzDxCka+mun21+NW3BY1DFR7qH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld+y4Fng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld+y4Fng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+TOrZM8LS94zLOtYPy81UhS5jAQZ3/ApDxkhaAypKk=;
	b=Ld+y4Fngoef+VD+LgGbuHiEZ/AoAKB7DkPBEOgvUPxV90d4q1IB7P01BU6hq709nH+dgEV
	PLf8MFIOe7aQoKj0Wpmw3k+O0SVgYij8ABZ2dZq2srJsLmq3S58Cf79cKLbaIz+LW+PMq+
	JCI/CmKa/uHZds/b/oM/21lD+2wTTSg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-UFZfRjg1PfmRfueFwup7Ig-1; Mon,
 07 Apr 2025 13:33:17 -0400
X-MC-Unique: UFZfRjg1PfmRfueFwup7Ig-1
X-Mimecast-MFC-AGG-ID: UFZfRjg1PfmRfueFwup7Ig_1744047195
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 369561956080;
	Mon,  7 Apr 2025 17:33:15 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC8051828AA7;
	Mon,  7 Apr 2025 17:33:09 +0000 (UTC)
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
Subject: [PATCH 21/28] dpll: zl3073x: Implement input pin state setting in automatic mode
Date: Mon,  7 Apr 2025 19:32:54 +0200
Message-ID: <20250407173301.1010462-2-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This implements input pin state setting when the DPLL is running in
automatic mode. Unlike manual mode, the DPLL mode switching is not used
here and the implementation uses special priority value (15) to make
the given pin non-selectable.
When the user sets state of the pin as disconnected the driver
internally sets its priority in HW to 15 that prevents the DPLL to
choose this input pin. Conversely, if the pin status is set to
selectable, the driver sets the pin priority in HW to the original saved
value.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index 072a33ec12399..192e0e56fcdde 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -528,6 +528,37 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 
 		rc = zl3073x_dpll_selected_ref_set(zldpll, new_ref);
 		break;
+
+	case DPLL_MODE_REFSEL_MODE_AUTO:
+		if (state == DPLL_PIN_STATE_SELECTABLE) {
+			if (pin->selectable)
+				return 0; /* Pin is already selectable */
+
+			/* Restore pin priority in HW */
+			rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
+			if (rc)
+				return rc;
+
+			/* Mark pin as selectable */
+			pin->selectable = true;
+		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			if (!pin->selectable)
+				return 0; /* Pin is already disconnected */
+
+			/* Set pin priority to none in HW */
+			rc = zl3073x_dpll_ref_prio_set(pin, DPLL_REF_PRIO_NONE);
+			if (rc)
+				return rc;
+
+			/* Mark pin as non-selectable */
+			pin->selectable = false;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid pin state for automatic mode");
+			return -EINVAL;
+		}
+		break;
+
 	default:
 		/* In other modes we cannot change input reference */
 		NL_SET_ERR_MSG(extack,
-- 
2.48.1

