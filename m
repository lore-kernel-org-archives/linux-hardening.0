Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07A44487
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:53:42 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321426BB
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:53:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5780040cb81so1848022a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405201; x=1696010001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zj4SpSBariL7w5PfW6Ds6GNC0+0okk3XV9I1LLkTyug=;
        b=bqBFSDme0elkUaFcgTvhd0/pw2zG1uvcMkyZvBH4FO+Rq0gD26bmikngEzK3fNcQNL
         /cNOmHR+tuR0lnQ/+cL4P5dHOf6IOCo9W/YsmVD9URm98dmhSQHwQ6CaDrtoQdt7ckVK
         Otq91qmV+5PW528xXwQaG4q5GsATQyGPWqUBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405201; x=1696010001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zj4SpSBariL7w5PfW6Ds6GNC0+0okk3XV9I1LLkTyug=;
        b=nt7CygEWKeWQCUyKkA3ZYNzv0+Ka7ZjLlajUhHYzEz6kSdrW1Fqp0g46SpKACBvXGq
         nkb1XU5sosrVUurQmlpL4PXNE1sKWnLaioIRrtqaad8xHsLYsyKUpWK8xAr19rjL+3NK
         gTx24/W2sdTZSzajl34dZjcNwsiDrfOzXB3BTbOo3stPlsiK9bF2FNkBVrMIuOL9wnx3
         GMm1ZCzbd1TkPxW8VKFJe3XBc90rPhUDuUunXD4Drhn7EmOdT4iWGK6pfkNu9H8p9jGz
         0d9IGnPzL2KF+Wg5JDzrp/txQol/AreUjPPrG+/Tk3PyaVpPTVBZAZ2metfbiVX6aY05
         eVTg==
X-Gm-Message-State: AOJu0Yz6HWGJe7UD3ghpWZjJmMhWvUm8lSJsJ0SrhCNAKzLIhk5fNCEa
	ihR7XB838vd9fH55a3+wcALijA==
X-Google-Smtp-Source: AGHT+IEcv6I2y2Tg2Odj/iWaOxh5mW66mAjC4xYL0PIzz5E6E4vYoNBJ5eGmBuobJlur8IK3kU6bxA==
X-Received: by 2002:a05:6a21:81aa:b0:152:cb38:5b47 with SMTP id pd42-20020a056a2181aa00b00152cb385b47mr257623pzb.55.1695405200892;
        Fri, 22 Sep 2023 10:53:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b0068e34f07eb5sm3477790pfn.165.2023.09.22.10.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:20 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Kees Cook <keescook@chromium.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with __counted_by
Date: Fri, 22 Sep 2023 10:53:19 -0700
Message-Id: <20230922175319.work.096-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tNrG8i/0a9DiFVHoyS+eyi+j3sakENn22yKf1szb4r4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSP1E3HqMf03zOoxsrwZjK7Qj8qQ3rlmWuIg
 hEVQLTNG5CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UjwAKCRCJcvTf3G3A
 JnXID/98/PX44Zti8qld555xxdRdu0RXKFI86bNon1If3/8TVm7WOjQiSGTHR4YdW90Zydlsl1L
 rNagT5wfhg6OP6bRi+uGJKlbSoUnfx5qQ9GZ9Fcyw8JHzZH0Mfzq2Tf6ypcRx3xsNEgtTme7et4
 uJ73qmrN0bMFT1ElebQMq3B8nvbYg62SMzuY/eGktx4SAwAnowdulA12IM4R0/0l2myEQMDWTMd
 crMzjlGE2AjP6rul7CiexgkQ3PBNTgsiq5WnTCb2J4SybdDTqsDut/Xr30sx9nGvX+GpP5HHr7o
 3Hc/EXEqI4dNa0I6b7zyPdDG0BqkPTIqaT1Lx4QJ+tAd+cUJqbnSYTciLrz0C5IfnjtiaTnYQNV
 sW5R9U0FqdeMnQz032u7VHBRj1dhXI8zNDhsfqDrCWDlUIsMMYF12Irr51DaG5U+PY8I/rWp18c
 pFukvnGCSCGfLrrGFt+QEZ7afQ3TGSTfyKuimDFBzz04G9A3LbtceghPaC8NWmOjzmP0KJUgbOw
 P2LIqnJmGvBQcI5hHrrAgYoxfcCR1A6Py9/A1392H0jxu6sdOPqSCQnhseIaoNcSR5+zW66AGln
 ycylr/yU55fASbpmOf4NWe9HCHyVHQFLkGFyWqd438Y5QydCReDiyKra63cn9iGAagCk8fHwZo/
 PgOkiO0 +z27dRqg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/cxl/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d1c559879dcc..40d055560e52 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -14,7 +14,7 @@
 
 struct cxl_cxims_data {
 	int nr_maps;
-	u64 xormaps[];
+	u64 xormaps[] __counted_by(nr_maps);
 };
 
 /*
@@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
 			      GFP_KERNEL);
 	if (!cximsd)
 		return -ENOMEM;
+	cximsd->nr_maps = nr_maps;
 	memcpy(cximsd->xormaps, cxims->xormap_list,
 	       nr_maps * sizeof(*cximsd->xormaps));
-	cximsd->nr_maps = nr_maps;
 	cxlrd->platform_data = cximsd;
 
 	return 0;
-- 
2.34.1

