Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80828D8F5
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348271; cv=none; b=lW5BgxsGhlnQCpO9IRno9zNuFuF65osb5JILOcERLEhq95gBXwRiVBmOF/QISqxuXZ3Y8rKBZ0zhkUrj5rH8TB1lQV0bH9fSzPAuUYr3iAUGwR0BmmNHW8YxWb+ooVwISHegNElH0mHXcTeTWl4zDihfPwDqWzbc7q0TsrfGUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348271; c=relaxed/simple;
	bh=ufpE0uS3u78wr/reXtvKH4Y/KlkziLMDeXTbX3Awtnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiQVVH/QFb8sYP2COp+fSYYVd2P/QazzMXFZ9gCrM0WsPb9UCN63lCOIQeQL/cshygBsFUzkJPGMlMC6+vYTMYWsJ/wqGGe9ZCosYW8woXWTVLYGBDKkHWGujW9W/FiflnOO67d/8RDMP5pcfCkQ1teBzU1dsnYJIMT6aNJF+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XryPduni; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XryPduni"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234c5b57557so31278915ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348269; x=1752953069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFWf4pajwuCq0yrKvf8AqqJc8kjEky1o95n0xVg9Pf8=;
        b=XryPduni/61+VmfrZ5Ln6yD/xBrw48BAEPYBUg9KlLk0ntbli/N60aWthRLOXKxi8D
         rUDHOZ5wdAlL8if9k4B9y4MgTnxVYVaLT306btXJ7hkoaM8wrjbaF+SG0CuT/EisLCYl
         qhD5anNZJcTfFjlINNykqm2KcyPsQeE2N3ztB0w/olg+EqgDZBuP9Y9SAfo8XnPNkWqE
         oM8Xk6yvnIlPgnfcEqzRAgwVS7GJ+9k85b7NsApkvPqEPzB1sT4dWHsVQSw/JLv5eZJs
         Fdvpc7TuHphKVxwIg19kDzBraZ6Ga7YaYQRXt3ZDx3+6WnS5Dy5rU6fpfP44nw+kjdn5
         xVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348269; x=1752953069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFWf4pajwuCq0yrKvf8AqqJc8kjEky1o95n0xVg9Pf8=;
        b=QCO9y6ejWoAexmp++x0oqw39N/BejujCLS+wpKwvkw6l0RkYef/RpRtUrUwT5dCCLw
         G1i5DHH/I82arTdrEqgmeUNXoSEVnWibep0+zs08f4Oufp6In59st7Fz0rjs3/0DEMxs
         dgdWIVMAcM2PbVWzeEyVYBFKqFgFFkUXiXSvuIcpk7HYZrU40bMMNKltlQW0DIHBp6DK
         r6KjP5ishwFsXww8r27U/KI2FFtX4h1W0KWpy+LMVkfE7KFfDLoTT77BSBjje2ghaAIS
         qB8Vx5cTf88gmNDTrCxG6P9oLo4SKBPJcZd3mU9UjDmnuFJlNFWWiGrHR2P4dJaLeidX
         0Wdw==
X-Gm-Message-State: AOJu0Yzx67xT2y7Z2HHuSs4kRiuHbUraitns2kOBAEev3jT7ljxSH2G2
	S9uvmTYx3UmXT1V1g3QZIFLeQcv7dMZbvHpiLPTeV2Gcs3rOQDqul/rC66vQbX2F
X-Gm-Gg: ASbGncsWArdW3N6VptyQElOCkynDBVJF3uCJudsVNm7AVY04Xf/If/hJIWOkEaZH/RP
	V/ZIQ+yMmKtAdsMj5jtwINDtYyuMcqjHu4paiXmlP6MYe5Nr7Xrkn48ab9CYFyxSsFNpPZc58FL
	WF2PfgN467r7xvFevQNIBHcpGCQUzC5iWR3GQUga4d8hnLvidJCN7vqUEynLDEoGUuXXwsVW2Eg
	EyRWbeMXxqEYPSjbPr3Xv00f7NtssqXuMdDrAArTc1RhxVlmQ6xF+/7CRlMhmRmBIVCQGsikok4
	fb9L1UTnMWzv/BpKXbvPJMyKnH3vegKkOYKUbi3JaGHUqmrAGcd2hLqwtkV/JzpADA9CvHbhz59
	mRMtOxiKZK/2q0fIB4gSxIWeD4lCCWo67iklToFN7gseF
X-Google-Smtp-Source: AGHT+IEtMd0QN6r2Kc2AYcdVN5SDeiX/Gxq2q8D8V7/TSzRchF3Jnp2BKgi4CL7e9g7Kw2LCx2xIfw==
X-Received: by 2002:a17:903:950:b0:237:ed8e:51d4 with SMTP id d9443c01a7336-23dee0b4b5fmr136182395ad.24.1752348268544;
        Sat, 12 Jul 2025 12:24:28 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:27 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 17/17] vfs: ioctl: add logging to ioctl_file_dedupe_range() for testing
Date: Sat, 12 Jul 2025 19:22:02 +0000
Message-Id: <20250712192202.707192-18-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This adds a message indicating a double-fetch bug trigger for testing
the SafeFetch patchset. It add the message right before the fix for
CVE-2016-6516 [1][2] introduced by Scott Bauer [3]. Which can be tested
by first compiling the double-fetch program from [4], and running a shell
script similar to the one provided by the SafeFetch paper authors in their
artifacts repository (see: run_security_artifact.sh) [5].

In summary, you can compile the sample from [4], then clear dmesg, run
the sample with `./a.out 7 65534 1000000 0`. Then remove both files used
in the sample /tmp/test.txt and /tmp/test2.txt. Now count the bug
warning messages in dmesg before clearing dmesg again. Then enable
safefetch with `./safefetch_control.sh -hooks` followed by
`./safefetch_control.sh -adaptive 4096 4096 0` or
`./safefetch_control.sh -rbtree 4096 4096 0` where safefetch_control.sh
can be found in [5]. Now run the compiled sample again and count the bug
warning messages in dmesg.

This was my method of testing the patchset as I forward ported it from
v5.11 after fixing any merge conflicts or compiler errors.

[1] https://nvd.nist.gov/vuln/detail/CVE-2016-6516
[2] https://www.openwall.com/lists/oss-security/2016/07/31/6
[3] 10eec60ce79187686e052092e5383c99b4420a20
[4] https://github.com/wpengfei/CVE-2016-6516-exploit/tree/master/Scott%20Bauer
[5] https://github.com/vusec/safefetch-ae/
---
 fs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 69107a245b4c..db8df94d4caa 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -439,6 +439,12 @@ static int ioctl_file_dedupe_range(struct file *file,
 		goto out;
 	}
 
+	// Add an extra check before the bug fix to check whether a double-fetch occurred
+	// With SafeFetch enabled this check will never get triggered because we correct
+	// the second fetch from the cache.
+	if (same->dest_count != count)
+		pr_warn("[Bug-Warning] Bug triggered\n");
+
 	same->dest_count = count;
 	ret = vfs_dedupe_file_range(file, same);
 	if (ret)
-- 
2.25.1

