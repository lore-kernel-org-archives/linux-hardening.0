Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E1C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhLPXQP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhLPXQP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 18:16:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07610C061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 15:16:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so1283150edv.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 15:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OQcSOtUDZr36eXkj168CCgk1lBaxtE6+FTcnovNqvA=;
        b=FY0pLta2YZkT2ZPO2uz6PRWE7PBuYrX9xom65uCAvERjqagHux6JKHgex0BPX1AdVg
         bM/FCAbq9EDYL3VtvWV7QXkOKG2x/4hKpyn1Wj3tjjcXyfq7mkwwoQxC/Sp9Jme3Ctpi
         /Rqis2sB3n26jP5EsO5xZt9+iu05EgXsnW4XhESWzIpDrmQ/viXVQfmXRwJ4SkFFbt+I
         +rVcuDq92WGvVbsg86vXkucBdH5IpAho2FFrSXGMvCZNyyHvyydRJx16yazdw83Bo/D8
         RJeHkQvFxc9hGeT/A7cXr9u0dMPJPkJhI81rgg3gY0KJTgi0CTs0Vt9CMa/aQTCm1mIx
         ZaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OQcSOtUDZr36eXkj168CCgk1lBaxtE6+FTcnovNqvA=;
        b=U2ptBHixBTq8l2CqcnDHCETSJZXM/9thF0l+sdxlMxr22rDi3lZeTAqy93BK+jV9OB
         yFNsT2R9YvbAYe0R7AXeLmTfSzb9zcLKWgFioMIyHwka2odtNyE/r7hs6CeOdzlOk6iD
         XCInCKm+t7uqtnj1C7BplsaOa1tO94uxV3WHD3MYh4AktcyPR6pWComtgA2GrYcGNvYJ
         ewAVsLZF+tfaMI2kEPHY+VUZxS9sIDnT2oDhhiFCsHMwWu/3JK9ZSNUsKc12kz947Ctr
         YiBIM/i3+dT5q0MX8VbeM82Sj0bfpadcWz3/yAVQ7jqZMS/Uf/CTqXSl3duurzE7RIDz
         FHNw==
X-Gm-Message-State: AOAM533D226E8tdDR6TGv8mZOIN1uDaHN6zYqCRYZgyPHdkre7Rm6J6g
        p7fLCKRKklHokjHCETU0EJ83d/7ALljY+LEgfaU1buJi4g==
X-Google-Smtp-Source: ABdhPJxiKeupPnCazRa1rJGlt9LUg9Kr/aR2ZjUdDIzerxHazdmHyBwp1RfjmgI0jfxnwvzSn0QsDpxHm6dhXw6ApKQ=
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr298276ejc.12.1639696573588;
 Thu, 16 Dec 2021 15:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20211216020831.93674-1-xiujianfeng@huawei.com> <20211216020831.93674-2-xiujianfeng@huawei.com>
In-Reply-To: <20211216020831.93674-2-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Dec 2021 18:16:02 -0500
Message-ID: <CAHC9VhRsSydnMg3uYf9bjXtmP+zydTHxTJzNYygBREpN0s4Lmw@mail.gmail.com>
Subject: Fwd: [PATCH -next, v3 2/2] audit: replace zero-length array with
 flexible-array member
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, linux-audit@redhat.com
Cc:     linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Forwarding this to the linux-audit mailing list.

---------- Forwarded message ---------
From: Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Wed, Dec 15, 2021 at 9:08 PM
Subject: [PATCH -next, v3 2/2] audit: replace zero-length array with
flexible-array member
To: <paul@paul-moore.com>, <eparis@redhat.com>,
<keescook@chromium.org>, <gustavoars@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>


Zero-length arrays are deprecated and should be replaced with
flexible-array members.

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/uapi/linux/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9176a095fefc..8eda133ca4c1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -514,7 +514,7 @@ struct audit_rule_data {
        __u32           values[AUDIT_MAX_FIELDS];
        __u32           fieldflags[AUDIT_MAX_FIELDS];
        __u32           buflen; /* total length of string fields */
-       char            buf[0]; /* string fields buffer */
+       char            buf[];  /* string fields buffer */
 };

 #endif /* _UAPI_LINUX_AUDIT_H_ */
--
2.17.1
