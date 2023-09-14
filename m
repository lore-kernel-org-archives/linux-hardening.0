Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA845EEAA5D
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 18:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjINSUK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbjINSUH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 14:20:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C61FF9
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 11:20:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d802ecb5883so1574107276.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694715602; x=1695320402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tDCVePA3H/Y86jExEhecx21ZlR+zsTby9yjOcJea7c=;
        b=y4bVZvSQiOReVX7uln3vq6mtDU0S/N5cg/O+gj6aClRcmHGVMj/49ZoNvIBZq8Y7u6
         JgPVVLqLKWeGntJG60jwo0SFhhP52nQG+n9NnViawtaX9cfJPdgMvLZqcUUzXxhNexsX
         VATAVd5F+XkOFQ6acORyK95BclERXTGl3vU//U1JSGkIM1pdSsxCDDoNeCSonHhmzePd
         XaYAIaW9Hknsel04Sga/Qf6G+hFQ1q/MeLSrpBOQaKV8ZimNHYerf6GqwWMR3Sq180sH
         eu4xq9nD5u+S2j1LPZvWDb7iEqrxT2ovJfxbPLbPVRjeCpn/UIM7p6G6eNqqpYgZbqvd
         RC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715602; x=1695320402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tDCVePA3H/Y86jExEhecx21ZlR+zsTby9yjOcJea7c=;
        b=cThamIAYffQ91iEwEfzdZ8DHzRhNQc6nnrbJR7VXlUN6SE4P6boQp2rRk4pgC3qcWK
         zBdVyE4kYJIQ8M4agKdTkY+dBzX26GjnwLu+BKO0HH1M+C+WFsmCYrEbgwy8XCXpeoFB
         RXu0cGKCp/OOr0ZZivE8zHNCazGAdtohdukA7gYyJeAJOQwyMiY26cQP9uaYzxgZr1qB
         IQQ7+fZD6CwpcebH4Dg2fhYTDb5vR8yq7Jjk2dHJtF/SaJRabv0i9y08P0KPMQ2Vqger
         dUDjApVPCv46RpNq/2YJW3YpfWa6DdOqHTQJkh5H7Ey4zd3xR6hYpl8hpKyUuQTXfqKS
         k5nw==
X-Gm-Message-State: AOJu0YxwEnoVtkorRwgcpMNJwQC9NUdmi/EFOgENvGlb3yb9h+Oiuk5i
        nz+1UfiP/ywyRSkRgCBw1HE+L6PekwaI3WpGvA==
X-Google-Smtp-Source: AGHT+IGfxVOd75Rdpx2cardrEaNX99DCozdAd+Y1ohWSOUbn/k74RQ3w7NoBhkr2+YnX8BQUjGQoK7m2XXfE0ndaVg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:abaf:0:b0:d77:bcce:eb11 with SMTP
 id v44-20020a25abaf000000b00d77bcceeb11mr135467ybi.10.1694715601838; Thu, 14
 Sep 2023 11:20:01 -0700 (PDT)
Date:   Thu, 14 Sep 2023 18:20:01 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANBOA2UC/zWNQQrDMAwEvxJ0rsBO0oP7lVJKsORUhyhGTk1Ly
 N9jCj3NzmVnh8ImXODW7WBcpciqTfylg/iadGYUag696wcX/IhlM435i2RS2QrO+d32grzpVKX ++cxsaVkVIxK5cB2Dp0QM7TcbJ/n8mvfHcZxWgPpkgwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694715600; l=1992;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=SeuSKp981fs1thsOAOeS7EP9Ar4X1zn644iwNj5mbW0=; b=BWw2xpB4+Q0ImJXqA281cKFhurR2PsXPzdhCXMjsCWc7SsHnWYgeKtLVUn9zKZtXCCIxlq54x
 Lllt8bVOVZ2DwqP3B3RwgpiECJ3K+prluKT70wJhl50BC6TEYxoRCPO
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v1-1-3adc2d9bfc52@google.com>
Subject: [PATCH] drm/etnaviv: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Bo YU <tsu.yubo@gmail.com>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Bo YU <tsu.yubo@gmail.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Similar to [1] which was never picked up. Let's prefer strscpy to strlcpy, though

[1]: https://lore.kernel.org/all/20190328080918.9290-1-tsu.yubo@gmail.com/
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index bafdfe49c1d8..9e7bebcf24eb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -511,7 +511,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
 
 	domain->id = domain->iter;
 	domain->nr_signals = dom->nr_signals;
-	strncpy(domain->name, dom->name, sizeof(domain->name));
+	strscpy(domain->name, dom->name, sizeof(domain->name));
 
 	domain->iter++;
 	if (domain->iter == nr_domains)
@@ -540,7 +540,7 @@ int etnaviv_pm_query_sig(struct etnaviv_gpu *gpu,
 	sig = &dom->signal[signal->iter];
 
 	signal->id = signal->iter;
-	strncpy(signal->name, sig->name, sizeof(signal->name));
+	strscpy(signal->name, sig->name, sizeof(signal->name));
 
 	signal->iter++;
 	if (signal->iter == dom->nr_signals)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-dd095491dfde

Best regards,
--
Justin Stitt <justinstitt@google.com>

