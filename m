Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CB1B29D
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKJ8m61K"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C4A9
	for <linux-hardening@vger.kernel.org>; Wed,  4 Oct 2023 12:34:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5ff5f858dso1024865ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 04 Oct 2023 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696448090; x=1697052890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiGYv3XhQldm154F5KRxnbU0FzMDf5iW4/dGkdNnd1w=;
        b=kKJ8m61K1KhSUM48Mp+psjvKH9SQ9bLAUfmF59JCdvIR92hU0A/kOpn3fbk0DgIPSI
         ZYJ1I6zumL7Agc2Cewl7jUtEanEnRgvrziYOIg3cfLBa7uk5MPs3dcHmLeWsjinYEwiJ
         0hTzYkxu35zgOecLL7o/9+Tagtf2IqvQGnvmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696448090; x=1697052890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiGYv3XhQldm154F5KRxnbU0FzMDf5iW4/dGkdNnd1w=;
        b=vy1Tg9q2MjSjO9kzk5VnzPgnIxTl/h5W6LaZSdOPxt51SYJRVHgZ339I3OQq20Boc4
         5Y+XWAE9E/KsZSL6JtdS+Itn5IbMxp+hkx7BJjQtl+lbXFZwB5isEJn84CnjMgj+ryx/
         GMT6JjnqMR85qEvyE9CJWIItCn1HPTVPPTLM2CcNW+nJgAwpr1wXST5IFHJjEcsrDdSa
         TefTF+cR8NkjvTFjKSVp93AvGuTIbz2usjsOBi22kKJvzhnJyC5jkxcUhGV0ULsxigAK
         OjVhJKBbbo3G7705AKStNsiXEr+LkxkMnHACNyCuwyk+8PUctWRjHNWBgaGoq61EYLYh
         NVqQ==
X-Gm-Message-State: AOJu0YzgQVj29x3W9nqdbJryUdbh7YN2YkOliJC4Kz7FVHW7vbEAaIWt
	j2I4AFtrWjXsuG9l/M/NJvsXM//35AuRlzQBRvo=
X-Google-Smtp-Source: AGHT+IGW+5tCTp+rfRDKGyryZJft29Uej9ZX6/lOVFuf+sZLXjaQY42Sc3pk2VbKzS4d5A+F/QEJbw==
X-Received: by 2002:a17:903:120f:b0:1c0:c86a:5425 with SMTP id l15-20020a170903120f00b001c0c86a5425mr3661525plh.19.1696448090415;
        Wed, 04 Oct 2023 12:34:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b001bde65894c8sm4078755plo.268.2023.10.04.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:34:49 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Include additional ASoC paths
Date: Wed,  4 Oct 2023 12:34:45 -0700
Message-Id: <20231004193441.work.109-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=keescook@chromium.org;
 h=from:subject:message-id; bh=bhO/Y1ttQwe5f/Nbhm1DLvm+Y0QnCguIE2+6MVMwPNY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHb5Vf1R8xZZf5h0PRJQQS7HmNKGQrWHzm1kWg
 v+I32cN2RqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZR2+VQAKCRCJcvTf3G3A
 JlCpD/4ubP8CNRBGcjvh18YOaX4poB1KbkiLzsURWeXoOa047EHVuso+qKvwbdPQXRZJDXmg2zP
 VZHOgPNQksxt6jlxRfaB/UYO66jsMFax5MrLpY8nPRnXXH8QqnM5dpaxo1abCkjybM5fS8I1N8K
 7MqrEvMSs1GgGXr0ODsyiaQfndqy3rnNiwRCoPxUeSgnLzIOUk4m2gLvUvSm9EvsccC3GFzYcXm
 HEFPQLGEWZEbyC4KvY8enhnDWTU8Fx3ktGHoAC+KHA9AleeskDbZMzaiIx5WNuHEBFLrElKBNea
 NsYFo93eoWueGFAxy6jVg/Id7CF8gCkCNlral6Y7DhD/tsujaKWcaN5n2PLxS/1mCDMgtyfjx63
 4EMaJpFinUZdyCDKHBttXgV1eHJMoRvfntPjYc+B72GvTYBvxiqlxeHDT9tz2TW4jEnLBw6fC7p
 dQSeBOccWsdn0luTLkQY0jeM9lUJtiUhDFaFsSMNy5bcFcYSdMCAN+aM0/VjVPvu6aitM6jN6EZ
 o8JMgIIYPd7zDCs44TZYydYPtSaYgzJjUvKE1w8q62ukenM3D2NBd2L5InulAgN0FtqAc+q09Iv
 yPZlcXGC2akp13FbJMJbsBG6z9vFziJHbGArDJQTt4iEi8t+ZXWBCDiJVPwW2buOcbRLN2dprFO
 LwKjRBeT qKJbPgA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure a few other paths are correctly sent to the ASoC maintainers.

Link: https://lore.kernel.org/lkml/63dd3676.170a0220.1f1b2.3244@mx.google.com/
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f18ed0fbd42..585a13b9b52a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20116,6 +20116,8 @@ F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	include/dt-bindings/sound/
 F:	include/sound/soc*
+F:	include/sound/sof/
+F:	include/uapi/sound/asoc.h
 F:	sound/soc/
 
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
-- 
2.34.1

