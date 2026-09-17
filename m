Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9A49EC6E;
	Thu, 17 Sep 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679672; cv=none; b=rXaXrt2+Ce1/WwlMm3n3j1pQxOVdXnQWdoOV11fK5QzrVKXqSYDjA8j0Dm5wD8bkb3trctFE+CWZ7lKKwIB0w0XxsABbt5uro7g8HNlTsCrz2W3DMq4lh/6HR7D15Ryka8hlZ0DPuLbKEAdj3CSR1KzNTKCkYrEVia053G4JJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679672; c=relaxed/simple;
	bh=2TxH4C1/ldY55xyQNjPTqxKkkfPopOU5SgJ9NAe3oTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iSt0EuEeWDdlARYUbGRoQm2atQFJrqPr2Tq6HwJk1nDGry7jJfwzli0vjDEJbf2arbyUSS54OBy5s+C2qKjdHBcfEYAmaeXG1ROyXmDPgEmRUAL8Sa+3qs7akQncxF7sVALSgoH4d/InotRTpTIMgPEjdCxp19pNzu9N1ow8GYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz4njpgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz4njpgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD83B1F000FF;
	Thu, 17 Sep 2026 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679670;
	bh=qoTLL+Y9jDbvbklS4smBLhLmCpbDdyoDpotOBwhiSEE=;
	h=From:To:Cc:Subject:Date;
	b=Uz4njpgXvyWV3DujjdkHYWfIyFct1dS8d0PQLGeiBdWccXTCJhGY2bYOrWWAITwsJ
	 shPPCbN6cCD/Ge8UM8iQNzvQPgDd2uWcZHZ+uBA/X3JdX1XxWJ1NQ+9SFCzkXl72Xk
	 n33CLWxghtgZbXnf1s2oM5e0EHWQq/ywNUxHniXs4ZyvG2vmhUTOwzMyoh6BR9sQgb
	 XcVAbW7W5o77FmyxcB4u2o7PgCHR23hLHlMEk2M5w4HRWzdNQL3R6RLULuEMLcqJGb
	 pXPUS7hymK4IJh0jx9T1Y9IpsIlBHqq9tlb2aLG9xmymVss4OtaeThr4mSbxF5oktl
	 9EFbmSjHm4CQQ==
From: Kees Cook <kees@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] coresight: cti: Add const to con_groups allocation type
Date: Thu, 17 Sep 2026 14:14:29 -0700
Message-Id: <20260917211428.i.947-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; i=kees@kernel.org; h=from:subject:message-id; bh=ZslHx5VqRft6I3xit3Pnoajg45iE4Y2S12l25+/PhA4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIkw/hRYIix5MaOzW1Y3SEfwRcn7Z09/sCmo7jr98v 26rTdbejlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlYJDIyHHO89X7OVpEZh09+ f98kc2m1/Ye9CQuS17dWz9oSfatqey7DP2PpvJk/VpQ88c7QKfj22W/K7hXb3WVeFP1YomZaWON 1lw8A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "const struct attribute_group **", but the
converted allocation type would be "struct attribute_group **", which is
the same type without the const qualifier. As there is no general way to
safely add const qualifiers, take the size from the assignment target
instead. No change in allocation size results.

Build tested ARCH=arm64 allmodconfig with GCC aarch64-linux-gnu 16.1.0:
drivers/hwtracing/coresight/coresight-cti-sysfs.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: <coresight@lists.linaro.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 3fe2c916d228..2ed5d8eb1dda 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -1132,7 +1132,7 @@ static int cti_create_cons_groups(struct device *dev, struct cti_device *ctidev)
 	/* nr groups = dynamic + static + NULL terminator */
 	nr_groups = ctidev->nr_trig_con + CORESIGHT_CTI_STATIC_GROUPS_MAX;
 	ctidev->con_groups = devm_kcalloc(dev, nr_groups,
-					  sizeof(struct attribute_group *),
+					  sizeof(*ctidev->con_groups),
 					  GFP_KERNEL);
 	if (!ctidev->con_groups)
 		return -ENOMEM;
-- 
2.34.1

