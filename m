Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891A204C3B
	for <linux-hardening@vger.kernel.org>; Fri, 25 Apr 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601018; cv=none; b=OX5eD1FYVDl309/cqma9FOGOl6hhN788aiKcE9NKAIB5qymerOIjMas9biuLbK4f+8/GLCEvJnicP98Ec1H0SZ85qEkKSQNRwhSXIRAoJdI4VB3JJIUZzZLPmf4A3aTyb4/wSLwYttYT/2V+WNfe/TlJiblNl+uYLpb46Wpeqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601018; c=relaxed/simple;
	bh=3iRdy5RSCEOsFq3bOZt6j1u20L2fxEKxd1GG2SMkA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNcHc2bBLWcHMOpwIdPK5q0wTCNS+Zw1Zz2FEnXPA/HWs4xj8wnYsKzHgu/UFNavI6uMx3fO9tz4NSA5KOO9JOWoUtGLNjWk25MZqqpfwP5+ow+2+iTxhxkXgWaH/6M1GOjgnW8PMSshZM6PjUxnA3PwAu69IPi7nf67cZ2jcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+a9SRob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+a9SRob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745601016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBE8uQbOs83wpyFuUKZrZf6HpLYJDUmUA4UU+MMtgoA=;
	b=N+a9SRob+CRcQFWa/4t7hg+b2KPhxr7LPibcSiifLhIbs8HrW9t9qqBBiNnKJTcGkMuazf
	mBLqwsl58CSD9iyf4eClD07DPxCovI0tV7oPEjeSHbstAM+Sh1iVbnOP0f1vetyRXBesDl
	bvF8JxAR3Ha4gP3Kca/z65THGM56YdE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-YMK6sSAgMp6O8VQnP8gleg-1; Fri,
 25 Apr 2025 13:10:11 -0400
X-MC-Unique: YMK6sSAgMp6O8VQnP8gleg-1
X-Mimecast-MFC-AGG-ID: YMK6sSAgMp6O8VQnP8gleg_1745601009
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4F341800ECB;
	Fri, 25 Apr 2025 17:10:08 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D9EC1800378;
	Fri, 25 Apr 2025 17:10:03 +0000 (UTC)
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
Subject: [PATCH net-next v5 5/8] mfd: zl3073x: Protect operations requiring multiple register accesses
Date: Fri, 25 Apr 2025 19:09:32 +0200
Message-ID: <20250425170935.740102-6-ivecera@redhat.com>
In-Reply-To: <20250425170935.740102-1-ivecera@redhat.com>
References: <20250425170935.740102-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Registers located on page 10 and above are called mailbox-type
registers. Each page represents a mailbox and is used to read from
and write to configuration of a specific object (DPLL, output,
reference or synth).

Each mailbox page contains a mask register, which selects an index of
the target object to interact with and a semaphore register, which
indicates the requested operation.

The remaining registers within the page are latch registers, which are
populated by the firmware during read operations or by the driver prior
to write operations.

Operations with these registers requires multiple register reads, writes
and polls and all of them need to be done atomically.

So add multiop_lock mutex to protect such operations and check the mutex
is held by the caller when it's accessing registers from page 10 and
above.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v4->v5:
* dropped mailbox API and replaced by an ability to protect multi-op
  accesses
v3->v4:
* completely reworked mailbox access
v1->v3:
* dropped ZL3073X_MB_OP macro usage
---
 drivers/mfd/zl3073x-core.c  | 14 ++++++++++++++
 include/linux/mfd/zl3073x.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 8c02ecc58e3f5..8fd0105564e4e 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -121,6 +121,12 @@ static const struct regmap_config zl3073x_regmap_config = {
 static bool
 zl3073x_check_reg(struct zl3073x_dev *zldev, unsigned int reg, size_t size)
 {
+	/* Check that multiop lock is held when accessing registers
+	 * from page 10 and above.
+	 */
+	if (ZL_REG_PAGE(reg) >= 10)
+		lockdep_assert_held(&zldev->multiop_lock);
+
 	/* Check the index is in valid range for indexed register */
 	if (ZL_REG_OFFSET(reg) > ZL_REG_MAX_OFFSET(reg)) {
 		dev_err(zldev->dev, "Index out of range for reg 0x%04lx\n",
@@ -554,6 +560,14 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Initialize mutex for operations where multiple reads, writes
+	 * and/or polls are required to be done atomically.
+	 */
+	rc = devm_mutex_init(zldev->dev, &zldev->multiop_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 8df10b82e3c21..a42a275577c49 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_MFD_ZL3073X_H
 #define __LINUX_MFD_ZL3073X_H
 
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 struct device;
@@ -12,10 +13,12 @@ struct regmap;
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
+ * @multiop_lock: to serialize multiple register operations
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
+	struct mutex		multiop_lock;
 };
 
 /**********************
-- 
2.49.0

