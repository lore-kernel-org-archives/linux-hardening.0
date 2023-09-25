Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7461079C
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 07:06:09 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3986B8
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 00:06:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8153284d6eso8833509276.3
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 00:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695625566; x=1696230366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qo6OQpCE04pWWcsadpkT68s/JdHKPH3Fz0vzZ7bj3RM=;
        b=U3tOSA50yRAnJsQQyEYyFvOuYdSiWyjubrEvwLOKX8h5cZ0MQ+YdZcBTgfTguIHbm2
         tm6AEAwZWLDP2kjjfKsIa/AfPHAgZvsFkjQPBHQLtJ8Z8fRvtuteiUPrCqYrmzU4iq8f
         48HJ/if7f7M5n1JJ3pyOwrntCATUc2X9EjhEDDP13jMiXcTKatjANPN7LBYBimWxb6Ur
         XYvzdxtZBS5765p8HmOVHkZl++iXGHTlOC0I1ofV+OygGmYtZtEcGiyUjMHaaDwaSaPi
         u1etatg1I2NpOlZvsq4zPyEAMZP4b0vnIR9/IKYGA48Ld87Ry+N5epmTiHzm7VBwDVqa
         XPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625566; x=1696230366;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qo6OQpCE04pWWcsadpkT68s/JdHKPH3Fz0vzZ7bj3RM=;
        b=csObN+DTh/32lEVlEhBWu7JJd56Xv/ahajab61/iUUpTV+C8cQT2PuqsxnOxzkqL09
         2IQ9QXfjjS6gFCG3/hUo9A3KCOU4N7dXABF6DOfRXLtWRskqRrLNzPk6Q/fYMkbD56OE
         aFZd0+skofEeKjpY+v3AL8DG9rrHk+Z0h7R0W5ALAwH8HGYdhqy7N9iagVeosUTWijam
         DfnLLj/yeMs3Q/bFwNyM1YcebTo963F17edGCDcBAvMiLrx7p3uxhykAuQs9K/9q3gWN
         3eSf2aMuca5yJ42rVl+watXqYPDJ66DZKP3ppbxCV5Sg/YpUVSBP1sqTnDUnjaRWz0gd
         A8IA==
X-Gm-Message-State: AOJu0Yww68oW5Lx9acTqMfIWH4Vibnc7uRw4v7TUuS4yPqdL3VNCYBip
	M6aXx9oNEptKQS9SMY9BM9X3BDely+OJKRGSoA==
X-Google-Smtp-Source: AGHT+IFL6RcLEbqF4P22oc8KJthtgJZ9I4gjnelF8DLVDruqhPbX4JycAc0dVu2g6PwkxJz9KG5Vnb8BbiVa784GOQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:abac:0:b0:d7a:c85c:725b with SMTP
 id v41-20020a25abac000000b00d7ac85c725bmr50744ybi.7.1695625565925; Mon, 25
 Sep 2023 00:06:05 -0700 (PDT)
Date: Mon, 25 Sep 2023 07:06:03 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFoxEWUC/x3NwQ6CMAyA4VchPdsEhwvMVzEe5lqwiYylRaIhv
 LuLx//y/TsYq7DBtdlBeROTJdc4nxpIz5gnRqHa4FrXtcF5tFVzKl8klY3VcCakGV/LhO9KWYm J8RGNMeHge98HCkN3GaGCRXmUz392ux/HD7dkJu58AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695625564; l=1779;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/oJWFABMzt7p+74DCkUM9oNwgT1wgj/iJtocYZ9umPE=; b=aJltci5reHJ/m8Bl/fua5gmnn3LHr/vrCoxC6FkKpLlZloqYPwsgN7m+WzQ/bTCl2oTwryUfE
 4vAxdwy5r4MB2/Vog4MR9HvDyl+0FGAW4WZIsC/HKj48oacyV+kqUry
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
Subject: [PATCH] dm log userspace: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`lc` is already zero-allocated:
|       lc = kzalloc(sizeof(*lc), GFP_KERNEL);
... as such, any future NUL-padding is superfluous.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Let's also go with the more idiomatic `dest, src, sizeof(dest)` pattern
for destination buffers that the compiler can calculate the size for.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/md/dm-log-userspace-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-log-userspace-base.c b/drivers/md/dm-log-userspace-base.c
index 5aace6ee6d47..7e4f27e86150 100644
--- a/drivers/md/dm-log-userspace-base.c
+++ b/drivers/md/dm-log-userspace-base.c
@@ -224,7 +224,7 @@ static int userspace_ctr(struct dm_dirty_log *log, struct dm_target *ti,
 
 	lc->usr_argc = argc;
 
-	strncpy(lc->uuid, argv[0], DM_UUID_LEN);
+	strscpy(lc->uuid, argv[0], sizeof(lc->uuid));
 	argc--;
 	argv++;
 	spin_lock_init(&lc->flush_lock);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-dm-log-userspace-base-c-857579d9834f

Best regards,
--
Justin Stitt <justinstitt@google.com>

