Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CC85C73
	for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977232; cv=none; b=nMl7nUm/B361SDdz+csPtOKPx+lN1Ng5VCl/VJYVxmAPGXafTCtf4OGCOfvPSi6XXMbmQFthmC0wv3Yh1B8HCjM4Hqe0X0yZnKIQVzKGWhI/MxklQZw33VPpbJwUQFn13DVK+XoWhvrwgx3YsbsescBSCRgj2d7AMz9d+y7qDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977232; c=relaxed/simple;
	bh=vYKzzse+hsxrCLrxZ00MkHClgVeFa8yh0cRD/lbNsc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OTAEe14SyK5k4qBfs5PwzueP51KEVl/O52y3YYawltdfEf6lX+MzETjBL6kO2D7HRVKSurkFUR91SQ1sx2aGb/Qt8tQ/pzZqWwCWAQVCdD3pUy3f8HaZqqKfAs12S1Q9aPUiy3oRlGiJKBcWBViRkPrQNbxE+bPGVTgVZa8Q2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbOu97p1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbOu97p1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd944567b6cso453285276.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710977230; x=1711582030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AKP8GbnuNaUxisIiiCc/HvCd/U76hXx8XgrXiVPpGRg=;
        b=mbOu97p1p0S1VxmokEH49hJg04X4G+yTVss3asgF3kK00Lgs++BSGfWPBfLv4dI/LV
         zuNOJJyRCBjZa5bWAqepwFZdKx4zCLUraCx8Vl1Bvlu6u7M8voEv8pR1xnkGCF8dMOLU
         xWk5oSJHGOzaKqm9ud+vqAgNuqImPjXtJ9bjyVeElFeyGAsptkQe/EWUc5NOlhGJTr7O
         E5MusuGm9EaBtmYWUJAMFj86iO4PDgUnzaFCGt3EAUKsbBFjQ5sCnRvPpg2A8dL1P5pq
         NVXvBccnZyusXkJMMm4HqQiPSF+2eQoaEaaG2PDDw6LZ20RvC6e71QXGql9yBrIpI8Iv
         Bphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977230; x=1711582030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKP8GbnuNaUxisIiiCc/HvCd/U76hXx8XgrXiVPpGRg=;
        b=MuZICfSmfhBwYVPvXl+FlT4VM3fl+iDFzgdVlx3o7BC8tBXQm0pWHzFKaRqOKX+2bT
         GsDLUdXOZKcbKxJQpAhSqcMmqFg2QzdNDSkukmDy2pOmSz5RoLWt3+AV172l3D+/WDRS
         D77Y6kCiutVZGIBaQhrFjZyCwe98ho5NZbIZ0aaIazgN3GsrNnyDS5dHXx5/DWCSeQw+
         U3n8UVSCqI8OgGK0JupIE2J1Hvj7o31ydOLVo0gxaRqtuTKJXFunwmk0MAy6SaBLKF8P
         WP7AMUhVLr6g0iYb1oruRi8+ARlCWOoxy4nRj2QgIjTJ/o68s0YZaeGhD0g9BGckUTCw
         b35g==
X-Forwarded-Encrypted: i=1; AJvYcCXOoPlhx03g0d7dz++5mgVoo0FKwF7xwXBqd6GrRuG31NS8mlUWQ6CV4+nNPs1P/jwvi8uARoHmmoYcSYUrkpc7l9adOTv0Wzjcxjdoy8xo
X-Gm-Message-State: AOJu0Yyv5dSteUx88bi6qTieyOWP5KKU388LBMJMd2j9PuNzmQM8Q83W
	j0bvHZ6povrwWIkXUDyqQ5V980bjgu3pf5fQAe5X9wIvCpIRkkiF5kjfm4mOqdQLHmkwl5qxFBE
	CEyZn8GhCP2Vfa9BptEVq3Q==
X-Google-Smtp-Source: AGHT+IEuSmkCZM+fjgO3sC5hsajCVr+cxjjEsGe7D1X4qeRsyT+mZfU7+wBSjMa/445hoCIZHlZQh85KK91nKegMSg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:2305:b0:dc6:b768:2994 with
 SMTP id do5-20020a056902230500b00dc6b7682994mr918835ybb.0.1710977229829; Wed,
 20 Mar 2024 16:27:09 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:27:09 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMxw+2UC/x3NQQ6CQAxG4auQrm0yDGCCVzEuxlK0mwH/kgmGc
 HcnLr/Newe5wtTp1hwELea25Ir20pC8U34p21RNMcQ+dDGwb8iyfnmCFYVzMWycBJltgX5YeBz bLg1y1ficqXZW6Gz7/3F/nOcPhdn3TnMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710977229; l=2043;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=vYKzzse+hsxrCLrxZ00MkHClgVeFa8yh0cRD/lbNsc0=; b=JC/x3li3W2pIluLdOmvQqlnTTHJNWulUTgz/kp1a57t3nVdHtwUTqdlFRVQV3tPE7LOa++mOB
 w6h6FYYjPdHD9R8HrU1SqQwcvixMX5Pj/cSMx/32f0OMzmjUZDgR8Jf
X-Mailer: b4 0.12.3
Message-ID: <20240320-strncpy-drivers-virt-acrn-ioreq-c-v1-1-db6996770341@google.com>
Subject: [PATCH] virt: acrn: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Fei Li <fei1.li@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We can see that client->name should be NUL-terminated based on its usage
with a %s C-string format specifier.
|	client->thread = kthread_run(ioreq_task, client, "VM%u-%s",
|					client->vm->vmid, client->name);

NUL-padding is not required as client is already zero-allocated:
|	client = kzalloc(sizeof(*client), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Note that this patch relies on the _new_ 2-argument version of strscpy()
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/virt/acrn/ioreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index 29e1ef1915fd..e94358239a4b 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -433,7 +433,7 @@ struct acrn_ioreq_client *acrn_ioreq_client_create(struct acrn_vm *vm,
 	client->priv = priv;
 	client->is_default = is_default;
 	if (name)
-		strncpy(client->name, name, sizeof(client->name) - 1);
+		strscpy(client->name, name);
 	rwlock_init(&client->range_lock);
 	INIT_LIST_HEAD(&client->range_list);
 	init_waitqueue_head(&client->wq);

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-drivers-virt-acrn-ioreq-c-9913a5c6e2bf

Best regards,
--
Justin Stitt <justinstitt@google.com>

