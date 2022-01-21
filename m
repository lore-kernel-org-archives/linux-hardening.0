Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D382AC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 21 Jan 2022 07:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbiAUHjr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Jan 2022 02:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379113AbiAUHji (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Jan 2022 02:39:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5238EC061574
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 23:39:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id h13so7099510plf.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/KI/DDN8T1ayErpxnQiZZ4iJShjEoYH/kl3zkOkoNM=;
        b=NMy5ZakHpoNnM2tGCEPIZUk5eQaDDt7d6UOXJA9Bkot8hQ8cwZWFw7AHkVV7w45aj/
         fooKSMsoNkTHHIHkKH0gBuFJR16x7IRrQdjuhm91pTk/A5qOnoOf9sp84fc88zCe0sb5
         s/V282A3oyIuK5gVHLmNNOitYm0EbJ0ffVyPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/KI/DDN8T1ayErpxnQiZZ4iJShjEoYH/kl3zkOkoNM=;
        b=YFsHbs5k1hctqgihY56UChv6XU0AVM+OccNrCQBO8ikUptFfdFg/LCJ8653iSaHXkd
         iVEs60zFV5i2zz1F8lAKmjwYFI9VPN3iyXasA1ObysruGa56ty0gfxAwmznbUH+C+SE/
         c2MYzXl0p33+0DsqMYvX5QBw/YGFhTDfNzq2t1HnHsHdaIbJ9dtrJqrA7o2aGl+63HFP
         MDKzHVr0R74fEvkTEg6E8GkTfQoDclpTbpMPG2li89DzHAyDDei47oFHyS2DOj13XxyB
         sV96a/qw5x9ZE0MH1VzvwBezYr9ygnSNqkbIhBmPClcEx/ePSeKeiEbnv+4QcLBEYKIV
         zmCQ==
X-Gm-Message-State: AOAM533J3fnxNL0aIETreTNov8jezhZBQ/5wW7qhL+67ICWS12QFqX4v
        HBPNXwT3Vwu7f6qx9pnv2rvrHAOqq5UMFA==
X-Google-Smtp-Source: ABdhPJzfwDP5KCYaZ2avm4GFVowDxl+HQFPqbIp0EUSpzjd3VONNETepWQLeksdkGayD/hvQVtkD7w==
X-Received: by 2002:a17:902:6b4a:b0:149:7c73:bd6f with SMTP id g10-20020a1709026b4a00b001497c73bd6fmr2966661plt.46.1642750777816;
        Thu, 20 Jan 2022 23:39:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm6005968pfj.115.2022.01.20.23.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 23:39:37 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] mptcp: Use struct_group() to avoid cross-field memset()
Date:   Thu, 20 Jan 2022 23:39:35 -0800
Message-Id: <20220121073935.1154263-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; h=from:subject; bh=yGrVKJycM9qivlstRAt4EfHl5vdMltBdt/HqxajR6wA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh6mM3Kzvim73jJw1jchuqW5i5KKj0xFVS8nRZ1MEy YrQE6iOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYepjNwAKCRCJcvTf3G3AJmx1D/ 41qpIDOaMktPi/OXv2JS0l8Y6yahywC7M/IL2yWxJqReTyQ/TGSfDZIx+g5bsg4+CSBxEyqePyxc8I BOCEmGny2GqWbeixcRQpzODGJmidasyWIQJYr/tR4fJq/TzbkrUy8omwXlfDzWxV/f90ONw8I3ZsBv rAeik1f80B4OmkGlxhAIrihDRlxPLYdC9OAW7NKGMD+6TiK94xVMy2Md2soiznKz0zrINsMwykTi2r hjUEhUCo7zdwnew0qdn9EpMTWtRbV0X9jwaylle24dI/0xUuCnau2FYPd9CaArUKAGCwdBLNzwP05c oDcT4M5WF86HnonrnAPFmheRPU3DOKESv+0Tx0MdeAzTQdhMLoVl/rP13wvh9ivzZUxHWteCA0+WPf RrpLoCRwTxSfs6K90OQiO5HgJA0lIh2KE0EPxFxrNUWWkYo15prCPU73zqCNnj2jv+WEksf3X0LSXz upMs54qoPEovaR1/XGZ6ds0SCyPJuyQsmRj61gaHoHVS9/Y35/CfQQFuM1zYV0eStN4+Uy8yZWTpPx Hzr6CJE3nJv1JGfGjAKxLZpakcvUeH9VCxHy1/DoV+J4F4zFL5dcteTqQ2oGvPepXq61bNA5rQYa9w ZwAI/1E3+GIx2JA2dfkvqyJmBQAuQZLRaxX55hOCuJdCGHq8CxdP45lxz5Zg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() to capture the fields to be reset, so that memset()
can be appropriately bounds-checked by the compiler.

Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/mptcp/protocol.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0e6b42c76ea0..85317ce38e3f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,7 +408,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
 
-	char	reset_start[0];
+	struct_group(reset,
 
 	unsigned long avg_pacing_rate; /* protected by msk socket lock */
 	u64	local_key;
@@ -458,7 +458,7 @@ struct mptcp_subflow_context {
 
 	long	delegated_status;
 
-	char	reset_end[0];
+	);
 
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
@@ -494,7 +494,7 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 static inline void
 mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 {
-	memset(subflow->reset_start, 0, subflow->reset_end - subflow->reset_start);
+	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
 }
 
-- 
2.30.2

