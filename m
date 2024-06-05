Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8615E567;
	Wed,  5 Jun 2024 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624194; cv=none; b=SQMaAZjVpCQjsgFzgZFt7I6xJRSc+8lcSRzH5qGjhxFU0P7FQ+lMfcU1BWkumTtMINCQrVtgwb1+H+HAd1sLoo3ndjooe6RuJmS//+AKTxEE8SFG1cLAVrgdy4kKcj7cA4NpS5KKc9xRPM/dyNU/74Qt8oycREJcXa2vPV0r+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624194; c=relaxed/simple;
	bh=zP4xiCVTeFjDQ2g8+oWzfck6hLqdQuFRlgxNThaxc9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/VfjTTKtQrBMllhEhVjrdu4aHgVWCTD568DwFA+/EzGeqk2TTjo1SqECkdXhQguzeuC8vl6CQ0Oy3RuP7miCSMIV1uRP831+xptFqf+eXA07jfWN3pvQ4I8kUZbESq7av40ut+BWs/PcN4TldW0LPpiBV9q5LS0JRWmkQOBEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeBImASB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeBImASB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6342c5faaso3027645ad.2;
        Wed, 05 Jun 2024 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717624192; x=1718228992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mra14dtkVef2CjOKhqBiFqoZuy1AZRPuVONw1kE8dTA=;
        b=MeBImASByN9z3tLI5ZzanTIcST2dTz7F4rRyyU6COYerVe4/LWVc+qUB3XGmJTuXdd
         0wxzN4wljy+G6nIsA4CI4sGMTSyLoURnJFZ3vGYKXB/iw55BE6vXUZzgWgTU0d9JunUF
         Z6acO7T3I1WTTPVDhR/0GiKrnbuDhYKieOPPpiW4n+Bttx2LLuGekMiwt4VNJGSuxvjk
         PXUHXeaCooyTgimv0BtYuEFd63CR1KxdC5nSaB7+54RyhiC9NCsuSfvw6QdtGPyEy6+X
         8MuCoQU3H7n+ZDMFc4m5nAR5EXfx6yHHQzk59EZhDZmdmNNDehqmda3kmy7+9DAwV8J5
         zY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717624192; x=1718228992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mra14dtkVef2CjOKhqBiFqoZuy1AZRPuVONw1kE8dTA=;
        b=qpryGGdq6EONTzJW6+JEyLIE0EExuZ/dvGXq3CVHnwJDVuvRHZiRLQ/otGtKf3m4aX
         UDf8Pomk7xo4+9k6H0QxSybE7QGGZUM4OFzjS3g1Udc94uYhRzCQtdEC1PW/6KIoGU9J
         NgjgESUXiYCiRnb6tGJWOEnRxsYkUf4EnGu1u9vGp2dgV/fkYTQMgULqTW+mk8djiIO8
         s3ZUDS5WEx5Aa0+LuWo9qNGUnRMw0wfhD0HDClvlFbNtQDtLmKDTtVBw5p+tdnRYjNKT
         13zrrsbAAJLEMl4p/C6m0tWW7s5JBOm5Wl0d4YnEnemqRyxysOhi8c3/ibrM+GnxCfZC
         GHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCeMgkKlc+O7tQWnDW6yi773S41CJdL21LliX5aGCgHhvUZdD/AFxHBjlNMm+QHAohQPolJDNRfSJdz3qqiIkVqkEvo6yPcsLJrJWWRsde0bUNvTNK0n8tRxfz+THqFM+DPaqVkf+YtssCV2I6
X-Gm-Message-State: AOJu0YzDbyZFFc8xCy0L7Gd8HeoXSoO5R0H5mr1i32Acl0RRkR4RbjzY
	17blqHuznYJV1OFb1xNKmMLpXiDz2dqkk2nnG54QelxvuwGvAedY
X-Google-Smtp-Source: AGHT+IF8zcApnyKMWBgo8KAhBV9dN87m8EgulrWk7ipu2gzPithGAqspUyJGunWKYTmRcpe9XoWn4A==
X-Received: by 2002:a17:902:d4cd:b0:1f4:620b:6a27 with SMTP id d9443c01a7336-1f6a5a02a74mr43804285ad.13.1717624191768;
        Wed, 05 Jun 2024 14:49:51 -0700 (PDT)
Received: from dev0.. ([49.43.162.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75effasm228855ad.29.2024.06.05.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:49:51 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH v2] pstore/ram: Replace of_node_put with __free() for automatic cleanup
Date: Wed,  5 Jun 2024 21:49:44 +0000
Message-Id: <20240605214944.22113-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __free(device_node) to the parent_node struct declaration
Add changes to incorporate the review comments from v1

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

PATCH v1 link:
https://lore.kernel.org/all/20240415161409.8375-1-jain.abhinav177@gmail.com/

Changes since v1:
 - Moved the variable definition back to the top of the function body
---
 fs/pstore/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 14f2f4864e48..f8258e4567c3 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -644,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 			    struct ramoops_platform_data *pdata)
 {
 	struct device_node *of_node = pdev->dev.of_node;
+	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -703,7 +704,6 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	 * we're not a child of "reserved-memory" and mimicking the
 	 * expected behavior.
 	 */
-	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
 	if (!of_node_name_eq(parent_node, "reserved-memory") &&
 	    !pdata->console_size && !pdata->ftrace_size &&
 	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
-- 
2.34.1

