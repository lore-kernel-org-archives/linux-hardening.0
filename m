Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B8C4320A
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB561242
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhHVH5h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVH5h (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:57:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C3FC06175F
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e15so8369749plh.8
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvdBkUpptZhXKvwrMm3zs3qjx3Jw+Diy7BkjH6c2x9o=;
        b=fg7ZhYLvxUugb8iVfWfC92pGeyt+/r98pwZwtJjW7D5m9+btWV+mAQjVNa2DeXw4uZ
         TBCIVYhAM3WflYWa48L2s/VrNdwxu7CILWfDneyuRYST6Ezk3jJitCQAyBVZW7Ex0udr
         QdVPoFRKhE/kfvccRSPKXi6X4fAb/9Tcqr5Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvdBkUpptZhXKvwrMm3zs3qjx3Jw+Diy7BkjH6c2x9o=;
        b=JQNyKDabYxKkPYwlDB6mMouqCsFvmJEM9NRt/9IkcTr2uxMNRo/FJNVCCPSfDIBwf+
         rsT9zIeCVrcSy5Gvb37n3AusTh8lI3YTpPqAvw5URUU5w+YkDZv8xKnaTZjnB5IQGPqZ
         A/ADvg2VfLLXi1rzdceiYDMdiKBkxUPM7BOQzNmhU0MFfmNDiRSTarVRR8wB/1CVbZ10
         KWMQUWfhzPpP82wsFyYrU922JDj2sY+ivZfsWsGFBBJXa6A3U5LCoCTPPIpPrwx08/jS
         GH/FocVLOA24y9NxxStcxozDYFOnRvCpIX77XFpooqFYPebozm5k2raKTj7WIq6x4mj6
         Zk4Q==
X-Gm-Message-State: AOAM5314TTF/QPTJ4lcQtZiJKHhnORQYH1fhFm81K2p69aZZX05BHRhF
        tKbdv0EtfcXG5qIbiZcZB5SQJQ==
X-Google-Smtp-Source: ABdhPJz1nXhyYemKrw+6kLeSH+jeEvo0I7wavFPKVlcHjoh7EMzwLenW7bCSCiP8kEkvHvQIIQc1kg==
X-Received: by 2002:a17:902:d2cd:b0:130:a7b7:3c8f with SMTP id n13-20020a170902d2cd00b00130a7b73c8fmr10580004plc.46.1629619016141;
        Sun, 22 Aug 2021 00:56:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y62sm11996200pfg.88.2021.08.22.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:56:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 22/25] string.h: Introduce memset_after() for wiping trailing members/padding
Date:   Sun, 22 Aug 2021 00:51:19 -0700
Message-Id: <20210822075122.864511-23-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2741; h=from:subject; bh=E6gFtKPMaqY94NYGTcjgqzMn4Zg8efYnWFddeRIDocU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH50IyFEulz6vf4MWlQ/Ezu82EvPp7pmwWKKNPw FQi+vpGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB+QAKCRCJcvTf3G3AJh3rEA CrFF/z6kOuE4E1nPr3TROjLRJGQjTLaabDuXR/aIm4UQKeKkoTwGA2+A4SqjMTq/+P5Ys7g2X4LT/W Z2l1Vk9U0SrRQPJl7vZYRJ+9O4qUs3Kf8Ny2bIVgxeZT2N0blFHjxagjdD8vAzrY3b1LssVIU5HLiQ CkTZwHf1BnUGyXWqlHau1Vtb3xdCMueRk/f0+dyoPkbCq9ZiKc0XgtZ5MOlzVE66BQLezYe3VZxDUH aDeSYCo7PVgr9pV36o86mUKSUXJWTQ74tdMd1P2VvIhlNEI+vIzBXIjvq2l/IC+Ia2/oqyD/PBLJJk RoXa16m2Lr5ydwZuU+5qMNSo8Cz5OcHc0iQS5x/zK4L2Y6i84HtrS2Ja/RoBQ4SawOGvwkqQMDWUhM tML3SJfr/6qBoVbM7j7oTKiWGwFiZkpavW0iPpwrFqTjTonEi3vdUzO/ahwHLs5uU8gEPP+nPovcfo wZ9AAvOWdDZeSU8i0x0zCI2Hiu5fGcmVETpSSG/F1WqZuQHz8KRI4ndkMy5COuwjY5DADDoBVXuei2 GDhIxOMqkO2jtycMsYYhPX4LOTHskAA/ikwrRY9YVN753cwclPR1h9ULCg29KZIvJfiQ4oFMPNQ49S SyWtCljmqAu2E43Fu6xl6RJf6H3Wn1D9Ei2FNzhed+0om1vGjS5eu9TtBUHg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

A common idiom in kernel code is to wipe the contents of a structure
after a given member. This is especially useful in places where there is
trailing padding. These open-coded cases are usually difficult to read
and very sensitive to struct layout changes. Introduce a new helper,
memset_after() that takes the target struct instance, the byte to write,
and the member name after which the zeroing should start.

Additionally adds memset_startat() for wiping trailing members _starting_
at a specific member instead of after a member, which is more readable
in certain circumstances, but doesn't include any preceding padding.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 17 +++++++++++++++++
 lib/test_memcpy.c      | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9473f81b9db2..d593de2635ba 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -271,6 +271,23 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+/**
+ * memset_after - Set a value after a struct member to the end of a struct
+ *
+ * @obj: Address of target struct instance
+ * @v: Byte value to repeatedly write
+ * @member: after which struct member to start writing bytes
+ *
+ * This is good for clearing padding following the given member.
+ */
+#define memset_after(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetofend(typeof(*(obj)), member), __val,	\
+	       sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));	\
+})
+
 /**
  * str_has_prefix - Test if a string has a given prefix
  * @str: The string to test
diff --git a/lib/test_memcpy.c b/lib/test_memcpy.c
index ec546cec883e..3b485de8c885 100644
--- a/lib/test_memcpy.c
+++ b/lib/test_memcpy.c
@@ -215,6 +215,13 @@ static void memset_test(struct kunit *test)
 			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
 			},
 	};
+	struct some_bytes after = {
+		.data = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x72,
+			  0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72,
+			  0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72,
+			  0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72, 0x72,
+			},
+	};
 	struct some_bytes dest = { };
 	int count, value;
 	u8 *ptr;
@@ -245,6 +252,12 @@ static void memset_test(struct kunit *test)
 	ptr += 8;
 	memset(ptr++, value++, count++);
 	compare("argument side-effects", dest, three);
+
+	/* Verify memset_after() */
+	dest = control;
+	memset_after(&dest, 0x72, three);
+	compare("memset_after()", dest, after);
+
 #undef TEST_OP
 }
 
-- 
2.30.2

