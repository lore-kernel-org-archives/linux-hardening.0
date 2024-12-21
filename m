Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E81F238A
	for <linux-hardening@vger.kernel.org>; Sat, 21 Dec 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779452; cv=none; b=JiJW26IKEItIxQo0G16SlhxjAWuyQuaPLwwGFlA2fY+3aBC4G0puEPB+tjpbtnzCXPquoYPj/7z+CJuRJHM9BGEvEJrFVHISa3j3kPTFC5/vr98ZehBOjGo8WpuAL7tmJMDH4qd4bf+sVcUa57fRSS543t/JhXxARjHD8PiZvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779452; c=relaxed/simple;
	bh=XhWNXFHaJ9glrnThaW+6uFMdg7Jt0dVoQ8ReWmSarVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BV/eAfagGaUXZ0CQPCGAJTehx8YksrZnFczwP9YkCetborCfkVMn3iQbi+fAcV93MCSYB8VVyus6pvSndJ3Vif6jsf7XAXTnizC3M2EJdEsQ5P436kzQK52D0KwQe4zwCNDrBjQf8GPgNqbYHLF4zdQTHe6mvHSFjChJKFHgxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8N6MNMn; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8N6MNMn"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3ff30b566so2844044a12.1
        for <linux-hardening@vger.kernel.org>; Sat, 21 Dec 2024 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734779449; x=1735384249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acFqHgTTvDfsaGKKoef1ZEN8Prd2tlZbEpNeYt8pW4w=;
        b=w8N6MNMnGoBZdDNYKib2K1CTFyo5K8pBhxsWZHJB27Y8fUoFOdczn3fwyy9/tFp7dy
         aMuVcOt106NaQqp5oyhxOn4QWbyPa/+LWGYpUCXcJJgoDXZyvWZMDJy4IiKYTEscPg3S
         HCXgQV2SNyLPIIAQDK7w9xL7y6iS9qLP8drLP2/vELShuuwMf/uqQfdk5T9L7evxcm0f
         PzhOHDYJvDheuSEu0rOyHE+T6IgOPwonLqLck0s+kIKI2ihusjjrtctLjp53YxNtt30o
         opH6dYF0uVEsEtuVtKB6WMQ/Vbu9yiDLkKLuRPgTkknHj0XLJlU2MbqWJZXCG10J7BwT
         mnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734779449; x=1735384249;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=acFqHgTTvDfsaGKKoef1ZEN8Prd2tlZbEpNeYt8pW4w=;
        b=BAM6SGeb3xDSA3vQmhXG72FVP7uVDiP2Bf3GXGNaQmMc3XLJ/5Zec7yq9I/vsCx2Oi
         KxeYKVqzjBpRXzCEuKvD6VpPZhcc7XlnP8fwc1QiwE09Jxzgn0KxpDbFOvZMvld+gaaa
         JvCAguS4nvcGaRxgeKyV7nFIKzaz3Qx5s5fNOsyuqRsK3cJhWDfQt1yzdq7EvE547F8A
         QnHmq5Z+rjX3gGOVk1IechVWdtIMGuW+S08HD+uNr3Gwf14vPaO50U4IeVC2Xax4WT8b
         aj+k2Zk6XCHVx+5nL0vRkF1Xryi6px/p1EOCDC/VgXQYuR0/S1wBV7mjAbBGnmTnINhD
         Xf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX48+PdhUutNhaKgFf4NL1L0afCZuFR4w7ounNygcxntOv8Z2d/SCXtWrkp8bXtrCYpUQwJx68XwkzkKRof6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/tXaLQWgxXNCKIcwuAJYtWz0JH95vSwTXunO+9o84hDrQWCK
	4+XvHwJRmYWWsVlgNckc1o3zQq6XdZuaMAgGNCvS/SYQnV065yl5ZvFpiK8DoYFyGQk26JRnmEV
	mxw==
X-Google-Smtp-Source: AGHT+IGeWbKxpk3gdrLwTVMOGxYTHG++3ekHtzTCNYqK+VxLg7d/tlVkzABgBueeFhOF/tGOx98kdsq6Gwg=
X-Received: from edzf16.prod.google.com ([2002:a05:6402:1950:b0:5d2:7367:4c84])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:254f:b0:5cf:e71c:ff97
 with SMTP id 4fb4d7f45d1cf-5d81ddfbe45mr4289512a12.24.1734779449412; Sat, 21
 Dec 2024 03:10:49 -0800 (PST)
Date: Sat, 21 Dec 2024 11:10:45 +0000
In-Reply-To: <Z2ahOy7XaflrfCMw@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z2ahOy7XaflrfCMw@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221111045.1082615-1-gnoack@google.com>
Subject: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, "=?UTF-8?q?Hanno=20B=C3=B6ck?=" <hanno@hboeck.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.

TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
let callers change the selection buffer and could be used to simulate
keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
use, as they do not modify the selection buffer.

This fixes a mouse support regression that affected Emacs (invisible mouse
cursor).

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste sub=
commands")
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/tty/vt/selection.c | 14 ++++++++++++++
 drivers/tty/vt/vt.c        |  2 --
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 564341f1a74f..0bd6544e30a6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selection __=
user *sel,
 	if (copy_from_user(&v, sel, sizeof(*sel)))
 		return -EFAULT;
=20
+	/*
+	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
+	 * use without CAP_SYS_ADMIN as they do not modify the selection.
+	 */
+	switch (v.sel_mode) {
+	case TIOCL_SELCLEAR:
+	case TIOCL_SELPOINTER:
+	case TIOCL_SELMOUSEREPORT:
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+
 	return set_selection_kernel(&v, tty);
 }
=20
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 96842ce817af..be5564ed8c01 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3345,8 +3345,6 @@ int tioclinux(struct tty_struct *tty, unsigned long a=
rg)
=20
 	switch (type) {
 	case TIOCL_SETSEL:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		return set_selection_user(param, tty);
 	case TIOCL_PASTESEL:
 		if (!capable(CAP_SYS_ADMIN))
--=20
2.47.1.613.gc27f4b7a9f-goog

