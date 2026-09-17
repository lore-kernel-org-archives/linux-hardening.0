Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A34F393C;
	Thu, 17 Sep 2026 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679615; cv=none; b=KkDwOLrelzikp36aPHtAqlhxe/sPxWFGJNacRc39GgPMirJrCqDzU7mTy6ocyUGw8EYLiIZtTgZ+DIJeBcREo0iUcDBnOg4M0QBADCL3mDuV6tFQ64TNDFLf/V+GWQVLhwYdtIID7cFWbsFtBHLP7SyTSzqKfdbz/EyN3/D/q7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679615; c=relaxed/simple;
	bh=kGVdJvoxUqY161AWw5rv7MApOBp2g1zfoUmphBeETxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DPTmZos2LhuUEXyOkJnCXKSfvkrbFZFMip4Pp5W1CfDPk7hOmLalWcRv/bBHnpYMnc9yMQvLxohS3zbdjo9Ts3k8Bm9ObZj3cRMzXfXPUlzTJt7cFv8E7tq5Wv3EP5L0gq5RrC5u8WSvA2Qr6KDinQrwXXHdCQC3m1guwOtDEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoBz9QjM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoBz9QjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BDD1F000FF;
	Thu, 17 Sep 2026 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679614;
	bh=kF7pWfsNzscDhCQmWCGtRrGt0EXytORuUEtbPZ5JJbc=;
	h=From:To:Cc:Subject:Date;
	b=OoBz9QjMxCv/h94jF5EMNghAmGoZ8PP3UCK7x+JAUKxXnGwuMtYKI+/KGSzIjJA/n
	 NQBqJQevocU41Vx1YYO5cvNPJ28xgRoomt78Me+rYwcVrEIAOXqSXEhoojVEBBeYny
	 xCxc+EXHabPy+K/XsvX5JMQQmv9pRgfzXDNBmO3ZzEXKh06FnD5Hdgi2U+0z1zyru0
	 C3QVgKyjZM8Ehkn+94xHzIM8CrcZUiYoXve36Wldc7qpUOe72QJwKCSyeVXhQ8xnKE
	 J8GWOK/r5BRdL4JpE+9y8BjW3BvAcKtQez7AiejD/R0shHOTaR2vaXpVvX+mjfw6Jb
	 +UjrWfjN5HY7A==
From: Kees Cook <kees@kernel.org>
To: Ed Brindley <kernel@maidavale.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Denis Pauk <pauk.denis@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hwmon: asus_wmi_sensors: Fix info[] allocation type
Date: Thu, 17 Sep 2026 14:13:33 -0700
Message-Id: <20260917211332.i.711-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=kees@kernel.org; h=from:subject:message-id; bh=18GCQhkkQo5tyjqZXkwL1mgT1HN111jiRWL1i7Isy94=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwv9eFupMkF+T2hzru3z//YkzjuytV2S9W5+5bu+it 3yJq3P2d5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEyE4z3D/6wpp5245KOCHx1c W8h+3y7wd77GAY99pxYL93LVeZYZbmH4n2Md5r2HcULuke+KR4qO2lxa9vXJ7l3Sk2yTLRQaN8V LMQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type of "sensor_data->wmi.info[type]" is
"const struct asus_wmi_sensor_info **", but the converted allocation
type would be "const struct asus_wmi_sensor_info ***", as the size was
taken from "*sensor_data->wmi.info", which is one level of indirection
too many. Luckily both element types are pointers of the same size. Take
the size from the element type of the assignment target.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/hwmon/asus_wmi_sensors.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Ed Brindley <kernel@maidavale.org>
Cc: Denis Pauk <pauk.denis@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: <linux-hwmon@vger.kernel.org>
---
 drivers/hwmon/asus_wmi_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index c2dd7ff882f2..621e3506972d 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -573,7 +573,7 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
 
 		sensor_data->wmi.info[type] = devm_kcalloc(dev,
 							   nr_count[type],
-							   sizeof(*sensor_data->wmi.info),
+							   sizeof(*sensor_data->wmi.info[type]),
 							   GFP_KERNEL);
 		if (!sensor_data->wmi.info[type])
 			return -ENOMEM;
-- 
2.34.1

