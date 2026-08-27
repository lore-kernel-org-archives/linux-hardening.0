Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1971E0DE8
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 04:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804256; cv=none; b=AZY2U85ok9SZiqr71JMC3H/ifaKQUqfEGETKr+MaT2UHxV0n3rI0RncecdgRuR7Jaa1xFA+J2APPM6yCyMI48usRFLJOghjJBnnxmP6VyAAcdl3VfZhMSqiG+vUE/pNcZzn4jA5eGBjU3lYf0Ox5gbN9bWSy6rEq+eRQGGWdC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804256; c=relaxed/simple;
	bh=smjs8DCyHfbFtnAez6SHJxIJ7dx3xNvndyjA/twe110=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=aBZ9oyrJ0jmhbfa8ebV5za6LhToPGdHQqD23aFGrd/kACoKAk6oI2BEJhTWMc+093kiVG1tmEEbAOH/8cHAgZNWhtHKNfLuZhEyABiXbrNN/gW/EodRz8Nkg+e5mDMa6vIDY4qz1aqkyVPyF7tn+ZT+3WNndIaYPIH8462OI76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnijOR15; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnijOR15"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1c2f1acebso601651a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787804254; x=1788409054; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMzSnQkFDbxeGZvlQrOG0uCcN7FgBdb2z4Q3uWVyr9M=;
        b=FnijOR15de8xnGMMz9pC33NWmORboHDsD/CYSQ5U/4pjJZMYBt58ATZYnCXudnDxHr
         2DI9mHwZw06VR219RFnIKiG4MJO6NL7aJR5BbZR/c3iWTvte1bZyVxQsnBqE0YHEhyPW
         ri/w6+TNzar+d6PV4Dx36p8Y8KnmErpKhOWQflfoIDYyUvuaQPnzRw6bQT+PsDVwYdfr
         akfuagbc+BwCFdJh5FGpganFQrUfujOaP4vwuywyXLjtamuO/fIGYfuZ4burXLA+ZOUE
         2pbY9dzdrr4s1dYbYKrYqDN75FgTSxRdj30LLeB/5wLkpVJJt/f6WHr2XJP1LQVpOYQ4
         a+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804254; x=1788409054;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMzSnQkFDbxeGZvlQrOG0uCcN7FgBdb2z4Q3uWVyr9M=;
        b=Hd8NDCVo4tN9rTJg1g1sBBYHgTb5eNXJ+tPMc3p1FrM6rU1erNvPk8kM/r1idauU+j
         TMekDWwEG/QZo1X5JFKyqchr4pza5vGYvUQHMlAjMXrDlEHXn9bFM/lHxgTKWeoytbiJ
         XGXMbkxqlXP0Y01Qo97oW/O+nZoQ8Ipvg/ykmwga9zk/BevcsKyBQfx0uwSw0+roPPI7
         dcFZOZAPXKv/qx8QaM6flwemTk7kvMPh0zNUQu2+qiJBleBwivKVTVxpDYR57f+Rfwv9
         2ZBSnHXYPnfEeERfWFxpRLV0EXhx0dS7CP7RNydlxtFF46bs+UXktefvw1t1fRRjMbLx
         o8Rg==
X-Forwarded-Encrypted: i=1; AHgh+RrJZ789DfsK0p4nu9c9QQ6RMHwEwyrImnwNj3kPrLkNCzqpOFv0sQdLMv8Lyo8r1N9GRCN1oqhFY2SAJYTrBzs=@vger.kernel.org
X-Gm-Message-State: AFuF++lWD+dwtF9vyQT54KZ+ZrWf5CvOmWdJFo0O8pVkR+jRrvqH2zvm
	z1YB6IlU8JJP96FnuLtbwUQGhNz7UYb2jvgbdmWzlP2402sXqbuOTFCZD0aaTJZgXDnM/p6n8Az
	z
X-Received: from plpn6.prod.google.com ([2002:a17:902:9686:b0:2d0:d8a:3ad7])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c48:b0:2d7:f0:896b
 with SMTP id d9443c01a7336-2d707b9cc1emr247925545ad.13.1787804253664; Wed, 26
 Aug 2026 21:17:33 -0700 (PDT)
Date: Thu, 27 Aug 2026 04:17:29 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827041732.188707-1-morbo@google.com>
Subject: [PATCH v3 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'struct fdtable' holds the file descriptor table information,
including the current file descriptor array 'fd' and its size 'max_fds'.
To harden the kernel against out-of-bounds accesses, we can annotate the
'fd' pointer field with the '__counted_by_ptr' attribute, referencing
'max_fds'.

The compiler uses the '__counted_by_ptr' attribute to track the
size of the memory allocated for the pointer field, enabling
runtime bounds checks under KASAN and fortified functions. There are
three places where a 'struct fdtable' is initialized, and in all of
them, 'max_fds' is set before the 'fd' pointer is accessed or assigned
in all allocation and initialization places.

No accesses to 'fd' occur before 'max_fds' is set, preventing any
potential runtime false-positives or panics due to uninitialized count
fields.

Assisted-by: Gemini:3.1-pro-preview
Signed-off-by: Bill Wendling <morbo@google.com>
---
v3 - Add version to the PATCH subject line
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: codemender-patching+linux@google.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/fdtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..3a5c88291125 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -25,7 +25,7 @@
 
 struct fdtable {
 	unsigned int max_fds;
-	struct file __rcu **fd;      /* current fd array */
+	struct file __rcu **fd __counted_by_ptr(max_fds);      /* current fd array */
 	unsigned long *close_on_exec;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
-- 
2.55.0.897.gb25b4bd76c-goog

