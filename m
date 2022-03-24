Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B192C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Mar 2022 23:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355737AbiCXXUq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Mar 2022 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355717AbiCXXUp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Mar 2022 19:20:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D753A57
        for <linux-hardening@vger.kernel.org>; Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so6313632ply.13
        for <linux-hardening@vger.kernel.org>; Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aC5jQY9bRnYXoBxm9qQ+y9WHEA+pJxVxqWzjjYx0m1I=;
        b=oA+MqEoqMQu9A6xghfI0ELS0LM4GC+4mjJLlvg2u64H/WKew5OS26j4VhdPFP9nJLN
         D+Kiom5gt5FZ8Ma13gpxGCc8hEoqrSn3sRqDzYOl7P0cPtOJo/8aioVlTzfHueupvsgn
         Sw4JoFlOz+3TxnbzEh2T9tNhddnekWpHPge9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aC5jQY9bRnYXoBxm9qQ+y9WHEA+pJxVxqWzjjYx0m1I=;
        b=7KydyfeVOHFXlAST6YhpXDtRb2DYW4fZfRuY43m5OlyYIdVvOtLC0wJJSim5Wk99P9
         vmSC+O5GlrHMQsHMMiqW/UBrdU+r9e0OwW4gYNoaczEOzpdnluypZG7QlNu8wv93axIm
         SxrWNkazFkPK7mBSQi+O8ii8tmlzMfHx7HZlzs7Vv0EQq6mIsoWD1wu2VHWIlzf9POjI
         J7L5UVfuB6JdJrRuZxFuMJxXNolvwpU0ZDO3iUgQvgXVmwegmq6JiMRn/E2bjmlHIIQm
         o1ODQUZJ2Dvp2Uco9066zYy2+7alSsRKeec1dsSoq76JpMvCodqgKsx98V0Bp9OSQkDu
         p6TQ==
X-Gm-Message-State: AOAM531Z+WnItCE/NR6SFHfsH4fs6KVU1nVqvnH6c57dUyVlwRpmy4HH
        of13D5J4HWw4gRNDPwq8bCoCzA==
X-Google-Smtp-Source: ABdhPJys0y4Rqi32hQUzml9sTZ388KFpz7yOfQvUTUBaqOcXtzcvypFvAAVg8/s5kxR0ABf7GApT6A==
X-Received: by 2002:a17:90b:4b4f:b0:1c7:d415:5b79 with SMTP id mi15-20020a17090b4b4f00b001c7d4155b79mr3707070pjb.96.1648163951978;
        Thu, 24 Mar 2022 16:19:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pc13-20020a17090b3b8d00b001c775679f58sm8347708pjb.37.2022.03.24.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:19:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     shuah@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Willem de Bruijn <willemb@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] selftests/harness: Run TEARDOWN for ASSERT failures
Date:   Thu, 24 Mar 2022 16:19:05 -0700
Message-Id: <20220324231907.1363887-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=578; h=from:subject; bh=eudHDlYS5FCMACsF/D8OI3ViMhC3c/UTt+QVDjCKUEM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiPPxqiFnYXLfN5FlkoqOQIU4BW60uwDtifEMQw2b+ qcYQYIaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYjz8agAKCRCJcvTf3G3AJvYaD/ 97JfOL/uskgeKMPuG9xP8+vzHXjf/RRqlLoVU3Adpf4IK5nhpHQktA2v0fuvR6f/q+m5IF40NNZOoc ydXWkt4r/eG02It9johJ1GuvN60PRdQe8ispjkQUCDoT5Kockw8YfFyKVcBslSSjS21mCZO8JUb3qd pmu4eivrwyV5jC+ZMIyoHkOHT28fBssdAI8gfYoPFJxPsKQIhevSVLPoxMikE2pPCPw4m8/J4KtcjK hR0YTVNm7gBvQGK857tDFVNcZebnFs+NHWSVIIiqPrmuFbDxw1gxE5zKTZhsj5JCb1iXOwAA4tQC8Z ipsOO5FlumCycIvkjblwG7XcZz/5AruCL1ge5KnkJRvTND3Zu8c2hM9IwAQqlM6QZSl+IQgF1CTeZ7 SrcFFNv/lrm53VY/eAkEn5FZZVD+qBUy/g7KO9GX3lWiQsJufD27QaF7Wh7RTT+Lnsiac2r6YyIDf/ 8defmq3MK4Phfd4E9BpO//rqR3z/hHwU68KWfRv0Ec2m5A95W6KPWNjwh0ySiMmu3TOMn0kDBCp1ik iAYtoWN2LZ2U8lXvaHzVmRq2xAd0Pzp2+lI7fTA1r7eo8bwV61ani75KOl8wrw0qpgNmZZAw3Eh68w NdyPPU2RXX7+QaGYqoCvWq1DjbvZBqzHQdpydNH3up9cpj59WQ37zUqY05Ow==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

I've needed TEARDOWN for ASSERT tests for a while now. It just took me a
while to figure out how to do it. Also included is a patch from Willem
de Bruijn that got lost, which makes sure that variants are passed to
TEARDOWN, since they may be needed there too.

Thanks!

-Kees

Kees Cook (1):
  selftests/harness: Run TEARDOWN for ASSERT failures

Willem de Bruijn (1):
  selftests/harness: Pass variant to teardown

 tools/testing/selftests/kselftest_harness.h | 59 ++++++++++++++-------
 1 file changed, 40 insertions(+), 19 deletions(-)

-- 
2.32.0

