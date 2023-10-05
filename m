Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749341764
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UHxsNuJ"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2882B6
	for <linux-hardening@vger.kernel.org>; Thu,  5 Oct 2023 14:05:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso2062248276.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Oct 2023 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696539944; x=1697144744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4y2YlrnXWnp/3hBKGWFmY8QqOEGdTjDuhv++ThsjEU=;
        b=3UHxsNuJw13MYYcb1v/IzDb9O+Ehjey4iE5+8L7c4DKUlVB59vKzKp7yRpDq2MORDy
         uhE9ga55yAyh0ZkC0+58TtAFMP94wBZd9phHO4SBc2KC3bYAncqR6aLIVwyKcrPxvKQv
         UQtq5gYNQFTQKdzRmWEEDiNhFqb+YndaqyqZzk589ePyq570td+Ur8WNiOYvMHWgO+Qh
         Pkb9DAAmCfJBB1WU7EsrJcmv3rMDJUp75MFmwXI/iNcNLdCji/gOyAgZkDdqw63uFqfb
         p2odL43ZiZ19uHM23jeqMWL4aQZ4EPoKAu0S6xiUYgknczYDwVHp5cCiSz2LfxZyco/9
         oXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696539944; x=1697144744;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4y2YlrnXWnp/3hBKGWFmY8QqOEGdTjDuhv++ThsjEU=;
        b=P2hSSCvHb141W6ghlMxqvQYyrEY4IHq5r3orRNexU7mS62fq/5hENqOf44iIowvJb9
         Y0GAEayUP92BA1SH+gULttHMiQvAtA+UHLauyHXr2+wn5h4nqqRmDNYpA/BAqPUq8DBz
         jTZ1p06cW2OaXdzbtYg9qIRY6sAn0zfXoUL4cfC0rZa4S+SFlqXK5YmVQP9XgxRTDJSL
         kwMqDtVqGyavE6a/7suwOEfMf7xfAcHzQb8c8bQLdu+aO2qurCgal1ifJoLBHFAEpwVH
         yzQpHYAa4O/BrJvmaSH1MnkEDqzUPXY0wxGj4DiRdly1GODqNEDZ+vsDyuTB7pcIXpLV
         iMyw==
X-Gm-Message-State: AOJu0YzybFJ5/aprg9Nz9dFDt78H9vrSEQRr4lOkGCDlJuZc9H3s5AmH
	oEUObh8LJDVAElZw7QkkvELzm1I/QU34VFZcMA==
X-Google-Smtp-Source: AGHT+IFYZDAsDI3aH1FkA57sI5MM9STwBtsstxHMNmmbHQo/N9JCli+azP76TBoo+x7ITXmPrGjh48fOOPj243Ue6Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:db48:0:b0:d7a:c85c:725b with SMTP
 id g69-20020a25db48000000b00d7ac85c725bmr87457ybf.7.1696539943849; Thu, 05
 Oct 2023 14:05:43 -0700 (PDT)
Date: Thu, 05 Oct 2023 21:05:42 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACYlH2UC/x2NywrDIBAAfyXsuQsaqdj+SinFx9rsRcMqISXk3
 2t7m7nMHNBImBrcpwOENm5cyxB9mSAuvrwJOQ2HWc1GK3XF1qXE9YNJeCNpWKgj9YXkB0Fq9Ik wFI8h+xfXiBGty9rcrM3GORjhVSjz/p8+nuf5BXYfPFuEAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696539942; l=1996;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=iWuTwxZczKzh+7gmgNXvK16vk7UgCuMWmTg1ny2oD8c=; b=YUlHgcN+oWStnkY0k8QsPE2sF9MJDlMlJwDVM6YDuXy2QvULO8Sa7bbF2I2FRmDvDk+53iYiN
 PyeP9/j4AHXAubuga/ZsL0+ZE9XOJq358MDHfpYVgcH2yjIPsxeX8yO
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v1-1-8dfd30123afc@google.com>
Subject: [PATCH] bna: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
`manufacturer`.

NUL-padding is not needed because bfa_ioc_get_adapter_manufacturer()'s
only caller passes `ad_attr` (which is from ioc_attr) which is then
memset to 0.
 bfa_nw_ioc_get_attr() ->
   bfa_ioc_get_adapter_attr() ->
     bfa_nw_ioc_get_attr() ->
       memset((void *)ioc_attr, 0, sizeof(struct bfa_ioc_attr));

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index b07522ac3e74..497cb65f2d06 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2839,7 +2839,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc *ioc, char *optrom_ver)
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strscpy(manufacturer, BFA_MFG_NAME, sizeof(manufacturer));
 }
 
 static void

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-68f13966f388

Best regards,
--
Justin Stitt <justinstitt@google.com>

