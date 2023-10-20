Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51821DDC9
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/vrYWot"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49118D52
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:57:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso16540057b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697831821; x=1698436621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wsBMquxJoi1c1zfpSSx0JVGoWkpT5IvUUb/lk/u2m3c=;
        b=G/vrYWot0Ap1j5C/qKfbDn+3NuWsLdvK0/N6bpS82BQ0MH7QCleJi12x4BysFkJ35J
         /J+fy1tzOapgz+UMdHG07x5HcuJgXBsEG55b4kffnv6YWeGIUkByngLuBTNy3v6L1lyO
         csVY4hCt2HuhBPtSHUag0s1dp0ADtzTqaEXY4nBERC4rv8Xc5oslw8dJWvaF8Zh07NOC
         oYykc7cqztFqc5RP4WmKy3679z+U50UGaDLsl1kItPgBdcMJ23yWm0JQaoP6P3cTQZXB
         LQ0e1wubXqsdiwcmg3rwy8RopO4jEJ9LmAkglIFRuYP0BysH3M3nlVC+T0rbQkgW2QtM
         f8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831821; x=1698436621;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wsBMquxJoi1c1zfpSSx0JVGoWkpT5IvUUb/lk/u2m3c=;
        b=AoQQwNKw8eVrTLlhv2SzrNIA5x1mvt+1kX3sMKriNcHWkV4/+V74+X6Aq4ogCek4nJ
         KluDltHuDp59J7BRDZINoBp51VYspIepgplf/XyfJjEzmv95VE4SD796glatt2wEY9ys
         IwPnFpeQq8iVCkde24RKq6ApsNhyvwmUSBJ3ick9LZnDoow8IhkomTVRaGMoNmnWlHgT
         +SExCM4ArH8KrzosGZ2D2QkRtmPMhYBCyaE6Q2ef1woG8fEdnAnPrIx8Q7ymUAjjxTe1
         cLWQaImROZD1JHHiLXnPfZriZMKszTMmgkRWqY0tt+r7y8FTS3pAboIqboP2C2XxI8yY
         jfWA==
X-Gm-Message-State: AOJu0Yzn9ovXz3+KfNTGcpd5MsDcKzt1Rw+xsAU/PElxBMaSGU/ayTE4
	mDkHrzLLcQt5tGR9DaVE8mzi74AGsXOOH+h3Ng==
X-Google-Smtp-Source: AGHT+IFrR5weHYnJhXHl8/JRt5e8qQi0VlpIGDVGdSatvyjTGJkvEfVcFkmPQdAfE/uzJYFihYcWQwz7QbI5gJEhtw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c5cf:0:b0:d9c:a498:c1ef with SMTP
 id v198-20020a25c5cf000000b00d9ca498c1efmr57226ybe.9.1697831821508; Fri, 20
 Oct 2023 12:57:01 -0700 (PDT)
Date: Fri, 20 Oct 2023 19:56:59 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIrbMmUC/yWNwQqDMBAFf0X23IWYIGJ/pUgJ8dXuwRh2RVrEf
 2+ol4G5zBxkUIHRvTlIsYvJmqu0t4bSO+YZLFN18s6H1nnHtmlO5cuTyg411rLYfPGZVgUnRvC IfRhi6DuqoaJ4yec/eYzn+QNaVw6GdAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697831820; l=2022;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xbKvdfML9Lhch2EvPasPnGLhNiINuxHk8T8T1a03niU=; b=VN3iQrEIlCAFm02G2atoU3NZxN/Tsd8NY36yuCIPB9X7iXIHpap9Hd0s9G3zCWE+K8LLjH517
 6D7jh0mioyKCAZFt28Q+rD8EfJYtBJnDYNJPlagbe1/1tVg7JodQ6MT
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-rpmsg-rpmsg_core-c-v1-1-a86b7930c1cf@google.com>
Subject: [PATCH] rpmsg: core: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect chinfo.name to be NUL-terminated based on its usage with
strncmp():

rpmsg_core.c:
389: if (strncmp(chinfo->name, rpdev->id.name, RPMSG_NAME_SIZE))

Moreover, NUL-padding is not required as chinfo has stack default
initialized all fields to zero:

rpmsg_core.c:
539: struct rpmsg_channel_info chinfo = {};

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Also, favor the more idiomatic strscpy() usage of:
(dest, src, sizeof(dest)).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com/
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 32b550c91d9f..8abc7d022ff7 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -545,7 +545,7 @@ static int rpmsg_dev_probe(struct device *dev)
 		goto out;
 
 	if (rpdrv->callback) {
-		strncpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		strscpy(chinfo.name, rpdev->id.name, sizeof(chinfo.name));
 		chinfo.src = rpdev->src;
 		chinfo.dst = RPMSG_ADDR_ANY;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-rpmsg-rpmsg_core-c-e32ea739a375

Best regards,
--
Justin Stitt <justinstitt@google.com>

