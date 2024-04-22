Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827C1BC44
	for <linux-hardening@vger.kernel.org>; Mon, 22 Apr 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821616; cv=none; b=OLbh9GOHRyJsWG4qsESitn/xGOtA6eL7taz1MgtIkh784msVcrUriamr4WXkdrRcOy9dkKF2ifRqG3TByJt05/3r56bfmzQbmxTMYa8a9PzUeOM44W5Q5J+yBx2m1cfFNCzXk3FnZ7wHt0bskVCu7Q2W8MMOynYM18UU6bVvAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821616; c=relaxed/simple;
	bh=KoGkjBaET7UqkuHSu4yCulVlOdC9PQQ8/g3x+7MJQF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pyFHIe9KKGsW3bWJpUMm4R1Snn53nU0atz4pHMnzmHDZw3ypdzODl7AGLmlliTbjCyCwxr6wnjOioLnJcUGQXCYfrAZ1mGWBHrHJ+SKScbybNFmn+6/G5c0Ap80jMZ/wqXWB0+s3fdca8kbi1xaeiPaitYV522XzP24C9EtG9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6sxRn7M; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6sxRn7M"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de46f4eacd3so9314902276.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Apr 2024 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713821614; x=1714426414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWL/zGxv/3TQuwEboaVdGnhbzcGjgPZ6QRFC5NUsRRk=;
        b=S6sxRn7MOuvkZTZTkos4vBLsGLmq30wjJSbNbrjUYnR+wL02BwolKj6igH9N7zIAiQ
         HBmkfvBCWghWgybR4xyPJlYcWFQnNW/+r8WsTUm40e9exdTnBxREdC+2UXYUxm7tlZTp
         bT5vAjZg8+rt298xICgNgM+xQunylvlFB5EnfBwdT8aAHnW7F7V3kX5WY08IeVceEuJa
         Gy+QcKvKydtSLsqFW+Yan37oWO9iUbpWTz+XVd5Xkpce+Ya08Mbc2JupMhATh9zGyMKt
         2k6imtFImzbRujx2adQzEqo3Xw3RKYLOQbItCDdjwPmvG8/wiGP2HRv+MM7ZeNHckU5p
         nD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821614; x=1714426414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWL/zGxv/3TQuwEboaVdGnhbzcGjgPZ6QRFC5NUsRRk=;
        b=hoNYaRbrmUGYYXGLZB0Y/LH1QWCbYUu9alQ/LrmI+ndL23rmevYXAweluAXHJCGmcz
         MnqL6KUYVY0ErIC+OqLkjB8Yiw+pN1JyRK1qSKox1+1SoFFELiofqskCQ5RQjWnobzdU
         q8iDps3BI7YJqTq2i5SOXWQUDNq1HtVyX4c44YO9CFPDhlV6zdJpX3WHuIpUhdLFlf7C
         XQpJ+rjHGZb5QMfoKMj5GYJsto3USxuXun0ddD5FN+rAAIvM4iRjO8xL4+s7QbKQjmt3
         w5JDcWJixACamX4XhEUCyhyeKg8Wr41ZLW1WDXLYrO46j8oQfCikXq5s0MoamnZ3SANV
         5aWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrnV82x8/AuiqQz+YfY95L34A1XZs3OnCj8y9AHd5PDOaI1pjIUnHp47LGfqMaHqDa9svcrPAyPM8w6Wr+FcScn9ed2WdPr6qry+vbd+3E
X-Gm-Message-State: AOJu0Yy1bbsUGBi43P9p4zLhCOHH8CIVshPOj1iK3H3/nzoeOxAj+mWt
	PCyvCIkTfDApzfZZsduxyIdfu94EXFAVpi1v3Ccg7wwuwDlrBF0kioPGcp+hE2scXCKnbhVxYQ2
	hAyegyXwC98mNHSEA9cjbKw==
X-Google-Smtp-Source: AGHT+IHRAYjODQvhZMAVdTut8PSJ03XnA8BSy2cwdXJaeLIsfBRt7ySYzs4u6FV72DEdNS6LhMHGPpJLStfRiO35lg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1148:b0:de4:7bae:3333 with
 SMTP id p8-20020a056902114800b00de47bae3333mr3637771ybu.3.1713821614629; Mon,
 22 Apr 2024 14:33:34 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:33:31 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKrXJmYC/43NTQ6CMBCG4auYrq3pP9SV9zAuShmgUSlpCdEQ7
 m5hQwzEuHy/ZJ4ZUYTgIKLzYUQBBhedb1PI4wHZxrQ1YFemRowwQRijOLZdcG1fYduAvXemtw0
 2uRJQqgyKkqB02QWo3GtRr7fUjYu9D+/lyUDn9bc3UEwxN1YSJgupFb3U3tcPOFn/RDM4sD8Ql
 hBdGEhCaYCTDcJXhFO5j/CEGCEpZEoJTtQGESsiSL6PiITkSmdWK2O1KL6QaZo+4tp3ZIYBAAA =
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713821613; l=2724;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KoGkjBaET7UqkuHSu4yCulVlOdC9PQQ8/g3x+7MJQF4=; b=ZZ4+o+IWJCMGEUu2xSN3K1eKCmtXxDDP5ygJn55HSjNFh6F5YsTicn2RWjMXOJO1gRqkE3i5E
 WZXZFNi1azVA+R/VkoSwsJ1XC/uVhmYYv2D4Q1xE1I8qFADgrxkbbu/
X-Mailer: b4 0.12.3
Message-ID: <20240422-snprintf-checkpatch-v5-1-f1e90bf7164e@google.com>
Subject: [PATCH v5] checkpatch: add check for snprintf to scnprintf
From: Justin Stitt <justinstitt@google.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

I am going to quote Lee Jones who has been doing some snprintf ->
scnprintf refactorings:

"There is a general misunderstanding amongst engineers that
{v}snprintf() returns the length of the data *actually* encoded into the
destination array.  However, as per the C99 standard {v}snprintf()
really returns the length of the data that *would have been* written if
there were enough space for it.  This misunderstanding has led to
buffer-overruns in the past.  It's generally considered safer to use the
{v}scnprintf() variants in their place (or even sprintf() in simple
cases).  So let's do that."

To help prevent new instances of snprintf() from popping up, let's add a
check to checkpatch.pl.

Suggested-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v5:
- use capture groups to let the user know which variation they used
- Link to v4: https://lore.kernel.org/r/20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com

Changes in v4:
- also check for vsnprintf variant (thanks Bill)
- Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com

Changes in v3:
- fix indentation
- add reference link (https://github.com/KSPP/linux/issues/105) (thanks Joe)
- Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com

Changes in v2:
- Had a vim moment and deleted a character before sending the patch.
- Replaced the character :)
- Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
---
From a discussion here [1].

[1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..b7404e53c554 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# {v}snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\b((v|)snprintf\s*\()/) {
+			WARN("SNPRINTF",
+			     "Prefer ${2}scnprintf over $1 - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
+		}
+
 # ethtool_sprintf uses that should likely be ethtool_puts
 		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
 			if (WARN("PREFER_ETHTOOL_PUTS",

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240221-snprintf-checkpatch-a864ed67ebd0

Best regards,
--
Justin Stitt <justinstitt@google.com>

