Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AD9C04A6A
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjHKV4U (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbjHKV4T (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Aug 2023 17:56:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773652728
        for <linux-hardening@vger.kernel.org>; Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589c2516024so11163537b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691790977; x=1692395777;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lT6tvtL3J1wO3rO58ecG8VmDi6hvumDUq9zV3VFr4l0=;
        b=4zR6Gk7b5WgoYYkjgHkbEdMl0Npa1klK7G6HU823mI4KCGMmE2ACU7FKX/Rx7djRWM
         vPSXX8RvxhZhN5BTdzsj7HLLyaKkJiaR/AWNiekKwSXCI0hZJBgaHMal2R1ulnpyTIKT
         Z4yV5rrzP91cKJNttjtv59XAZFBbEovwcSq3KhLeb9Mb2QbVPmOgqsddE91asxnnNnAf
         a2off5mhdEoIqCUh2baX3eqv5OzsUpFVQlJIo9QD/SPpjfqtgJdpld9NHRqSe0Q2xxVu
         /yST74GcCCA4NGu9cTHbIvHYTjCIAu+QwMK0U1NjBwXQfqopCDiAAHhj97LjOvCLXE6R
         qnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790977; x=1692395777;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lT6tvtL3J1wO3rO58ecG8VmDi6hvumDUq9zV3VFr4l0=;
        b=kYEHXyFGuy3hVB450Gs+wFDUTRwSCsSm95LPayeod/FOi8vJuAU4Q0OF5jiKLKulW4
         iJfCTYB1oa1kzZeDrsBA3ScZtKHrEvzTPWRKe0uNiCGDI/1LxXu2gQyakLBttiUn2YFX
         D0HDMX+empsfFlioGTm5WigOnQ1FyMUj9AkvuLvsqKgekY6yyhf4L9KebXJJhbzaTwh4
         uImdRdQId+6yWMucrNDv/q3B7T9RtUiMSJbHv4/Z4tzFt1iiz6OJUSOy41THoKik1qep
         MqQ544ToWMfKlS2SVIupa4dLpdJFsOYuPcmCys2f33yK4csInqNdTQGCCx7P17wnEVJ+
         KEIA==
X-Gm-Message-State: AOJu0YwbSB0s0bDpAoXlbjDZLzgWF4tBPw6zKLVTh2S3q6NGcRyZPax3
        mHWoRnNenPVTnzxCjYei+Bop29WU6O+q0mzp3w==
X-Google-Smtp-Source: AGHT+IHeErCF9oRJ+YjqL0nvzOSVKIvENViCdgPR6lX/nLxioPJPIyxxMS3l/0/J8uWK2yZvq5UVWwCZX9DkbYQAPQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:b64e:0:b0:589:a5c6:4a8f with SMTP
 id h14-20020a81b64e000000b00589a5c64a8fmr56998ywk.6.1691790977740; Fri, 11
 Aug 2023 14:56:17 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:56:15 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH6u1mQC/x3MQQqAIBBA0avErBvQzKiuEi3EphwKixEikO6et
 HyL/zMkEqYEY5VB6ObEZyzQdQU+uLgR8lIMjWqM6rVGJz5gMoPCnSTSgUPXL8q21rfWQckuoZW ffznN7/sBkre9I2IAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691790976; l=1354;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=BDgTepl8ANjK7Fi3fsCGrvFDBI6wG66OFrFJ5xRKuj8=; b=S/xRL7ar/FEQsFKSEeFdyltpdmxSXJiVn2g8hnPqMJK9IO8SDw/aPXvJH2qtnHOc8yzvexD8g
 bE0kNvLPxekBCOjoY8gK0ym/jwQORc9w0odpV6vX7mocLqzapcpEAmr
X-Mailer: b4 0.12.3
Message-ID: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
Subject: [PATCH] s390/ipl: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Use `strscpy_pad` which has the same behavior as `strncpy` here with the
extra safeguard of guaranteeing NUL-termination of destination strings.
In it's current form, this may result in silent truncation if the src
string has the same size as the destination string.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/s390/kernel/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 85a00d97a314..a6dcf6f28197 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -266,7 +266,7 @@ static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
 		struct kobj_attribute *attr,				\
 		const char *buf, size_t len)				\
 {									\
-	strncpy(_value, buf, sizeof(_value) - 1);			\
+	strscpy_pad(_value, buf, sizeof(_value));			\
 	strim(_value);							\
 	return len;							\
 }									\

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230811-arch-s390-kernel-968d0545c45a

Best regards,
--
Justin Stitt <justinstitt@google.com>

