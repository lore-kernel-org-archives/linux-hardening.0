Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208EEC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 09:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJRJZw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJRJZi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 05:25:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394896557
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:25:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 10so13316148pli.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MUGpXXu/YLX6vB16EEikz0mUodhAtO8kh4qarh/vsQ=;
        b=JtNmvf1ubSjiH1NO0qolmx2k/7lVy3Sznt8a8J8fM31erknTm2/E4tqjoxnBJwLEUi
         f3Ub/BNwRaIM6jgFHsYdDtJ86QHx2fNnwdn55tyNvD6wbcQXSG9/JRY/lQnc85sRdv8Z
         Ea4kYzXelL/Wlo0P6SmcA4mO/+bqaZgW1FYXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MUGpXXu/YLX6vB16EEikz0mUodhAtO8kh4qarh/vsQ=;
        b=BY/I2owesTTZ5wr9LvZ7sYkQ3HktIBy8yDV1XDnOmL5ZPmp/FZkXSZ/PGXGAZLOWtk
         RTBuyv0RGfFT8xfLZ/Ds7DSHS3WQxexLoquJVzamnNfZaQp3zRlmnYed+BYFWx8NHQZx
         iSwYmKkoL0/sdYIdGfDAeZhwHmp//uHwjSwXKO3/0T4dvuDDtswOXIFsYB8v0c2PiT7/
         r1IrJxJtK/bWEtsdMhP+Yt/+XbxaP+qS+W+xDUnSa4xQTe/wQgcG8t0gaITRBdfarqIu
         nRblGjie+FC+Wu05X2p5eEltGapdkitUIlMACp8fXFm5UEDwsdHzFah92Y+4UqSOLOns
         Un4g==
X-Gm-Message-State: ACrzQf3fyT8tUc+0gAP55O9KuOKTCVLGnmw/lq+TxPErTkgfa6mIQcSa
        aOf5aEqQwsDSK24hyB0OaK4H5w==
X-Google-Smtp-Source: AMsMyM5fHoJkZ04COrIOtFCeb2dhusZr7vVpO96gDwpJ6y8MRdxE8qYSAnuq4a+oCbS8YJhDc9xMOw==
X-Received: by 2002:a17:90b:350d:b0:20d:5438:f594 with SMTP id ls13-20020a17090b350d00b0020d5438f594mr38870290pjb.216.1666085128750;
        Tue, 18 Oct 2022 02:25:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b00561c179e17dsm8694847pfg.76.2022.10.18.02.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:25:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ruhl@www.outflux.net, Michael J <michael.j.ruhl@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/2] igb: Do not free q_vector unless new one was allocated
Date:   Tue, 18 Oct 2022 02:25:24 -0700
Message-Id: <20221018092526.4035344-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018092340.never.556-kees@kernel.org>
References: <20221018092340.never.556-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; h=from:subject; bh=R8ylvO6BqWbNVREdX/u1o3d4rMnlPe7DgQcXRdLK/uk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTnEFGT/npSNQmG6Pg/wQsD1SJfFxPxu2rbyaqXID oCQB78+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05xBQAKCRCJcvTf3G3AJi7vD/ 96KK47LIncnqzTUMut5a5skw4vihz4xnknY7/ue9t+x9mLj8qHg68Bwhsj1s6Ei3FnMALk3w768VYs SWUJUKa88nfLmMsRyuuiv/GTuK+tV2alLC3zKeeLtuPkJZIpyoNJwHOvRCJK8iOk6/dHj5XBXtOOr1 WEv8l8xFabrpKP3Pmf3DxpM4T3Fp/rmj8cCa8rnX6wvcH0nQwL5Jhtp7ZZ2wB9VuSRi1wg63+on06o HYBlb23VbUFT1uO4xKE0RlsmQlP/4y9JJmgScoRQkr1eQoIbL4uR4tX3ke8KTzviQUllgpIcN/HKHO 3EDeF9pKlGLcenyNmM9RDXH0dW1bLrNiAJ5f6yaaVWLx8MAooB4nY6dVUi9WiF2DJuZuEQenqPtlB6 StgzPvNXcrHnuhXvMO2GcNYO6VSfxhypAGYmHZKw6IQXOCzYF6yjVQW7Yji1kcmn1rk+aAC7rAetO5 NkxrAUM6cASntDrRuZK7kTOeOTuoHu8xS0XJttoDEy9dSJlLHNkMw7xIvR5ydp2oUpVfsCDGqKzyWm fhbrVNLgZtECKGDo1+eaDPoDYIskAVsjWf5kTjfLVOd+UrVNXtm9Kj4lolcvXjs38jYkx0OPzUy7mE x2lTxueP8LPPu50EdJIIy8Xy1olop7KKBYCeVB9wDl0PgbIz8gffRV7gFaUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Avoid potential use-after-free condition under memory pressure. If the
kzalloc() fails, q_vector will be freed but left in the original
adapter->q_vector[v_idx] array position.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f8e32833226c..6256855d0f62 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1202,8 +1202,12 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	if (!q_vector) {
 		q_vector = kzalloc(size, GFP_KERNEL);
 	} else if (size > ksize(q_vector)) {
-		kfree_rcu(q_vector, rcu);
-		q_vector = kzalloc(size, GFP_KERNEL);
+		struct igb_q_vector *new_q_vector;
+
+		new_q_vector = kzalloc(size, GFP_KERNEL);
+		if (new_q_vector)
+			kfree_rcu(q_vector, rcu);
+		q_vector = new_q_vector;
 	} else {
 		memset(q_vector, 0, size);
 	}
-- 
2.34.1

