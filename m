Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF492B9D8
	for <linux-hardening@vger.kernel.org>; Tue,  2 Apr 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090398; cv=none; b=aGXQYYK8TmHT7Ib+RLYIppEPoGOLY3Eye1FkdJo6JR2pUIxqvLxusxkN5UXX0ODNN57k5L6a8XVd16kNmmjK0bcf6FBQwl0i9W0fkjk+8bgTuQeIGdvA0ZP//4kUjUOqTaDgcF26NYF3uk7kJZrIGk/6KakuFb88Gg5Fd4Lx/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090398; c=relaxed/simple;
	bh=tjg4x5e3PlDUqq2WuUJ3+ChpV/LB7ZJ2PHMkeIF7ESs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KFceP3ysBTVyk25wrpLVKb76qg8WHb++ym5ifvItcdiJnuB1RslZ+z+0u8yIXJa8eydSZ5r63ZZGwzIJXBg/cMMmq6ZFDBDTBcouR1N5faDPWuyK5IehZ8mFXhgBfckveHsCF59cMfDgqkbsToNKX4Xn9D9ljwN8c6Aie6FpR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ag979f8a; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ag979f8a"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso654079439f.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Apr 2024 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712090396; x=1712695196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VM22ZLPwCtsIw+jd1nTqxgUKJwdnIyjGn6t0jOkoy0=;
        b=Ag979f8abBT6DlUaCi1RaZnycttckxA6YLSwyv9z6XIDvol7pa3atZJAVl1V0Df/dD
         t5rjQNfe6xN/mYrvsNIazYvVeg1tTUkgFjC7hnN9+L9DQm1Nm9/0E3RFuACahkAtlJN7
         V4rVM3swXjd0Sp+Kf4myk9n1gyqptSh5qT6+nbFqJVezrUyJSX4u1jTgMLg5gni5pDKy
         eepjuHMejaVO4szhFHWX1voEVThsHhrnRXZyox5eeJentP5Rl07wRanSTW1jui/HKJi9
         Z2V0+io5bvqYA1XViCYJAdlw2rQffFKuqUUoJ1dStFk8XGc57Vf6jMLtdVhtlqGflml5
         u+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090396; x=1712695196;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VM22ZLPwCtsIw+jd1nTqxgUKJwdnIyjGn6t0jOkoy0=;
        b=T5nQOS9lmFEG3cWXKq1A3IIdl+61KueiMRNA6jjO/fNPcSG4tJepgdBPgLCKNM5Gfc
         Nz1fVEn8iMT6I6XiWzectOkMtDrHDtvZswwcb+ZB80tTELXT9tKdeF+T8NUhBWPaan20
         4VPTdbi6bdQS8EDh0Ri1M2CnBnpTPe8wmfDMUodFjdQxyNik36b8OFLp1BhWtJcE530A
         +WYMLUDMgZxRtarqoQWa2ARQfmEK0XtySvf24zeoQCxSoD+dQRy7cNVvLmLpk9bnObuA
         j6DX6iToDc4AkpBuTzPDDSKS2eYMSgf+9f2eFOP2XNgiNZwHCX0yot9NGxEah8a93GwA
         xeGA==
X-Gm-Message-State: AOJu0YwXU8a3RaFy3dYw93TOxWU5bBRPm/AlzFTf+QMdVBDFuGiBZ7BK
	WkF8OrtjgLo4bS7qC/EcIBSM7L0DnhM0va+AroczRaw7PLkzqqiZNqOxRVSbnJ7Fj9VB0xNpDY0
	v3757UZUvig2eNtOf7ydEdw==
X-Google-Smtp-Source: AGHT+IETt606vn4lNHDW0WE2X2CYGTAwbZHxQnN51d+Fg1HVMdUJfWlJGaaEMQ8RBw0bMJQMIrKbATkWStefspoEyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:3422:b0:7cc:ea7:4f0f with
 SMTP id n34-20020a056602342200b007cc0ea74f0fmr705482ioz.3.1712090396564; Tue,
 02 Apr 2024 13:39:56 -0700 (PDT)
Date: Tue, 02 Apr 2024 20:39:49 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABRtDGYC/x3MQQqDMBBA0avIrDsQY8DYq5Qikow6CyeSidIi3
 r2hy7f4/wKlzKTwbC7IdLJykor20UBYJ1kIOVaDNdYZZyxqyRL2L7JwwZjGLR1SFANSG7veB++ NG6Dme6aZP//1633fPwhSQSRqAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712090395; l=1551;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tjg4x5e3PlDUqq2WuUJ3+ChpV/LB7ZJ2PHMkeIF7ESs=; b=hxAr8s4jOllI37g6nd6bnWHNTlJmle/4ReN2d9pG0fwRgSqJNmD7gevfUKm+eOTcGaS+Foga9
 Wl/BSJBSpDDAEzH6WgKhVZY/42+Q5I+j/O92HrtY2JrImnsHtOykUky
X-Mailer: b4 0.12.3
Message-ID: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>
Subject: [PATCH] init: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

data_page wants to be NUL-terminated and NUL-padded, use strscpy_pad to
provide both of these. data_page no longer awkwardly relies on
init_mount to perform its NUL-termination, although that sanity check is
left unchanged.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 init/do_mounts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 3c5fd993bc7e..6af29da8889e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -159,8 +159,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 		if (!p)
 			return -ENOMEM;
 		data_page = page_address(p);
-		/* zero-pad. init_mount() will make sure it's terminated */
-		strncpy(data_page, data, PAGE_SIZE);
+		strscpy_pad(data_page, data, PAGE_SIZE);
 	}
 
 	ret = init_mount(name, "/root", fs, flags, data_page);

---
base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
change-id: 20240402-strncpy-init-do_mounts-c-e1d378c88049

Best regards,
--
Justin Stitt <justinstitt@google.com>

