Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37080378D6B
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804167; cv=none; b=D9RZ6fvTvdGXvjcjUGiUCChgjJtYfTegZc5Cj3+l+NrH2u8g4NZKZw0j4rpXAJnwhK7RUH5zi1geJdJvPeBH38F4fmIHREQLU6Vr5nD6vwLuCTbX/bk6ohTmWYRA3PniJbbdighLvTxj3KJDUDOl5vNCA8eLjY4XajeU7cqG/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804167; c=relaxed/simple;
	bh=n+SjTCjuYTXl5KayVO6WXewqVZcudCQw53KO0rshhwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=q2uI1dq3LNr69XFXeWuqwyEb3QPGIbqwAU8HYk/lW+0nkPUEiSmMUHOJR44NZlVFfdl4wc8/cFLbzx8GNCDlBL9mtGmVWlP1JUY0nnqoQ/eAah6UfutSbgMLmm408ZJ53s/A6cPeIyt5/CEo29brSMB0G4pPkMcIe55HZKjCG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U08KaW0w; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U08KaW0w"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so2252751a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 21:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787804165; x=1788408965; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tC+1FnIjErVH9SYEpec69S04EuD4PIv2jo4qBhMrSCE=;
        b=U08KaW0wwvnTvFuZBryYuf/W1bOYZ57SKAe8ry/bh/G+00lvhaDPLgst970UQ/iOrD
         Q0M3LFBVp1L0fPwPyWkTaWRLxdvK4dEvgRt5RgeZIesQVnfxLShUQCFxghrX49nVCPhg
         +IyNQlUYfkHJqdP3BrmgkkuKExUt0t4woFLtZGSz03daXughR62eHJardSqq9Ue6D3QQ
         ra0fbKnYxAuuxDKPuRYCstIeEWncLweAOUn/M3KKCMDKF0FHgkyguATjm+FpEPGuIkQ0
         5B8DMJqzqFAff5hnq3NwIVqj2wgEz3XHS/JY8Zw/8R4qEcY+bamCnaf9e85DpMwRyHff
         zlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804165; x=1788408965;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tC+1FnIjErVH9SYEpec69S04EuD4PIv2jo4qBhMrSCE=;
        b=sXO9f+t7uASVBXCiqQD5+o9uwEWmLDR0YM58OQvxjMbdruyBVcb+nfdzR1m8NUTEXO
         0Yodknzq7mz6QUd+a5nxI3Anz6CSzqDW9YdlvI9VctwFc9kuhqMr5xVqpYtu6jKdmVQE
         vFEgYqWL4iEEuDtmSMqg50UrZlNBO8FpRFaXXcDbHI8ain+LvnSJy5RJVGYuiM5I8a6f
         BY/bLMuo1dGeKrZTuMUQNRHBVpmJJEys4CZ+JfbGLRu4PQhSoDZ9AqLOctnMDCVv40gu
         yxiy2ZQ8/3D1od1M5nEjjkVJMxmqQ7rRJDFdA2NolWg/+R5Pl+Lnqgci6AF0sseW9q0P
         Posg==
X-Forwarded-Encrypted: i=1; AHgh+RrBvLD7Ln7dZtDjFq2BGyfbHat4I1lxBAefOLBjdHew9hsAk7P/pksli+QkIdcsEJuymh84saTfG/ayfoz9CIk=@vger.kernel.org
X-Gm-Message-State: AFuF++lXtoWLmb5rF9qrpKcUWsEbW/mNYSGna/qWGmImjrZ0YnMWnMB3
	kfPH1v0jsoyjvorFoKNdgpvEqKaQ+Oav/8DtDg9MuW3cnx7whW2Djv30Xxv6D1SiuWQde9xEc8x
	9
X-Received: from pfblb17.prod.google.com ([2002:a05:6a00:4f11:b0:84a:1bf6:cb4a])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8005:b0:848:76c4:fba9
 with SMTP id d2e1a72fcca58-8537279f105mr23418409b3a.7.1787804165145; Wed, 26
 Aug 2026 21:16:05 -0700 (PDT)
Date: Thu, 27 Aug 2026 04:15:55 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827041601.187608-1-morbo@google.com>
Subject: [PATCH 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
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

