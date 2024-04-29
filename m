Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9191411EF
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423835; cv=none; b=L0SqhMuk7N9DDVVyTydD2cJrnJzKwNp+IMmT9ZC4QftNFe7OIueYvEPsW8SthERh9efb3mUALRc0+NKnZwjvzd4gwHCeBmTpavszPkSOah58EtR6b9TOKBOTT/TRHejH23Yf9HM1iikEgNR0zAbe9nqD5q2ewrmTM1avxzXzqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423835; c=relaxed/simple;
	bh=E51RN5MCBslyxtFShtUwThE7vElft68Pwp0ik5uTa94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uP2IIy7JSK4mawf6wp2VCRcyQzJ1g/dvnlLMOj+X8+Aop8cISnjeszwL265D3YkAMykaGOrmCI3VY1fPhn/XQF/xnH+VoiQAUSBbAKC9Q//eJP99Lk4/Fz6qzBYNTdN1mMFY5Cr5owUG4Cv3mXJn2OedCMFc5HFmqVLi35B1+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQlsfeP3; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQlsfeP3"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7dec58efbfaso230487839f.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714423833; x=1715028633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p+KWfUI7WWjJz2aEzllZVt1Sw+QNmzAz/2DNTRseciU=;
        b=iQlsfeP3PNVldcJa9zzyk5dcdlNcSO4Hs6D8TTNB2xJ2WCMdN/zxTziC/KLYbw/0AC
         vs7ddWBnIMzgwG9JKcXCibZLcjD+KeeF9e3V9MVkW/B94ARTVhELXNsUHSlN/LW68vvY
         qf/Mfrshqq/heqZ3ZLXSvWMnvjoi6U3Vv7wsU6cWgwBHf7MZze+qA9r396FOiuXRj1sL
         2F3S/qqPvmPk7VYncU0baxJoOnFS4i9B2/VRdORqZ2AjZgJUG9+HNQVVyVmQDWUtpqN1
         6uG3iZ6VwVKDhT87CyuuPGxceZiZKd6+kDKLHgAj1MxZ7iFfJcH5CG+dstD/gy4kp7lv
         LNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423833; x=1715028633;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+KWfUI7WWjJz2aEzllZVt1Sw+QNmzAz/2DNTRseciU=;
        b=XDjudMnfXUUZhNSHKX/FI8Hith1iyEHzb+KjVCdb0jgNsvcD05oz1/Szymkv+iHeVW
         NDS246GMZTF0NGswBdRIvMxyS2tFMZF/3gp5CS2rkg+WC5Cv4GFuj0n60wvVPqX4LJxr
         RGnw2Q3XiwHMWrLyFHBuCG0GkFAHCbRjBgDQVmpApjUmzeC+yNuABSIF/r5mc+YtK8y3
         E3RI5ufTnol5AcQRbU/CHTVwMpu3o81LuYPae1+2rCiX99xxDIxashbu97H/AFLhhajb
         LgJ2z2EfJhdVOHWoqlavXUFmdXZ+g7JcuXj6JuXryOiosPAKCSwmsua3CSOyeCl+Zvqg
         RAxg==
X-Forwarded-Encrypted: i=1; AJvYcCUn/v/CMijGJCoHUr23jUfOgSPdLlBAkUXCtXpIrkrzdtznckvHmNp2GbLercntLaq75aofzlwSz2Tas2NNm8lyIWWvk84EUINC28TMYniV
X-Gm-Message-State: AOJu0YyYJN+A6FRMSz64ConfuqQNFK8beSoTfcJJyQka8CFqaBgD9g9/
	1MmsCR3JYYlCGWpg1kMKop1pW9+ThswN419DRntePHfnKQQO0pxfPqfE4BD6yDdnBsFlGrbGFay
	PuUfVHrfqd72xqhPiMANJxA==
X-Google-Smtp-Source: AGHT+IFmrEC39GW//zFmGOIhRKDWCLIzg+5DId6LIi/jSAtahHuWsAG/CndMnYRnHSw3kt3DwU65bT4uzvQA4TMr2A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6e02:f13:b0:36c:4405:68af with
 SMTP id x19-20020a056e020f1300b0036c440568afmr265464ilj.6.1714423832942; Mon,
 29 Apr 2024 13:50:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:50:30 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABUIMGYC/x3Nyw6CMBBG4Vchs2YSqJXbqxAXWH9lIinNtFEI4
 d1tXH6bcw6KUEGkoThI8ZEoq8+oy4LcPPkXWB7ZZCpjK1sbjkm9Czu/oR4Lh/UL5VnumVMCO27 bvrs2fWPtxVHOBMVTtv9ivJ3nD+WqHI9yAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714423831; l=1762;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=E51RN5MCBslyxtFShtUwThE7vElft68Pwp0ik5uTa94=; b=KRsbfMxM48ZQuhpUdtIv3IR8y1K3aT/WjQXifMOc/OUMsw4zO+bfvDG1CgeQ8ial9UKusJEFS
 EIocTm4zPwKBfi9QfaKdU3X/YObu5KAKXEKmxSx6ktLmw/kSeaBYng3
X-Mailer: b4 0.12.3
Message-ID: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
Subject: [PATCH] PM: hibernate: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This kernel config option is simply assigned with the resume_file
buffer. It should be NUL-terminated but not necessarily NUL-padded as
per its further usage with other string apis:
|	static int __init find_resume_device(void)
|	{
|		if (!strlen(resume_file))
|			return -ENOENT;
|
|		pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);

Use strscpy [2] as it guarantees NUL-termination on the destination
buffer. Specifically, use the new 2-argument version of strscpy()
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 43b1a82e800c..0a213f69a9e4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1361,7 +1361,7 @@ static int __init resume_setup(char *str)
 	if (noresume)
 		return 1;
 
-	strncpy(resume_file, str, 255);
+	strscpy(resume_file, str);
 	return 1;
 }
 

---
base-commit: d7ad0581567927c433918bb5f06f3d29f89807d3
change-id: 20240412-strncpy-kernel-power-hibernate-c-77985696443c

Best regards,
--
Justin Stitt <justinstitt@google.com>

