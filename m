Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686443A87
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:49:56 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED61BC
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:49:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690d9cda925so2250873b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695404994; x=1696009794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i346clq8OfBFzjIMANH+n2WNr6xQCzrAEDi+whp12qc=;
        b=Lpf995zItFq6sR0tGyAyBCBbqloaVSUoihECQF8R6YAWb1piw+dr8wUNLTVEVoz46j
         Al074oqsdK/IUrEnJwMeL/j1i/8DIGuAjl8XCOtH7tHzG7dtP1/0/kmsDdOoEq6mglEi
         Ya+zm7x0eydL5BHLdzZ07ZgWJTWFJnKZGihsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404994; x=1696009794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i346clq8OfBFzjIMANH+n2WNr6xQCzrAEDi+whp12qc=;
        b=uFgyjKN6/BIWPFYGBw0oBMJwrEzSkXTlhUmjj+WCUXcHkA6M6Y3q0gPPd5JIrNrVEp
         6anBk+lknqWyd0DGAZIocW+q+GqSzuxLL8d9894uqf47bVseW+H29Zel47dtB7wJMrA1
         OpuADv0H+1OjhTtCRvykNsxbT0cLcuizazl2eB0JvzZ+AzANpcjs1F4msVaQXHc0jVd+
         v10YxqmVfG7wKbIVaN7Pf4i3zdZ8keTtFNpnfjlw17FoV+D4y3QbsMg0iNLEQGJaNQNh
         D76a9WVqVarOUsLTfNy3JIR2RNO09Ii7xglbB+yvK6SK+HUfrodLaA0Cvq41TkaJuL9N
         Q08A==
X-Gm-Message-State: AOJu0YxG3sy9cZPS0DwxPK82o29A6BzmBqbJIv4hZJnYBObVmgZYZ0Wy
	xOkAcCwuzy6pK9xP9oCBYpK3Cg==
X-Google-Smtp-Source: AGHT+IHDCf6iaIOrd4e/2vfSV3BCOtdXxkSb5FuhJslb/6GFKoAPt32qtP+ZnC440mhFZShfIwaS8A==
X-Received: by 2002:a05:6a00:2e93:b0:690:2ad9:1436 with SMTP id fd19-20020a056a002e9300b006902ad91436mr184891pfb.7.1695404994406;
        Fri, 22 Sep 2023 10:49:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v13-20020a63b64d000000b0057783b0f102sm3053318pgt.40.2023.09.22.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:49:53 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	lijian <lijian@yulong.com>,
	linux-media@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] media: v4l2-event: Annotate struct v4l2_subscribed_event with __counted_by
Date: Fri, 22 Sep 2023 10:49:52 -0700
Message-Id: <20230922174951.work.160-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092; i=keescook@chromium.org;
 h=from:subject:message-id; bh=C66/icBEq2MG+m/4ZluAAHZC3P5Kpbkm+mwqC112tHk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPAkSq5hJos3sXunT3ysggynSqRlnNPBwz8S
 uw47BLY+beJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3TwAAKCRCJcvTf3G3A
 JrwJD/9Ga6dhlY0NaypMA6bx76My1z2ArqeY+4D5HEL3TANx74Wr4Kc0p/+suRYVJWhO2AcnxeU
 2hrfzl3pi0Vvw9c5dSxjhNykeazY/+6bWYyMMPEZs+nkNWTNsSaNGWSuQlwi/DWkvux/s2CAfma
 aNW56Oa/XhHaEk7LI2ZSJilEjfkWfZ7Yak8Ud4M2+BCIntq+ML2oE8ms1fCZqoYjtvZ+/UsHTmS
 g3SYTUAf7cjUXhU15YO3y8zQyNYyZsatTU3HGJNpJAJjL/QYtBELDxXf70bmNHzha8SDMSv1YS8
 MgDAkfMLfM7r+R4anEuiL/mXkrtSd6LB6jsKoXgK+VLjG1JP+UUKDIuvcmO7TM1l6VuHWj9WRld
 yTTwN4mMvPSm47Xx3PUaC6LuTijjcqhA3Ua6nFbW0zvaPg7IpV44SycHiEpioj88TrElu81AFrL
 kIGefhO0Hpe32pz7zFpcstbvnlZgAvxX88/pxkNiwIBzunAJ48TCSevzWX1fGf3Zt4iDpLr+bT5
 V4BjtZntEnOCExVsQWu5ZfbI41epwpEP3p6WJ6KEcVIEcAzKw4q3Hbb0xAxEj0AR75RIOyyofOf
 5wYS6DC88fkx+lu3Yu29SH5YEGxqz8hysn6mgDV1W4BcnwHl9dkjhIvY13uFHiexjRTItbx3DEf
 DL1oEuc RlCqUUwQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct v4l2_subscribed_event.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: lijian <lijian@yulong.com>
Cc: linux-media@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/v4l2-core/v4l2-event.c | 2 +-
 include/media/v4l2-event.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index c5ce9f11ad7b..3898ff7edddb 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -238,6 +238,7 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	sev = kvzalloc(struct_size(sev, events, elems), GFP_KERNEL);
 	if (!sev)
 		return -ENOMEM;
+	sev->elems = elems;
 	for (i = 0; i < elems; i++)
 		sev->events[i].sev = sev;
 	sev->type = sub->type;
@@ -245,7 +246,6 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	sev->flags = sub->flags;
 	sev->fh = fh;
 	sev->ops = ops;
-	sev->elems = elems;
 
 	mutex_lock(&fh->subscribe_lock);
 
diff --git a/include/media/v4l2-event.h b/include/media/v4l2-event.h
index 4ffa914ade3a..3a0e2588361c 100644
--- a/include/media/v4l2-event.h
+++ b/include/media/v4l2-event.h
@@ -78,7 +78,7 @@ struct v4l2_subscribed_event {
 	unsigned int		elems;
 	unsigned int		first;
 	unsigned int		in_use;
-	struct v4l2_kevent	events[];
+	struct v4l2_kevent	events[] __counted_by(elems);
 };
 
 /**
-- 
2.34.1

