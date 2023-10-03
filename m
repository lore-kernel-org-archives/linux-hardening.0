Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4E3FB3F
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 23:28:59 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B897B0
	for <linux-hardening@vger.kernel.org>; Tue,  3 Oct 2023 16:28:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c60cec8041so10711325ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Oct 2023 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375737; x=1696980537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mewr2b70zj+E+PpMtuqRQXYpLvw4Y2kPAtz8L71vU0I=;
        b=Gq+gphMwlzljnJCKit7St6eAm1T3gh4oMGIP2fokDe9rOonYZfG2soLJwkTfm8Eo9h
         rfljuBIeizdZtNbUbOXnc9m7VkIleh3hhJG+jcsBmg+ZJbwea4IW5wcRxsTBxncRWQ2L
         7MV7Bwh+SJqxK0Ida1JGynx2Z86cK2sM4Q9zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375737; x=1696980537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mewr2b70zj+E+PpMtuqRQXYpLvw4Y2kPAtz8L71vU0I=;
        b=Qwnucpf7ZvkPt0FV0tN4fG0pE2AJ8/lg915xfRk1QCunEcv+RpHNL+yqtEQXKs94ZA
         LSjISdrdu9Bmxu8LMv2NKrVqYgold6Gi4V7V6mTpOkNFcalrzVYhKJsAgCWA7mk0OLp4
         dkWEmXFYiH8hFkm7TVwXPZWevSmIxEwtcvZp9xR1oX/A7h/V7Ze0g/7GyAq3Tm/zr+Sv
         1zcedNv55ne1MOVxHqsj43QoYaLG+OsSXUhyGORJ+6DgQ0H3SEhTVKEH7XZ/Ngwf6jZE
         7j3v9i48spo+aIWNal/t0v8NEBgUzrV58fu/alR5iUhUowSO7w6Rua1oqo7Y2/AHMUHg
         C+5g==
X-Gm-Message-State: AOJu0YygY4eegJYwoBICzDC5DaYSUcirkRUGyBvV4eXtJwNlXkYOBK3K
	UKjEhlNHJeNME10aDIk4Hpm6LQ==
X-Google-Smtp-Source: AGHT+IE9+0pmjc2CqAJFQTA1BUgWoTDOaeHCQ2RtQhFPP3SatP2ZRDf6Q59SkUDovbfYKbDPKVBYdQ==
X-Received: by 2002:a17:903:24c:b0:1c7:4f87:3dbe with SMTP id j12-20020a170903024c00b001c74f873dbemr1177087plh.31.1696375736870;
        Tue, 03 Oct 2023 16:28:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b001bbd1562e75sm2201487plg.55.2023.10.03.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:28:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by
Date: Tue,  3 Oct 2023 16:28:53 -0700
Message-Id: <20231003232852.work.257-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=keescook@chromium.org;
 h=from:subject:message-id; bh=6X+YStEd0LKlaV0dQ/+jU63am+Tg/LnFddxaxahC+bw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKO1gHu4l9h8ToOMvkOmkto8cSVU/vIIIfRBe
 GeN6y35pSWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyjtQAKCRCJcvTf3G3A
 JgNjD/4q5gV6j+9dUNB2OWkREBYsVc6X++ugjnovyEuKGMIO5OVnXc9jH79Kp+y27z4flA8uzzb
 +/r402rgPMkNPLC5GCQr12BvpEC1X8LALA79ist2DeSe1oktOoVS3aMe+/Xy6TqdcMeDeIZoo/7
 T1Rn6zkPYXU/8vtFSebH5zH51EeajceKubb+yEJ8rmen79X1C7Gyeb7Ijc3HWazoUS0FKasUx5A
 cOnmPn+ui24LfU1Qa7V7TdcR9rfRZ8updCADmqZ6QM5DHxxwuvgir/CGTN4izQGV1OUxMJgJS4l
 +wodJb5c0SRHeF+7+yAT6WO4qsuBQQwFXdnsw2ywzFe2rTOZ22M/mAcK22lbc28oAaVPrL6tWj1
 MT6VpE1AqFevzjlgTxDde83nlltZhG2Vveh6cPfzFBtn53tVWK1kaPFTw5cr4Ku6TnJswmeRLtJ
 sxEuDhD/KSvpRx1PhGEU8jGsnOjuSnT9E79xugfNmv/2wjEIJSha6UeyebKRB3HpoAqL5eXJBDb
 37rBp22xYP5M/W7HQmIFzZ+iR3s7UV+UW+3JYpQusIFADZzQH0yUHk/DoV7EVgBxMtYXwAs0xOn
 vxcomU0K+gw5b+cB6mxXslxsu7jQ5DVxyatycmhvSOz7GUbXtQlraWBOe+LhgFI/Y8J7Mupz2q9
 aPyj3M0 Mg5yrwWA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct snd_soc_dapm_widget_list.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/sound/soc-dapm.h | 2 +-
 sound/soc/soc-dapm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d2faec9a323e..51516c93916e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -717,7 +717,7 @@ struct snd_soc_dapm_context {
 /* A list of widgets associated with an object, typically a snd_kcontrol */
 struct snd_soc_dapm_widget_list {
 	int num_widgets;
-	struct snd_soc_dapm_widget *widgets[];
+	struct snd_soc_dapm_widget *widgets[] __counted_by(num_widgets);
 };
 
 #define for_each_dapm_widgets(list, i, widget)				\
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2512aadf95f7..2e3df47c9cf3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -497,8 +497,8 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 	if (!new_wlist)
 		return -ENOMEM;
 
-	new_wlist->widgets[n - 1] = widget;
 	new_wlist->num_widgets = n;
+	new_wlist->widgets[n - 1] = widget;
 
 	data->wlist = new_wlist;
 
-- 
2.34.1

