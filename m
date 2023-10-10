Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9648186C
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1mksrxoa"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBB091
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 13:53:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso8125045276.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696971185; x=1697575985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nzrS9yyU7Fxl+rEcRC2xGRsO34stFhcBXCNXeuzJc9Q=;
        b=1mksrxoazT1pzlHvN6L+lcXmg/Imy21GLAGQ04+Nx8DKk9suu1RKbM57IqXPm6bJqN
         LeJh1EHuF+9oNubAIcitTqnHQz4UVTNGVLkxkl3eXtEf2vVLShgooYeKnQ/BMeXKvX6a
         REW2ZGlAjncB+7tWENokHQu7IKN50q+8rPl31kj1KnH9HukCB3lYM6P5YysnroTYgNj8
         KbC/F6UmUiNn8VFUPyOTbIUpstD8u2aVOpELXPGODR0UpwLD+vbSGNuO5CXnqMHepTkA
         TUfC3v490losvT/9oeP99f0bZzRcoC0YuzGxeF64lTdwxfgobUVCWEQNUs7zpfxzbpNu
         bMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696971185; x=1697575985;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzrS9yyU7Fxl+rEcRC2xGRsO34stFhcBXCNXeuzJc9Q=;
        b=EJAlbyGqm3TzKnFSnk7KkNN/MR6eDTLpcdrvYAi1w5PEc8GMFP5IITo9dOcCKy+24o
         nuQcIzjHohYov8SPQ76EM4+WiWVgw6HrC9L/uAsC1uzRAD7cKJikyUoWXsTstOBlfBwf
         hIfH3KwfrSPsutdKaNW/p2ifZxLsiS7XMH906BQ3V6esry06tocKn3xHfG6aLiljIVS1
         W9ADfHikh1lEhy9z9BRkQGn1eUHJy7LyUSbL6u/CiVdNjTvho27PmgLKwulxkwJdrz6d
         borZ/pdu8p9yR8bCdu/Vl/TpIsVeXzv0Yj/BeeQRTg0dVTCo2Y1tMrikRk96mr790Fq+
         Xh7Q==
X-Gm-Message-State: AOJu0YzUXBVhtmMkhZJX68tm5y/Zontqj1jBTSuyEjWUZYAZ02GInDzY
	eXpEzmmtRpkJxtU870gs7kQ7kaMFUJNfOzsDoA==
X-Google-Smtp-Source: AGHT+IFEawv3/Q1aVdi1akfbJBKo97xvPPwQmp2OCE1jugDl7DSQ5964VSx1uuZU3vGzMYluwJTj8jYCJu4sipxh6g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:85:b0:d86:5644:5d12 with SMTP
 id h5-20020a056902008500b00d8656445d12mr360216ybs.4.1696971184847; Tue, 10
 Oct 2023 13:53:04 -0700 (PDT)
Date: Tue, 10 Oct 2023 20:53:00 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKu5JWUC/x2N0QrCMBAEf6XcswdJqhT8FRGxua09kBguoVRK/
 93Yl2HnZWejAlMUunYbGRYt+klN/KmjOD/TC6zSnIILvXfecamWYv6ymC6wwgmVUWfYf2iqeLO eHQ48RDJHFhmm4MYBchFqx9kw6XpEb/d9/wFd1mpihAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696971183; l=2113;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2n+/99+B9opeglb9JUPmq/bkJEGJQqpMF0ubyjWVGZk=; b=QW1y3WrgWpVSmEbu1+0vOfFFpmr1+pxJv4LGFzx7Dc1VvHcE4fwNoHfwpAzs/aoR0cBHfUaXB
 QqdiMRspgFuCva36ud5TV5Qm1njxFennsGdx1/XqmdCR/al80n4nf9s
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com>
Subject: [PATCH] i40e: use scnprintf over strncpy+strncat
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
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

Moreover, `strncat` shouldn't really be used either as per
fortify-string.h:
 * Do not use this function. While FORTIFY_SOURCE tries to avoid
 * read and write overflows, this is only possible when the sizes
 * of @p and @q are known to the compiler. Prefer building the
 * string with formatting, via scnprintf() or similar.

Instead, use `scnprintf` with "%s%s" format string. This code is now
more readable and robust.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/intel/i40e/i40e_ddp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 0e72abd178ae..ec25e4be250f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -438,10 +438,9 @@ int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash)
 		char profile_name[sizeof(I40E_DDP_PROFILE_PATH)
 				  + I40E_DDP_PROFILE_NAME_MAX];
 
-		profile_name[sizeof(profile_name) - 1] = 0;
-		strncpy(profile_name, I40E_DDP_PROFILE_PATH,
-			sizeof(profile_name) - 1);
-		strncat(profile_name, flash->data, I40E_DDP_PROFILE_NAME_MAX);
+		scnprintf(profile_name, sizeof(profile_name), "%s%s",
+			  I40E_DDP_PROFILE_PATH, flash->data);
+
 		/* Load DDP recipe. */
 		status = request_firmware(&ddp_config, profile_name,
 					  &netdev->dev);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-dd7f20b7ed5d

Best regards,
--
Justin Stitt <justinstitt@google.com>

