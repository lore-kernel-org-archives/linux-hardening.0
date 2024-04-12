Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575F14D6F5
	for <linux-hardening@vger.kernel.org>; Fri, 12 Apr 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948032; cv=none; b=lYznqS/bXe2vnLeDI3mp0TJIdECWAiZgYX2tyuCfK/e1s/8ual9Uu1LfLxEDpLdK+G2OLAtkFp+wZWLnhy9I8C0qAaRB3sKmf3AzwvbNoY/GretVG1OOjpG81NxjRq02GBrPjwptCT3gmDB6YKFJfDtejCEp8CCH6Xn0IC9wBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948032; c=relaxed/simple;
	bh=FHYmDrKaqpfpTRuPXl2DoFH5LA+zgDT0YDVnlDewaH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SyWzGblyhapzw03IkaftGlCeDBwPqB89h2+mcD9VsJfg71hCkgN6guJBt3hgHgJBQtrhJEMTKTTzgLPRDBS/VYu7tgWOYGDMxLPEgAyGPXnzRBXXn2jwOWpAI5Rh9rlWrwe1YpZZHtMhHSOvLjy0cRLd8Dc494Y3t8JeSafZ5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfD3ehD2; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfD3ehD2"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7d667dd202cso164061239f.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Apr 2024 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712948029; x=1713552829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ku+cYfV3CL9NDsoRJLchzk83CxUteslcXBw1rBPpBQ4=;
        b=cfD3ehD2hT973F+ZCY6H8bzsssillE4z3k/ST3LiDA+KsZEC93DvdH2nHabn4lwbM/
         gzzWmQ0FelTAd12EfQ2Q89/OOFcmp/D47J4s9Yxnz/0PmprwCzX5mh6JlZjCwCwoZ67Z
         4+bcnIkQCrVWQ0HUHcTqnh3fRgEbwvzdu0dCI3dD8ulsOpl8ohi1Fsdy3KCfO/Vrt3JH
         SLd8t4AAH/v/I8LSXxT2gfLars1zKHxakXOV+ioxTk8z6BQQhMGVBHFb8BrFgc5+oIYB
         e/JV4dSz09Xh8l/K3yVtU03hjZlOvQEJkbBJUFphJfyfKZz0tgFt9kkvqjryRU1LYLJn
         mS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948029; x=1713552829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ku+cYfV3CL9NDsoRJLchzk83CxUteslcXBw1rBPpBQ4=;
        b=H88wmdOLY0GFY0evkVGQbY1iL8t0+f9dmH3vq7RKhIs2vj6aNLkHYQ+3qnLwQmd9jw
         1MXbOVYQlefx0Lm+aMEPayEOd4eyq8d0PKzAf9VnzI3JWyqwf7hE7pSiZawTKmWYK4w/
         JKPRoRZ0d2G1GLfe2S8++eSkjI/P+J+izFHB2btrwAL1CsYHpe8Jso4Fn/UqHmePfj+i
         4uNOczJ2XzuUsGsdzFkhD5riFw6Ea4+f5OVlTS30HZnOef9nVnzlZ7mEBpOtk3eAZcvf
         L8R3UpzhTNsgX04yZFS0O8upzRqSzV5Q4Jx4pfo0UFXB62VmXaKNm6x8eTg2bnitZJZA
         uKPA==
X-Forwarded-Encrypted: i=1; AJvYcCUlCMl/KAuX+C6zV0+GtED/mBsNr4V4y0dRfOR2bar8lHTyeJ+snLHcdBHqjkTimxv1XXanE7IluAQept1CFsRqx87r8EJKGFrkEG/y4+r3
X-Gm-Message-State: AOJu0Yz7xJ8y3/+/VglMKquwDb4ZqhgOtjsjrkg96JZbSrH4mVuGgSsm
	/PvXWDiA2kWYVIe/nhhmCCj7D2l+9fWc3iCtFk8zgSxNLa+bmSREBwrczbxsttBT9rg715C44p1
	x0jcOxri4fxGigarqBvIMmA==
X-Google-Smtp-Source: AGHT+IFIgCcbrNG0WVTnmYkDHfTcUVCEG2xc3xCMlYSow98Vu7k7eQ29VCUlewX5/iqYIg8yJw0Aoj31HUwl+kTG/A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:2720:b0:482:dafb:95b7 with
 SMTP id m32-20020a056638272000b00482dafb95b7mr108126jav.2.1712948029249; Fri,
 12 Apr 2024 11:53:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 18:53:47 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADqDGWYC/x3NQQ6CMBBG4auQWTsJVBrUqxgXWH50QilkRgmEc
 Hcbl9/mvZ0MKjC6FTspFjGZUkZ1Kii82/QCS5dNrnR1WVeO7aMpzBsP0ITI49R9I3hoY7RtNA5 88edr8GievW8oZ2ZFL+t/cX8cxw/Rj1rpcgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712948028; l=1692;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=FHYmDrKaqpfpTRuPXl2DoFH5LA+zgDT0YDVnlDewaH0=; b=pWm/MHLjmrDU97kGz+go/s2QQbsbuuiO6zSazvNgFRTlpwEH0VSe83O/r1uhKZsmlXVlSBlD4
 r6ftS/8HNstBETceWQdRRLeikrnqi2Zc9U6HVKPIW0at/1YtRhfCNrR
X-Mailer: b4 0.12.3
Message-ID: <20240412-strncpy-kernel-module-kallsyms-c-v1-1-ba3f0fc16163@google.com>
Subject: [PATCH] kallsyms: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. The goal is to remove its use completely [2].

namebuf is eventually cleaned of any trailing llvm suffixes using
strstr(). This hints that namebuf should be NUL-terminated.

static void cleanup_symbol_name(char *s)
{
	char *res;
	...
	res = strstr(s, ".llvm.");
	...
}

Due to this, use strscpy() over strncpy() as it guarantees
NUL-termination on the destination buffer. Drop the -1 from the length
calculation as it is no longer needed to ensure NUL-termination.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90 [2]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
---
 kernel/module/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ef73ae7c8909..62fb57bb9f16 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -348,7 +348,7 @@ const char *module_address_lookup(unsigned long addr,
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
+		strscpy(namebuf, ret, KSYM_NAME_LEN);
 		ret = namebuf;
 	}
 	preempt_enable();

---
base-commit: d7ad0581567927c433918bb5f06f3d29f89807d3
change-id: 20240412-strncpy-kernel-module-kallsyms-c-8539c5e7bf57

Best regards,
--
Justin Stitt <justinstitt@google.com>

