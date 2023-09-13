Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A217EE3F3F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Sep 2023 01:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjIMBKb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Sep 2023 21:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbjIMBK3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Sep 2023 21:10:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A991720
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 18:10:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e8e12df78so5428218276.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694567425; x=1695172225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iTSTWXZd+Qc8kQEsl400yBzqT1y2zESnQaxG1xsvJaA=;
        b=HCwHyOruBRi9VfQqcfOpXo7xNrWnwmyCNr+69VzYRHfu53Oqu222sFRxJaeAf5zaar
         QRiJyS+cyrpqjvL64JpvN7PK3mQOUN9eiNQ/q4QTxmzDCJbJI8Aw0fzltvWBBeK6/vEY
         PnBSvVkkTVd8Kx7b1tMfTp4+OJ1ZJ/bVuRGWaUt1+Ugwcf0KV0yLxS7dw6jOAVOBQpAl
         o66sziDimCcXpLuewjtT4wiXNzXCsPMwiDhcr98DRWYwc37d9PJ1e4wsizmRArCqXc6K
         gSYrgnAaRTu4vPnHQ4pxAejGUJ+b3p3TknDt0Mm92283Wc5vYdQ9LsT4eBP/ThVlC9kA
         whWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694567425; x=1695172225;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTSTWXZd+Qc8kQEsl400yBzqT1y2zESnQaxG1xsvJaA=;
        b=ORaH5MvR+MhHDBEOV3S5GvV15Kh/UcLoulaGbVuSrPiUtfNb/EepplxJtxU+cpj7on
         fCKbWiw6nL1BsCBW5r9Z98UEeZ9SB4S5ZuHuE/5RX2Rf+JcIm5qw1SBDkIkm1g1vCjWr
         dGMPDGgwL6YM1oIddQbemMngPmCGAnVuBOiy1QoULPguQZRGoh6syYDneSuomQg9auG9
         hd28/5EsEWpIO3u69IGfzBZhpGPMuvauYgayBgTlqL25gr9WE151JJF1odfS8wVxpWuG
         XRMca5UC0dY/yAgUBo+qp2sjFs+aO96xJXsSWxaL/eaMfvIgF9c4ryz6F7H9Y1ivNb82
         uJzQ==
X-Gm-Message-State: AOJu0YxBLudGPVVlhPrtq86FuAWqwYgy7vl4DQ8EFCVYpsrgLn6MgyBt
        p/Q3hYkTnxZDz95nc6YCN7uXLy/uLo47buQzrg==
X-Google-Smtp-Source: AGHT+IHukZFxy/YRGdSU7QLzuMJsFp1hyiIUjVxzrzp0P2y3eo8C8hd88kGz9ROOjKOkKNpxqDSw1PChJL8Vq8X8Dg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:341:0:b0:d08:ea77:52d4 with SMTP
 id 62-20020a250341000000b00d08ea7752d4mr21572ybd.12.1694567424762; Tue, 12
 Sep 2023 18:10:24 -0700 (PDT)
Date:   Wed, 13 Sep 2023 01:10:24 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP8LAWUC/x3MQQ5AMBBA0avIrE2iLQuuIhbaDmZTMoMQcXeN5
 Vv8/4CSMCl0xQNCJyuvKcOUBYRlTDMhx2ywlXVVaxzqLilsN0bhk0Qxjhf6QzHgZCw50ziqaw+ 534Qmvv53P7zvByxhMlhrAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694567423; l=1658;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=XVfRHzQuTBImCvXBurgaSYSr/Vjhen73sLf0hYhbk6Y=; b=Nx9E2Hb33C+dWpKRT232WwVU71QYhrtm0y8h6goM40QFhf4jRRWy8F4BVjnwubJR1AIB0krEx
 FTrQFMQi11GBea3GQmmqXOBkt1UaYJlHxwHtukgb+LQAlVQEJL2lTSt
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
Subject: [PATCH] dax: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

`dax_id->dev_name` is expected to be NUL-terminated and has been zero-allocated.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer. Moreover, due to
`dax_id` being zero-allocated the padding behavior of `strncpy` is not
needed and a simple 1:1 replacement of strncpy -> strscpy should
suffice.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0ee96e6fc426..1659b787b65f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -103,7 +103,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 		if (action == ID_ADD) {
 			dax_id = kzalloc(sizeof(*dax_id), GFP_KERNEL);
 			if (dax_id) {
-				strncpy(dax_id->dev_name, buf, DAX_NAME_LEN);
+				strscpy(dax_id->dev_name, buf, DAX_NAME_LEN);
 				list_add(&dax_id->list, &dax_drv->ids);
 			} else
 				rc = -ENOMEM;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-dax-bus-c-f12e3153e44b

Best regards,
--
Justin Stitt <justinstitt@google.com>

