Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED7DC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 09:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJRJER (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJRJEO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F0A99DF
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:04:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q1so12739576pgl.11
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6jXP5rr3Q3qr2aS0J/xPsH/umdUTreFu1h1A3gs3aQ=;
        b=QD4p8BVwUzYqkWzz2ygyWHyNq1FIy96vtCbm2AnS4pnHfAaMUZBACOmUP723SmnxmG
         6CN/3G3T88NUXcyQt+k7UJXGvpKbncl+CvCjf9vBmAiGym3FoibWLy5TLCOwLu80Kxdy
         wwHNIk3ih9Cgte0TRQoUo8aYLFcu0hF5V5dY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6jXP5rr3Q3qr2aS0J/xPsH/umdUTreFu1h1A3gs3aQ=;
        b=6wnvOlk+zWjbKHAR/4QYvd4gdqDcnJk9AULo2laXj2MiMInTBZVmUwVvItUfMpeAxZ
         wEELzgsaDBuwcX7P5rGb62SFhPvtu+Qt9INOnNS/w2eOisAdilacND2Qe1D8lmSwGSdC
         KA7k63hDfKPO1xonY2ZJ1drwCs3jFIyloZQPL2vf7NwcNe1fSdpCaReM5MsmsV7lgTXu
         f+MBaDulSEdxtrmwHDz5Q1YAlKQlnjNp6FxGQEy1oWnMzIZmR1Gvr+DN0pB1QCpRm2xW
         ebYHJJLIBOBd3sW+/5GRZS+AWahITwgl/xGXY1iWy5+O8n/Wk4CfkUn0MM1XMZKv9OXF
         y6qA==
X-Gm-Message-State: ACrzQf3i9O6j9CZxuAwETZnJX85ji3G79dK/9Yg87X4zpgD1Wy8jsXYE
        JCHPdfRcM3m13pgs+TIYeGz5SQ==
X-Google-Smtp-Source: AMsMyM5tncSStMmm7cz0EpJNuUki11273cPYl4K7HZtPwAdktvxqKe+AvV3DtABdJHBV+yJGxWiTrQ==
X-Received: by 2002:a05:6a00:148a:b0:566:10d8:9404 with SMTP id v10-20020a056a00148a00b0056610d89404mr2197357pfu.84.1666083853227;
        Tue, 18 Oct 2022 02:04:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b00561b3ee73f6sm8816229pfk.144.2022.10.18.02.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:04:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] devres: Use kmalloc_size_roundup() to match ksize() usage
Date:   Tue, 18 Oct 2022 02:04:10 -0700
Message-Id: <20221018090406.never.856-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; h=from:subject:message-id; bh=VRjJ85d7FRzO9QdnNALjjPmlohFMyyDeN2Qy48G2Wdc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmwK5HjmNau/2Z8OSw58zvrURKnB0+VP8PGWljZU GGlZDbCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05sCgAKCRCJcvTf3G3AJmVID/ oDsrYusLzCt85XakVLHBFAmwjiMokMARd8n10E7KTaSxXIUmltwvhx4/yIRmnqwhaXd7y0AG7kNTBy wEb9lwJ8TLrPox+5gjU5C9+NWbMecYR7jAtYyMTtiViFf22JpUc8oSfmrEOzzRX5HlcjTeWgHcyMY+ 4D2Hg4s1XVdHW3uTUy4QMueoZl+svJ1tNYTcd8cQHgbU3l8NtUMh0HN1V7q496B71EsV05Z2QxLV/m 8RX61dFy7n7npWNnwOnnUj1HAvgY8y1SanH2MwhzrkyYWFJ8LEY0EZgXhPGG679HeWfLj5DBcps6UL ZDZRmuJ7bwnvjeivE8L8MS95G0KOc8rgaeX0B0P5rwmQQu738HB0PbVoGR7UBxPc1+nYE0yRvUaWaM rzoIUrtKPapTaiQD2iPKR62e4cBWVQtH0KnJj2NYRuV8WdrY1HRTk/tgQc7A6k8FCMomzmI0MraGuK 22kLZEe8+19L39ybrgAp4E2DR/XHpi3k/ar/Yx0HBXppFR8WtYhSLzF7AbcpREds4r29I7+DwslIuE c1b3gf6dUcUEk+56nb1seyE9vfobXTTW+lWYjDuNrHJWTUrYx4F+iK1CAVM/v7+M8aJ9BQUi0MD/vf ruH8lfb1WQRLCoWlKhUi4rRajDs9+hZC+gDj6xcDzVyZJf3Bq1dArIflUgEw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Round up allocations with kmalloc_size_roundup() so that devres's use
of ksize() is always accurate and no special handling of the memory is
needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/devres.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 4ab2b50ee38f..c0e100074aa3 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -101,6 +101,9 @@ static bool check_dr_size(size_t size, size_t *tot_size)
 					size, tot_size)))
 		return false;
 
+	/* Actually allocate the full kmalloc bucket size. */
+	*tot_size = kmalloc_size_roundup(*tot_size);
+
 	return true;
 }
 
-- 
2.34.1

