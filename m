Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE89C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKRAeX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiKRAeS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 19:34:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA58716E4
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 16:34:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g10so3153597plo.11
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfKoIXcdSbSCG4X8dhvdkumwWP5cdUHpW/BAvV90utQ=;
        b=hBAITYaklRvHDDl64erxDCykr4u6NNFZ8OfJfZ1JT3AFy1r2suv3k/1rLcyzRXga0N
         /Gxby+KLLrwQV7OBkH8LYJSkKhJPZmRywFIeLAjhWp9a/BDOFymG1t+YxoeVqcooLMOC
         THVmW0Q2Ukz0Y0EPe7mbObmo0p8I/djfdpo1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfKoIXcdSbSCG4X8dhvdkumwWP5cdUHpW/BAvV90utQ=;
        b=z6YCzoOQRBNzXQTenYewLDVQXpa8zu6D6m2jCMAMHODpCDxb3Rbq49OloaxH1+vllG
         NUPVxD4xXnROuIV5tAE7a13WtX0K6ed4cayVJmxK3t4hzh8NJyHqlww+sQH8TI963bgg
         y7vRU6dcsBAv1i2WTz//gLuihI8eDWbIwolpjWhnLfzBta6Aj91vXSl7hVcWFBKr8ljv
         Jpm9EiKDY4E8TWA49/XMqy+8+0WNE3vv1wRIUCZxeLGPUkqpiQLVe8VaGBXgxLdlxbf8
         YkBY6MtyzACq2eZm+7hM+RKsRM6breAB3drWtsP1ApFVfTsM4PS+i+MrL+jJE6fJnXV6
         EWyA==
X-Gm-Message-State: ANoB5pmQjqv0DLkxZAtq/2yI2s1mzj87SgR72EUTMKqLdBYQbayldEKN
        cZWNjaqzEKYWmsV1UZJQq8fP4g==
X-Google-Smtp-Source: AA0mqf6qI1CpK2kkytMt09iK5URjD1iMJmLNXdgwK+fruRzJWWFpW2jfwg3hAMw41jRbyichhCspbA==
X-Received: by 2002:a17:902:9a01:b0:176:cf64:2f39 with SMTP id v1-20020a1709029a0100b00176cf642f39mr5096556plp.93.1668731656837;
        Thu, 17 Nov 2022 16:34:16 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b0016c50179b1esm2058299plx.152.2022.11.17.16.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:34:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Remove FOLL_FORCE for stack setup
Date:   Thu, 17 Nov 2022 16:34:14 -0800
Message-Id: <20221118003410.never.653-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; h=from:subject:message-id; bh=Q3A301qUeRB8tq7dkiRpjGQmp7qcdEcbj6KnmtW0Kwk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdtMFIHEE/2aFsG+0+1k2j6trtVeqZg6//sNcJ9PZ qpTOZmaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bTBQAKCRCJcvTf3G3AJmxND/ 4nU1/hNVNbDf3WDg7BJbbkga3ERM+KhF9FnAQVu8KD6VPUt+W3bNr9NimO5ebcKzxJIpAWnFFquFte arvoVm5AdjVA997ZUKDrwC3EfEOyszPX6WaRYz6/CTXy7OFJiJKAgdqiz0rM0Jb/VpEyNJFTQNVyxV wMroI6NjViv6G3EUD1FiAkTEyQvtGBfX4ps6mqXa+VFwFlzH56Pqq95o3+RDaekupGblAKIBILa3px 8qchKhd+rbNaM/5Q+krz/xGgEM3pADGVa1Gc7LcICT0swoJlyfl1/5QZCPntj70a0cp50YlpWLkL48 45rCEUBDdCNJ4zVQ8RGTTK7xxjzkZU/6LtVntk/6bvsujeJDTaexOWPF3/qYjPI2jUerZlakCMj4rf Tgd33LBDRv/KHbPWibXCHmOHgWJwjfNWmVbwxsDs+Yksj/1JiO7OX0fLNJpZn9GbNjmBjfKyz4MjzP c5GmSJFRqJPwPubdfziNeJUTx6BpruAG2rBrcZWSPMAW+hvDOXwvycOVf6FcXrKbuxWDN0o4vHAS4B PtDF7gVEHcr/1T1ve6JOKyFcoF5KHZnCDfMJa7DhDf/f6beMa0KDPvcVSZKFe40c//VyjBP88R8yis ZoZVUu2RUXJONdTela0ORVr6/2I+UkBiTe7Sdd4SleuMafvG7eTx4ES95sfA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

It does not appear that FOLL_FORCE should be needed for setting up the
stack pages. They are allocated using the nascent brpm->vma, which was
newly created with VM_STACK_FLAGS, which an arch can override, but they
all appear to include VM_WRITE | VM_MAYWRITE. Remove FOLL_FORCE.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/lkml/202211171439.CDE720EAD@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9585bc1bc970..870a707b5d3b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -200,7 +200,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 {
 	struct page *page;
 	int ret;
-	unsigned int gup_flags = FOLL_FORCE;
+	unsigned int gup_flags = 0;
 
 #ifdef CONFIG_STACK_GROWSUP
 	if (write) {
-- 
2.34.1

