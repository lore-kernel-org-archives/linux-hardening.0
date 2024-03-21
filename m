Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39638134400
	for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051451; cv=none; b=Peol1q3wMFacbCV22nXLzEaXWZKj9rkRHunKvx60p+DguX6k8IT0kvfpB5me9V+49cfAAdSp/dWpF/KGkYtgS9aKgt2zW1HxKidbR5YWSgnO6fFrTj3ZWQgfSE5XsDeJXFwD5FqeTkb3unEAx0/v66Aq2X8erVHMREGtRiU4ORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051451; c=relaxed/simple;
	bh=S6RP6uWmLdlEXkKQny/wqkGVsqJcl1gAUGPqZ6bCYiM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jmkkvguXBnLdWKydN3+/6VkVbUsNZpTWtnxilrV2FVFmNZmj59ILyvXzdcK2AkMTGVRCoV62OYVJmxVqRlcO04elr4o8MKh8G192wjYTubbnBmXSO+ebo0E4R09BdeSsPv6Z/HEr4fCOHnXTcUWxdR8Jve8UxNfpx20Z9pQSZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9UBmgHd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9UBmgHd"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso2407321276.1
        for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711051449; x=1711656249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TCBKqThFKtYqhjiY4RMqU+IuZ1w6cv8EE0k+cJlDNnk=;
        b=t9UBmgHd/q5utv6qWZdP7eKjHmnVZeNPsHJMDwPYc4VzSykPCFSN7CTgGuWTVhHh+a
         aKYy3oo4FCmLVj+XEkYF67gVoWr+EGVpoDy9KDhU+KV1z8h0vybFigUzJVjuqcBcQVDi
         9UmqlsMy2iJRkUHNR8I9EdPTQxdvTqqtsFqsliQ7cuFrF7hYiNguxgHqbnR4oDDOHWj+
         FPJxBjH6zXp5rlwhy0fpxHw6jCbrbESsqvo5Ky7MZSvoDJz7FjZyvxMnyPP53mO65s3h
         AWBYcWP74+R9YGP7LJSclVyEpCt5zYHP+H8lumtOK1/34k4CFGACNJ5Ja89dzoaPxFV4
         U8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051449; x=1711656249;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCBKqThFKtYqhjiY4RMqU+IuZ1w6cv8EE0k+cJlDNnk=;
        b=K9pfl8LnEStHw6ibz/wTl7MOetKFjmd/SHwCQbZHYmxiBFZdpxVv3LQ0lVzMczU+Jf
         v66VDtC20FTPXx013x7/ycJiCpfqw1aLd5M+YvKpyUxkC0nrNDfuqKzQXU9TTACu+gYb
         i+AZtykEK+3wWcUGDuw6w5rk8J1MZ8VZH1c5fyLYc4TmTzK8JUR0Lc0BkqK9fanaqzxj
         1FpEEK7Hp8d5DG5wRWCW3j93D80/YNJKwLYC/9ktMp/yxYL4ZZgNYov17+OtV+Y1kv+I
         XPjjm1rH9fOdwgiV+bLP+p4IbfTgh1mUpIvCqXASmPA80Ogp1oeR0DGpRNh1U2V6nSul
         o6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/snHQwqGAw3LnmTtf4yS6NHIChnozEcvLE4hkJwxyWCgMKpvMS+CVHEcdWloIQbScG2m+9oLwrUwcDAxjkLaBah8Qt8SJ+e1DHKrnKkLq
X-Gm-Message-State: AOJu0Yy8p9sICKt3jIIECSgiRsffz4SQlEeGoNJGEUJ+EA3oBVCzPlyF
	R4ESNQhQhjyo0LnqlmXDRnt77JdDEw5WtKTiIxRwQ35vxT488ek/kq3nVezW5ijB0/JU6Jc3YJW
	hfV3qfvZqmeUzXYojNznyGg==
X-Google-Smtp-Source: AGHT+IE5VBN/+0LV/WPi06J13PSBodS0OdOu9MsbtLw0uhdLxrW4h4oP0M2VfdY/eM1a/8qsQNDCacEmRg4kGkc2ng==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2484:b0:dbd:b165:441 with
 SMTP id ds4-20020a056902248400b00dbdb1650441mr74857ybb.0.1711051449209; Thu,
 21 Mar 2024 13:04:09 -0700 (PDT)
Date: Thu, 21 Mar 2024 20:04:08 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALeS/GUC/4XNQQqDMBCF4avIrDslicVqV71HEWmTiQ5oEhKRi
 nj3pkLXZVb/LL63QaLIlOBWbBBp4cTe5VCnAvTwdD0hm9yghLqIUglMc3Q6rGgTvtjZae5otJ0
 1gTVqrFW+ylyrUgrIRohk+X34jzb3wGn2cT3mFvn9/mT5R14kSrTGkKp03dQN3Xvv+5HO2k/Q7 vv+AbD0yg3LAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711051448; l=1634;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=S6RP6uWmLdlEXkKQny/wqkGVsqJcl1gAUGPqZ6bCYiM=; b=ltUxZ2cpj94pnvyIBEzmfBEHQXiRRLeDTlLyWbffUabFpLWPDEAtsiKsRij39k9phe/VyFBxJ
 50r/4jHF4KlATUMzXLzQG9U+LPWH6633/Y5LV4uwnne1EeG7KX+npD1
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v2-1-0b6daec6cc56@google.com>
Subject: [PATCH v2] binfmt: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

There is a _nearly_ identical implementation of fill_psinfo present in
binfmt_elf.c -- except that one uses get_task_comm over strncpy(). Let's
mirror that in binfmt_elf_fdpic.c

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use get_task_comm (thanks Eric)
- Link to v1: https://lore.kernel.org/r/20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1920ed69279b..3314249e8674 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	get_task_comm(psinfo->pr_fname, p);
 
 	return 0;
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-fs-binfmt_elf_fdpic-c-828286d76310

Best regards,
--
Justin Stitt <justinstitt@google.com>

