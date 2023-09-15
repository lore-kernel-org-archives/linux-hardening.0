Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B3FCD37A9
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbjIOUQp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbjIOUQM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:16:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC630FA
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:15:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690471b5889so918193b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808919; x=1695413719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w8pbHszfCpVRKvLNW5+32KFz2EZUD5ueTN7U1w8HFo=;
        b=FmbvkYu6ddu7F8+G0qKxVJtXzvvyKCz/QtF8GtkDdOX4HFpslz29FPPy+heyqNtbLm
         zygfbCgGs53K8yYIGIx42vzDrvEX1OSTstulkUceWp4x1/cMmel3eQaZPQkQE8v3pdi0
         jldbwSHeNsDy/K1trR1dI1tDNvBnVwSjpA8Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808919; x=1695413719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w8pbHszfCpVRKvLNW5+32KFz2EZUD5ueTN7U1w8HFo=;
        b=XcAST2xJtUSDXstLaeqoxZnErZ+kLHyCDu0Nva2g4N/lbmepIy4S1h2r1D+DvG0GEz
         wQd6u39xtc9gaGKam5mPWO0ockxlPLGzsAxnjO7yXsDwZ59+v5wNVIibiaRi5OyAP6dd
         yAQ2hPKTpIaLjhUYDiRVwp7DW2Vmv989N7cW8prYzHoCvJw+rXnQpj72uKODfubpzbqD
         J/m3uJ0Dqdii+KCsKpPKpJmSZbiPNvhnmLoGxiUkJbdPZlN5C+jmgxQEQZ8fq8H9LH7F
         fN4bp9pAC/CG8cWFQruubf2d8zlTKTwCWr+3aKvQIm2QMx3pXz83+bHII2uOory+lrr8
         Xzew==
X-Gm-Message-State: AOJu0Yw/D0U28kGjAJz8TW8OcceNShdN9xWPIZjI5txCRIv6FMPlvMqn
        AQskydiKNZsAeKdSbl3EiHfW+A==
X-Google-Smtp-Source: AGHT+IHfuqeJ9ZAn3MunxwHrKU8GKe2P/Qfi2HE+t5E4znmmL9cdXh/Hh8gnRQA+06Ej6GKlNU+m9w==
X-Received: by 2002:a05:6a00:1949:b0:68e:417c:ed5c with SMTP id s9-20020a056a00194900b0068e417ced5cmr2901197pfk.32.1694808919258;
        Fri, 15 Sep 2023 13:15:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z15-20020aa785cf000000b0069029a3196dsm3320094pfn.184.2023.09.15.13.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:15:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] ceph: Annotate struct ceph_osd_request with __counted_by
Date:   Fri, 15 Sep 2023 13:15:17 -0700
Message-Id: <20230915201517.never.373-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AmH8bN4F2ziXz0Z5YnlEPY0FFmz4WBV4Hrt1uqyDRes=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLtVT5VsBXPgep3O4AyayotxNhxeQbO4Z6caq
 4bgXJt2IN2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7VQAKCRCJcvTf3G3A
 JvG8D/kBmR4/73WcqLcQcfZ5AAGQQBpqE9J7q/mjZ+UbsQV2m9A0SBCDX97Li8f/0Rla/QjMJgW
 y1kNPx8A5IGfqso+ErmEX/jvCkSP/PfjbTUrZlmNHUHNkiSrUJCzxNLmxaY6zOXydzU/lh8hmek
 u3A7Exe2D6NgGiFDY55GwrNFgFTdS1HxnyURJ4cQJDQHH7boXlfeO4YVl+nOMBL2nlrF3lphm1I
 Zl49zmIoznpwf6gbDjLul0AeIVrgHmeZo8VM1mdX3ow3M6JcX4J8T6UhhLK64mrQBXcfhEHYbbf
 VNK7Me1ZOj3g24mq6ik1bWOGfFPlzXKJNObFtlssYMHbH6fSTax10K0lQeIrrg9WOQTZZT8WIxx
 yiW7XSqoGv4ddDLzNl44ISWOsfpny0i9nRi0daL0pay2CYh9ahAAsnJ1DfegWJ/7TmWtDDciVtj
 i9N+up7jzsKNv67ubYZWQb62DWKMy+dfuH5T3jYJ2dD3+jZTh+bCJEVqJVVsWvm89uQjJmgqQOJ
 gBMiML59Ky/UIbQ2mRak98NeiXIHVxrlbtduo4ihoM+jbZLFK2CFgmwzi3KXyvaNTt7L6h5iJ6Y
 ghMet33KklOxTWy0tvwEGn0e9b8jiPQzWC4fWwKO4u3cQ0QTCnuOx7AYPqxubNnWz6eos8IF8AG
 ECH0vz6 +J8OtTTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ceph_osd_request.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/ceph/osd_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index bf9823956758..b8610e9d2471 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -278,7 +278,7 @@ struct ceph_osd_request {
 	int r_attempts;
 	u32 r_map_dne_bound;
 
-	struct ceph_osd_req_op r_ops[];
+	struct ceph_osd_req_op r_ops[] __counted_by(r_num_ops);
 };
 
 struct ceph_request_redirect {
-- 
2.34.1

