Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA111C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 18:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8527A60ED4
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhJYSkR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:40:17 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32199 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhJYSkR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 14:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635187075; x=1666723075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RdxBijYOEPtiB6x6VjTfgg0W01+MwVCL+OhHPKYBiTw=;
  b=NkPPgovQEl910MjK5Wf9VPCJIAsSajPTD8osmdH5hLETARtfC7FG/1Yn
   zmaGX3MOLdahjWe/kJ4RK9lwxVqswy2b2Zmm/sgpBo+WeqpXWHbFeA8BP
   xqLZsfmL7HjazQvhTFstSk/o2mxlJPqkBy2P/WAUfocC3U4eALPB77sJm
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 11:37:54 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 11:37:54 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 11:37:53 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Kees Cook <keescook@chromium.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qian Cai" <quic_qiancai@quicinc.com>
Subject: [PATCH] fortify: Avoid shadowing previous locals
Date:   Mon, 25 Oct 2021 14:37:28 -0400
Message-ID: <20211025183728.181399-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

__compiletime_strlen macro expansion will shadow p_size and p_len local
variables. Just rename those in __compiletime_strlen.

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 include/linux/fortify-string.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index fdb0a74c9ca2..155c622e4f24 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -10,18 +10,18 @@ void __read_overflow(void) __compiletime_error("detected read beyond size of obj
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 
-#define __compiletime_strlen(p)				\
-({							\
-	unsigned char *__p = (unsigned char *)(p);      \
-	size_t ret = (size_t)-1;			\
-	size_t p_size = __builtin_object_size(p, 1);	\
-	if (p_size != (size_t)-1) {			\
-		size_t p_len = p_size - 1;		\
-		if (__builtin_constant_p(__p[p_len]) &&	\
-		    __p[p_len] == '\0')			\
-			ret = __builtin_strlen(__p);	\
-	}						\
-	ret;						\
+#define __compiletime_strlen(ptr)				\
+({								\
+	unsigned char *__ptr = (unsigned char *)(ptr);		\
+	size_t ret = (size_t)-1;				\
+	size_t ptr_size = __builtin_object_size(ptr, 1);	\
+	if (ptr_size != (size_t)-1) {				\
+		size_t ptr_len = ptr_size - 1;			\
+		if (__builtin_constant_p(__ptr[ptr_len]) &&	\
+		    __ptr[ptr_len] == '\0')			\
+			ret = __builtin_strlen(__ptr);		\
+	}							\
+	ret;							\
 })
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
-- 
2.30.2

