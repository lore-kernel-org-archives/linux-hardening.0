Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E9EEEAA77
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 21:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjINVk4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINVkz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 17:40:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23095E7F
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 14:40:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5924b2aac52so19472577b3.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694727650; x=1695332450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yg6NbhhS6bNBw/im5wDGZLYsqmgcXnTvleG//pORS78=;
        b=0aVZQDcPxW9vqBUD5lokonAdN0omVw+fVFqi1FwSebHZ9fv9DT4cN0DrlwPZbsWqP+
         8N58N/u8KPo/w/ixO2UKpiw/80Yeh69t2zbBinK8YsbZHeM49GesrttM5d8WMuOxz33m
         eD+3PkxmcIvipq2dznue6VcQq4/C1/IHltWYaNTy3d/DbtUcVkgsXn9ArGuiJGq3Zg3j
         sFZrSlLCyvOLzJdPVNOsfebYE8tyBgRfym9YwYNfiLQx10mdU0AF1tmvyopUPJHIL7Pc
         5lt8lOO/CdqRjKmTUl6Uo46LVMg0noF1R6B3+hY8UCyZq1wQHfyf+53JmwEGZoNzHFWQ
         wdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694727650; x=1695332450;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yg6NbhhS6bNBw/im5wDGZLYsqmgcXnTvleG//pORS78=;
        b=fsE9tJYcmlNKgRviHUToAh4DbSCqTmgGHwGKwq5NoJDVwXxFNQb3QDwfVVFk9YL7zA
         +UEL8dKNk4ou1vRHo7Ns3EdkZFXTILDvFnGDUXP3iYLU9djLlKM5P2nl8zRP9dnJAGE8
         bon9m6i5LH27IN06Sa5ZwYVq/aROHVG7KWLeZJMFvXOrk2hQ2SiNGeMfcxRlKk26cWQ4
         xCDx7eaL/DsOALQxM8eTrR20D9quYHWm7US3imv+QWTgab3U20muiuVN1f01mQXsygSZ
         RYFDaPvyjvzxRP35jkkt0DmJsH8d1DUU1iJMzi0Gwh8FkXWGh/BxSh0rLQJcjtJgf9oY
         LDIQ==
X-Gm-Message-State: AOJu0YxW8Yomu6oRwdpo7oPbfblCwtTxitrmqC0KUxGW82j8Xbc9mOj5
        +AWR3buJNC1Oi95iXAIV6Wu3lCV7Aeg9QrpGyA==
X-Google-Smtp-Source: AGHT+IHIwo1uxVWE4qpMcXDY+I8QuHt0NGAH38LuWxAvqb8Hw+peynTElFPrZBbvCY+tn1X9WNxQ4+n8wAYBwLiIEw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:d8f:b0:59b:ea96:887f with
 SMTP id da15-20020a05690c0d8f00b0059bea96887fmr125429ywb.0.1694727650404;
 Thu, 14 Sep 2023 14:40:50 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:40:49 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOF9A2UC/x2Nyw6CMBAAf4Xs2U1oSwL4K8ZDLQtuTB/Z2ioh/
 LuNt5nLzAGZhCnDtTtAqHLmGJqoSwfuacNGyEtz0L02/awGzG8JLu24CFeSjFsqjT2GWCrZgqG +PLoohCuL/9gGDsdZaW0mMz1GDS2dhFb+/re3+3n+AGeHtrSGAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694727649; l=1779;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=veRS+F8fLCXOEB+IwiJ2Jr1EVTbkT3rdWvzzy6w4YBI=; b=mxTJZ6DGijn6/IfaObu6+S9iqoBOFL/VXV+IETu4YWEw2MiDJWtx0Af8fFwoaDQuBhONmsZIu
 cVfnCIxjq5WDEKO2xTXXXVEW93KmK0oIwx+SXuNXj091829J4/96aii
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
Subject: [PATCH] drm/nouveau/core: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

There is likely no bug in the current implementation due to the safeguard:
| 	cname[sizeof(cname) - 1] = '\0';
... however we can provide simpler and easier to understand code using
the newer (and recommended) `strscpy` api.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
index 91fb494d4009..374212da9e95 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
@@ -79,8 +79,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, const char *fwname, int ver,
 	int i;
 
 	/* Convert device name to lowercase */
-	strncpy(cname, device->chip->name, sizeof(cname));
-	cname[sizeof(cname) - 1] = '\0';
+	strscpy(cname, device->chip->name, sizeof(cname));
 	i = strlen(cname);
 	while (i) {
 		--i;

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-791223838b72

Best regards,
--
Justin Stitt <justinstitt@google.com>

