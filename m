Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DE44473
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:52:57 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435F41995
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1888392a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405161; x=1696009961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSy8puFeXhx0444elPiTeRpnKr0zw+uEmx7ZUgtG/Dk=;
        b=E8a+jlVLU42KDRxaSTV8s1DjumLBBmWzfzkfLJuYRzh4vzBWX36oz13mVR0tbDOXaW
         nRW6afSYZebWtzmCLlgiiV5imwTYpibFaX5vwIbh/y4BrVV3wlBob3WubKZJKEv8bWXd
         xeAZguQdA7d9Aj50sv3B9pBe3C3L0eR0EWPjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405161; x=1696009961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSy8puFeXhx0444elPiTeRpnKr0zw+uEmx7ZUgtG/Dk=;
        b=KLP55OJ5gMIh6kqMktFekEJz58z0ec50UCPf1y1zhBTEHQ65nxMLsT9Q6xBXSNneHR
         +54pr7T2PSo/eo2HTODwN9uUBN1tg6jgcCHY3OEG+3M82K9b1wmdfRNseNAPT6Yi9WUb
         9aZ7C4/wN2wz5JuYG8wf//CAf7so3cc5eF+60aTy24ySOHR6Bh1VHg0xK5NSZqs/lrk/
         OcO62U540T5edaS4Lp7OEkMh5WZIikRGlYGfUkkKifbRXsnyBizKELOu+6dzAayT/mpz
         aDaQtHBlU1kstZlmnTWTH8rJNahTngoufcmageXB/Ns4AJa8/6ijV0YdxclbSvDRlJQe
         h1cA==
X-Gm-Message-State: AOJu0Yz5X1WP4s7AXwcMdDFOn9G3R3Vr94C+NP6ZManGduE6Uy600O4c
	0upAngOPHZ5GzX/8IGpJxV72EA==
X-Google-Smtp-Source: AGHT+IGs9vWhlgTxV1Aqo0Ts/QnHggFMLwWvRbuUtTLBD1j/rEhcKu6yPTyXKYPaOAab6dPPu3rpqg==
X-Received: by 2002:a17:90b:686:b0:268:13c4:b800 with SMTP id m6-20020a17090b068600b0026813c4b800mr417595pjz.21.1695405160722;
        Fri, 22 Sep 2023 10:52:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a4ec800b0026094c23d0asm3524738pjl.17.2023.09.22.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	nvdimm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] libnvdimm: Annotate struct nd_region with __counted_by
Date: Fri, 22 Sep 2023 10:52:39 -0700
Message-Id: <20230922175238.work.116-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=keescook@chromium.org;
 h=from:subject:message-id; bh=F761VQHXmd2u4Wh2IEMoSgcuswWDj9IUbpQjwrV+U7U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRn7mm/yqnmTumY4FRBROvnp/IvAD87OmcL1
 yK+d5kEY2GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UZwAKCRCJcvTf3G3A
 JhAZEACeucv92nBVoYitGAfmlofYg5eafD6vhQlME6vo7ELBJbtrs5nr/6inRq0/eA0kAT7moqL
 KQNjP6gMWKDuvItgrJBObPbsP1TX8Gf5Q4h7aGpP6aoBVEMGlUstcXMFNo/Y0dAjMchHw/UEf3h
 O+fzNwcrJMiRRqZHP/axClfYmDNc8Os3sZ8c+6h1PofZK+HM7c+qpeHena/yZ/Ii3ZOnJR2Cd0p
 fSDNE4t4g6onf4oN7KjzkOSCQoQ3ouDpsoBPCMByzL13NB7URsh0NTZ1I+ufBZYHGsIbswWi0p2
 COaH0/j8klNyrzEHGbX9oNOiNjoggxZyefLa3/4Ep5yK/y8Ujsp/WSvzVAtBx7vyuVTd5vcsUPc
 6GerUe+AOVWiQtjG5Zx2qplTjE1qN/38QFxI52lCjl6QdnZkfARiKyDu1Fby2oLvw2gc6ywBImU
 EXszuxp09F7eDU5USjQQlkNRSMI7i3NBbBSOV0VGH/2jbDpXv6fage8NNNNY95kPBx+j0yUDllz
 f9dBtF5+cyeapGtokkSwa+v9mwfoggMism33zlyua73+Q6FdqegMBQz0yCC3R7hAziUujAeGcCm
 zTHG2oNr0j2/n1xnSV5DewoHZaDuQVpxkLlge7kd+1NKZ+pzIzbgOaq2ol75jtMnlrXQokeCGqY
 n6M6Oyu v8uheuFA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nd_region.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/nvdimm/nd.h          | 2 +-
 drivers/nvdimm/region_devs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index e8b9d27dbb3c..ae2078eb6a62 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -422,7 +422,7 @@ struct nd_region {
 	struct nd_interleave_set *nd_set;
 	struct nd_percpu_lane __percpu *lane;
 	int (*flush)(struct nd_region *nd_region, struct bio *bio);
-	struct nd_mapping mapping[];
+	struct nd_mapping mapping[] __counted_by(ndr_mappings);
 };
 
 static inline bool nsl_validate_nlabel(struct nd_region *nd_region,
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0a81f87f6f6c..5be65fce85cf 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1028,6 +1028,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 	if (!nd_region)
 		return NULL;
+	nd_region->ndr_mappings = ndr_desc->num_mappings;
 	/* CXL pre-assigns memregion ids before creating nvdimm regions */
 	if (test_bit(ND_REGION_CXL, &ndr_desc->flags)) {
 		nd_region->id = ndr_desc->memregion;
@@ -1062,7 +1063,6 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 		get_device(&nvdimm->dev);
 	}
-	nd_region->ndr_mappings = ndr_desc->num_mappings;
 	nd_region->provider_data = ndr_desc->provider_data;
 	nd_region->nd_set = ndr_desc->nd_set;
 	nd_region->num_lanes = ndr_desc->num_lanes;
-- 
2.34.1

