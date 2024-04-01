Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FEE4DA13
	for <linux-hardening@vger.kernel.org>; Mon,  1 Apr 2024 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995052; cv=none; b=FInYCDfdDyIbI8dTxjwK5BtTOWkkW7F04yRfq0yh536gznZOvhzgvIJ14J+L6MLK4AfxjHjEWp8AhXPeqq2hl83rissmpDd2Jroh9dnC69AtA2GSFQyY9fADjwvPI/LWInnDpmBTzKsFIBkaHRiJFFGCUaDcUM0p/xwEAA9Q8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995052; c=relaxed/simple;
	bh=z2HNaLW7w9QpZHWGF0jaA9MyMN6bCQ1kVStq5aF7W4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CnuyB4BBZmcr1wZ8Hy3vQcf/z/jukAjH6S33esI2991gdVgb7cquQVJG14L4/IKmYHX/Ag7a/+D0ZwtTN4o+nTMNMCnSFSWwVB0Ov4xHIz8jqXVJ3O3jo0H0/KpyCn0ewBVfIqO2RzMyfqVSRvyPDViIXVgU0yGuU4nz9DweFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHMkJeSL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHMkJeSL"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7149079276.1
        for <linux-hardening@vger.kernel.org>; Mon, 01 Apr 2024 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711995049; x=1712599849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sw2vY2M4CeKEyqj973cP6PJDE6m3drwFn3wvpEExDXs=;
        b=rHMkJeSLIwbDSDjhAaUaHbGeo9ua3hm9of4MyQaLy0zZMvNGtvYEnEdula2es1QbPW
         pY4QSMRWt+1t/WE9SNVbgzlEVlFj8GGjMIaO0tar77U8CEsd/4yT+PIfWJYbsXsvAvbV
         uCCvztO/lH1qProrX3SxFuT+O/4ldTN1OWLZdVfhqgcxMvNAnVBKnxhFPFv6H2jgvOJ0
         8FJLuRFXQwdPA7pnbfjNsj+s//nuXBraiIeZpaypwBXn5cbliWpVG+myT90fLVRhK9Ag
         SMgGj7StrbdgJVpr6fkS2+lUtNxDv0JNJq5Qmi0r1Mjk/99ISZ+LSOWL44a+iDi/OlYR
         6Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711995049; x=1712599849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sw2vY2M4CeKEyqj973cP6PJDE6m3drwFn3wvpEExDXs=;
        b=mfiQr6l23krhaVX0aUl2azZ4SmOCTtebp++PdG4rIwzyhtOM/hlDhvG7tUqpSWpruM
         XcP6rx6b/ev4r+cBqOEMeEboiFXwZCM6zygUp/KaAEkvBEyewsH09XB70s2Eaalw9Y0w
         uSxtL66C/qC03vei8YcJok8BZaCun+qVjzypUXhbA66gBJhVY9oyoGOOJ5DT1U3p72jL
         y5+ibZ1Urcf7n1amYH7fQyMRG0AI7dNaBdrOW9gNldmIm2WR0F10lhn8uUI1ry+/h/xk
         DxzH/OaR7pb6Xz0/orVgNng1NEQb9TC5a4YAarw1qobF646MItLcDvi4XM/B1U0TMLlB
         xe9A==
X-Forwarded-Encrypted: i=1; AJvYcCWyZHHm2KbkQf9rWDugo03IkH6AZktqVZ9WPbo55KbCXDCib9/T+0qgUtac0W5x4JGaQDOGBtLjofP00zCU/3ZHFD/RDLpPnOwEZIe7sNiC
X-Gm-Message-State: AOJu0YyZDZUHfMQB7XhfuMUC2ElwVFgOZ6yJhPIHT6XocOc5/Rau4YS+
	+TKZyTwPVMPWyFsECy7DpffqoAlxy9GGwbYHQVtWtxlRsoZna1WNitjiRTG2GBur/o/JPKQSvig
	nYKPlSQXqsLcq+orlSN8RLA==
X-Google-Smtp-Source: AGHT+IFAZ8Se8nHA0Of3hEysmza4VRg6qbci7e1TG3olLS+L6R1D++n7SLB99RNTps6QkAlE7iFc8jPZQ89cC3NRtQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2313:b0:ddd:7581:1237 with
 SMTP id do19-20020a056902231300b00ddd75811237mr3279498ybb.3.1711995049368;
 Mon, 01 Apr 2024 11:10:49 -0700 (PDT)
Date: Mon, 01 Apr 2024 18:10:48 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKf4CmYC/43NQQ6CMBCF4auQWTumLQWNK+5hWGCZQhOkpFMJh
 PTuVk7g8nuL/x3AFBwxPIoDAq2OnZ8z1KUAM3bzQOj6bFBCaVEqiRzDbJYdLeNoeZk+jFsXY0C
 Dml6W6pvVpu4hB5ZA1m1n/Nlmj46jD/v5tcrf+ld2lShRmLq8V50UqpLN4P0w0dX4N7QppS9rB YvIxQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711995048; l=3756;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=z2HNaLW7w9QpZHWGF0jaA9MyMN6bCQ1kVStq5aF7W4M=; b=kU6IxVx3/F03byPgQEL8DLNLMSnWNCYWY3e9y+7keVoKq+5hvMV5hXsypcquKgXyj0ecnWlJ8
 lvja9jJqSVCAxSvYraO/3hVEpDYa2ynuZ0XmjXrTG7v0QdUj3JsrDWG
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-hfsplus-xattr-c-v2-1-6e089999355e@google.com>
Subject: [PATCH v2] hfsplus: refactor copy_name to not use strncpy
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated with NUL-terminated destination strings [1].

The copy_name() method does a lot of manual buffer manipulation to
eventually arrive with its desired string. If we don't know the
namespace this attr has or belongs to we want to prepend "osx." to our
final string. Following this, we're copying xattr_name and doing a
bizarre manual NUL-byte assignment with a memset where n=1.

Really, we can use some more obvious string APIs to acomplish this,
improving readability and security. Following the same control flow as
before: if we don't know the namespace let's use scnprintf() to form our
prefix + xattr_name pairing (while NUL-terminating too!). Otherwise, use
strscpy() to return the number of bytes copied into our buffer.
Additionally, for non-empty strings, include the NUL-byte in the length
-- matching the behavior of the previous implementation.

Note that strscpy() _can_ return -E2BIG but this is already handled by
all callsites:

In both hfsplus_listxattr_finder_info() and hfsplus_listxattr(), ret is
already type ssize_t so we can change the return type of copy_name() to
match (understanding that scnprintf()'s return type is different yet
fully representable by ssize_t). Furthermore, listxattr() in fs/xattr.c
is well-equipped to handle a potential -E2BIG return result from
vfs_listxattr():
|	ssize_t error;
...
|	error = vfs_listxattr(d, klist, size);
|	if (error > 0) {
|		if (size && copy_to_user(list, klist, error))
|			error = -EFAULT;
|	} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
|		/* The file system tried to returned a list bigger
|			than XATTR_LIST_MAX bytes. Not possible. */
|		error = -E2BIG;
|	}
... the error can potentially already be -E2BIG, skipping this else-if
and ending up at the same state as other errors.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- include NUL-byte in length (thanks Kees)
- reword commit message slightly
- Link to v1: https://lore.kernel.org/r/20240321-strncpy-fs-hfsplus-xattr-c-v1-1-0c6385a10251@google.com
---
---
 fs/hfsplus/xattr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9c9ff6b8c6f7..5a400259ae74 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -400,21 +400,19 @@ static int name_len(const char *xattr_name, int xattr_name_len)
 	return len;
 }
 
-static int copy_name(char *buffer, const char *xattr_name, int name_len)
+static ssize_t copy_name(char *buffer, const char *xattr_name, int name_len)
 {
-	int len = name_len;
-	int offset = 0;
+	ssize_t len;
 
-	if (!is_known_namespace(xattr_name)) {
-		memcpy(buffer, XATTR_MAC_OSX_PREFIX, XATTR_MAC_OSX_PREFIX_LEN);
-		offset += XATTR_MAC_OSX_PREFIX_LEN;
-		len += XATTR_MAC_OSX_PREFIX_LEN;
-	}
-
-	strncpy(buffer + offset, xattr_name, name_len);
-	memset(buffer + offset + name_len, 0, 1);
-	len += 1;
+	if (!is_known_namespace(xattr_name))
+		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
+				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
+	else
+		len = strscpy(buffer, xattr_name, name_len + 1);
 
+	/* include NUL-byte in length for non-empty name */
+	if (len >= 0)
+		len++;
 	return len;
 }
 

---
base-commit: 241590e5a1d1b6219c8d3045c167f2fbcc076cbb
change-id: 20240321-strncpy-fs-hfsplus-xattr-c-4ebfe67f4c6d

Best regards,
--
Justin Stitt <justinstitt@google.com>

