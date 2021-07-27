Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE0C19F39
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FAF60FA0
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 20:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhG0U7U (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jul 2021 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhG0U7N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A2C0617B1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jul 2021 13:59:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so6604123pjb.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jul 2021 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RbUTIPyfuQU3KvEwbLJbeU9iwD29PEErUjBhpe3f1nk=;
        b=GtYyBBbtPxLFI/WfuLaMvDoXxWyPmC0zNQzNuCkFG4NF0Vg9BHEps6UBdbqkXeNeF3
         TCLGbDASIg/2n9k5Rj/pRUe4EsWyA1ECIuxw4qfKiy8940LxdncMbz9exdPrnZjqZaTH
         WwI9EGrUEd5BHZVFi1kSv8N0o7CeawloSKwTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbUTIPyfuQU3KvEwbLJbeU9iwD29PEErUjBhpe3f1nk=;
        b=B5L60hq016Jfh4vPjbXrrAZEqhvVMLmA0c7Jnvzx1tqTueWxGBQUo1jKN5KxDrHHKr
         oyq76BsvZ1MdO6npJoT24RWnh0Tk5svwaPFDwgB8plYXqWpwd1C1pfh05FyhQdMpXb+x
         xLh/DERX0huJTcoDXHInzhAicztdScYah5hepFN15ZWUmZBiuHEZjskV3+LyHrrKPQFk
         AQoiMiKft7fp/RwyxDTx+9dpUegL5RyZhZc9bmr66KCXelESYwc0fxBQGwusFCdSVPqu
         06TrKgymdQ+rpzb3QRnvi94igKE/ehQ08vvErYzdtpHbfvzoI/LijiIn5vi0Aa00odIQ
         fBwg==
X-Gm-Message-State: AOAM531yUVSnn4fJM30XzEjPla8Go+lQf5/5rZKA9SJW5KfubHqOK8nW
        ofMbztKx3j+AHZCb46g3lb7F8g==
X-Google-Smtp-Source: ABdhPJy7+ciBuOtNN7d83O4Zu0WNd8ovLzhIYFckNLYZmMMBqTt0NJ7ydcv6U7b3s5X1OqBXomDXgw==
X-Received: by 2002:a63:4b20:: with SMTP id y32mr25282843pga.382.1627419549553;
        Tue, 27 Jul 2021 13:59:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n12sm5264202pgr.2.2021.07.27.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 14/64] libertas_tf: Use struct_group() for memcpy() region
Date:   Tue, 27 Jul 2021 13:58:05 -0700
Message-Id: <20210727205855.411487-15-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; h=from:subject; bh=aN5SRWSO0jhRLPZQ+xEXk4KxeSHDMCg25qp77Fv8hh8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHODeg0TURmPLYxq0mwE2hFWy/0AYNHuIKbeAQlp DWoEAlmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzgwAKCRCJcvTf3G3AJjDjEA CAOGWMwUe/TqhcNNpZ+tmgfq8Zfq/oBEgyGg6BbrnIuZqsMJLAnXFi1FFsi5XiWdBd9wW2z+pWLDsZ Qk5cK3uqkczBfKd+ThpeYFCNe/sGC223YyA78nUC5LdHCnah148wC6VuU4iYiPf187zVu1aljWgPkP QgNCXG2oB9NqtBh3pf0JmaHSqgeAqqpxLaVaFEmJDH7QkNmA17wGfU899KFpdb3HVZ8CkncDMoZhn1 DPXzHpS9vXg9vY+WPSF5Taeau8VEyUmFL+4Pc4A2M2LVWkpNBJCyJaADuQQg6QJdEmd9Qr6GMczp8B kuQcY9rOtl7uJhxsUbV+WyMYzIHXeJTGYueZa//yzwGhHGliQt3xlVGVyKk9A3pnvgh3jDJN8uYVaj b/rYpFLFcaBGhaT1yXcgkFAyKZpXO8Vh/Pi/2cwO1Z5UW4BAcnj54ZvKyiY4BZaN4jeZ47sDe9ccuy Y2ISwX8AwsLUH5I50e1AM5SHgOwd6aFVQVGJ0mAJspEUB2gl2BWkH9f+9sQ4HHmBKVKFcOmb1P4Ax/ PyqbaIoRlAj521CKzVKPR5wMiaW+0R2VneaPhPljqaAoY8fgIovvOjTe7GjzsFwSiv1CtakSIvU3Td UV1MTQ9MpUR6nFelPgLKjEpZMPkFtJ/MjnG8kchV6cXWqyz8+t5IN5yp45VQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field array bounds checking for memcpy(), memmove(), and memset(),
avoid intentionally writing across neighboring fields.

Use struct_group() in struct txpd around members tx_dest_addr_high
and tx_dest_addr_low so they can be referenced together. This will
allow memcpy() and sizeof() to more easily reason about sizes, improve
readability, and avoid future warnings about writing beyond the end
of tx_dest_addr_high.

"pahole" shows no size nor member offset changes to struct txpd.
"objdump -d" shows no object code changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/libertas_tf/libertas_tf.h | 10 ++++++----
 drivers/net/wireless/marvell/libertas_tf/main.c        |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
index 5d726545d987..b2af2ddb6bc4 100644
--- a/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
+++ b/drivers/net/wireless/marvell/libertas_tf/libertas_tf.h
@@ -268,10 +268,12 @@ struct txpd {
 	__le32 tx_packet_location;
 	/* Tx packet length */
 	__le16 tx_packet_length;
-	/* First 2 byte of destination MAC address */
-	u8 tx_dest_addr_high[2];
-	/* Last 4 byte of destination MAC address */
-	u8 tx_dest_addr_low[4];
+	struct_group(tx_dest_addr,
+		/* First 2 byte of destination MAC address */
+		u8 tx_dest_addr_high[2];
+		/* Last 4 byte of destination MAC address */
+		u8 tx_dest_addr_low[4];
+	);
 	/* Pkt Priority */
 	u8 priority;
 	/* Pkt Trasnit Power control */
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 71492211904b..02a1e1f547d8 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -232,7 +232,8 @@ static void lbtf_tx_work(struct work_struct *work)
 			     ieee80211_get_tx_rate(priv->hw, info)->hw_value);
 
 	/* copy destination address from 802.11 header */
-	memcpy(txpd->tx_dest_addr_high, skb->data + sizeof(struct txpd) + 4,
+	BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
+	memcpy(&txpd->tx_dest_addr, skb->data + sizeof(struct txpd) + 4,
 		ETH_ALEN);
 	txpd->tx_packet_length = cpu_to_le16(len);
 	txpd->tx_packet_location = cpu_to_le32(sizeof(struct txpd));
-- 
2.30.2

