Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED562C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 23:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhLPXPA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbhLPXPA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 18:15:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E41C061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 15:14:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b7so1183533edd.6
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHb0wzJReJcWzD8iPaUi6zn3oC1phPcKLFFNdASUvAs=;
        b=d2zt9L/kKB/aSUZvtpV+jjw9FzhfB2ZEmhCxEZo9bjegvjPDFr5PA3L0TVZQCsTisv
         9SatTHVprd+Vkrpdij/KLO4/lCa3EwDthHd1WjqWcENYUTro9Fd+xTjrpzRnk/NLSVYA
         WJDU4s7VVd2ye4sozyZ4z0+AuxiTTlxhMBK4M2WEqDGuOUDfHsCwAOpiNu7FDpCWdbYd
         oLdD9rD2Uu3YFX0n0QXLKKdAaVkd0Yp/J4ABKhpLyPWcoUjV4wD7wVLm/7JIut02l0+3
         H0bZrfb4RqBWrLQBvGcXmF32lCODeMkXZgnJ2aElwjwlO0FQkobC2C4WLqaUG0XA5Cg0
         1TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHb0wzJReJcWzD8iPaUi6zn3oC1phPcKLFFNdASUvAs=;
        b=HPCneE3X51RgmU6EheDNYmYl/LkHYzmuwTJgJw1HH3uqzfIqtZm82pc2rvDRJxghTL
         Ex8068+CHJpGxszXlxbW3HrGYBI3CObV26oDrmcK4VuQ31Q3rBM1Z3b/l66NGP+pFDLK
         5T/lb6fGG8+XxAGALbi2jtTBhuitCSno7B6nHmDMTFCB/HNjqqiZe11cfDfi0zAJVIL4
         UhirrpS1duG1edrBEYcaTrsuFyTAFNMbm1T7XD8gE8pCQaMoMPIm8y79w2F9hNbPkG3b
         t1rk8z/taEBPGMmZ0pidZkcY3aN7LLxQMJBa6V0L0nPgITd/8gvLUAbWkkgEbbpuHCIO
         KJXA==
X-Gm-Message-State: AOAM531q4C6YYq6iPVXnEmN02JW6YFYG5mGmGN7Q+SvxqNGz/7FL/OQj
        Tv9jBOtBNyyJfZhjZnyP2gQTmHHPmgyI09uPbrLygELXSA==
X-Google-Smtp-Source: ABdhPJz/1rx16cQtmiMuCYR3M34LNEDXzoPQwDR6GMNDf6kUp8LBGuj1WQmMZtpzCB9WW4JwuPmnMlihFllsQoyxMc4=
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr200017edd.213.1639696498414;
 Thu, 16 Dec 2021 15:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20211216020831.93674-1-xiujianfeng@huawei.com>
In-Reply-To: <20211216020831.93674-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Dec 2021 18:14:47 -0500
Message-ID: <CAHC9VhRgP3dSExpUkVkxN0Mi3KAXmuyr3TjT37YHs4Yqa9piFQ@mail.gmail.com>
Subject: Fwd: [PATCH -next, v3 1/2] audit: use struct_size() helper in audit_[send|make]_reply()
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
Subject: [PATCH -next, v3 1/2] audit: use struct_size() helper in
audit_[send|make]_reply()
To: <paul@paul-moore.com>, <eparis@redhat.com>,
<keescook@chromium.org>, <gustavoars@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>


Make use of struct_size() helper instead of an open-coded calculation.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.c       | 2 +-
 kernel/auditfilter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index f33028578c60..7778eca34837 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1459,7 +1459,7 @@ static int audit_receive_msg(struct sk_buff
*skb, struct nlmsghdr *nlh)
                        security_release_secctx(ctx, len);
                }
                audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
-                                sig_data, sizeof(*sig_data) + len);
+                                sig_data, struct_size(sig_data, ctx, len));
                kfree(sig_data);
                break;
        case AUDIT_TTY_GET: {
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 19352820b274..42d99896e7a6 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1092,7 +1092,7 @@ static void audit_list_rules(int seq, struct
sk_buff_head *q)
                                break;
                        skb = audit_make_reply(seq, AUDIT_LIST_RULES, 0, 1,
                                               data,
-                                              sizeof(*data) + data->buflen);
+                                              struct_size(data, buf,
data->buflen));
                        if (skb)
                                skb_queue_tail(q, skb);
                        kfree(data);
--
2.17.1
