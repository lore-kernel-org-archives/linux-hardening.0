Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF20487AE
	for <linux-hardening@vger.kernel.org>; Fri, 15 Mar 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533358; cv=none; b=MrzbRgwjr19uBPEORspFPmlDUPqG4XH9U8oT/nckecUf53wCvWxMzDrn0p58nF0FV/3SYw9wt+Qs+JQAHZcj9j029h7rMMX0M+Z61ad3oo+s23GD/vnlr95GCYGiyi63vmcTdX3J2iLqqSA3hhJjtOmP/XSXi15cN1XfPXXXLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533358; c=relaxed/simple;
	bh=lAjciVBn7fEdF0vkatR5U3zbNKfVnP57tHInDU09ybk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jpZrj1qh1l9jop8P2vBHd+tNsFehon/z0tcKdEjhixt+60GlxMRWrNTALEh/SvyF/zRuBphHulvwUwNy9FEkm3SqjQMM9TA9S1uVxqbjo6l5HKATBeaSdZSb3qSXdRJNRx8/8R6wg61www6m4urf4wjzsy9JHqVwMz9KuuycaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbzuEcPO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbzuEcPO"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so37831377b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Mar 2024 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710533352; x=1711138152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbpSIycwsc2tWO8Q5CI8ZjMC/0xhm3/hIri+gWrvEyg=;
        b=NbzuEcPOBY4VvI64L8EIzsAtCdos3OIYcEbxTucLU1d38+wML7Kgm2iOMJ0WEMSF0r
         HRuela7Rn3ip05FLPyuU8xSQt+Z01H6JZshINoXwnCogpyJwc5Dx69U8ExZrD2vBV0D2
         LZfY18Tsy6gu8WpLv/a7xBbp+qipLIpTLvE71wuXVGa6prSXUUu8fD5fqwf++Q4k3M8m
         QmYhuCbErwM+FA7uH+1iDQ8dyv+chVSUJqrGSk3pfDpovRZ5HU9sImIrM0sOkO7oSXg0
         VUtK0JEOn/6jHEzLc8ynwGjSsGJHFR6vY64sMNtm31B50EV9dk+ZpQwO/BKcdiklXPzH
         B1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533352; x=1711138152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbpSIycwsc2tWO8Q5CI8ZjMC/0xhm3/hIri+gWrvEyg=;
        b=ba0gKSQ7aMmyNuNjBjmOVaXxs64/PO6xdNYlWn+vN+QxKLST3cKQV3x3OkDNDJLUUP
         qxFhb7xhB2Lb0CgNU6C/YB4S+E5psd5duleWCE+KPr7Qixvrv/tSof8BD5AjA5GhmCFh
         V7Kgc2vZ8YLEhamLQOlkVLipnqwI6VYay9kFAEJXHkJXfUx1GLD1yIjgPpux0JjjrCsT
         g52rvQlySXXtEqPvftKLadf4h5mnYi6v+modjkx1Dh1HRRoYUX3ZZ6Kt0R/vu40/Yjmv
         sOtkWX5xNE642lRgBDrn31BjauG3QLzJ0xSSOHUfzdtQv47xwZnPr3NYD4NldBCEofWI
         vjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWqp3yLJt8N01/xGSdZ27TMKik7deTxS441JfghG4gqKrdRBP9WVpPXIX9GFPR5WNZN151b2MjDvLgJIfLUkv5iX6agrHmWev1kYzmsT80
X-Gm-Message-State: AOJu0YwgZJfJCFUS3HWnCU9eCLFqirHwAu+rrU7K/lmCuaxwQTNk2wA9
	MFxjDI8/W+DDJOxT474HpNWqm5xCCnkXj+mCM0pNxDtcqNEEy3noORUjENh++FXmUAS42CpYb22
	BuxE5tJ2Qo9TttzbxGCGpgA==
X-Google-Smtp-Source: AGHT+IGv2B2BHSGgGnn03zVy0mQfCfkyTSQjukbCNgvH1W0pSmC4veeyN9vI+f495SthecQLixky26M+y4gOvBjVUQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:3513:b0:60f:d74f:a5ba with
 SMTP id fq19-20020a05690c351300b0060fd74fa5bamr454040ywb.2.1710533352687;
 Fri, 15 Mar 2024 13:09:12 -0700 (PDT)
Date: Fri, 15 Mar 2024 20:09:11 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOaq9GUC/43NTQ7CIBCG4as0sxYD9EfblfcwLihMy0SFBhqia
 Xp3aXdujMv3S+aZBSIGwghdsUDARJG8y1EeCtBWuREZmdwguay4lIJFNwVy88C0RX2f1KwtU+e
 mQtOcsDcc8uUUcKDXrl5vuS3F2Yf3/iSJbf3tJcEEK5Wuuaz7um3EZfR+fOBR+ydsYJJ/IDIjb a8wC0Zhyb+QdV0/Q4Zf7fwAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710533351; l=2367;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=lAjciVBn7fEdF0vkatR5U3zbNKfVnP57tHInDU09ybk=; b=i4dhQ8hRHLCWukhlCP0iY3njxd/7+izprjcy6rYPHPAKA5+J+JsF2SwDFOHUnQaBn7m+z0px3
 aw0OtHtVuojCRayqi83sDz3Y6oz2JQSt1/NMxR2iqAlg2vzIN7rU1x4
X-Mailer: b4 0.12.3
Message-ID: <20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com>
Subject: [PATCH v3] checkpatch: add check for snprintf to scnprintf
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
index 9c4c4a61bc83..69dfb7412014 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\bsnprintf\s*\(\s*/) {
+			WARN("SNPRINTF",
+			     "Prefer scnprintf over snprintf - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
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

