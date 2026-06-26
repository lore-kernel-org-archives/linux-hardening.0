Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F722F8EBC
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463428; cv=none; b=ik1XzW8s40vl4tGceOurLeJVr+1LGQS/qW4Vec/5TxFFpB1kHn1KRLRwBkqqlNu4wEIT5nQar450KXnPViVCT2fe4iF/a+TA+5J1JgnMlqtMDy8buXxkOfs9no/DAe5codEuiUsP6UHEEOf0pSOjtsqDFoFSQn8MYvrmkhDXyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463428; c=relaxed/simple;
	bh=gi6cjj4yVrM928zwD15uDmvPXd6Clwc+js6B3393dJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnXx7mu/0IJCpsrQYhUZfqxxbfsmkYs8JJvcS9WOmMqLV6+5bFN5OL0lugHU50KJgzoUTCjzX7pK09NnvxVqpaL74uLwhkyNVHuayVQSg/cHhjZ5/M6yhSAyj9NaMn3hcK8tzhBKFswckaPTGAYcuDJrnQNx87erMHFt1tb8PqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1nW048o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1nW048o"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so13243675e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782463425; x=1783068225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzRs5rqLLtXVGsPkhyCwyE08g4chaY0AjMl0jB56qQo=;
        b=H1nW048oTChxfiAu/iy1Xc0skWP75+a5K0NuycSqJ7BsXHX1kkbi1YPw0TnHUlN8OM
         1bwRnG7+rl395MsMc+okYKV+JxqayqrKIgptFS+WeFQvDRAz7E90GPLmL6FePxyeSj8L
         4y/F6CiUmwZx1ckkwTi+OBSwmzp+tnE9QXS/26cV5yWs3L8lIPy7BBdF32kRk65eOLAr
         I4ZW3uO8D19qP2NEmdNeLL0gIsf4HqydDbR003WIM+kLwMwtuGtccr5XhOLBdajWgnNL
         CZiG934ivNicAbe5OSTQ2VDiISH00exjK/I+Z9jQnfI2FdylfbZV12hnAuQKwxXR7Qr3
         AjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463425; x=1783068225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzRs5rqLLtXVGsPkhyCwyE08g4chaY0AjMl0jB56qQo=;
        b=OFtSj0061ysCgLaDJ1c5E+Bk7rZFmlA8h6GUxIDdyfcjn2WrMzqueY+sDJLqiELODf
         mlpBykPM9EcoKMOk4r3dlTWrmm8GShlsJhkGzJ99Wy4qV38hyA+YoqDnpj9rd0ipQ2c9
         rHTPj5VowYMVak0zkcAaDA/Trkl1vIROOk3U3PTF29RypDZPbdCNzY4JYQvZHI0/DTyl
         yNJKBYvgsZYnQHLb6QxQ5Ya3mlazruh1vzqhWeF+Z1n9LiOVF0dA7HZjkyKpp4ZPeWLR
         tr7DgyDM6hPw4U8iTQzBAM5rreKDuncpXSgujxa/bMUy4aAziE4JT/FRrLuvgQp4TUbq
         U2jw==
X-Forwarded-Encrypted: i=1; AFNElJ+1QntU39Gv8cpJ2jLzpTHZW5O/TXNDiRHyDO6VkA86OYzF+FLK3RwphKQZtrpzdHKB7CzI7CrWC8JAz/kdvww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3I/pUiRJeqQzDZCjLZQfGzjdKsYTYfUG9s0ovmfUznRM9x782
	vNOk4+NrFN/V8rSL+w8VsJaVlNEgsw51c90rPeKV3pLYZrjzgJUu0Pe7
X-Gm-Gg: AfdE7cmd2OPsGA9FB7gxU1qlw0J0tlrHCpFk9x1LQIsleS7RmwA4lve8C5PtMJs2a85
	cv+bCK392LQn9dJkgyHsNL4/ArWL7YhGQ6TyJwnut/G2py4WtrtgGA0aUfvXx6hpXo4oIQ7oKDJ
	3e9DVFqzLnmyS/ILnYYstZ2LxeVI2PD4aqmrNg5eC6zENck0ZGBTyVfVxMQ8ByIc1N4CTDOTMKN
	g9ctdgwFSaYMdMPXigIEoLLQWTbHkBrhxlbZJc+4T8EiheyzE1ZHmUxbKtUd5dWNYmzjGmQBim9
	OBoi/DyTYMw5Ue/lj20J5zqtxb/Pn2BLcc/5FQHhUD/Z/329V2BWdyiisKeXv7MWBje+MwyDyIu
	TNCVJ3iS1AZaZE4DIXr9tl3Dx470I+ux2eOte3dnwDJuDYHw4TOjALBsmt99jMhM8h3oTgqRr9G
	wuRatjbmhadeu3k1E+ggbvE+SEhwX0IbrZTdUD7rfecLWK+bD412I5bks79YCL2/o6OGiGew==
X-Received: by 2002:a05:600c:540f:b0:492:6f5c:fd8c with SMTP id 5b1f17b1804b1-4926f5d0214mr1724275e9.15.1782463424661;
        Fri, 26 Jun 2026 01:43:44 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c278ab2sm23257135e9.1.2026.06.26.01.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:43:44 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 next] drivers/md/md: Use bounded strings ops when setting disk->disk_name
Date: Fri, 26 Jun 2026 09:43:34 +0100
Message-Id: <20260626084334.3012-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() and sprintf() with snprintf() for safety.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v2: Make sizeof look like a function call for consistency.

This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8b568eee8743..4b659d10fa4d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6346,11 +6346,11 @@ struct mddev *md_alloc(dev_t dev, char *name)
 	disk->first_minor = unit << shift;
 	disk->minors = 1 << shift;
 	if (name)
-		strcpy(disk->disk_name, name);
+		strscpy(disk->disk_name, name);
 	else if (partitioned)
-		sprintf(disk->disk_name, "md_d%d", unit);
+		snprintf(disk->disk_name, sizeof(disk->disk_name), "md_d%d", unit);
 	else
-		sprintf(disk->disk_name, "md%d", unit);
+		snprintf(disk->disk_name, sizeof (disk->disk_name), "md%d", unit);
 	disk->fops = &md_fops;
 	disk->private_data = mddev;
 
-- 
2.39.5

