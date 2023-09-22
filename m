Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2E43A9A
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:50:52 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462010CE
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692ada71d79so755288b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405044; x=1696009844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIEluTePXKUgmZoz//4ptV8zeRXzjojVV5Zn13TdbAA=;
        b=B8ACxVnmTI70CkCoVxDOImntSKGYWkxDtztMJ2WECSD0rLzx9Jds7fYgy1zuD4+/Oa
         Qxg3wfnkJsQjDAszIq5zLtgnIByRNxCz108y25uGyofojIaLImyMsaz80znXdC75p5oD
         GFzsiJmJyYoRUmIFPHL7nx7uLkj5rmDh7j7vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405044; x=1696009844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIEluTePXKUgmZoz//4ptV8zeRXzjojVV5Zn13TdbAA=;
        b=c9UUYilNMtt2c/t1BBX1QznnLZiO1at4QtZ3zcrIgPDShmGv6OfbFwILw04vCiA/pe
         j0+OzwW2rUgoK4T+eO+FEoWYwaLVV64djcbipOwoioznWDMH7ZxwRy8tAcPTMrrMTymA
         ZwIj76uXqI9Yj0vHzyocGRTR6UlQf4UVlriuAfsWGs0Mgr8EcynSX8cWXhcKIz+nRKYw
         978GwsOdLJi6N1q4ii2VpEZd7N4X+w7QWi36JTCZbYavV0FDs1oZE5H2pOFoNnV3kZcK
         dCpErHrUGkgxnDVdHjZbMP0vELmjlTp5Zc3frjVbcXcfBVpOXifOISj+Jswjs9RO/Qoa
         6SoA==
X-Gm-Message-State: AOJu0YzSuTY+GW6EyCAtSpTcuJIoLpQOSaCwzYHtaaf6yvYXCNJxJu78
	44/CklBhKBlgIjxcR5b7qe+h6w==
X-Google-Smtp-Source: AGHT+IGlzZWrQahzIVY7sXtrvLZBK5+3kHZlDPRAqWBrggsxuzxxsLFOwwww26ZuTCH8VBPpWjNhmQ==
X-Received: by 2002:a05:6a20:8409:b0:159:b45e:1c7d with SMTP id c9-20020a056a20840900b00159b45e1c7dmr331120pzd.15.1695405044050;
        Fri, 22 Sep 2023 10:50:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b0068be4ce33easm3556666pfi.96.2023.09.22.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	alsa-devel@alsa-project.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jason Montleon <jmontleo@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: hda: Annotate struct hda_conn_list with __counted_by
Date: Fri, 22 Sep 2023 10:50:42 -0700
Message-Id: <20230922175042.work.547-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=keescook@chromium.org;
 h=from:subject:message-id; bh=2+WFGivuUVAKb1W+9E3ktp6XUMEEm32AWq2NC2ISBJg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPyOwKNuU3DBxwepcnIO9oHljCgGuE/kMNNW
 SIuGoQNj8SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T8gAKCRCJcvTf3G3A
 Jo+WD/9F+wyEdMZRixRxq25YvGH8mw+aR+YpOV3Jnt0ScoGqx0BVe0PCT0yiRIlirDR/leDv/w8
 f7dQOHwxs6N9HFxhaKWBn/5fS39ICNQHC6rGWyVsrtVhQomA7J2VerZJ3EHX1Py8vAQ45YeksaK
 68AiMW/ZxVcB2VQVOV9JK2LLA8q1GDFaSzTX25NBCsilUpoA4Xg2zoxf99DJqx4M4DEcYMvA8dx
 P+iFCootNqc75w1qhByYrkec6Ypk9186+KIEpX23pJvVkkOnm+l4jFmeAc6fDGLx4GGyVGf7oBF
 bbuUPvR9ftPa8SdqnefuqXk6wUxPKdb94b6/PnBWLs8O87U+ug0Nkh5oYTMTOEp/cfyM7Aj3lT1
 HrZA5MhV2tsVVK2LMCLeFmqxZBfw/XJal0TYdzkGV7Y5HGrF3yDBqnAdJW4/uZeL9psk2L0ptaN
 L/SvDMIi0e7Jmwu580DQfxp4N23uZcYYDQNVFdCMuE+NSTggdbiilocOwMPL5ypkjb9X/boktW5
 tzYNjZsA3ZGXjSwzW61MmJOC52NSPC6Tk0bOHBbzVQfJGJUVVG8Q0uBN5PkgRtuVrc8oh4zUF5Z
 ILsCXDzpDzwULkvGXjOBJv5tUcenHcoyf4qbL5mC9nHz9RbDqdz0MnmL9tLf7L5LBNwVdJAyQpX
 sITrZ/3 7N36Rc8A==
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

As found with Coccinelle[1], add __counted_by for struct hda_conn_list.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 33af707a65ab..01718b1fc9a7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -88,7 +88,7 @@ struct hda_conn_list {
 	struct list_head list;
 	int len;
 	hda_nid_t nid;
-	hda_nid_t conns[];
+	hda_nid_t conns[] __counted_by(len);
 };
 
 /* look up the cached results */
-- 
2.34.1

