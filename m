Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E532C46467
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Jan 2023 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjARUgB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjARUfl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Jan 2023 15:35:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22E5EF9F
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:35:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q64so244487pjq.4
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jan 2023 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GlL87WtXYWnFJQ82sP+jz4ggPtw5DmAgZ3Db5gKK8ZQ=;
        b=il1JhA1q5vUc1knM/UMIMPfx+vofRef7GCBMpvS6rXoUDeL/dRjy2yVdleC8GlWeGW
         Y+ZhKWCQknCzc81YNavYwUgFBYJIN03JZoiyLHO3fqcvqvBA/QliZfpeytI0SrxGJ3He
         308Zzo8NJoxbPUJbbPyiwU3dY4a3qKvEqPKQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlL87WtXYWnFJQ82sP+jz4ggPtw5DmAgZ3Db5gKK8ZQ=;
        b=GGGZQ1Uobvp8k/1oOhTxYR+8eLk6eN/PqOlMARj2SWK5E+U76P3oke0CicXx7K6tp3
         63xdrJQQHiuEXpLj3rAob9df+nMOka9yT8U0qcCkC9MfTAqXU6GSCj9wbIrhdi95R7bC
         iImV5TXXtbB52d3OLKzcFhQFoPvZU2RxFtRKlyLMXh5InREiNMrgBFF8M2P/99EGAniN
         pfcqjjSCUcqARQWXf9LxZzxtDaD2Jw9G1KmsVkey12ymahPiZbmiwHWpWCyw6Y6Y9cRW
         FO1EANY51vIIDkZQajlpsJ0wHLZGPXg+E/gpxTghIrbD0sYRS6LcegHa2kqAA1TBri35
         sLXQ==
X-Gm-Message-State: AFqh2kpYTpLUQUSLxRrv3PWH/eKZOT0xjq1JjrbeX/d4iM+BEh7O/9tF
        ouoO1qgy+JLCRaSViImPfVtiOQ==
X-Google-Smtp-Source: AMrXdXu9WhoZzCPIiQOj9shw/cxiZ4ZpEMcBtMO4PMbDGQ4H7FcViutbdRywGGFecx6Uavr02u50oA==
X-Received: by 2002:a17:90b:4d8d:b0:229:6b20:2424 with SMTP id oj13-20020a17090b4d8d00b002296b202424mr14337188pjb.11.1674074102970;
        Wed, 18 Jan 2023 12:35:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a098a00b002192db1f8e8sm1731691pjo.23.2023.01.18.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:35:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Michael Chan <michael.chan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] bnxt: Do not read past the end of test names
Date:   Wed, 18 Jan 2023 12:35:01 -0800
Message-Id: <20230118203457.never.612-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3175; h=from:subject:message-id; bh=IkmNRS1zkCvBM7XN/FXavkfZ6bNyrS/zqS25w8Li07Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjyFf0kq0GA2aFV5NYCC3EK0yZjk6LWynNzeC3CrF5 fcBYaeCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY8hX9AAKCRCJcvTf3G3AJpWMEA CXM2ReEF/7ofukRqiz4IlPcLfa+oDa70G9tS+v0Fgp2EspSNzb1mGUP8qFNZMlrvzQW65P5RZVE45G IrRE0GIex7Q2uZvzyNlnSmXw31fdLv3Oiprw55rTUdfIgTWgeVysuesyL+D1ssHir3FjLUQ7b9oppA zfIooJQ8I00GMl4gNzjWEOlkaIZ/N1EL+9bs1WZTlCKV8nTimXU1PDesVUa6I4tpFFJ6+xZ7N1Lv+X zSfz7+xhsTRngfwkeGHrGQBKKmwv3hZhYa6C3NCx4s8pXI8l0jWzn3F3a4ZqecFwCQkRyg4xOoPF62 ++Vs/eIWaA6e6qVLLb9Twv0pFIQGIkRVyMpYBaojZJn/Y+UNXaGnYr/2hc2p+5hZDcsgx9BbV2LJGt iscSm0yEpfCaLfQNZCv1tM3T/DtcmFJuiK7xNGzZ9VybDaW1afNOk30A8b+QqCh+aduOZQQvsmiavc +2M0m/wU3kG6VG6ZpS0hM/fNdmyLzquF3ehEiIhRGZP7/BY/f6Y5RFwKbFkfs5bt1PECJZ6s6d7p/Q lsESHHaKo1tf5Bdj/ZFnO679VnLhkh0EcrcEezmGkf71GxWFWxl62DHQvG6UwqljRXM5HOzK5/HrFL 69Wn2oMZVFicU9r38BiN86KLir3RMs2NbVIkEF+CZL1YVkMcwwl3C7r1jNWg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Test names were being concatenated based on a offset beyond the end of
the first name, which tripped the buffer overflow detection logic:

 detected buffer overflow in strnlen
 [...]
 Call Trace:
 bnxt_ethtool_init.cold+0x18/0x18

Refactor struct hwrm_selftest_qlist_output to use an actual array,
and adjust the concatenation to use snprintf() rather than a series of
strncat() calls.

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Link: https://lore.kernel.org/lkml/Y8F%2F1w1AZTvLglFX@x1-carbon/
Tested-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Fixes: eb51365846bc ("bnxt_en: Add basic ethtool -t selftest support.")
Cc: Michael Chan <michael.chan@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 ++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h     |  9 +--------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cbf17fcfb7ab..ec573127b707 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3969,7 +3969,7 @@ void bnxt_ethtool_init(struct bnxt *bp)
 		test_info->timeout = HWRM_CMD_TIMEOUT;
 	for (i = 0; i < bp->num_tests; i++) {
 		char *str = test_info->string[i];
-		char *fw_str = resp->test0_name + i * 32;
+		char *fw_str = resp->test_name[i];
 
 		if (i == BNXT_MACLPBK_TEST_IDX) {
 			strcpy(str, "Mac loopback test (offline)");
@@ -3980,14 +3980,9 @@ void bnxt_ethtool_init(struct bnxt *bp)
 		} else if (i == BNXT_IRQ_TEST_IDX) {
 			strcpy(str, "Interrupt_test (offline)");
 		} else {
-			strscpy(str, fw_str, ETH_GSTRING_LEN);
-			strncat(str, " test", ETH_GSTRING_LEN - strlen(str));
-			if (test_info->offline_mask & (1 << i))
-				strncat(str, " (offline)",
-					ETH_GSTRING_LEN - strlen(str));
-			else
-				strncat(str, " (online)",
-					ETH_GSTRING_LEN - strlen(str));
+			snprintf(str, ETH_GSTRING_LEN, "%s test (%s)",
+				 fw_str, test_info->offline_mask & (1 << i) ?
+					"offline" : "online");
 		}
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index 2686a714a59f..a5408879e077 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -10249,14 +10249,7 @@ struct hwrm_selftest_qlist_output {
 	u8	unused_0;
 	__le16	test_timeout;
 	u8	unused_1[2];
-	char	test0_name[32];
-	char	test1_name[32];
-	char	test2_name[32];
-	char	test3_name[32];
-	char	test4_name[32];
-	char	test5_name[32];
-	char	test6_name[32];
-	char	test7_name[32];
+	char	test_name[8][32];
 	u8	eyescope_target_BER_support;
 	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E8_SUPPORTED  0x0UL
 	#define SELFTEST_QLIST_RESP_EYESCOPE_TARGET_BER_SUPPORT_BER_1E9_SUPPORTED  0x1UL
-- 
2.34.1

