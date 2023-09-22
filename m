Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC424446E
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:53:15 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2532134
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-57790939a2bso1737833a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405175; x=1696009975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/0LZ0BdfayvR6V9xf9atKQs0gdDCoGM9ROyyifaWhI=;
        b=OgkI163Bl0N3N74GUigJQLmFpCLY2hGDHUGiO9kDBn4jHDmtnsrpmSYapru3gb+LHk
         jLrA+nVtk6sTBs6hK/xdClqUBIQsTYQnE0t9CPi8APBo/is8YZjta9EpOp9IqXJpIF0p
         t68a38l9+Oa1Rlpb1LBa8IZGFZ9hn0jUfBd1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405175; x=1696009975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/0LZ0BdfayvR6V9xf9atKQs0gdDCoGM9ROyyifaWhI=;
        b=gXgWSeUIKcLCDCDXkXKdmc70CqSFUtcrIl8P0WEIcbPhuC2ifkId0jAIVxQOA+QxES
         8WzSBVpnmI0EnJAYLOCyH+RHwUrxBnKhND9qwKGx2X5n6fkXwGN1RUcB5vAdE7q2LEiG
         vk5wiRPOPKQf/x+Hm7bZN6pffCaXLIqUds1GMZYlOFiOE8SKmBb8b/V/OoCXYnSqrV04
         0KA/Slqgj4FG3kiIk5s+EB0VmmCvLKRjcMhdlrqEJuUCY/1jE/SkGI6VDECORL0TtQmE
         0SnDgiMy//Fbk0QTwQpTRaULdzllMZnE0fvmOw7hm7kmoJ8Qw6LQtbiumCIbae3fA89r
         E+mw==
X-Gm-Message-State: AOJu0YxebsUIRi59t4DXYZQ4jkrs2yHKWefSYZ6tLDcoeZ+/wUUF4Mw9
	IiuYn10FHYph3A5JtsuKNooZow==
X-Google-Smtp-Source: AGHT+IFnVXdwioFBcLb/UlAJqAnKODkBoXi1bC8KREhejIZ+WcLNaYl7phfrL1clZWMl13h6InObJg==
X-Received: by 2002:a17:90a:c202:b0:274:78:4f0e with SMTP id e2-20020a17090ac20200b0027400784f0emr416568pjt.20.1695405175507;
        Fri, 22 Sep 2023 10:52:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fy17-20020a17090b021100b00262ca945cecsm5227765pjb.54.2023.09.22.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:54 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-modules@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] module: Annotate struct module_notes_attrs with __counted_by
Date: Fri, 22 Sep 2023 10:52:53 -0700
Message-Id: <20230922175253.work.237-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4/3c+CoHlipaNXkdzTa2IhKSABVzwvBmwK4qj1DpXRc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdR1oRMzsDYP0G/QWE/szqUISRngpgS5fIOjA
 IYsDgB1uXyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UdQAKCRCJcvTf3G3A
 JrHMD/9aYabujUq1U7QI9gTsrf5dHhMeWQw1CQH79MnJrW++o7C5IEMyLbJfry4+oLPAYIoxf69
 2obWMo91urrMxORLP1X1L5+MnQzOK0huTmYcdNbnhaU7AjptWupBcV1Id8OTPGi4rrHb6W6uNvU
 pdEr2BfnosTjKZZpdoFI7ZYvJRqKjTXodZ0gBAIPoc6VKiPZdg7pawJmzgOJtihqhzUSNvKSw6C
 SvjvPpgbOUaPERgY2kSCWkynCQRlKVm5FO8BtEGZC9xRclnYbTYPwp2DT+N1J305rEvElzOZdnW
 03xkznRHmdMko+G7mByYCxKYt2D2oJ2Q3YIpXWbfhF4Uwl4BvWijLt0CdFR7K7OqrDljRmjWMlS
 Nvt+W3OR3sjjgiVuSoN0TDYPixxS00RO5O7zqdKeee+IV5ofHEiR9v6LgOkkkMgcQ4F5Re1HVtX
 KaoAtXTamyLN+2ILzP23YcpywgaCprTBi3RBy+TfG6oPlbCmVBrrOP6zp2wtG3nTi/fO83iE70a
 6e05w1D79fhYnj8PSZg3sXsr4C2E/Z8tMyz01+Dbd+17+JPah6MtZNjsZ6excTzdGMPO6kMU91E
 NCVSp52ZWNLiQo9IjBCxTXfnn93Ick0waeJbCT3W3MD6Zq02bXwdYIMdrrZmpKkQJqFtE4cprEq
 gyVmi1a Kkcr5/KA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct module_notes_attrs.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index c921bf044050..d964167c6658 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -143,7 +143,7 @@ static void remove_sect_attrs(struct module *mod)
 struct module_notes_attrs {
 	struct kobject *dir;
 	unsigned int notes;
-	struct bin_attribute attrs[];
+	struct bin_attribute attrs[] __counted_by(notes);
 };
 
 static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
-- 
2.34.1

