Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322D156D7
	for <linux-hardening@vger.kernel.org>; Sun,  8 Oct 2023 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0TxNufF"
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A327B3
	for <linux-hardening@vger.kernel.org>; Sun,  8 Oct 2023 10:06:09 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1dd8304b980so2651805fac.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Oct 2023 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696784768; x=1697389568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nqNFicLmChhNvsLQV7hRq15LodE1T4vEvc1Jrz7PUE=;
        b=L0TxNufFJ28PNYnbTDlW8JYZug0+VINdkAENywU0sVEluA5eaY8p56UM2H6ONSSewX
         BefgBZc+S/sRjWgKbA5qTWbACLf4JhnH/gK8VlkswbOqL+avc5Zhn7R0WCAFlLyyIjXb
         HCc1iaaeefS9+CHIhOPt2ZBvwZgYonpkNOm2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784768; x=1697389568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nqNFicLmChhNvsLQV7hRq15LodE1T4vEvc1Jrz7PUE=;
        b=M03eDRqIkCmKfLfXD47y8wwf5SfxtjbIyeKYyAYlT+f5fsvQjlhP+2lXqn2pou90dr
         KSTEKWk/7Ib8w4Sun9OjXksBzkP+pUL8LUwKt1iomjvCVi4FNbpvtuSkxLqRDsc5fV+Y
         g/2yuBEfYU7XqMT57R35gKKfLxYp0E0bfneS+mIKhIpSSB8q/Tq6fZMjghq1gde+n6WX
         6CUoeGjeRsX/nLI9ohkAQ/0VPbKDC0bhRZUr8s9kR69e8PYSBiWvQgZ1ed4M29o7l10x
         pn8TWHf3GE/wE6Dyuja5xmI9UFqaiMzhchUNq40hd2GKXGrvC67zKAJKszHzSsRFXpjb
         q3JA==
X-Gm-Message-State: AOJu0YwVBJyFcepgwdzGyHGOg6hpp21jKq/BG08gH7GRR69l5QI7gdYj
	rlenFE43Z4loHmrtzvi5dQDLQA==
X-Google-Smtp-Source: AGHT+IG2CL4VX7lW1hVP1JbsiQepUUABt/IJtOXBKKYge0GlWd1+Drv72rEVv1gvSoMI0PJ8SMz+qw==
X-Received: by 2002:a05:6870:e99a:b0:1d6:439d:d03e with SMTP id r26-20020a056870e99a00b001d6439dd03emr16299580oao.18.1696784768266;
        Sun, 08 Oct 2023 10:06:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020a638f45000000b0058901200bbbsm6729861pgn.40.2023.10.08.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:06:07 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Lukas Loidolt <e1634039@student.tuwien.ac.at>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] randstruct: Fix gcc-plugin performance mode to stay in group
Date: Sun,  8 Oct 2023 10:05:56 -0700
Message-Id: <20231008170552.work.766-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=keescook@chromium.org;
 h=from:subject:message-id; bh=qv0SIpdVAd3ngaHncfIuud+zey9eeaZyOKuEy6jeorw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIuFzu7vTuSz+3VGO1JVCPh0ubAQljqhiucij9
 oLQjB3POL+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSLhcwAKCRCJcvTf3G3A
 JhOyD/0d8vIe30z382IYGDgIbm+R6DVIQhzHkNFDVHXPEMNVNNJ0UEcqT92bmfcVFEgsO7trUWc
 G2grf+7o60WseUEXUTIdxVtXAgn0rfpqwf4Gy942wFdBBeMgG+seMxmv7i9A+swhbETnQvK3CWF
 CLVAyreBEpDjOwr6sgxKag+zn79zZtYu2ZnUZ8VC7kJR02Cx7GRekWahCoLjojjWkViJ1E3L6Jb
 viPAoDn1ukpTK96MdHdBbYl61E2b61yfJKcn3O+qCRQahQ4617117WZwswKzlqGvU//6Gnzydnp
 1SyG0S5+rEia+QCmd2AZLNmhPEAhEtydF12bUE2HYmkcR+FuZaKExVbEGhQ8bm//dJLl2F5YIj7
 w9GdaLz4bxRAYAasP8iQz03jNQTNI05OOaZEZwEsDYMMKL5otxQzD4GFku3Ap1j+UBofndwK/bz
 +IIhuT1mq4hb230NybmGBZaQT+tMCwAkzYUGVKgIEVNObR8/L6D8rtVPApVE9KGAGYlpWfOa6Qj
 9HYM4uCYuG846NQdF4pbXS1tcmbQF3FR0vJvuFg02JZK1SFojNtWvNYKWUUO5+JbjBhAvQfncCu
 PunvqMXM8H5hwTfyq1UolEEjtNmlpYPF0nPBR7UdD6Nko9Yz5EYgq9+VNyN1kc2NULSyXl58XnD
 ITgKT3X FQTEXZWA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The performance mode of the gcc-plugin randstruct was shuffling struct
members outside of the cache-line groups. Limit the range to the
specified group indexes.

Cc: linux-hardening@vger.kernel.org
Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 951b74ba1b24..366395cab490 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -191,12 +191,14 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
 
 static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
 {
-	unsigned long i, x;
+	unsigned long i, x, index;
 	struct partition_group size_group[length];
 	unsigned long num_groups = 0;
 	unsigned long randnum;
 
 	partition_struct(newtree, length, (struct partition_group *)&size_group, &num_groups);
+
+	/* FIXME: this group shuffle is currently a no-op. */
 	for (i = num_groups - 1; i > 0; i--) {
 		struct partition_group tmp;
 		randnum = ranval(prng_state) % (i + 1);
@@ -206,11 +208,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 	}
 
 	for (x = 0; x < num_groups; x++) {
-		for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
+		for (index = size_group[x].length - 1; index > 0; index--) {
 			tree tmp;
+
+			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
-			randnum = ranval(prng_state) % (i + 1);
+			randnum = ranval(prng_state) % (index + 1);
+			randnum += size_group[x].start;
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;
-- 
2.34.1

