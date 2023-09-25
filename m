Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A111BDE7
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 17:20:47 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FE10E
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 10:20:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c1ff5b741cso62489195ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662446; x=1696267246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPLbH/Tf+wdfFPVL445Q4TNBVYOrnwBXbZL8JKEtuvw=;
        b=iu+sNNU2PCMSdc4vDSJEV2lj2fW8yaSajEyyasj4YQhtXfTprLeHrZcg8Lw2mypyJ8
         kVyEspUVRx45v13jeTtRS9/p1wUN/TuB0aTukwJcFKSvPJ+SOxeEDK3gdN6DnQZm2sxB
         nm0jWge5ktkN6/shuGjvoxbWv/q8hUBQ7q3Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662446; x=1696267246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPLbH/Tf+wdfFPVL445Q4TNBVYOrnwBXbZL8JKEtuvw=;
        b=aWhCR0cqLty3IoLGHbeUGO0u3XCgWAy2A2wMgbXx8yVPhQAiqp1wsdpl1ZmiY1Q0OX
         +CZxwoHKXPyJSm36aQIVbHv0suUF5k4GUj19R3H8w4NJtIcL79lNsTb1VHetcXJQGvjZ
         V0aAMyet/yN4oWlW+8KyksHlI9v0bneqCYIao4+ZTTDULhMLph0gpSHCHXV044lS91rH
         IhsG+WNSSiZpwt40shzH2wDBpgA4NFMI8stQE8H3SwrHY3Dvd5Q9nMWYsswDKMuOmLtF
         bfpXPxtT47z+plnpmFKVCjEcimekFdKOj0WGcPuk071oJ51ZJqP1zfCn65A9oqLJ/duv
         iprg==
X-Gm-Message-State: AOJu0YywT9O+rR28FWhst3SdrBt8JAUJL0FGsHYrLR7u86zQGMPM04B7
	WMn1O8IgOaO3aeT464p6hwPF5GztymyDa9jO1vQ=
X-Google-Smtp-Source: AGHT+IH/2iId8tq9z0S+QgPxRRa+XsbO8n2kJks60ziSQmgdUQFCwvKzoBFQaNPGDPAy1E/11VievQ==
X-Received: by 2002:a17:902:ab1a:b0:1b6:6f12:502e with SMTP id ik26-20020a170902ab1a00b001b66f12502emr7369227plb.49.1695662446062;
        Mon, 25 Sep 2023 10:20:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001c62b9a51a4sm202654plr.239.2023.09.25.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:20:45 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: hardening: Add __counted_by regex
Date: Mon, 25 Sep 2023 10:20:41 -0700
Message-Id: <20230925172037.work.853-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=680; i=keescook@chromium.org;
 h=from:subject:message-id; bh=rAmWngsH0Gjx5R0B8Ys0oawcRtQO9WskXs2KSeiUA0Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlEcFpTbJw89m25nOYSCFD8DEggHluPsQVN8XIj
 Dd0XtZOxYaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRHBaQAKCRCJcvTf3G3A
 JliCD/wOfGWDGI4gYxLuP8jKyzmW7RXSI+PJQ5RlwWdPQlrIl+Us8l+/HAoEMqpJ1Ax5Mr3h0+x
 NpwgnoB1lpv8enkEOTwaZ4CFp8evfv3MwpQhCKJkXKBCix69B+PvOAb2msqVAvT//xFUIUha5go
 /YuGCwJ9gEMBzY1aJf0AHMZCZi8FhcjxnSy4Wi+SF6l6L4AXqvyW5UwQFJ2bqnUt/i87GeQ7OUu
 PQ8R7a+yyVGFxJE7W8pZYFNaslP4M7/wpxCBgnR8eLry38r7xYswvFxxK+6IRF0vyG6Oj0Lqy3P
 Ri2YDmzYXl7+uFLDOmCvVCcpQj2gzlHlwVvhj+q1mo2C0h+QC/wXVj3C+I/ESWFaUXvV9Vw+h/X
 S9ACAHO6c1vswtu6XHKGj0EQDeb7oUvwh2c2QCo0CB82c/7KxqJ2YhX6ZACogah01ILQfBuxCH+
 lCTidggRtPjrcqzAP2n/UYOhRslJgcZWUav64Vj+KcPtg1ub2UBHURQOrjuvpjQC+iCtr61jOjy
 RkzDM9adZPgS51Tg0EVtDIL4BewxrrgohkdaPd0vFKwlVi/uW9EJ7hP9v0ZA4mcGLPzjBhviR8Q
 mSrf0DiCHqEFZoNdIyT0gZZAYVnYJfw/xUHv1XTozZ3UfMrzQQamRvLsAUMZnX87iXmQIxcMgUR
 hk5tj/uB DMwrDKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since __counted_by annotations may also require that code be changed to
get initialization ordering correct, let's get an extra group of eyes on
code that is working on these annotations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 737dcc7a2155..741285b8246e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11405,6 +11405,7 @@ F:	kernel/configs/hardening.config
 F:	mm/usercopy.c
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
+K:	\b__counted_by\b
 
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
-- 
2.34.1

