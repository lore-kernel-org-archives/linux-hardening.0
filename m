Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0671272CB
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553131; cv=none; b=UuWqUa4lzexJJD/eE3oGV/UWYsVlMUTbnNLli+wy8vMYJJbIvM6Fcgrz2bCVpzbI/UmjDwRlSKdQrLPsDSoKIfwaT5on4+JRC25V87S8zRhIFwmAXv/xwr/J8e5Lcvc2WBpBFENaCodxl9roMbby96Lg+NQsLaSDWTBprlQ8+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553131; c=relaxed/simple;
	bh=glDEKtdwdqyJIt9bRVsA7OStBeZEdBkYYd62ei+rhmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yg+ul5z5Sy9Zfv0qxYmpxhuItn1mfo3ot2aNMwoO5XfjwrTr0DbODu5VPaMBGZxb08gVY2HVQ4IkXD1QB1OK6WKOYumAYR4ZLAVy4o/s4ioFyI1809hAewfPMbEoS+J09O9Ei2WZP6AxK2XH9mVrYLJWwK/rHcxwSNPDR2pfSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcQQq+4W; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcQQq+4W"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so1973660276.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708553127; x=1709157927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEXpQXg5vnSo+q/Y96zcMRb8jRrXDHbwFt0Ekcc6U9I=;
        b=XcQQq+4WQ1MZQLL9UPv+1x6qXBcOYK3405lqc8h21vpYT40o+1qyoF65kO7QQoAxfX
         tu3xF5X+uHntG6SQiFjgQiXHm9jp89M38ocEsmZbC7JPiJjoOmij/01JePm38rWj7GG/
         aPIY0J6mzWJb+lGQGmTSqA1m2KNS7NlmBNxCq0Lyic+9/ssQGwPKlaEsN2SSRzXIjV0V
         hlVop0ZgMR3fZyrv+WS2rlFGMrNjHAuK1IWIEjQceICZvJo8o5bO5jp6nrtVovp5VJ1Z
         ifF9WqKSZsnyhMg14kG01h57KId4B0gI5dj16ThNTgtEyyoYL4OT+fJmO2LfZrIXZ51i
         4DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553127; x=1709157927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEXpQXg5vnSo+q/Y96zcMRb8jRrXDHbwFt0Ekcc6U9I=;
        b=d/OpK6Z/ZaRl/IsjwdnXov485DDWnfwrKtyUeh5FfQOJVHurb4nqvFLVKahTHOtrp/
         GaI4w3jCLrJ+rI9n7JfUJJbEqJZiY+k6wBOSorIl152aGIgqHevOu96C8n0JTCToYBC8
         6AT8A74MiUkw3A9nqfDHr1tifl7uBJE0WrX8pxXjnPaiyM6bLpqHhBWRfuWTqvcR97Pf
         fB29gnsIZTb8jonruR022EEaqWJ96x1FezsB6uX3i8LCQGzU7wz2RHiDG0B371pasx2k
         mZtzfE92iNrRhi2ipNk/zInoTMikvD6L6XLKGLrO8/kFhCsSQLGnfIA1SLjgCOFCdfOe
         YMUg==
X-Forwarded-Encrypted: i=1; AJvYcCW4VZIQr72jtHgbZTa5NtL9Mo3zDwa2Fjoe+SSmogOtEuoNwU77P+ErXSvjgvZRoxw0Tg9nPeSFCPifMf3D9JVNUB3UdnAM68n8V934exkE
X-Gm-Message-State: AOJu0Yymy5G4wIr8+VkQ+XzUcJembupcusjcXE51PXG6VGDwNnIlYdfC
	1YRwRNCXj/8q2GOCH3FoHDgsLJSdPpLF/eyVN2dTxdqz9gH59mEzsgVgz/VT9BCwRTzc45lRu34
	IeekVuwUHPPaZLRV2I+2luQ==
X-Google-Smtp-Source: AGHT+IH65ETPwbThwk5AYf7wJ0+qz1pjROYQoRed6Nxu0TgqLyz0Kj79tkAiKpPEL1LlETwVW/wVTtfz+bTZkf2Qfw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100a:b0:dc9:5ef8:2b2d with
 SMTP id w10-20020a056902100a00b00dc95ef82b2dmr158311ybt.4.1708553127595; Wed,
 21 Feb 2024 14:05:27 -0800 (PST)
Date: Wed, 21 Feb 2024 22:05:16 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJtz1mUC/x3MQQqAIBBA0avIrBNUwqKrRAvTMYfARCWC8O5Jy
 7f4/4WCmbDAwl7IeFOhK3bIgYENJh7IyXWDEmoUSkleYsoUq+c2oD2TqTZwM+sRnZ5wdwJ6mTJ 6ev7rurX2AVsF9GhlAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708553126; l=1887;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=glDEKtdwdqyJIt9bRVsA7OStBeZEdBkYYd62ei+rhmE=; b=uyJIZ0LPetF0XN9X4zCF00e6OsEkDTxKePErRG4rK3MlHowXuvM/g/ti/1N5Q7c9JLpIRHmzb
 jOOSpBX2gahDxCJ40oMTEt9NWPSyrvjCWqzNtseVW8J0tQWA4ku2Dd7
X-Mailer: b4 0.12.3
Message-ID: <20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com>
Subject: [PATCH] checkpatch: add check for snprintf to scnprintf
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
From a discussion here [1].

[1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..bb4e99c818a9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7012,6 +7012,12 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# snprintf uses that should likely be {v}scnprintf
+		if ($line =~ /\snprintf\s*\(\s*/) {
+				WARN("SNPRINTF",
+				     "Prefer scnprintf over snprintf\n" . $herecurr);
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

