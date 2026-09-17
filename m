Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07B4F405E;
	Thu, 17 Sep 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679627; cv=none; b=Av4hq4gJj9sHCGpNhKJemr2vlVEtVLKK/uHnU9SW599jiW8c6Qd/9L/v3EO5y/w3qTcorYy0OkNk1tnVfe4uUCN1g/xsKucL3fzTWwULjI7WHrDRNi1xMN+Zw1cam9NcGdCZibkqE+wJOtc8kcMl+iJuotpoah3Hnfl2nGDDvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679627; c=relaxed/simple;
	bh=2W9J/d2AsHparWJK+aNjrlKPTYSPzzfnztjEHukMPaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a+vFWC1+oBGKbYDNbSXYTw6D6bJjNAnpP5EiIasW8ZaR7Pkm3Il/uk6O16cXhW8cwrXCOSYj4hS6Zcgk/e1+WCP52KcW23BzsHsgyXT2Y6YCZT4PLjTnKSAx5u/onjr08H9Ay57UZik1+Y/cOSHgOk+3rYZsUn7TuCUcQHDod8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKtBz2Xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKtBz2Xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA51F000FF;
	Thu, 17 Sep 2026 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679626;
	bh=v4ALv4PlUkkEzw8n/20WsOuPBd75uA1YbabHxHjcL1k=;
	h=From:To:Cc:Subject:Date;
	b=nKtBz2XwUR4kkvAOpRK51OeI2Vqak5cDuxLjb4y1t/5LokQAyFcXRRhirId6zMdeR
	 Fpc6hX7la/BPYfFxd4SaRUD50d8rxEUza3grU5WXb+A1Bbxpelm2pyIPiuMonfZDtM
	 Z5AyBMpTkmFSrLC9dy+VP5TsZxzxV3Wqhn4VDttL15N7u+3KKugCLICUKd8pKd+Tu5
	 27qs4dud3pTo/QMsTiHEKrKYkL3qgKawQxuUPzgmeHgGDyBb9XQJIb3zvbZO6lFte9
	 c4sYe1TCnzWsl/0oFWtFSDhFg+CLaCJ6di1KIvIb4VopVnvqzix59MnC9m8dkVSY63
	 bqNqGqkb66KGg==
From: Kees Cook <kees@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Guenter Roeck <linux@roeck-us.net>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hwmon: scmi: Fix info[] allocation type
Date: Thu, 17 Sep 2026 14:13:45 -0700
Message-Id: <20260917211344.i.911-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=kees@kernel.org; h=from:subject:message-id; bh=rFYSh2hqNBw2ENmrdsxu+Uyvi5RqE7u5dNsIMBJsNcQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIjh2i7cvmKH4o+iA+daEQx5+e68J5PHs/i9z5ynnd 76jJ53FOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACaS6sbIsEVq0ZzC3NWN0WFH HJtePwt3X7XiCFPCKpPgZzNYZzKxFDD8FYiZfadF9kWJ1NWlKVKxxXvvy913qNvT5GEslXN97Y0 mVgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type of "scmi_sensors->info[type]" is
"const struct scmi_sensor_info **", but the converted allocation type
would be "const struct scmi_sensor_info ***", as the size was taken from
"*scmi_sensors->info", which is one level of indirection too many.
Luckily both element types are pointers of the same size. Take the size
from the element type of the assignment target.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/hwmon/scmi-hwmon.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: <arm-scmi@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-hwmon@vger.kernel.org>
---
 drivers/hwmon/scmi-hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index eec223d174c0..9ae8f774297e 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -305,7 +305,8 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 
 		scmi_sensors->info[type] =
 			devm_kcalloc(dev, nr_count[type],
-				     sizeof(*scmi_sensors->info), GFP_KERNEL);
+				     sizeof(*scmi_sensors->info[type]),
+				     GFP_KERNEL);
 		if (!scmi_sensors->info[type])
 			return -ENOMEM;
 	}
-- 
2.34.1

