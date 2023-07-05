Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054BFEB64DD
	for <linux-hardening@archiver.kernel.org>; Wed,  5 Jul 2023 06:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjGEGdi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGEGdf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:35 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029731709
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 23:33:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-19fa4346498so5565386fac.1
        for <linux-hardening@vger.kernel.org>; Tue, 04 Jul 2023 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688538801; x=1691130801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtlHSYlk61uE8OQ84nuywDVrRHfSI4oOT81ysMvjyFA=;
        b=YwXhEKM0bu8FLh1wIz59SqsCgWkobp8aMDaj1CHNsuATyIC4RfmsCuv+E2a0nBcO3E
         WDTMK08X82N1aLjr5w800Rmi5KkdfuSXoG5l/ZsyDV8RgeW0Y9gk8RsRABpvUrPPItNC
         oAJPB8tv5xMpX8RQvRgMYbfppt/cgVN4dJ6u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538801; x=1691130801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtlHSYlk61uE8OQ84nuywDVrRHfSI4oOT81ysMvjyFA=;
        b=B8l0ZDVrtArMGeTKWnk9w5zoXVKEhy6kuSv/jitySghnZA1MQGWV60lIVFsosPcnuh
         WMGplh1UNifcwnNVjsvB869euJ5x7SgOwWe+9q8wnPWd4G0ofKFVC+oJzG0DtX8ZLfZV
         nP/ggX9K0Ci52dpZKII42HaMkIKhcXMYODKGsPpH4+ByWEZmNwy8FaxnJ57gbHJBY8kz
         7/h+cHiylZMoEJXBtDztRUzBa2TJwrBYoaslpne95LEjoJbEpiiP9HbvvogYp0gJGkN6
         EPEgn+x7waA1UQtGi/rrzIe3glhLa5/J8ls1ZCBeqfXtx3A8VROfN63OmHr8NtAAM61R
         immg==
X-Gm-Message-State: ABy/qLYwHLjmf77QGRaQaVmw+jGU4HLvCuJ8551xGsTKfn8GmwBefjPF
        Ml3Mav+IL4upVeqsOao973TD3g==
X-Google-Smtp-Source: APBJJlGWMaUVY0TTBQBklTknGLh3stDvEgk0pSskAi32YTtDZEDoFGMo+Ddm6TezqBzUtzqDD1VujQ==
X-Received: by 2002:a05:6870:ac9a:b0:1ad:4d4:34c5 with SMTP id ns26-20020a056870ac9a00b001ad04d434c5mr17360781oab.39.1688538801499;
        Tue, 04 Jul 2023 23:33:21 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id h18-20020a63f912000000b0051b36aee4f6sm17145711pgi.83.2023.07.04.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:20 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Date:   Wed,  5 Jul 2023 06:33:15 +0000
Message-ID: <20230705063315.3680666-3-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230705063315.3680666-1-jeffxu@google.com>
References: <20230705063315.3680666-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for sysctl vm.memfd_noexec is 2
(MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED)

memfd_create(.., MFD_EXEC) should fail in this case.

Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Closes: https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dba0e8ba002f..dbdd9ec5e397 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1147,6 +1147,11 @@ static void test_sysctl_child(void)
 	sysctl_assert_write("2");
 	mfd_fail_new("kern_memfd_sysctl_2",
 		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
+		MFD_CLOEXEC | MFD_EXEC);
+	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	close(fd);
+
 	sysctl_fail_write("0");
 	sysctl_fail_write("1");
 }
-- 
2.41.0.255.g8b1d071c50-goog

