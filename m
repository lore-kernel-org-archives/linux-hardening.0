Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6874EC433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  7 Dec 2021 06:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhLGGft (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 7 Dec 2021 01:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbhLGGfs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 7 Dec 2021 01:35:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367D6C0611F7
        for <linux-hardening@vger.kernel.org>; Mon,  6 Dec 2021 22:32:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so1131689pjb.5
        for <linux-hardening@vger.kernel.org>; Mon, 06 Dec 2021 22:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cods9WyaktA6BF6JbbixG/DZf7V5gCMolIBwnRIBsoA=;
        b=MMD41CtxbBzB9YAAnCbHieIqVxNNB7RXyBlaQGRrHSeyJzYxkZgp4SmWmDhqYNerxg
         MprUuKqQAdg87VjPx7xnn5SuRVIZ4iMi7flp+RPD7CksU6Va8ZAaqdNdm1cV5SSwSrLo
         tc/PwmOJa5JD+CExp35BTRQAXpR6U5Ek4JuVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cods9WyaktA6BF6JbbixG/DZf7V5gCMolIBwnRIBsoA=;
        b=jCk2gZOLvZcJQ1o4SRcG5dg0L1lFxemwvqJ6nGNqpT06+SxUw5U4kutCW4zFTHDzEc
         aZYY0/EXWZYsraWXGE9xHGs5JDy/m4CM1V/WptJEW3Eap16kDaeEh5Xx+BGhTAmVaZya
         M9ORfLisaH/LGIYyLySSMnIyxzAah7QOf0maFHLxV5ar8MmjLENdDVbT/Y04anIpRZTU
         ErXc66xgb0HqQ6m58WxOqexc0YOohNKQmetqmEx0o/5BEJMtcgB/EaO2ZDZlGMv8E1li
         rE1QzZ2vfkOVOkTEO9al4gs3zfdViU2F8I3s+EtqRt8SuikgTdeRL5RURcZoBIz23ot6
         NHzg==
X-Gm-Message-State: AOAM5300g/ynIpmO9uayGv03koPtmHWuXFNE2n5ckgdfIqmWG9u0Up4T
        DwD7p+caJtSsIEqXF9ZxFTJgQw==
X-Google-Smtp-Source: ABdhPJyp1UxglPEqmBhAA0mHlqJZn71XaypcbZcnECd4iiPFthtfrShdVlCTDQxxiafiXeZrE7GRMg==
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr4322891pjb.179.1638858738693;
        Mon, 06 Dec 2021 22:32:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm15487110pfi.154.2021.12.06.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 22:32:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] hv_sock: Extract hvs_send_data() helper that takes only header
Date:   Mon,  6 Dec 2021 22:32:17 -0800
Message-Id: <20211207063217.2591451-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572; h=from:subject; bh=48lY+W7yxU1t+Az6SdjP5/a959EClqgZo8+U7ONH7iw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhrv/woEdF1Rs69O+MuGiyQRAPdwunWIkJe1PXhimt WEGXogyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYa7/8AAKCRCJcvTf3G3AJoBLD/ 0ULE05fML+vI6+/LCIG9Ks4prnpoPtcUsW4eIvsa59c015zp36rvqreqIxD63DBa64rs8r4MgskEc9 WFVuih/7jWmW9P0kl6Wpb1qpRJxTTg85WPn53QptwU4zIbYVjo8u3om7OU8/ZSzD0oCDo7QRQDR8sq vu1hEZ6KZRPmdx0RguKp1+TgiUdYRDRRVcSAB977TwcutxZ3U1JNZy53y+ze3DanRCy5HW+qNFly9D ZyYFmUZxGcMNc+4v5B36dIKkRmJrHLZK5xrbUnrpxpCC/iXfR2DsJeHQVFrc7ejRYe0qjtSb2TWZlf 2Hondoefq+t1yBc0iL1SZBn8y/V9E6Qy0cWhF8zO89pX96X+hAZzEJKceL1hD/r1nNbfwlJl4I9t4F Cwu1o1EQSktmt/Cs2kUNx9HsTUiGBY3IaQ2EwDDiLHSJZRFCty/eOH7zKT1BDwNmIdUH0wytq+dma+ 1w+fUpV+dA3wpd+XqK/IgwIY5xKby/V+mUZVhz4GT+WQaRib/yeVFrVRdy3iue/rpBnsqq31xiXOdi WN3gjAK/DLqn0KCr9zObiXuiRdVbWoIVXXFsrbEOmiMZM+mC9VfVRNAIjxRfPhWoYSaEhsxfNjQViZ fPHEZ/ZDNNJ9EGqpcRzaJIuGKy++T3K+6nLXpcl7XsjqOZ7XQCiuvWaa0Wsw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building under -Warray-bounds, the compiler is especially
conservative when faced with casts from a smaller object to a larger
object. While this has found many real bugs, there are some cases that
are currently false positives (like here). With this as one of the last
few instances of the warning in the kernel before -Warray-bounds can be
enabled globally, rearrange the functions so that there is a header-only
version of hvs_send_data(). Silences this warning:

net/vmw_vsock/hyperv_transport.c: In function 'hvs_shutdown_lock_held.constprop':
net/vmw_vsock/hyperv_transport.c:231:32: warning: array subscript 'struct hvs_send_buf[0]' is partly outside array bounds of 'struct vmpipe_proto_header[1]' [-Warray-bounds]
  231 |         send_buf->hdr.pkt_type = 1;
      |         ~~~~~~~~~~~~~~~~~~~~~~~^~~
net/vmw_vsock/hyperv_transport.c:465:36: note: while referencing 'hdr'
  465 |         struct vmpipe_proto_header hdr;
      |                                    ^~~

This change results in no executable instruction differences.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/vmw_vsock/hyperv_transport.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 19189cf30a72..e111e13b6660 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -225,14 +225,20 @@ static size_t hvs_channel_writable_bytes(struct vmbus_channel *chan)
 	return round_down(ret, 8);
 }
 
+static int __hvs_send_data(struct vmbus_channel *chan,
+			   struct vmpipe_proto_header *hdr,
+			   size_t to_write)
+{
+	hdr->pkt_type = 1;
+	hdr->data_size = to_write;
+	return vmbus_sendpacket(chan, hdr, sizeof(*hdr) + to_write,
+				0, VM_PKT_DATA_INBAND, 0);
+}
+
 static int hvs_send_data(struct vmbus_channel *chan,
 			 struct hvs_send_buf *send_buf, size_t to_write)
 {
-	send_buf->hdr.pkt_type = 1;
-	send_buf->hdr.data_size = to_write;
-	return vmbus_sendpacket(chan, &send_buf->hdr,
-				sizeof(send_buf->hdr) + to_write,
-				0, VM_PKT_DATA_INBAND, 0);
+	return __hvs_send_data(chan, &send_buf->hdr, to_write);
 }
 
 static void hvs_channel_cb(void *ctx)
@@ -468,7 +474,7 @@ static void hvs_shutdown_lock_held(struct hvsock *hvs, int mode)
 		return;
 
 	/* It can't fail: see hvs_channel_writable_bytes(). */
-	(void)hvs_send_data(hvs->chan, (struct hvs_send_buf *)&hdr, 0);
+	(void)__hvs_send_data(hvs->chan, &hdr, 0);
 	hvs->fin_sent = true;
 }
 
-- 
2.30.2

