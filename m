Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA4128399
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415973; cv=none; b=SFWBu0R+hw9dYKN4zxo3/LzS3ktsgVRAXLHogBFV8+k81lQVQ+ErQ8w6QlOG9xkqDHD5qYK2kKrLFe1OIIw1FK6hs+7cKwdH3wJs+YwuabevAd6zHSno56u3b0Lf9jzJLl59CelfxrBT5Cx9gs8OmDbW16iMKQNsqW4FMJ0Sgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415973; c=relaxed/simple;
	bh=QBdZBMXCVF0uuM31zTQeK3OKrbEfxdu1leuRI7upUEs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mKxIwxGrLTl+SY7VnvLafLCnqEeEtm9iqWcJ2ls3aKJr49h1oXOUbHpEKzNzOHO+xQz2biXRFZgUh/JRsMnVRUaL6duY03fmLG5fdQRB1ryJ6TpImDTobJUiM5tD8NHihU4IvhBbq81GP2R32s3/kDTYDmi91dcYGd9xxb2wmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBqaOHmB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBqaOHmB"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso6810987b3.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714415971; x=1715020771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wSYJcoyaTi79NbRMVjq5HHUnz6U3D46cE4KoRFu8N2A=;
        b=dBqaOHmBucHXMhnKlV/DCWeSaXeIXjBKTxe3/wiANSsIfjQw7HWGFT/SjVfo182qh7
         FqlXrnA8ZbaV58nkv9CJrIIMOvViFARPDAc4i2piCrSWtRXthCTXuep3TL7P+SjMU13Z
         8g0yJSq0lc85VBHEIZBEjVFz94aNEQyrT42HZfGa7XeHkvmQ0l/Tbfo7FS32mPlk+2Tg
         jWzHvUIha5JMPfuN1ofLQ+AveQwiqP0CyQVtpjmWr2g/MkXNnHhq3aWpnhYcR/kTsEso
         IkEvFTbzMlFmwrx9B8U/MLBdCcpIbWDrvIRV6Ko83WXDUsr+wZySb1YF/gN47QOh9JK0
         ZqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415971; x=1715020771;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSYJcoyaTi79NbRMVjq5HHUnz6U3D46cE4KoRFu8N2A=;
        b=KclGW7lPReUMit6DKWh+rTxcl6OaE6gyZiZG99y86x3uypeMQuiulNwMztI0Yzwkka
         iWMpxT9fxB2RwYNjsCoCpVQE0bvn/EU1dW71TckT3UZrV78lCCiX4ifRvmh7GqJG7HOd
         UHoXHGQ12AU4bUJdpbF8/uxl1IgPxKF+QoyK5glSabhHc0WSpHA6oId7VgCsn56CXYUB
         ydFfcgWLqjecOjjVofqRqFZgZIiYQ5aTJB2e5FRJwl1IdnbCB74JPB2zHL8ajA6ffwEd
         NVXGSXVB8f6VqkLxMsBjanmBBBuJG0Bs7QiPJWa9IRRaFViZKVRurfzNnx0yPmZpwG3Z
         27iA==
X-Forwarded-Encrypted: i=1; AJvYcCV7WmKhPUYKDMppV7s+/oCrffHh+Q3cgNYX7B/ts3Zccy990N1ySDlnKkmVx8yrWln+v5bvSfXyDYHoTazmEiW+JFUKTwe6xX5h6eOH+tYJ
X-Gm-Message-State: AOJu0YwrO2fS4eubcJ7ZO5tVsBbBXxmElY9w3HO9F1QeDBPACfp3SVYM
	NeBlMFd6xooSli3AMdfDQEAyogE4+3l3P8Re9S4401HCgm1Y8yIyjkSEj2WhUyolz5WZeTArPUd
	AbIHEyBn1os6aWzF7VDXHpQ==
X-Google-Smtp-Source: AGHT+IHANfFH7TFflKbRryihtyZjur78IWuaWQA8CIlpRzlcXweRhaGAdP48CqTQpxlMGfUxNSjq3zDgCuJMsX2ulA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:290a:b0:61b:6c2:392c with
 SMTP id eg10-20020a05690c290a00b0061b06c2392cmr91397ywb.0.1714415970772; Mon,
 29 Apr 2024 11:39:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 18:39:28 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGDpL2YC/43QzWrDMAzA8VcpPs/Dlj8S77T3GD3YjpKYbXGwQ
 1gpefepvXQjYez4F+gn0JVVLAkrezldWcE11ZQnCvt0YnH004A8ddQMBGgBIHmd5pKmpedxxPg
 ++yWO3LdWY2cbDJ1gtDkX7NPXXX07U4+pLrlc7kdWeZv+7a2SS658NAJMMM7K1yHn4QOfY/5kN
 3CFfyBAiAseSeg8KrFD1ANR0hwjihCvjcTGWq2E3SH6gWjRHiOakNa6Jjrro9Nhh5gfCMAxYgj pJToR+kbSv38h27Z9A8yGVKrLAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714415970; l=2913;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=QBdZBMXCVF0uuM31zTQeK3OKrbEfxdu1leuRI7upUEs=; b=YWO1yUokL7cw7iVMCGuxveXQyCZ9XwuqGLpFjp5iFwgxyVtsjIrneZua/7/APlJDwqUkzDw7A
 3S3WB1l//IrDVBY7Es6i4nZH2WMTn0MmXhislWJPUGPOueoQGl/zR+n
X-Mailer: b4 0.12.3
Message-ID: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
Subject: [PATCH v6] checkpatch: add check for snprintf to scnprintf
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
Changes in v6:
- move capture group to only include symbol name (not spaces or paren)
- Link to v5: https://lore.kernel.org/r/20240422-snprintf-checkpatch-v5-1-f1e90bf7164e@google.com

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
index 9c4c4a61bc83..bdae8a7ae5ed 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# {v}snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\b((v|)snprintf)\s*\(/) {
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

